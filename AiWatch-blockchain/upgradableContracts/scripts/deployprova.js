const {ethers, upgrades} = require("hardhat");

async function main(){
  const prova = await ethers.getContractFactory("contracts/prova.sol:prova");
  const Prova = await prova.deploy();

  await Prova.deployed()
    await Prova.deployTransaction.wait();
let provider = ethers.getDefaultProvider("http://localhost:8545");
let code = await provider.getCode(Prova.address);
console.log(code)

  console.log("Storage deployed to:",Prova.address);
  
}

main();