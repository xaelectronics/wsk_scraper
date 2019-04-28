defmodule WskScraper.Repo.Migrations.CreateDailyFantasyFuel do
  use Ecto.Migration

  def change do
    create table(:daily_fantasy_fuel) do
      add :betting_site, :string
      add :date, :date
      add :name, :string
      add :position, :string
      add :days_rest, :integer
      add :team, :string
      add :opp, :string
      add :projected_team_score, :float
      add :salary, :string
      add :opp_rank, :float
      add :ppg_projected, :float

      timestamps()
    end

    create unique_index(:daily_fantasy_fuel, [:betting_site, :date, :name])
  end
end
