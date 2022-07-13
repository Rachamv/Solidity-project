pragma solidity ^0.5.7;

contract Will {
    address owner;
    uint    fortune;
    bool    deceased;

    constructor() payable public{
        owner = msg.sender; //msg sender address
        fortune = msg.value; //total amount to send
        deceased = false;

    }
    // modifier so the person can who call the contractis the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    // modifier so that only allocate funds when deceased happen
      modifier mustBeDeceased {
        require(deceased == true);
        _;
    }
    // list of family wallets
    address payable[]familyWallets;

    //map through inhertance
    mapping(address=>uint) inhertance;

    // set iheritance for each address
    function setInheritance(address payable wallet, uint amount) public {
    familyWallets.push(wallet);
    inhertance[wallet] = amount;
    }
     // pay each family member based on their wallet address
     function payout() private mustBeDeceased{
         for(uint i=0; i<familyWallets.length; i++){
             familyWallets[i].transfer(inhertance[familyWallets[i]]);
             // tranfering the funds from contractct address to reciever address 
         }
     }

     function hasDeceased() public onlyOwner {
             deceased = true;
             payout();
         }

}