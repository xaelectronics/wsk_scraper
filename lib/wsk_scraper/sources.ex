defmodule WskScraper.Sources do
  @moduledoc """
  The Sources context.
  """

  import Ecto.Query, warn: false
  alias WskScraper.Repo

  alias WskScraper.Sources.DailyFantasyFuel

  @doc """
  Returns the list of daily_fantasy_fuel.

  ## Examples

      iex> list_daily_fantasy_fuel()
      [%DailyFantasyFuel{}, ...]

  """
  def list_daily_fantasy_fuel do
    Repo.all(DailyFantasyFuel)
  end

  def list_daily_fantasy_fuel(site, date) do
    DailyFantasyFuel
    |> where([dfs], dfs.betting_site == ^site)
    |> where([dfs], dfs.date == ^date)
    |> Repo.all()
  end

  @doc """
  Gets a single daily_fantasy_fuel.

  Raises `Ecto.NoResultsError` if the Daily fantasy fuel does not exist.

  ## Examples

      iex> get_daily_fantasy_fuel!(123)
      %DailyFantasyFuel{}

      iex> get_daily_fantasy_fuel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_daily_fantasy_fuel!(id), do: Repo.get!(DailyFantasyFuel, id)

  @doc """
  Creates a daily_fantasy_fuel.

  ## Examples

      iex> create_daily_fantasy_fuel(%{field: value})
      {:ok, %DailyFantasyFuel{}}

      iex> create_daily_fantasy_fuel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_daily_fantasy_fuel(attrs \\ %{}) do
    %DailyFantasyFuel{}
    |> DailyFantasyFuel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a daily_fantasy_fuel.

  ## Examples

      iex> update_daily_fantasy_fuel(daily_fantasy_fuel, %{field: new_value})
      {:ok, %DailyFantasyFuel{}}

      iex> update_daily_fantasy_fuel(daily_fantasy_fuel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_daily_fantasy_fuel(%DailyFantasyFuel{} = daily_fantasy_fuel, attrs) do
    daily_fantasy_fuel
    |> DailyFantasyFuel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DailyFantasyFuel.

  ## Examples

      iex> delete_daily_fantasy_fuel(daily_fantasy_fuel)
      {:ok, %DailyFantasyFuel{}}

      iex> delete_daily_fantasy_fuel(daily_fantasy_fuel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_daily_fantasy_fuel(%DailyFantasyFuel{} = daily_fantasy_fuel) do
    Repo.delete(daily_fantasy_fuel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking daily_fantasy_fuel changes.

  ## Examples

      iex> change_daily_fantasy_fuel(daily_fantasy_fuel)
      %Ecto.Changeset{source: %DailyFantasyFuel{}}

  """
  def change_daily_fantasy_fuel(%DailyFantasyFuel{} = daily_fantasy_fuel) do
    DailyFantasyFuel.changeset(daily_fantasy_fuel, %{})
  end

  alias WskScraper.Sources.Numberfire

  @doc """
  Returns the list of numberfire.

  ## Examples

      iex> list_numberfire()
      [%Numberfire{}, ...]

  """
  def list_numberfire do
    Repo.all(Numberfire)
  end

  def list_numberfire(site, date) do
    Numberfire
    |> where([nf], nf.betting_site == ^site)
    |> where([nf], nf.date == ^date)
    |> Repo.all()
  end


  @doc """
  Gets a single numberfire.

  Raises `Ecto.NoResultsError` if the Numberfire does not exist.

  ## Examples

      iex> get_numberfire!(123)
      %Numberfire{}

      iex> get_numberfire!(456)
      ** (Ecto.NoResultsError)

  """
  def get_numberfire!(id), do: Repo.get!(Numberfire, id)

  @doc """
  Creates a numberfire.

  ## Examples

      iex> create_numberfire(%{field: value})
      {:ok, %Numberfire{}}

      iex> create_numberfire(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_numberfire(attrs \\ %{}) do
    %Numberfire{}
    |> Numberfire.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a numberfire.

  ## Examples

      iex> update_numberfire(numberfire, %{field: new_value})
      {:ok, %Numberfire{}}

      iex> update_numberfire(numberfire, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_numberfire(%Numberfire{} = numberfire, attrs) do
    numberfire
    |> Numberfire.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Numberfire.

  ## Examples

      iex> delete_numberfire(numberfire)
      {:ok, %Numberfire{}}

      iex> delete_numberfire(numberfire)
      {:error, %Ecto.Changeset{}}

  """
  def delete_numberfire(%Numberfire{} = numberfire) do
    Repo.delete(numberfire)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking numberfire changes.

  ## Examples

      iex> change_numberfire(numberfire)
      %Ecto.Changeset{source: %Numberfire{}}

  """
  def change_numberfire(%Numberfire{} = numberfire) do
    Numberfire.changeset(numberfire, %{})
  end
end
