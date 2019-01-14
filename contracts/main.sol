pragma solidity ^0.5.0;

contract main{

  address doctor = msg.sender;

  struct prescription {
    address emmiter;
    string medication;
    uint dose;
  }

  uint public prescriptionId = 0;
  mapping (uint => prescription) public prescriptions;

  function addCounter (string memory _medication, uint _dose) public{
    prescriptionId++;
    prescriptions[prescriptionId] = prescription(doctor, _medication, _dose);

  }

}
