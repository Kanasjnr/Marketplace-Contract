// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.27;

contract Marketplace {

    enum Status {
        Created,
        Pending,
        Sold
    }

    struct Item {
        string name;
        uint256 price;
        Status status;
    }

    address public owner;
    address public buyer;

    Item[] public items;
    mapping(uint256 => bool) public isSold;

    event ItemListed(string indexed name, uint256 price);
    event ItemSold(string indexed name, uint256 price, address buyer);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

function listItem(string memory _name, uint256 _price) external onlyOwner {
    require(msg.sender != address(0), "Zero address is not allowed");
    require(_price > 0, "Price must be greater than zero");

    Item memory newItem = Item({
        name: _name,
        price: _price, 
        status: Status.Created
    });

    items.push(newItem);
    emit ItemListed(_name, _price);
}

    function buyItem(uint256 _index) external payable {


        require(_index < items.length, "Item index out of bounds");
        Item storage itemToBuy = items[_index];

        
        require(itemToBuy.status == Status.Created, "Item not available for sale");
         require(msg.value == itemToBuy.price, "Incorrect amount sent");
        
        itemToBuy.status = Status.Sold;
        isSold[_index] = true;

        (bool sent, ) = owner.call{value: msg.value}("");
        require(sent, "Failed to send Ether");

        emit ItemSold(itemToBuy.name, itemToBuy.price, msg.sender);
    }

   
}
