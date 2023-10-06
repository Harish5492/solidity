// SPDX-License-Identifier: MTL
pragma solidity >= 0.5.0 < 0.9.0;
// ToDo
// 1. Renting Functionality:
//    - Users should be able to rent a car by paying 1 Ether.
//    - The contract should store the details of the user and the rented car.
//    - Users should not be able to rent more than one car at a time.

// 2. Car Details:
//    - The contract should maintain a list of available cars with their details such as the car number and the price
//    - The contract should prevent multiple cars with the same number from being added

// 3. Returning Functionality:
//    - contract should be able to return a rented car.
//    - The contract should verify that the user has rented the specified car
//    - The contract should refund 75% of the Ether used as a fee to the user.
struct car
{   
    uint quantity;
    uint car_number;
    uint car_price;
    string car_name;
}
struct buyer
{   
    uint person;
    string name;
    address _buyer;
    uint driving_licence;
}
contract Car_rent
{  
   
   uint public  rent_fee = 1 ether;
   uint public refund_amt = 0.75 ether;
   mapping (address=>car) public cars;
   mapping (address=>buyer) public buyers;
   uint id;
   uint idd;

   function CarRent(uint _quantity, uint _person,string memory _name,address _buyer, uint _dl,uint carnumber, uint carprice,string memory carname) external payable 
   {
     require(msg.value==rent_fee,"insufficent balance");
     cars[msg.sender] = car(_quantity,carnumber, carprice, carname);
     idd++;
     buyers[msg.sender] = buyer(_person,_name,_buyer,_dl);
     id++;
     }

    function CarReturnd() public returns(bool)
{
    // require(cars[idd].quantity!=0 && buyers[id].person!=0,"car is not rented");
    // cars[idd].quantity-=qty;
    // buyers[id].person-=qty;
    // return true;
    //require(cars[msg.sender].car_number==_abc , "car not available");
    delete cars[msg.sender];
    delete buyers[msg.sender];
    return true;

}

  function CarRefund() public 
  {  
     payable(msg.sender).transfer(refund_amt);
  }
}
