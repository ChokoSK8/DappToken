// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;

abstract contract	Ownable {
	address private owner;

	event OwnershipTransferred(
		address indexed _prev,
		address indexed _newOwner
		);

	constructor() {
		owner = msg.sender;
		emit OwnershipTransferred(address(0), owner);
	}

	function isOwner() public view returns (bool) {
		return msg.sender == owner;
	}

	modifier onlyOwner() {
		require (isOwner());
		_;
	}

	function transferOwnership(address _newOwner) public onlyOwner {
		require(_newOwner != address(0));
		owner = _newOwner;
		emit OwnershipTransferred(owner, _newOwner);
	}

	function approve(address _spender, uint256 _value) external virtual returns (bool);
}