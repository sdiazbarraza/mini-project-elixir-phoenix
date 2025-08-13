defmodule MiniProjectWeb.Admin.PatientController do
  use MiniProjectWeb, :controller

  alias MiniProject.Patients
  alias MiniProject.Patients.Patient
  alias FlopPhoenix.Phoenix

  def index(conn, params) do
     {:ok, {patients, meta}} = Flop.validate_and_run(Patient, params, for: Patient)
    render(conn, :index, patients: patients, meta: meta)
  end

  def new(conn, _params) do
    changeset = Patients.change_patient(%Patient{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"patient" => patient_params}) do
    case Patients.create_patient(patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient created successfully.")
        |> redirect(to: ~p"/admin/patients/#{patient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id)
    render(conn, :show, patient: patient)
  end

  def edit(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id)
    changeset = Patients.change_patient(patient)
    render(conn, :edit, patient: patient, changeset: changeset)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = Patients.get_patient!(id)

    case Patients.update_patient(patient, patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient updated successfully.")
        |> redirect(to: ~p"/admin/patients/#{patient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, patient: patient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id)
    {:ok, _patient} = Patients.delete_patient(patient)

    conn
    |> put_flash(:info, "Patient deleted successfully.")
    |> redirect(to: ~p"/admin/patients")
  end
end
