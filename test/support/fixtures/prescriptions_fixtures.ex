defmodule MiniProject.PrescriptionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiniProject.Prescriptions` context.
  """

  @doc """
  Generate a prescription.
  """
  def prescription_fixture(attrs \\ %{}) do
    patient =  MiniProject.PatientsFixtures.patient_fixture()
    practitioner = MiniProject.PractitionersFixtures.practitioner_fixture()

    {:ok, prescription} =
      attrs
      |> Enum.into(%{
         detail: "some  detail",
         patient_id: patient.id, 
         practitioner_id: practitioner.id        
      })
      |> MiniProject.Prescriptions.create_prescription()

    prescription
  end
end
