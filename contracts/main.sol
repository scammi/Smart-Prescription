pragma solidity ^0.5.0;

contract main{

  address goverment;
  uint public prescriptionId;
  struct prescription {
    address emmiter;
    string medication;
    uint dose;
  }
  mapping (uint => prescription) public prescriptions;
  mapping (address => bool) public doctors;

//owner of the contract has administration privileges
  constructor() public{
    goverment = msg.sender;
  }
//government gives permission to prescribe to doctor addresses
  function addDoctor (address _doctor) public{
    require(msg.sender == goverment);
    doctors[_doctor] = true;
  }
// checks if doctors have permission to prescribe
  function seeDoctor (address _doctor) public view returns(bool){
    return doctors[_doctor];
  }
//first checks if doctor allows, if so, it adds a prescription construct to the mapping
  function addPresciption (address _doctor, string memory _medication, uint _dose) public{
    require (seeDoctor(_doctor) == true, "ONLY DOCTORS CAN PRESCRIBE");
    prescriptionId++;
    prescriptions[prescriptionId] = prescription(_doctor, _medication, _dose);
  }


}
