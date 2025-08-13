defmodule MiniProject.PractitionersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiniProject.Practitioners` context.
  """

  @doc """
  Generate a practitioner.
  """
  def practitioner_fixture(attrs \\ %{}) do
    {:ok, practitioner} =
      attrs
      |> Enum.into(%{
         first_name: "some  first_name",
        birthdate: ~D[2025-08-11],
        email: "123@123.com",
        last_name: "some last_name",
        phone: "some phone"
      })
      |> MiniProject.Practitioners.create_practitioner()

    practitioner
  end
end
