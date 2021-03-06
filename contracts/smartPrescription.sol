pragma solidity ^0.5.0;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721.sol';

/**
 * @title Smart-Presciptions emulated with smart contrats
 * @dev see https://github.com/scammi/Smart-Prescription
 */
contract smartPrescription is ERC721{

//sudo account that grants permissions
  address goverment;

//ID of every prescription
  uint public prescriptionId;

//Struct emulating a pharmaceutical prescription
  struct prescription {
    address emitter;
    string medication;
    uint dose;
    uint refill;
  }

//Mapping from token id to the prescription struct
  mapping (uint => prescription) public prescriptions;

//Mapping from pharmacies address to its permission
  mapping (address => bool) public pharmacies;

//Mapping from doctors address to its permission
  mapping (address => bool) public doctors;

//Constructor of contarct makes goverment sudo administration privileges
  constructor() public{
    goverment = msg.sender;
  }

/**
*@dev sudo account gives doctors address permission to mint prescriptions tokens
*@param _doctor address belongs to the doctor to give mint rights
*/
  function permissionDoctor (address _doctor, bool _bool) public{
    require(msg.sender == goverment);

    doctors[_doctor] = _bool;
  }

/**
*@dev sudo account gives pharmacies permission to modify tokens
*@param _pharmacy address belongs to the pharmacy to give rights to
*/
  function permissionPharmacy (address _pharmacy, bool _bool) public{
    require(msg.sender == goverment);

    pharmacies[_pharmacy] = _bool;
  }

/**
*@dev returns wheter an address has been given permission
*@param _doctor addres to be evaluated
*/
  function seeDoctor (address _doctor) public view returns(bool){
    return doctors[_doctor];
  }

/**
*@dev returns wheter an address has been given permission
*@param _pharmacy addres to be evaluated
*/
  function seePharmacy (address _pharmacy) public view returns (bool){
    return pharmacies[_pharmacy];
  }

/**
*@dev creates a new prescription construct which is added to prescription
*mapping using as key prescription ID.
*Then _mint from zepelin ERC721 standar creates a NFT and gives to patient address
*it also evaluates if the emmiter has permission with require
*increments the prescriptionId
*@param _doctor address emmiter
*@param _medication string drug being prescribed
*@param _dose uint the amount of the drug
*@param _refill uint times the prescription is valid
*/
  function addPrescription (address _patient, address _doctor, string memory _medication, uint _dose, uint _refill) public{
    require (seeDoctor(_doctor) == true, "ONLY VALID DOCTORS CAN PRESCRIBE");

    prescriptionId++;

    prescriptions[prescriptionId] = prescription(_doctor, _medication, _dose, _refill);

    _mint(_patient, prescriptionId);
  }

/**
@dev modifies prescriptions refill variable decresing by one every time it's called
*until it reaches 0 where the prescription will be deleted
*pharmacies should fire this function when disposing the drug to the patient
*the function first checks the permission of the pharmacy
@param _prescriptionId uint the prescription struct of the drug being ask for
@param _pharmacy address belongs to the pharmacy calling this function
*/
function giveDrug(uint _prescriptionId, address _pharmacy) public{
  require (seePharmacy(_pharmacy) == true, "ONLY VALID PHARMACY AND MODIFY PRESCRIPTION");

  uint refill = prescriptions[_prescriptionId].refill;
    if (refill == 0){

      delete (prescriptions[_prescriptionId]);
      _burn(_prescriptionId);

    } else {

      prescriptions[_prescriptionId].refill--;
    }
}

}
