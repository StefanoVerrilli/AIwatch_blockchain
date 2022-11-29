const {ethers, upgrades} = require("hardhat");

async function main(){
  const Storage = await ethers.getContractFactory("StorageV1");
  const storage = await Storage.deploy();
  //const storage = await upgrades.deployProxy(Storage,{kind: 'uups'},{
  //  initializer: "initialize",
  //});

  await storage.deployed();

  console.log("Storage deployed to:",storage.address);
}

main();