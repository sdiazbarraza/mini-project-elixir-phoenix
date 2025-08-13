defmodule MiniProject.Prescriptions.Prescription do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Flop.Schema,
         filterable: [:practitioner_first_name, :practitioner_last_name, :patient_first_name, :patient_last_name],
         sortable: [:practitioner_first_name, :practitioner_last_name, :patient_first_name, :patient_last_name],
         join_fields: [
           practitioner_first_name: [binding: :practitioner, field: :first_name],
           practitioner_last_name: [binding: :practitioner, field: :last_name],
           patient_first_name: [binding: :patient, field: :first_name],
           patient_last_name: [binding: :patient, field: :last_name]
         ],
         default_limit: 50
  }

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
