defmodule MiniProject.Prescriptions.Prescription do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prescriptions" do
    field :detail, :string
    belongs_to :patient, MiniProject.Patients.Patient
    belongs_to :practitioner, MiniProject.Practitioners.Practitioner

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(prescription, attrs) do
    prescription
    |> cast(attrs, [:detail, :practitioner_id, :patient_id])
    |> validate_required([:detail])
  end
end
