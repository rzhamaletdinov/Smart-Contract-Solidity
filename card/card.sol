pragma solidity ^0.4.13;
 
contract Ownable {
    
    address owner;

    function Ownable (){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender != owner);
        _;
    }
    
    function setOwner(address newOwner) onlyOwner {
        owner = newOwner;
    }

    function getOwner() constant returns (address){
        return owner;
    }
}
 
contract BusinessCard is Ownable {
    
    mapping (bytes32 => string) repository;
    
    function getField(string key) constant returns (string) {
        return repository[sha256(key)];
    }
    
    function setField(string key, string value) onlyOwner {
        repository[sha256(key)] = value;
    }
}