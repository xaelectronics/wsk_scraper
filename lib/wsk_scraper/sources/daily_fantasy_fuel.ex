defmodule WskScraper.Sources.DailyFantasyFuel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daily_fantasy_fuel" do
    field :betting_site, :string
    field :date, :date
    field :days_rest, :integer
    field :name, :string
    field :opp, :string
    field :opp_rank, :float
    field :position, :string
    field :ppg_projected, :float
    field :projected_team_score, :float
    field :salary, :string
    field :team, :string

    timestamps()
  end

  @attrs [
    :betting_site, :date, :name, :position, :days_rest, :team, :opp, :projected_team_score, :salary, :opp_rank, :ppg_projected
  ]
  @required_attrs [

  ]
  @doc false
  def changeset(daily_fantasy_fuel, attrs) do
    daily_fantasy_fuel
    |> cast(attrs, @attrs)
    |> validate_required(@required_attrs)
    |> unique_constraint(:name, name: :daily_fantasy_fuel_betting_site_date_name_index)
  end
end
