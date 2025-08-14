defmodule MiniProjectWeb.Api.PrescriptionJSON do
  alias MiniProject.Prescriptions.Prescription

  @doc """
  Renders a list of prescriptions.
  """
  def index(%{prescriptions: prescriptions}) do
    %{data: for(prescription <- prescriptions, do: data(prescription))}
  end

  @doc """
  Renders a single prescription.
  """
  def show(%{prescription: prescription}) do
    %{data: data(prescription)}
  end

  defp data(%Prescription{} = prescription) do
    %{
      id: prescription.id,
      detail: prescription.detail,
      patient_id: prescription.patient_id,
      practitioner_id: prescription.practitioner_id
    }
  end
end
