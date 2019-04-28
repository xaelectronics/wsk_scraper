defmodule WskScraper.SourcesTest do
  use WskScraper.DataCase

  alias WskScraper.Sources

  describe "daily_fantasy_fuel" do
    alias WskScraper.Sources.DailyFantasyFuel

    @valid_attrs %{betting_site: "some betting_site", date: ~D[2010-04-17], days_rest: 42, integer: "some integer", name: "some name", opp: "some opp", opp_rank: 120.5, position: "some position", ppg_projected: 120.5, projected_team_score: 120.5, salary: "some salary", team: "some team"}
    @update_attrs %{betting_site: "some updated betting_site", date: ~D[2011-05-18], days_rest: 43, integer: "some updated integer", name: "some updated name", opp: "some updated opp", opp_rank: 456.7, position: "some updated position", ppg_projected: 456.7, projected_team_score: 456.7, salary: "some updated salary", team: "some updated team"}
    @invalid_attrs %{betting_site: nil, date: nil, days_rest: nil, integer: nil, name: nil, opp: nil, opp_rank: nil, position: nil, ppg_projected: nil, projected_team_score: nil, salary: nil, team: nil}

    def daily_fantasy_fuel_fixture(attrs \\ %{}) do
      {:ok, daily_fantasy_fuel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sources.create_daily_fantasy_fuel()

      daily_fantasy_fuel
    end

    test "list_daily_fantasy_fuel/0 returns all daily_fantasy_fuel" do
      daily_fantasy_fuel = daily_fantasy_fuel_fixture()
      assert Sources.list_daily_fantasy_fuel() == [daily_fantasy_fuel]
    end

    test "get_daily_fantasy_fuel!/1 returns the daily_fantasy_fuel with given id" do
      daily_fantasy_fuel = daily_fantasy_fuel_fixture()
      assert Sources.get_daily_fantasy_fuel!(daily_fantasy_fuel.id) == daily_fantasy_fuel
    end

    test "create_daily_fantasy_fuel/1 with valid data creates a daily_fantasy_fuel" do
      assert {:ok, %DailyFantasyFuel{} = daily_fantasy_fuel} = Sources.create_daily_fantasy_fuel(@valid_attrs)
      assert daily_fantasy_fuel.betting_site == "some betting_site"
      assert daily_fantasy_fuel.date == ~D[2010-04-17]
      assert daily_fantasy_fuel.days_rest == 42
      assert daily_fantasy_fuel.integer == "some integer"
      assert daily_fantasy_fuel.name == "some name"
      assert daily_fantasy_fuel.opp == "some opp"
      assert daily_fantasy_fuel.opp_rank == 120.5
      assert daily_fantasy_fuel.position == "some position"
      assert daily_fantasy_fuel.ppg_projected == 120.5
      assert daily_fantasy_fuel.projected_team_score == 120.5
      assert daily_fantasy_fuel.salary == "some salary"
      assert daily_fantasy_fuel.team == "some team"
    end

    test "create_daily_fantasy_fuel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sources.create_daily_fantasy_fuel(@invalid_attrs)
    end

    test "update_daily_fantasy_fuel/2 with valid data updates the daily_fantasy_fuel" do
      daily_fantasy_fuel = daily_fantasy_fuel_fixture()
      assert {:ok, %DailyFantasyFuel{} = daily_fantasy_fuel} = Sources.update_daily_fantasy_fuel(daily_fantasy_fuel, @update_attrs)
      assert daily_fantasy_fuel.betting_site == "some updated betting_site"
      assert daily_fantasy_fuel.date == ~D[2011-05-18]
      assert daily_fantasy_fuel.days_rest == 43
      assert daily_fantasy_fuel.integer == "some updated integer"
      assert daily_fantasy_fuel.name == "some updated name"
      assert daily_fantasy_fuel.opp == "some updated opp"
      assert daily_fantasy_fuel.opp_rank == 456.7
      assert daily_fantasy_fuel.position == "some updated position"
      assert daily_fantasy_fuel.ppg_projected == 456.7
      assert daily_fantasy_fuel.projected_team_score == 456.7
      assert daily_fantasy_fuel.salary == "some updated salary"
      assert daily_fantasy_fuel.team == "some updated team"
    end

    test "update_daily_fantasy_fuel/2 with invalid data returns error changeset" do
      daily_fantasy_fuel = daily_fantasy_fuel_fixture()
      assert {:error, %Ecto.Changeset{}} = Sources.update_daily_fantasy_fuel(daily_fantasy_fuel, @invalid_attrs)
      assert daily_fantasy_fuel == Sources.get_daily_fantasy_fuel!(daily_fantasy_fuel.id)
    end

    test "delete_daily_fantasy_fuel/1 deletes the daily_fantasy_fuel" do
      daily_fantasy_fuel = daily_fantasy_fuel_fixture()
      assert {:ok, %DailyFantasyFuel{}} = Sources.delete_daily_fantasy_fuel(daily_fantasy_fuel)
      assert_raise Ecto.NoResultsError, fn -> Sources.get_daily_fantasy_fuel!(daily_fantasy_fuel.id) end
    end

    test "change_daily_fantasy_fuel/1 returns a daily_fantasy_fuel changeset" do
      daily_fantasy_fuel = daily_fantasy_fuel_fixture()
      assert %Ecto.Changeset{} = Sources.change_daily_fantasy_fuel(daily_fantasy_fuel)
    end
  end
end
