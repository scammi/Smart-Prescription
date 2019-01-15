pragma solidity ^0.5.0;

contract main{

  address goverment;
  uint public prescriptionId;
  address[] public doctors;
  struct prescription {
    address emmiter;
    string medication;
    uint dose;
  }

  constructor() public{
    goverment = msg.sender;
  }

  modifier beDoc (address _doctor){
        require(
            doctors[_doctor].exists,
            "Only doctors can call this function."
        );
        _;
    }

  mapping (uint => prescription) public prescriptions;

  function addCounter (address _doctor, string memory _medication, uint _dose) public beDoc(_doctor){
    prescriptionId++;
    prescriptions[prescriptionId] = prescription(_doctor, _medication, _dose);
  }

  function addDoctor (address _doctor) public{
    require(msg.sender == goverment);
    doctors.push(_doctor);
  }
}
