// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

contract StorageV1{

    mapping (address=>string) private CheckSum;

    address private ManagerProxyAddress;

    address private owner;

    constructor(){
        owner = msg.sender;
    }

     modifier IsCaller(){
        require(ManagerProxyAddress == msg.sender);
        _;
    }

    function StoreVal(string memory _Hash,address _storer) 
    external IsCaller
    {
        CheckSum[_storer] = _Hash;
    }

    function RetriveVal(address _from_pk) external IsCaller view returns(string memory){
        return CheckSum[_from_pk];
    }


    function SetCaller(address _CallerAddress) public IsOwner{
        ManagerProxyAddress = _CallerAddress;
    }

    modifier IsOwner(){
        require(msg.sender == owner);
        _;
    }

    //Test function
    function getAdmin()external view returns(address){
        return owner;
    }
}
