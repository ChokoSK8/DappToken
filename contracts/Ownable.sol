// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;

contract	Ownable {
	address private _owner;

	event OwnershipTransferred(
		address indexed _prev,
		address indexed _newOwner
		);

	constructor() internal {
		_owner = msg.sender;
		emit OwnershipTransferred(address(0), _owner);
	}

	
}