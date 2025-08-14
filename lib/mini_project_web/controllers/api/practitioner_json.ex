defmodule MiniProjectWeb.Api.PractitionerJSON do
  alias MiniProject.Practitioners.Practitioner

  @doc """
  Renders a list of practitioners.
  """
  def index(%{practitioners: practitioners}) do
    %{data: for(practitioner <- practitioners, do: data(practitioner))}
  end

  @doc """
  Renders a single practitioner.
  """
  def show(%{practitioner: practitioner}) do
    %{data: data(practitioner)}
  end

  defp data(%Practitioner{} = practitioner) do
    %{
      id: practitioner.id,
      first_name: practitioner.first_name,
      last_name: practitioner.last_name,
      email: practitioner.email,
      phone: practitioner.phone,
      birthdate: practitioner.birthdate
    }
  end
end
