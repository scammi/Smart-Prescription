# Smart-Prescription
Digital medical drug prescription with smart contracts

#### About.
Electronic medical drug prescription emulated with smart contracts.
Enables physicians to create ERC271 nonfungible tokens that are delegated to the patient address. The token is exchanged in a pharmacy for the drug and burned.

The token struct contains de following variables:
  * PatientAdress
  * Drug
  * Dose
  * Counter

It is intended to be possible to add programmable elements to such a system, enabling automated refills, expiration dates, and detection of contraindications and adverse effects.

There are 3 main players and a coordinator (government) or sudo for now. The other 3 players are
the doctor, the patient, and the pharmacies. Every each one will have different permissions.

First, all methods and variables will be created and the sudo account will be used to test, later
every party will be delegated its function by permissions.

Main methods.
  * create structs
  * view
Main variables
  * struct for prescriptions
  * dynamic array for prescriptions

#### Installation guide
1. things you'll need
	* npm
	* Truffle framework
	* Ganache or other local blockchain
2. Clone the respository to your machine
3. Fire up ganache and open CLI on the proyect directory
4. Run truffle build | truffle migrate --reset
	* now we have deployed our contract to the local chain and we are ready to interact with it
5. Run truffle console 
