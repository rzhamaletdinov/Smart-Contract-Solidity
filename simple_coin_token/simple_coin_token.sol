pragma solidity ^0.4.13;
 
 
/**
 * ERC20 standard implemetned token 
 */
contract SimpleTokenCoin {
    
    string public constant name     = 'Simple Coin Token';
    
    string public constant symbol   = "SCT";
    
    /**
     * digits after dot
     */
    uint32 public constant decimals = 18;
    
    /**
     * Total count emmissioned tokens (created tokens)
     */
    uint public totalSupply         = 0;
    
    /**
     *  Balances of users
     */
    mapping (address => uint) balances;
    
    /**
     * Balance of user
     */
    function balancesOf(address _current_address) constant returns (uint balance){
            return balances[_current_address];
    }
    
    /**
     *  Transfe fron owner to address
     */
    function transfer(address _to, uint _value) returns (bool success) {
        
        if(balances[msg.sender] < _value || 
            balances[_to] + _value < balances[_to]) { //check overflowing uint value
            return false;
        }
        
        balances[msg.sender] -=_value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint _value) returns (bool success) {
        if(balances[_from] < _value || 
            balances[_to] + _value < balances[_to]) { //check overflowing uint value
            return false;
        }
        
        balances[_from] -=_value;
        balances[_to] += _value;
        Transfer(_from, _to, _value);
        return true;
    }
    
    function approve(address _spender, uint _value) returns (bool success){
        return true;
    }
    
    function allowance(address _owner, address _spender) constant returns (uint remaining) {
        return 0;        
    }
    
    event Transfer(address indexed _from, address indexed _to, uint _value);
    
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}