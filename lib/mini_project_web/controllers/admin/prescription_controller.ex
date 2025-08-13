defmodule MiniProjectWeb.Admin.PrescriptionController do
  use MiniProjectWeb, :controller
  import Ecto.Query
  alias MiniProject.Repo
  alias MiniProject.Prescriptions
  alias MiniProject.Prescriptions.Prescription

  def index(conn, params) do
    query =
      from p in Prescription,
        join: patient in assoc(p, :patient),
        join: practitioner in assoc(p, :practitioner),
        preload: [patient: patient, practitioner: practitioner]

    {:ok, {prescriptions, meta}} =
      Flop.validate_and_run(query, params, for: Prescription, repo: Repo)

    render(conn, :index,
      prescriptions: prescriptions,
      meta: meta
    )
  end

  def new(conn, _params) do
    changeset = Prescriptions.change_prescription(%Prescription{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"prescription" => prescription_params}) do
    case Prescriptions.create_prescription(prescription_params) do
      {:ok, prescription} ->
        conn
        |> put_flash(:info, "Prescription created successfully.")
        |> redirect(to: ~p"/admin/prescriptions/#{prescription}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    prescription = Prescriptions.get_prescription!(id) |> Repo.preload([:practitioner, :patient])
    render(conn, :show, prescription: prescription)
  end

  def edit(conn, %{"id" => id}) do
    prescription = Prescriptions.get_prescription!(id)
    changeset = Prescriptions.change_prescription(prescription)
    render(conn, :edit, prescription: prescription, changeset: changeset)
  end

  def update(conn, %{"id" => id, "prescription" => prescription_params}) do
    prescription = Prescriptions.get_prescription!(id)

    case Prescriptions.update_prescription(prescription, prescription_params) do
      {:ok, prescription} ->
        conn
        |> put_flash(:info, "Prescription updated successfully.")
        |> redirect(to: ~p"/admin/prescriptions/#{prescription}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, prescription: prescription, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    prescription = Prescriptions.get_prescription!(id)
    {:ok, _prescription} = Prescriptions.delete_prescription(prescription)

    conn
    |> put_flash(:info, "Prescription deleted successfully.")
    |> redirect(to: ~p"/admin/prescriptions")
  end
end
