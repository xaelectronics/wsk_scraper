defmodule WskScraper.Scraper.DailyFantasyFuel do
  @moduledoc """
  Scrapes data from http://www.dailyfantasyfuel.com/mlb/projections/{betting_site}/{date}/
  """
  require Logger
  alias HTTPoison.Response
  use ExActor.GenServer, export: :wish_api
  @refresh_interval 60 * 60 #one hour
  @timeout 60_000

  defstart start_link(_) do
    schedule_refresh()
    scrape("draftkings")
    scrape("fanduel")
    initial_state(nil)
  end

  defhandleinfo :refresh, state: _ do
    scrape("draftkings")
    scrape("fanduel")
    schedule_refresh()
    new_state(nil)
  end

  def schedule_refresh do
    Process.send_after(self(), :refresh, (@refresh_interval * 1000))
  end

  @doc """
  Scrapes DFF for fanduel or draftkings data
  betting_site = "draftkings" || "fanduel" #defaults to draftkings
  date = "yyyy-mm-dd" #defaults to today (UTC)
  """
  def scrape(betting_site \\ "draftkings", date \\ today()) do
    url = "http://www.dailyfantasyfuel.com/mlb/projections/#{betting_site}/#{date}"
    case HTTPoison.get(url, [recv_timeout: @timeout, timeout: @timeout]) do
      {:ok, %Response{status_code: 200, body: body}} ->
        info = %{betting_site: betting_site, date: date}
        parse_player_data(info, body)
        |> Enum.each(fn(player) ->
          WskScraper.Sources.create_daily_fantasy_fuel(player) #persist to DB
        end)
      {code, response} ->
        Logger.warn("Unexpected response! #{code}: #{inspect response}")
        :error
    end
  end

  @doc """
  convenience code to scrape from start of 2019 season
  """
  def scrape_all do
    #season start
    start = Timex.parse!("2019-03-28T00:00:00.196Z", "{ISO:Extended:Z}") |> Timex.to_date
    today = Timex.now("US/Eastern") |> Timex.to_date
    duration = Timex.diff(today, start)
    |> Timex.Duration.from_microseconds
    |> Timex.Duration.to_days

    0..round(duration)
    |> Enum.each(fn(shift) ->
      date = start |> Timex.shift(days: shift) |> to_string
      scrape("draftkings", date)
      scrape("fanduel", date)
    end)
  end

  def parse_player_data(info, html) do
    Floki.find(html, "div.projections-listing")
    |> Enum.map(fn(el) ->
      %{
        name: Floki.attribute(el, "data-name") |> List.first,
        position: Floki.attribute(el, "data-position") |> List.first,
        days_rest: Floki.attribute(el, "data-days_rest") |> List.first,
        team: Floki.attribute(el, "data-team") |> List.first,
        opp: Floki.attribute(el, "data-opp") |> List.first, #opponent
        projected_team_score: Floki.attribute(el, "data-projected_team_score") |> List.first, #this is called Order in the spreadsheet for some reason
        salary: Floki.attribute(el, "data-salary") |> List.first,
        opp_rank: Floki.attribute(el, "data-opp_rank") |> List.first,
        ppg_projected: Floki.attribute(el, "data-ppg_projected") |> List.first,
      }
      |> Map.merge(info)
    end)
  end

  def today do
    Timex.now("US/Eastern") |> Timex.to_date |> to_string
  end
end
