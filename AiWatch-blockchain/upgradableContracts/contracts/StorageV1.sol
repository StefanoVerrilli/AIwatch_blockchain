// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

contract Storage{
    struct Queue{
        mapping(uint256=>string) HashList;
        uint256 first;
        uint256 last;
    }

    mapping (address=>Queue) private queue;

    address private ManagerProxyAddress;

    address private owner;
    
    event hashevent(string hash);

    constructor(){
        owner = msg.sender;
    }

     modifier IsCaller(){
        //require(ManagerProxyAddress == msg.sender);
        _;
    }

    function StorreVal(string memory _Hash,address _storer)
    external IsCaller
    {
        queue[_storer].HashList[queue[_storer].last] = _Hash;
        queue[_storer].last+=1;
    }

    function RetriveVal(address _from_pk) external IsCaller{
        require(queue[_from_pk].last>queue[_from_pk].first);
        string memory data = queue[_from_pk].HashList[queue[_from_pk].first];
        emit hashevent(data);
        delete queue[_from_pk].HashList[queue[_from_pk].first];
        queue[_from_pk].first+=1;
    }


    function getList(address _from_pk) external view returns(string memory hashes){
        hashes = queue[_from_pk].HashList[queue[_from_pk].first];
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
