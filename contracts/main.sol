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

  constructor public {sudo = msg.sender;}

  function createPrescription (string _medication, uint _dose) return (uint prescriptionId) {
    prescriptionId = prescriptionId++;
    prescriptions[prescriptionId] = prescription(sudo, patientStatic, _medication, _dose);
    return prescriptionId;
  }
  
}
