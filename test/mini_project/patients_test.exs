defmodule MiniProject.PatientsTest do
  use MiniProject.DataCase

  alias MiniProject.Patients

  describe "patients" do
    alias MiniProject.Patients.Patient

    import MiniProject.PatientsFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, phone: nil, birthdate: nil, email: nil}

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert Patients.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert Patients.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      valid_attrs = %{first_name: "some  first_name", last_name: "some last_name", phone: "some phone", birthdate: ~D[2025-08-11], email: "123@123.com"}

      assert {:ok, %Patient{} = patient} = Patients.create_patient(valid_attrs)
      assert patient. first_name == "some  first_name"
      assert patient.last_name == "some last_name"
      assert patient.phone == "some phone"
      assert patient.birthdate == ~D[2025-08-11]
      assert patient.email == "123@123.com"
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Patients.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      update_attrs = %{first_name: "some updated  first_name", last_name: "some updated last_name", phone: "some updated phone", birthdate: ~D[2025-08-12], email: "123@123.com"}

      assert {:ok, %Patient{} = patient} = Patients.update_patient(patient, update_attrs)
      assert patient. first_name == "some updated  first_name"
      assert patient.last_name == "some updated last_name"
      assert patient.phone == "some updated phone"
      assert patient.birthdate == ~D[2025-08-12]
      assert patient.email == "123@123.com"
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = Patients.update_patient(patient, @invalid_attrs)
      assert patient == Patients.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = Patients.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> Patients.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = Patients.change_patient(patient)
    end
  end

  describe "patients api" do
    alias MiniProject.Patients.Patient

    import MiniProject.PatientsFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, email: nil, phone: nil, birthdate: nil}

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert Patients.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert Patients.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      valid_attrs = %{first_name: "some first_name", last_name: "some last_name", email: "123@123.com", phone: "some phone", birthdate: ~D[2025-08-13]}

      assert {:ok, %Patient{} = patient} = Patients.create_patient(valid_attrs)
      assert patient.first_name == "some first_name"
      assert patient.last_name == "some last_name"
      assert patient.email == "123@123.com"
      assert patient.phone == "some phone"
      assert patient.birthdate == ~D[2025-08-13]
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Patients.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      update_attrs = %{first_name: "some updated first_name", last_name: "some updated last_name", email: "123@123.com", phone: "some updated phone", birthdate: ~D[2025-08-14]}

      assert {:ok, %Patient{} = patient} = Patients.update_patient(patient, update_attrs)
      assert patient.first_name == "some updated first_name"
      assert patient.last_name == "some updated last_name"
      assert patient.email == "123@123.com"
      assert patient.phone == "some updated phone"
      assert patient.birthdate == ~D[2025-08-14]
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = Patients.update_patient(patient, @invalid_attrs)
      assert patient == Patients.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = Patients.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> Patients.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = Patients.change_patient(patient)
    end
  end
end
