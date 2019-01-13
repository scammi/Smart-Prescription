pragma solidity ^0.5.2;

contract creatorPrescription {

  address sudo;
  address patientStatic;

  struct prescription {
    address emmiter;
    address patient;
    string medication;
    uint dose;
  }

  uint prescriptionId;
  mapping (uint => prescription) prescriptions;

  function createPrescription (string _medication, uint _dose) returns (uint prescriptionId) {
    prescriptionId = prescriptionId++;
    prescriptions[prescriptionId] = prescription(sudo, patientStatic, _medication, _dose);
    return prescriptionId;
  }

}
