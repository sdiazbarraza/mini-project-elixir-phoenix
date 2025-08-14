defmodule MiniProjectWeb.Api.PatientJSON do
  alias MiniProject.Patients.Patient

  @doc """
  Renders a list of patients.
  """
  def index(%{patients: patients}) do
    %{data: for(patient <- patients, do: data(patient))}
  end

  @doc """
  Renders a single patient.
  """
  def show(%{patient: patient}) do
    %{data: data(patient)}
  end

  defp data(%Patient{} = patient) do
    %{
      id: patient.id,
      first_name: patient.first_name,
      last_name: patient.last_name,
      email: patient.email,
      phone: patient.phone,
      birthdate: patient.birthdate
    }
  end
end
