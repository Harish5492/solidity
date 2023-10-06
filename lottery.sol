// SPDX-License-Identifier: MTL
pragma solidity >= 0.5.0 < 0.9.0;
contract Lottery
{
    address public manager;
    address payable[] public participants;

    constructor()
    {
        manager = msg.sender;
    }

    receive () payable external 
    {
        require(msg.value >= 2 ether);
        participants.push(payable(msg.sender));
    }

    function Chkbalance() public view returns(uint)
    {
        require(manager ==msg.sender);
        return address(this).balance ;
    }

    function Random() public view returns(uint)
    {
      return  uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,participants.length)));
    }

    function Winner() public  
    {
        require(manager ==msg.sender);
        require(participants.length>=3);
        uint r = Random();
        address payable winner;
        uint index = r% participants.length;
        winner = participants[index];
        winner.transfer(Chkbalance());
        participants = new address payable [](0);

    }




}