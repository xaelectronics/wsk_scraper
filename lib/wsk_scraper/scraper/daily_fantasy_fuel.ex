defmodule WskScraper.Scraper.DailyFantasyFuel do
  @moduledoc """
  Scrapes data from http://www.dailyfantasyfuel.com/mlb/projections/{betting_site}/{date}/
  """
  require Logger
  alias HTTPoison.Response

  @doc """
  Scrapes DFF for fanduel or draftkings data
  site = "draftkings" || "fanduel" #defaults to draftkings
  date = "yyyy-mm-dd" #defaults to today (UTC)
  """
  def scrape(site \\ "draftkings", date \\ today()) do
    url = "http://www.dailyfantasyfuel.com/mlb/projections/#{site}/#{date}"
    case HTTPoison.get(url) do
      {:ok, %Response{status_code: 200, body: body}} ->
        parse_player_data(date, body)
      {code, response} ->
        Logger.warn("Unexpected response! #{code}: #{inspect response}")
        :error
    end
  end

  def parse_player_data(date, html) do
    Floki.find(html, "div.projections-listing")
    |> Enum.map(fn(el) ->
      %{
        date: date,
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
    end)
  end

  def today do
    Timex.now("US/Eastern") |> Timex.to_date |> to_string
  end
end
