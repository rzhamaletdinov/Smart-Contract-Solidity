pragma solidity ^0.4.13;
 
contract BusinessCard {
    
    mapping (bytes32 => string) repository;
    
    address owner;
    
    string name;
    
    uint age;
    
    uint year;
    
    function BusinessCard () {
        owner = msg.sender;
    }

    function getOwner () constant returns (address){
        return owner;
    }
    
    function getField(string key) constant returns (string) {
        return repository[sha256(key)];
    }
    
    function setField(string key, string value) {
        require(msg.sender == owner);
//        if(msg.sender != owner)
//            throw;
        repository[sha256(key)] = value;
    }
}