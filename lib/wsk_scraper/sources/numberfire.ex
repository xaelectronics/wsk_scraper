defmodule WskScraper.Sources.Numberfire do
  use Ecto.Schema
  import Ecto.Changeset

  schema "numberfire" do
    field :"1b", :float
    field :"2b", :float
    field :"3b", :float
    field :avg, :float
    field :bb, :float
    field :betting_site, :string
    field :date, :date
    field :hr, :float
    field :k, :float
    field :name, :string
    field :opp, :string
    field :pa, :float
    field :position, :string
    field :projected_fp, :float
    field :r, :float
    field :rbi, :float
    field :salary, :integer
    field :sb, :float
    field :team, :string
    field :value, :float

    timestamps()
  end

  @attrs [
    :betting_site, :date, :name, :position, :team, :opp, :projected_fp, :salary, :value, :pa, :bb, :"1b", :"2b", :"3b", :hr, :r, :rbi, :sb, :k, :avg
  ]
  @required_attrs [

  ]

  @doc false
  def changeset(numberfire, attrs) do
    numberfire
    |> cast(attrs, @attrs)
    |> validate_required(@required_attrs)
    |> unique_constraint(:name, name: :numberfire_betting_site_date_name_index)
  end
end
