require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");

module.exports = {
  solidity: "0.8.17",
  networks: {
    besu: {
      url: `http://127.0.0.1:8545`,
      accounts: [process.env.PRI_KEY],
    },
  },
};
