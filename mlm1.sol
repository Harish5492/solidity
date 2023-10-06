// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract mlm {
    mapping(address => address) public users;
    mapping(address => bool) public isuser;
    
    constructor()
    {
        require(users[msg.sender]==address(0),"user already exists");
        isuser[msg.sender]=true;
    }

    function marketing(address referrer) public payable {
        require(msg.value == 1 ether, "must have 1 ether");
        require(!isuser[msg.sender],"user already exists");
        address currentreferrer = referrer;
        payable(currentreferrer).transfer((msg.value * 10) / 100);
        currentreferrer = users[currentreferrer];
        if (currentreferrer != address(0)) {
            payable(currentreferrer).transfer((msg.value * 5) / 100);
            currentreferrer = users[currentreferrer];
            if (currentreferrer != address(0)) {
                payable(currentreferrer).transfer((msg.value * 3) / 100);
                currentreferrer = users[currentreferrer];
                if (currentreferrer != address(0)) {
                    payable(currentreferrer).transfer((msg.value * 2) / 100);
                    currentreferrer = users[currentreferrer];
                    if (currentreferrer != address(0)) {
                        payable(currentreferrer).transfer(
                            (msg.value * 1) / 100 );
                        currentreferrer = users[currentreferrer];
                    }
                }
            }
        }
    }
}
