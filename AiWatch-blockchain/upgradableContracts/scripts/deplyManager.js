const {ethers, upgrades} = require("hardhat");

async function main(){
  const Manager = await ethers.getContractFactory("ManagerV1");
  const adminAddress = ethers.utils.getAddress("0xeB6e71BfB760bD0bbDd3C0a6466FBC6bb9608E8e");
  const manager = await upgrades.deployProxy(Manager,{kind: 'uups'},[adminAddress],{
    initializer: "Inizialize",
  });
  await manager.deployed();
  console.log("manager deployed to:",manager.address);
  let provider = ethers.getDefaultProvider("http://localhost:8545");
  let code = await provider.getCode(manager.address);
  await manager.deployTransaction.wait();
  let result = await manager.getAdminList()
  console.log(result);

}

main();