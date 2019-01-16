pragma solidity ^0.5.0;

contract main{

  address goverment;
  uint public prescriptionId;
  struct prescription {
    address emmiter;
    string medication;
    uint dose;
    uint refill;
  }

  mapping (uint => prescription) public prescriptions;
  mapping (address => bool) public pharmacies;
  mapping (address => bool) public doctors;

//owner of the contract has administration privileges
  constructor() public{
    goverment = msg.sender;
  }

//government gives permission
  function addDoctor (address _doctor) public{
    require(msg.sender == goverment);
    doctors[_doctor] = true;
  }
  function addPharmacy (address _pharmacy) public{
    require(msg.sender == goverment);
    pharmacies[_pharmacy] = true;
  }

// checks if doctors and pharmacy have permission to prescribe
  function seeDoctor (address _doctor) public view returns(bool){
    return doctors[_doctor];
  }
  function seePharmacy (address _pharmacy) public view returns (bool){
    return pharmacies[_pharmacy];
  }

//first checks if doctor allows, if so, it adds a prescription construct to the mapping
  function addPresciption (address _doctor, string memory _medication, uint _dose, uint _refill) public{
    require (seeDoctor(_doctor) == true, "ONLY DOCTORS CAN PRESCRIBE");
    prescriptionId++;
    prescriptions[prescriptionId] = prescription(_doctor, _medication, _dose, _refill);
  }
//pharmacy should be able to view, modify and destroy prescriptions.
//we must register pharmacies addresses and give them permissions
//to view they can just called the public mapping
//to modify i gonna try to access the mapping
//to destroy we need a new function
//owner of the prescription is anyone who has it
function giveDrug(uint _prescriptionId, address _pharmacy) public{
  require (seePharmacy(_pharmacy) == true, "ONLY REGISTER PHARMACY AND MODIFY PRESCRIPTION");
  uint refill = prescriptions[_prescriptionId].refill;
    if (refill == 0){
      delete (prescriptions[_prescriptionId]);
    } else {
      prescriptions[_prescriptionId].refill--;
    }
}

}
