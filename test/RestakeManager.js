const {
    time,
    loadFixture,
  } = require("@nomicfoundation/hardhat-toolbox/network-helpers");
  const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
  const { expect } = require("chai");
  
  describe("RestakeManager", function () {

    async function deployFixture() {
        // Contracts are deployed using the first signer/account by default
        const [owner, otherAccount] = await ethers.getSigners();
    
        // role
        const RoleManager = await ethers.getContractFactory("RoleManager");
        const roleManager = await RoleManager.deploy();
        await roleManager.initialize(owner.address);
        // ezETH
        const EzEthToken = await ethers.getContractFactory("EzEthToken");
        const ezEthToken = await EzEthToken.deploy();
        await ezEthToken.initialize(roleManager.target);

        // RenzoOracle
        const RenzoOracle = await ethers.getContractFactory("RenzoOracle");
        const renzoOracle = await RenzoOracle.deploy();
        await renzoOracle.initialize(roleManager.target);

        // el StrategyManager
        const StrategyManager = await ethers.getContractFactory("StrategyManager");
        const strategyManager = await StrategyManager.deploy();

        // el DelegationManager
        const DelegationManager = await ethers.getContractFactory("DelegationManager");
        const delegationManager = await DelegationManager.deploy();

        // DepositQueue
        const DepositQueue = await ethers.getContractFactory("DepositQueue");
        const depositQueue = await DepositQueue.deploy();
        await depositQueue.initialize(roleManager.target);

        // RestakeManager
        const RestakeManager = await ethers.getContractFactory("RestakeManager");
        const restakeManager = await RestakeManager.deploy();
        await restakeManager.initialize(
            roleManager.target,
            ezEthToken.target,
            renzoOracle.target,
            strategyManager.target,
            delegationManager.target,
            depositQueue.target
            );

        return { roleManager, ezEthToken, renzoOracle, strategyManager, delegationManager, depositQueue, restakeManager };
      }

      describe("Deployment", function () {
        it("init", async function () {
          const { roleManager, ezEthToken, renzoOracle, strategyManager, delegationManager, depositQueue, restakeManager } = await loadFixture(deployFixture);
    
          console.log(roleManager.target,  ezEthToken.target, renzoOracle.target, strategyManager.target, delegationManager.target, depositQueue.target, restakeManager.target );
        });
      });
  });