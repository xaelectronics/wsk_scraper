defmodule WskScraperWeb.NumberfireController do
  use WskScraperWeb, :controller

  alias WskScraper.Sources
  alias WskScraper.Sources.Numberfire

  def index(conn, %{"betting_site" => site, "date" => date}) do
    numberfire = Sources.list_numberfire(site, date)
    render(conn, "index.html", numberfire: numberfire)
  end

  def csv(conn, %{"betting_site" => site, "date" => date}) do
    numberfire = Sources.list_numberfire(site, date)
    build_csv = numberfire
    |> Enum.map(fn(row) -> "#{row.betting_site}, #{row.date}, \"#{row.name}\", #{row.position}, #{row.team}, #{row.opp}, #{row.projected_fp}, #{row.salary}, #{row.value}, #{row.pa}, #{row.bb}, #{Map.get(row, :"1b")}, #{Map.get(row, :"2b")}, #{Map.get(row, :"3b")}, #{row.hr}, #{row.r}, #{row.rbi}, #{row.sb}, #{row.k}, #{row.avg}" end)
    |> Enum.join("\n")
    conn |> send_resp(201, "betting_site, date, name, position, team, opp, projected_fp, salary, value, pa, bb, 1b, 2b, 3b, hr, r, rbi, sb, k, avg\n#{build_csv}")
  end
end
