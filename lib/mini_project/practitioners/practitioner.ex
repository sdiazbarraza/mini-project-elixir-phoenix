defmodule MiniProject.Practitioners.Practitioner do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {
    Flop.Schema,
    filterable: [:first_name, :last_name],
    sortable: [:first_name, :last_name],
    default_limit: 50
  }

  schema "practitioners" do
    field :first_name, :string
    field :last_name, :string
    field :phone, :string
    field :birthdate, :date
    field :email, :string
    has_many :prescriptions, MiniProject.Prescriptions.Prescription
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(practitioner, attrs) do
    practitioner
    |> cast(attrs, [:first_name, :last_name, :phone, :birthdate, :email])
    |> validate_required([:first_name, :last_name, :phone, :birthdate, :email])
    |> validate_format(:email, ~r/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/, message: "tiene un formato inválido")
    |> unique_constraint(:email, message: "ya está en uso")
  end
end
