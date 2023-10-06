// SPDX-License-Identifier: MTL
pragma solidity >= 0.5.0 < 0.9.0;
contract Event_Contract 
{
    struct Event{
        address organizer;
        string name;
        uint date;
        uint price;
        uint ticketcount;
        uint ticketremain;

    }
     
     mapping(uint=>Event) public events;
     mapping(address=>mapping(uint=>uint)) public tickets;
     uint  nextid;

     function CreateEvent(string memory _name, uint _date, uint _price, uint _ticketcount) external
     {
       require(_date>block.timestamp,"your event is not valid");
       require(_ticketcount>0,"you can only organize the event if ticket are more than zero");
       
       events[nextid] = Event(msg.sender,_name,_date,_price,_ticketcount,_ticketcount);
       nextid++;
     }

     function Buytickets(uint id,uint quantity) external payable
     {
        require(events[id].date!=0,"event does not exist");
        require(events[id].date>block.timestamp,"event has already occured");
        Event storage _event =events[id];
        require(msg.value==(_event.price*quantity),"you dont have enough ether");
        require(_event.ticketremain>=quantity,"tickets are not available");
        _event.ticketremain-=quantity;
        tickets[msg.sender] [id]+= quantity;
        
     }
     
     function TransferTickets(uint id, uint quantity, address to ) external 
     {
        require(events[id].date!=0,"event does not exist");
        require(events[id].date>block.timestamp,"event has already occured");
        require(tickets[msg.sender][id]>=quantity,"you don't have enough tickets");
        tickets[msg.sender][id] -=quantity;
        tickets[to][id]+= quantity;
     }
}