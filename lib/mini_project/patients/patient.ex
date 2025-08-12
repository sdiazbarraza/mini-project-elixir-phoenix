defmodule MiniProject.Patients.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :"first_name", :string
    field :last_name, :string
    field :phone, :string
    field :birthdate, :date
    field :email, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:" first_name", :last_name, :phone, :birthdate, :email])
    |> validate_required([:" first_name", :last_name, :phone, :birthdate, :email])
    |> validate_format(:email, ~r/^[\w.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$/, message: "tiene un formato inválido")
    |> unique_constraint(:email, message: "ya está en uso")
  end
end
