defmodule MiniProjectWeb.Api.PrescriptionControllerTest do
  use MiniProjectWeb.ConnCase

  import MiniProject.PrescriptionsFixtures
  import MiniProject.PatientsFixtures
  import MiniProject.PractitionersFixtures

  alias MiniProject.Prescriptions.Prescription

  @create_attrs %{
    detail: "some detail",
    patient_id: 1,        
    practitioner_id: 1 
  }
  @update_attrs %{
    detail: "some updated detail",
    patient_id: 1,        
    practitioner_id: 1 
  }
  @invalid_attrs %{detail: nil, patient_id: nil, practitioner_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all prescriptions", %{conn: conn} do
      conn = get(conn, ~p"/api/prescriptions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create prescription" do
    test "renders prescription when data is valid", %{conn: conn} do
      patient = patient_fixture()
      practitioner = practitioner_fixture()

      create_attrs = %{
        detail: "some detail",
        patient_id: patient.id,
        practitioner_id: practitioner.id
      }

      conn = post(conn, ~p"/api/prescriptions", prescription: create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/prescriptions/#{id}")

      assert %{
              "id" => ^id,
              "detail" => "some detail"
            } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/prescriptions", prescription: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update prescription" do
    setup %{conn: conn} do
      patient = patient_fixture()
      practitioner = practitioner_fixture()

      prescription =
        %MiniProject.Prescriptions.Prescription{
          detail: "some detail",
          patient_id: patient.id,
          practitioner_id: practitioner.id
        }
        |> MiniProject.Repo.insert!()

      {:ok, conn: conn, prescription: prescription}
    end

  test "renders prescription when data is valid", %{conn: conn, prescription: %Prescription{id: id} = prescription} do
    update_attrs = %{detail: "some updated detail"}

    conn = put(conn, ~p"/api/prescriptions/#{prescription}", prescription: update_attrs)
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get(conn, ~p"/api/prescriptions/#{id}")

    assert %{
             "id" => ^id,
             "detail" => "some updated detail"
           } = json_response(conn, 200)["data"]
  end

    test "renders errors when data is invalid", %{conn: conn, prescription: prescription} do
      conn = put(conn, ~p"/api/prescriptions/#{prescription}", prescription: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete prescription" do
    setup [:create_prescription]

    test "deletes chosen prescription", %{conn: conn, prescription: prescription} do
      conn = delete(conn, ~p"/api/prescriptions/#{prescription}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/prescriptions/#{prescription}")
      end
    end
  end

  defp create_prescription(_) do
    prescription = prescription_fixture()
    %{prescription: prescription}
  end
end
