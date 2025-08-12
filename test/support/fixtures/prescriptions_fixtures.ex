defmodule MiniProject.PrescriptionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiniProject.Prescriptions` context.
  """

  @doc """
  Generate a prescription.
  """
  def prescription_fixture(attrs \\ %{}) do
    {:ok, prescription} =
      attrs
      |> Enum.into(%{
         detail: "some  detail"
      })
      |> MiniProject.Prescriptions.create_prescription()

    prescription
  end
end
