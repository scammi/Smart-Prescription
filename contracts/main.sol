pragma solidity ^0.5.0;

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

}
