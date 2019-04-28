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

  describe "numberfire" do
    alias WskScraper.Sources.Numberfire

    @valid_attrs %{"1b": 120.5, "2b": 120.5, "3b": 120.5, avg: 120.5, bb: 120.5, betting_site: "some betting_site", date: ~D[2010-04-17], hr: 120.5, k: 120.5, name: "some name", opp: "some opp", pa: 120.5, position: "some position", projected_fp: 120.5, r: 120.5, rbi: 120.5, salary: "some salary", sb: 120.5, team: "some team", value: 120.5}
    @update_attrs %{"1b": 456.7, "2b": 456.7, "3b": 456.7, avg: 456.7, bb: 456.7, betting_site: "some updated betting_site", date: ~D[2011-05-18], hr: 456.7, k: 456.7, name: "some updated name", opp: "some updated opp", pa: 456.7, position: "some updated position", projected_fp: 456.7, r: 456.7, rbi: 456.7, salary: "some updated salary", sb: 456.7, team: "some updated team", value: 456.7}
    @invalid_attrs %{"1b": nil, "2b": nil, "3b": nil, avg: nil, bb: nil, betting_site: nil, date: nil, hr: nil, k: nil, name: nil, opp: nil, pa: nil, position: nil, projected_fp: nil, r: nil, rbi: nil, salary: nil, sb: nil, team: nil, value: nil}

    def numberfire_fixture(attrs \\ %{}) do
      {:ok, numberfire} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sources.create_numberfire()

      numberfire
    end

    test "list_numberfire/0 returns all numberfire" do
      numberfire = numberfire_fixture()
      assert Sources.list_numberfire() == [numberfire]
    end

    test "get_numberfire!/1 returns the numberfire with given id" do
      numberfire = numberfire_fixture()
      assert Sources.get_numberfire!(numberfire.id) == numberfire
    end

    test "create_numberfire/1 with valid data creates a numberfire" do
      assert {:ok, %Numberfire{} = numberfire} = Sources.create_numberfire(@valid_attrs)
      assert numberfire.1b == 120.5
      assert numberfire.2b == 120.5
      assert numberfire.3b == 120.5
      assert numberfire.avg == 120.5
      assert numberfire.bb == 120.5
      assert numberfire.betting_site == "some betting_site"
      assert numberfire.date == ~D[2010-04-17]
      assert numberfire.hr == 120.5
      assert numberfire.k == 120.5
      assert numberfire.name == "some name"
      assert numberfire.opp == "some opp"
      assert numberfire.pa == 120.5
      assert numberfire.position == "some position"
      assert numberfire.projected_fp == 120.5
      assert numberfire.r == 120.5
      assert numberfire.rbi == 120.5
      assert numberfire.salary == "some salary"
      assert numberfire.sb == 120.5
      assert numberfire.team == "some team"
      assert numberfire.value == 120.5
    end

    test "create_numberfire/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sources.create_numberfire(@invalid_attrs)
    end

    test "update_numberfire/2 with valid data updates the numberfire" do
      numberfire = numberfire_fixture()
      assert {:ok, %Numberfire{} = numberfire} = Sources.update_numberfire(numberfire, @update_attrs)
      assert numberfire.1b == 456.7
      assert numberfire.2b == 456.7
      assert numberfire.3b == 456.7
      assert numberfire.avg == 456.7
      assert numberfire.bb == 456.7
      assert numberfire.betting_site == "some updated betting_site"
      assert numberfire.date == ~D[2011-05-18]
      assert numberfire.hr == 456.7
      assert numberfire.k == 456.7
      assert numberfire.name == "some updated name"
      assert numberfire.opp == "some updated opp"
      assert numberfire.pa == 456.7
      assert numberfire.position == "some updated position"
      assert numberfire.projected_fp == 456.7
      assert numberfire.r == 456.7
      assert numberfire.rbi == 456.7
      assert numberfire.salary == "some updated salary"
      assert numberfire.sb == 456.7
      assert numberfire.team == "some updated team"
      assert numberfire.value == 456.7
    end

    test "update_numberfire/2 with invalid data returns error changeset" do
      numberfire = numberfire_fixture()
      assert {:error, %Ecto.Changeset{}} = Sources.update_numberfire(numberfire, @invalid_attrs)
      assert numberfire == Sources.get_numberfire!(numberfire.id)
    end

    test "delete_numberfire/1 deletes the numberfire" do
      numberfire = numberfire_fixture()
      assert {:ok, %Numberfire{}} = Sources.delete_numberfire(numberfire)
      assert_raise Ecto.NoResultsError, fn -> Sources.get_numberfire!(numberfire.id) end
    end

    test "change_numberfire/1 returns a numberfire changeset" do
      numberfire = numberfire_fixture()
      assert %Ecto.Changeset{} = Sources.change_numberfire(numberfire)
    end
  end
end
