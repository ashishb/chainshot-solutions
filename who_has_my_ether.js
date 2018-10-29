// Solution to https://www.chainshot.com/challenges/5b45277dd9f997416b4b0413/stage/5b4527b8d9f997416b4b0414

const {web3} = require('./setup');

/**
 * Given an account address on the ethereum blockchain find 
 * all the addresses that were sent ether from that address
 * @param {string} address - The hexidecimal address for the account
 * @async
 * @returns {Array} all the addresses that receieved ether
 */
async function findAddresses(address) {
  let set1 = new Set()
  const n = await web3.eth.getBlockNumber();
  for (var i = 1; i <= n; i++) {
      let block = await web3.eth.getBlock(i, true);
        for (var j = 0; j < block.transactions.length; j++) {
          var tx = block.transactions[j];
          if (address == tx.from) {
            console.log(tx.to)
            set1.add(tx.to)
           }
        }
  }
  return Array.from(set1);
}

export default findAddresses;
