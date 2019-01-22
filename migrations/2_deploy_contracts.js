var smartPrescription = artifacts.require("./smartPrescription.sol");

module.exports = function(deployer) {
  deployer.deploy(smartPrescription);
};
