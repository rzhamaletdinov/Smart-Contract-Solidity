pragma solidity ^0.4.13;
 
contract BusinessCard {
    
    mapping (bytes32 => string) data;
    
    string name;
    
    uint age;
    
    uint year;
    
    function getData(string key) constant returns (string) {
        return data[sha256(key)];
    }
    
    function setData(string key, string value) {
        data[sha256(key)] = value;
    }
    
    function getName() constant returns (string) {
        return name;
    }
    
    function setName(string newName) {
        name = newName;
    }
    
    function getAge() constant returns (uint) {
        return age;
    }
    
    function setAge(uint newAge) {
        age = newAge;
    }

    function getYear() constant returns (uint) {
        return year;
    }
    
    function setYear(uint newYear){
        year = newYear;
    }
}