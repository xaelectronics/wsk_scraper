defmodule WskScraper.Repo.Migrations.CreateNumberfire do
  use Ecto.Migration

  def change do
    create table(:numberfire) do
      add :betting_site, :string
      add :date, :date
      add :name, :string
      add :position, :string
      add :team, :string
      add :opp, :string
      add :projected_fp, :float
      add :salary, :integer
      add :value, :float
      add :pa, :float
      add :bb, :float
      add :"1b", :float
      add :"2b", :float
      add :"3b", :float
      add :hr, :float
      add :r, :float
      add :rbi, :float
      add :sb, :float
      add :k, :float
      add :avg, :float

      timestamps()
    end

    create unique_index(:numberfire, [:betting_site, :date, :name])

    alter table(:daily_fantasy_fuel) do
      remove :integer
    end

  end
end
