defmodule MiniProject.PatientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiniProject.Patients` context.
  """

  @doc """
  Generate a patient.
  """
  def patient_fixture(attrs \\ %{}) do
    {:ok, patient} =
      attrs
      |> Enum.into(%{
         first_name: "some  first_name",
        birthdate: ~D[2025-08-11],
        email: "some email",
        last_name: "some last_name",
        phone: "some phone"
      })
      |> MiniProject.Patients.create_patient()

    patient
  end
end
