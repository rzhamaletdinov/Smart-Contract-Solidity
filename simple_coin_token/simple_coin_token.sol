pragma solidity ^0.4.13;

/**
 * Check own class functionality
 */ 

contract Ownable {
    
    address owner;
    
    function Ownable() {
        owner = msg.sender;
    }
 
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
 
    function transferOwnership(address newOwner) onlyOwner {
        owner == newOwner;
    }
} 
 
/**
 * ERC20 standard implemetned token 
 */
contract SimpleTokenCoin is Ownable{
    
    string public constant name     = 'Simple Coin Token';
    
    string public constant symbol   = "SCT";
    
    /**
     * digits after dot
     */
    uint32 public constant decimals = 18;
    
    /**
     * Total count emmissioned tokens (created tokens)
     * 
     * For public methods getters created automatically
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
     * List allowed sums for users to transfer from addresses
     */
    mapping (address => mapping(address => uint)) allowed;
    
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
        
        if(allowed[_from][msg.sender] < _value) {//TODO: check if isset(allowed[_from][msg.sender])
            return false;
        }
        
        allowed[_from][msg.sender] -= _value;
        balances[_from] -=_value;
        balances[_to] += _value;
        Transfer(_from, _to, _value);
        return true;
    }
    
    /**
     * Выпуск новых монет на кошелек пользователю
     */
    function mint(address _to,  uint _value) onlyOwner {
        assert(totalSupply + _value >= totalSupply && balances[_to] + _value >= balances[_to]); //What is assert? analog reqire?
        balances[_to] += _value;
        totalSupply += _value;
    }
    
    /**
     * Разрешить конкретному пользователю снять с опеределенного счета определенное кол-во денег
     */ 
    function approve(address _spender, uint _value) returns (bool success){
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    /**
     * Показать сколько денег доступно для снятия пользователю с конкретного адреса
     */
    function allowance(address _owner, address _spender) constant returns (uint remaining) {
        return allowed[_owner][_spender];
    }
    
    /**
     * Событие трансфера, надо дергать при трансфере
     */
    event Transfer(address indexed _from, address indexed _to, uint _value);
    
    /**
     * События разрешения перевода конкретной суммы конкретному пользователю
     */
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}