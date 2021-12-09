const DappToken = artifacts.require("./DappToken.sol");

contract('DappToken', function(accounts) {

	it ('initial contract with the correct values', function() {
		return DappToken.deployed().then(function(instance) {
			tokenInstance = instance;
			return tokenInstance.name();
		}).then(function(name) {
			assert.equal(name, 'Dapp Token', 'has the correct name');
			return tokenInstance.symbol();
		}).then(function(symbol) {
			assert.equal(symbol, 'DAPP', 'has the correct symbol');
			return tokenInstance.standard();
		}).then(function(standard) {
			assert.equal(standard, 'DApp Token v1.0', 'has the correct symbol');
		});
	})

	it ('allocate initial supply upon deployement', function() {
		return DappToken.deployed().then(function(instance) {
			tokenInstance = instance;
			return tokenInstance.totalSupply();
		}).then(function(totalSupply) {
			assert.equal(totalSupply.toNumber(), 1000000, 'set the total supply to 1,000,000');
			return tokenInstance.balanceOf(accounts[0]);
		}).then(function(adminBalance) {
			assert.equal(adminBalance.toNumber(), 1000000, 'it allocates the initial supply to the admin accounts');
		});
	});

	it('transfer token ownership', function() {
		return DappToken.deployed().then(function(instance) {
			tokenInstance = instance;
			return tokenInstance.transfer.call(accounts[1], 999999999, {from: accounts[0]});
		}).then(assert.fail).catch(function(error) {
			assert(error.message.indexOf('revert') >= 0, 'error message must contain revert');
			return tokenInstance.transfer(accounts[1], 500000, {from: accounts[0]});
		}).then(function(receipt) {
			assert.equal(receipt.logs[0].event, 'Transfer', 'should be a Transfer event');
			assert.equal(receipt, true, 'the transfer should return true');
			assert.equal(receipt.logs[0].args._from, accounts[0], 'logs the debited account');
			assert.equal(receipt.logs[0].args._to, accounts[1], 'logs the recipient account');
			assert.equal(receipt.logs[0].args._value, 500000, 'log the transaction amount')
			return tokenInstance.balanceOf(accounts[1]);
		}).then(function(balance) {
			assert.equal(balance.toNumber(), 500000, 'The account 1 receive his tokens');
			return tokenInstance.balanceOf(accounts[0]);
		}).then(function(balance) {
			assert.equal(balance.toNumber(), 500000, 'The account 0 got debited');
			return tokenInstance.balanceOf(accounts[0]);
		})
	})
})