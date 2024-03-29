// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Land is ERC721 {
    uint256 public cost = 1 ether;
    uint256 public maxSupply = 5;
    uint256 public totalSupply = 0;

    struct Building {
        string name;
        address owner;
        int256 posX;
        int256 posY;
        int256 posZ;
        uint256 sizeX;
        uint256 sizeY;
        uint256 sizeZ;
    }

    Building[] public Buildings;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _cost
    ) ERC721(_name, _symbol) {
        cost = _cost;

        Buildings.push(
            Building("City Hall", address(0x0), 0, 0, 0, 10, 10, 10)
        );
        Buildings.push(Building("Stadium", address(0x0), 0, 10, 0, 10, 5, 3));
        Buildings.push(
            Building("University", address(0x0), 0, -10, 0, 10, 5, 3)
        );
        Buildings.push(
            Building("Shopping Plaza 1", address(0x0), 10, 0, 0, 5, 25, 5)
        );
        Buildings.push(
            Building("Shopping Plaza 2", address(0x0), -10, 0, 0, 5, 25, 5)
        );
    }

    function mint(uint256 _id) public payable {
        uint256 supply = totalSupply;
        require(supply <= maxSupply);
        require(Buildings[_id - 1].owner == address(0x0));
        require(msg.value >= cost);

        // NOTE: tokenID always starts from 1, but our array starts from 0
        Buildings[_id - 1].owner = msg.sender;
        totalSupply = totalSupply + 1;

        _safeMint(msg.sender, _id);
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );

        // Update Building ownership
        Buildings[tokenId - 1].owner = to;

        _transfer(from, to, tokenId);
    }

    

    // Public View Functions
    function getBuildings() public view returns (Building[] memory) {
        return Buildings;
    }

    function getBuilding(uint256 _id) public view returns (Building memory) {
        return Buildings[_id - 1];
    }
}