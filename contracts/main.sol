pragma solidity ^0.5.0;

contract main{

  address goverment;
  constructor() public{
    goverment = msg.sender;
  }

  address[] private doctors;

  struct prescription {
    address emmiter;
    string medication;
    uint dose;
  }

  uint public prescriptionId = 0;
  mapping (uint => prescription) public prescriptions;

  function addCounter (address _doctor, string memory _medication, uint _dose) public{
    prescriptionId++;
    prescriptions[prescriptionId] = prescription(_doctor, _medication, _dose);

  }

  function addDoctor (address _doctor) public{
    require(msg.sender == goverment);
    doctors.push(_doctor);
  }
}
