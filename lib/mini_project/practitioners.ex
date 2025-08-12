defmodule MiniProject.Practitioners do

  alias MiniProject.Repo
  alias MiniProject.Practitioners.Practitioner

  @api_url "https://fakerapi.it/api/v1/persons?_locale=es_ES&_quantity=100"

  @moduledoc """
  The Practitioners context.
  """

  import Ecto.Query, warn: false
  alias MiniProject.Repo

  alias MiniProject.Practitioners.Practitioner

  @doc """
  Returns the list of practitioners.

  ## Examples

      iex> list_practitioners()
      [%Practitioner{}, ...]

  """
  def list_practitioners do
    Repo.all(Practitioner)
  end

  @doc """
  Gets a single practitioner.

  Raises `Ecto.NoResultsError` if the Practitioner does not exist.

  ## Examples

      iex> get_practitioner!(123)
      %Practitioner{}

      iex> get_practitioner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_practitioner!(id), do: Repo.get!(Practitioner, id)

  @doc """
  Creates a practitioner.

  ## Examples

      iex> create_practitioner(%{field: value})
      {:ok, %Practitioner{}}

      iex> create_practitioner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_practitioner(attrs \\ %{}) do
    %Practitioner{}
    |> Practitioner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a practitioner.

  ## Examples

      iex> update_practitioner(practitioner, %{field: new_value})
      {:ok, %Practitioner{}}

      iex> update_practitioner(practitioner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_practitioner(%Practitioner{} = practitioner, attrs) do
    practitioner
    |> Practitioner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a practitioner.

  ## Examples

      iex> delete_practitioner(practitioner)
      {:ok, %Practitioner{}}

      iex> delete_practitioner(practitioner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_practitioner(%Practitioner{} = practitioner) do
    Repo.delete(practitioner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking practitioner changes.

  ## Examples

      iex> change_practitioner(practitioner)
      %Ecto.Changeset{data: %Practitioner{}}

  """
  def change_practitioner(%Practitioner{} = practitioner, attrs \\ %{}) do
    Practitioner.changeset(practitioner, attrs)
  end

  def loader do
    case HTTPoison.get(@api_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> Map.get("data", [])
        |> Enum.map(&map_person_to_practitioner/1)
        |> Enum.each(&insert_practitioner/1)

        {:ok, "Practitioners loaded successfully"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp map_person_to_practitioner(person) do
    %{
      first_name: person["firstname"],
      last_name: person["lastname"],
      email: person["email"],
      phone: person["phone"],
      birthdate: parse_date(person["birthday"])
    }
  end

  defp parse_date(date_string) do
    case Date.from_iso8601(date_string) do
      {:ok, date} -> date
      _ -> nil
    end
  end

  defp insert_practitioner(attrs) do
    %Practitioner{}
    |> Practitioner.changeset(attrs)
    |> Repo.insert()
  end
end
