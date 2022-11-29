// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

interface Admin{
    function getAdmins() external view returns (address[] memory);
}

contract ManagerV1 is Initializable, UUPSUpgradeable{

    struct Receiver {
        address to;
        bool exists;
    }

    mapping (address=>Receiver) private correspondings;

    address[] adminList;

    Admin AdminContractInstance;

     mapping (address=>string) private CheckSum;


    function Inizialize(address _AdminAddress) public initializer{
        AdminContractInstance = Admin(_AdminAddress);
    }
    
    function _authorizeUpgrade(address newImplementation) internal override{

    }

// Interface for interaction with Storage smart contract

    function StoreInterface(string memory Hash) external {
        if(!MappingExists(msg.sender))
            revert();
        CheckSum[msg.sender] = Hash;
        //StorageContractProxyInstance.StoreVal(Hash, msg.sender);
    }


    function RetriveInterface(address _receiver) external view returns(string memory){
        if(!(correspondings[msg.sender].to == _receiver))
            revert();
        return CheckSum[msg.sender];
        //StorageContractProxyInstance.RetriveVal(msg.sender);
    }
// END --Interface for storage smart contract

// Starting corresponding managment for ensure the correct usage of the pipeline

    function MappingExists(address _key) private view returns(bool exists) {
        return correspondings[_key].exists;
    }

    function newCorresponding(address _sender,address _receiver) 
    external OnlyOwnerof 
    validAddress(_sender) 
    validAddress(_receiver)
    returns(bool isAdded)
    {
        require(!MappingExists(_sender));
        correspondings[_sender].to = _receiver;
        correspondings[_sender].exists = true;
        return true;
    }

    function deleteCorresponding(address _sender)
    external OnlyOwnerof
    validAddress(_sender)
    returns(bool isDeleted) {
        require(MappingExists(_sender));
        correspondings[_sender].exists = false;
        return true;
    }

    function updateEntity(address _sender, address _receiver) 
    external OnlyOwnerof
    validAddress(_sender)
    validAddress(_receiver)
    returns(bool isUpdated) {
        require(MappingExists(_sender));
        correspondings[_sender].to = _receiver;
        return true;
    }

    // -- Correspondings managment 

    // Owner checkings to ensure the caller is authorized

    modifier OnlyOwnerof(){
        //adminList = AdminContractInstance.getAdmins();
        //for(uint i=0;i<adminList.length;i++){
        //    if(adminList[i] == msg.sender)
                _;
        //}
        //revert("Not Allowed");
    }
    // -- Owner checkings

    modifier validAddress(address _address){
        require(_address != address(0));
        _;
    }

    //Test function
    function getAdminList() external view returns(address [] memory){
        return AdminContractInstance.getAdmins();
    }

}