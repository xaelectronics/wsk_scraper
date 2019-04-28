defmodule WskScraper.Scraper.Numberfire do
  @moduledoc """
  Scrapes data from http://www.numberfire.com/mlb/daily-fantasy/daily-baseball-projections/{position}
  Different positions require GET requests to different pages
  Different betting sites require POST requests to set site
  """
  require Logger
  alias HTTPoison.Response
  alias CookieJar.HTTPoison, as: HTTPoison
  use ExActor.GenServer, export: :wish_api
  @refresh_interval 60 * 60 #one hour
  @timeout 60_000
  @platforms [%{site: "draftkings", value: 4}, %{site: "fanduel", value: 3}, %{site: "yahoo", value: 13}]
  @positions ["batters", "pitchers", "C", "1B", "2B", "3B", "SS", "OF", "DH", "SP", "RP"]

  defstart start_link(_) do
    schedule_refresh()
    Task.start(fn() -> scrape_all_platforms() end)
    initial_state(nil)
  end

  defhandleinfo :refresh, state: _ do
    scrape_all_platforms()
    schedule_refresh()
    new_state(nil)
  end

  def schedule_refresh do
    Process.send_after(self(), :refresh, (@refresh_interval * 1000))
  end

  def scrape_all_platforms do
    @platforms
    |> Enum.each(fn(platform) ->
      {:ok, jar} = CookieJar.new
      settings = %{jar: jar, site: platform.site}
      body = %{site: platform.value} |> URI.encode_query()
      headers = [{"Content-Type", "application/x-www-form-urlencoded; charset=UTF-8"}]
      case HTTPoison.post(jar, "http://www.numberfire.com/mlb/daily-fantasy/set-dfs-site", body, headers) do
        {:ok, %Response{status_code: 200, body: body}} ->
          if body == "{\"error\":0}" do
            scrape_all_positions(settings)
          else
            Logger.warn("Unexpected numberfire response")
          end
        _ ->
          Logger.warn("Unexpected numberfire response")
      end
      CookieJar.smash(jar)
    end)
  end

  def scrape_all_positions(settings) do
    @positions |> Enum.each(fn(position) -> scrape(settings, position) end)
  end

  @doc """
  Scrapes DFF for fanduel or draftkings data
  betting_site = "draftkings" || "fanduel" #defaults to draftkings
  date = "yyyy-mm-dd" #defaults to today (UTC)
  {:ok, jar} = CookieJar.new
  settings = %{jar: jar, site: "fanduel"}
  WskScraper.Scraper.Numberfire.scrape(cookie_jar, "batters")
  """
  def scrape(settings, position) do
    url = "http://www.numberfire.com/mlb/daily-fantasy/daily-baseball-projections/#{position}"
    case HTTPoison.get(settings.jar, url, [recv_timeout: @timeout, timeout: @timeout]) do
      {:ok, %Response{status_code: 200, body: body}} ->
        info = %{betting_site: settings.site, date: today()}
        parse_player_data(info, body)
        |> Enum.each(fn(player) ->
          if !is_nil(player.name) && player.name != "" do
            WskScraper.Sources.create_numberfire(player) #persist to DB
          end
        end)
      {code, response} ->
        Logger.warn("Unexpected response! #{code}: #{inspect response}")
        :error
    end
  end

  def parse_player_data(info, html) do
    Floki.find(html, "tbody.stat-table__body tr")
    |> Enum.map(fn(el) ->
      %{
        name: Floki.find(el, ".player-info .full") |> text(),
        position: Floki.find(el, ".player-info .player-info--position") |> text(),
        team: Floki.find(el, ".team-player__team.active") |> text(),
        opp: Floki.find(el, ".team-player__team:not(.active)") |> text(), #opponent
        projected_fp: Floki.find(el, ".fp") |> text(),
        salary: Floki.find(el, ".cost") |> text() |> String.replace(~r/\$|,/, "") |> to_int(), #TODO make this more robust
        value: Floki.find(el, ".value") |> text(),
        pa: Floki.find(el, ".pa") |> text(),
        bb: Floki.find(el, ".bb") |> text(),
        "1b": Floki.find(el, ".1b") |> text(),
        "2b": Floki.find(el, ".2b") |> text(),
        "3b": Floki.find(el, ".3b") |> text(),
        hr: Floki.find(el, ".hr") |> text(),
        r: Floki.find(el, ".r") |> text(),
        rbi: Floki.find(el, ".rbi") |> text(),
        sb: Floki.find(el, ".sb") |> text(),
        k: Floki.find(el, ".k") |> text(),
        avg: Floki.find(el, ".avg") |> text(),
      }
      |> Map.merge(info)
    end)
  end

  def to_int(value) do
    case Integer.parse(value) do
      :error -> nil
      {int, _} -> int
    end
  end

  def text(element) do
    element |> Floki.text |> String.trim
  end

  def today do
    Timex.now("US/Eastern") |> Timex.to_date |> to_string
  end
end
