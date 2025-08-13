defmodule MiniProject.Prescriptions do
  alias MiniProject.Repo

  alias MiniProject.Patients.Patient
  alias MiniProject.Practitioners.Practitioner
  alias MiniProject.Prescriptions.Prescription
  alias Flop
  alias Faker.Lorem

  @moduledoc """
  The Prescriptions context.
  """

  import Ecto.Query, warn: false
  alias MiniProject.Repo

  alias MiniProject.Prescriptions.Prescription

  @doc """
  Returns the list of prescriptions.

  ## Examples

      iex> list_prescriptions()
      [%Prescription{}, ...]

  """
  def list_prescriptions do
    Repo.all(Prescription)
  end

  @doc """
  Gets a single prescription.

  Raises `Ecto.NoResultsError` if the Prescription does not exist.

  ## Examples

      iex> get_prescription!(123)
      %Prescription{}

      iex> get_prescription!(456)
      ** (Ecto.NoResultsError)

  """
  def get_prescription!(id), do: Repo.get!(Prescription, id)

  @doc """
  Creates a prescription.

  ## Examples

      iex> create_prescription(%{field: value})
      {:ok, %Prescription{}}

      iex> create_prescription(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_prescription(attrs \\ %{}) do
    %Prescription{}
    |> Prescription.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a prescription.

  ## Examples

      iex> update_prescription(prescription, %{field: new_value})
      {:ok, %Prescription{}}

      iex> update_prescription(prescription, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_prescription(%Prescription{} = prescription, attrs) do
    prescription
    |> Prescription.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a prescription.

  ## Examples

      iex> delete_prescription(prescription)
      {:ok, %Prescription{}}

      iex> delete_prescription(prescription)
      {:error, %Ecto.Changeset{}}

  """
  def delete_prescription(%Prescription{} = prescription) do
    Repo.delete(prescription)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking prescription changes.

  ## Examples

      iex> change_prescription(prescription)
      %Ecto.Changeset{data: %Prescription{}}

  """
  def change_prescription(%Prescription{} = prescription, attrs \\ %{}) do
    Prescription.changeset(prescription, attrs)
  end

  def loader do
    practitioners = Repo.all(Practitioner)
    patients = Repo.all(Patient)

    if practitioners == [] or patients == [] do
      {:error, "No hay médicos o pacientes disponibles para asignar recetas"}
    else
      for _ <- 1..100 do
        practitioner = Enum.random(practitioners)
        patient = Enum.random(patients)

        if practitioner && patient do
          %Prescription{}
          |> Prescription.changeset(%{
            detail: Lorem.sentence(),
            practitioner_id: practitioner.id,
            patient_id: patient.id
          })
          |> Repo.insert()
        else
          IO.puts("Error: Practitioner o Patient es nil")
        end
      end
      {:ok, "Recetas creadas exitosamente"}
    end
  end 

  def list_prescriptions(params \\ %{}) do
    query =
      Prescription
      |> Repo.preload([:patient, :practitioner])  # preload relaciones

    Flop.validate_and_run(query, params, for: Prescription, repo: Repo)
  end 
end
