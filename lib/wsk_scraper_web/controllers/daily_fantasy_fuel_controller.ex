defmodule WskScraperWeb.DailyFantasyFuelController do
  use WskScraperWeb, :controller

  alias WskScraper.Sources
  alias WskScraper.Sources.DailyFantasyFuel

  def index(conn, %{"betting_site" => site, "date" => date}) do
    daily_fantasy_fuel = Sources.list_daily_fantasy_fuel(site, date)
    render(conn, "index.html", daily_fantasy_fuel: daily_fantasy_fuel)
  end

  def csv(conn, %{"betting_site" => site, "date" => date}) do
    daily_fantasy_fuel = Sources.list_daily_fantasy_fuel(site, date)
    build_csv = daily_fantasy_fuel
    |> Enum.map(fn(row) -> "#{row.betting_site}, #{row.date}, \"#{row.name}\", #{row.position}, #{row.days_rest}, #{row.team}, #{row.opp}, #{row.projected_team_score}, #{row.salary}, #{row.integer}, #{row.opp_rank}, #{row.ppg_projected}" end)
    |> Enum.join("\n")
    conn |> send_resp(201, "betting_site, date, name, position, days_rest, team, opp, projected_team_score, salary, integer, opp_rank, ppg_projected\n#{build_csv}")
  end

  def initialize(conn, _) do
    Task.start(fn() -> WskScraper.Scraper.DailyFantasyFuel.scrape_all() end)
    conn |> send_resp(200, "2019 DFF sync started")
  end
end
