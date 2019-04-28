defmodule WskScraperWeb.DailyFantasyFuelControllerTest do
  use WskScraperWeb.ConnCase

  alias WskScraper.Sources

  @create_attrs %{betting_site: "some betting_site", date: ~D[2010-04-17], days_rest: 42, integer: "some integer", name: "some name", opp: "some opp", opp_rank: 120.5, position: "some position", ppg_projected: 120.5, projected_team_score: 120.5, salary: "some salary", team: "some team"}
  @update_attrs %{betting_site: "some updated betting_site", date: ~D[2011-05-18], days_rest: 43, integer: "some updated integer", name: "some updated name", opp: "some updated opp", opp_rank: 456.7, position: "some updated position", ppg_projected: 456.7, projected_team_score: 456.7, salary: "some updated salary", team: "some updated team"}
  @invalid_attrs %{betting_site: nil, date: nil, days_rest: nil, integer: nil, name: nil, opp: nil, opp_rank: nil, position: nil, ppg_projected: nil, projected_team_score: nil, salary: nil, team: nil}

  def fixture(:daily_fantasy_fuel) do
    {:ok, daily_fantasy_fuel} = Sources.create_daily_fantasy_fuel(@create_attrs)
    daily_fantasy_fuel
  end

  describe "index" do
    test "lists all daily_fantasy_fuel", %{conn: conn} do
      conn = get(conn, Routes.daily_fantasy_fuel_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Daily fantasy fuel"
    end
  end

  describe "new daily_fantasy_fuel" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.daily_fantasy_fuel_path(conn, :new))
      assert html_response(conn, 200) =~ "New Daily fantasy fuel"
    end
  end

  describe "create daily_fantasy_fuel" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.daily_fantasy_fuel_path(conn, :create), daily_fantasy_fuel: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.daily_fantasy_fuel_path(conn, :show, id)

      conn = get(conn, Routes.daily_fantasy_fuel_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Daily fantasy fuel"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.daily_fantasy_fuel_path(conn, :create), daily_fantasy_fuel: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Daily fantasy fuel"
    end
  end

  describe "edit daily_fantasy_fuel" do
    setup [:create_daily_fantasy_fuel]

    test "renders form for editing chosen daily_fantasy_fuel", %{conn: conn, daily_fantasy_fuel: daily_fantasy_fuel} do
      conn = get(conn, Routes.daily_fantasy_fuel_path(conn, :edit, daily_fantasy_fuel))
      assert html_response(conn, 200) =~ "Edit Daily fantasy fuel"
    end
  end

  describe "update daily_fantasy_fuel" do
    setup [:create_daily_fantasy_fuel]

    test "redirects when data is valid", %{conn: conn, daily_fantasy_fuel: daily_fantasy_fuel} do
      conn = put(conn, Routes.daily_fantasy_fuel_path(conn, :update, daily_fantasy_fuel), daily_fantasy_fuel: @update_attrs)
      assert redirected_to(conn) == Routes.daily_fantasy_fuel_path(conn, :show, daily_fantasy_fuel)

      conn = get(conn, Routes.daily_fantasy_fuel_path(conn, :show, daily_fantasy_fuel))
      assert html_response(conn, 200) =~ "some updated betting_site"
    end

    test "renders errors when data is invalid", %{conn: conn, daily_fantasy_fuel: daily_fantasy_fuel} do
      conn = put(conn, Routes.daily_fantasy_fuel_path(conn, :update, daily_fantasy_fuel), daily_fantasy_fuel: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Daily fantasy fuel"
    end
  end

  describe "delete daily_fantasy_fuel" do
    setup [:create_daily_fantasy_fuel]

    test "deletes chosen daily_fantasy_fuel", %{conn: conn, daily_fantasy_fuel: daily_fantasy_fuel} do
      conn = delete(conn, Routes.daily_fantasy_fuel_path(conn, :delete, daily_fantasy_fuel))
      assert redirected_to(conn) == Routes.daily_fantasy_fuel_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.daily_fantasy_fuel_path(conn, :show, daily_fantasy_fuel))
      end
    end
  end

  defp create_daily_fantasy_fuel(_) do
    daily_fantasy_fuel = fixture(:daily_fantasy_fuel)
    {:ok, daily_fantasy_fuel: daily_fantasy_fuel}
  end
end
