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

        await roleManager.grantRole(await roleManager.RESTAKE_MANAGER_ADMIN(), owner.address);
        
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

        // el EigenPodManager
        const EigenPodManager = await ethers.getContractFactory("EigenPodManager");
        const eigenPodManager = await EigenPodManager.deploy();

        // OperatorDelegator
        const OperatorDelegator0 = await ethers.getContractFactory("OperatorDelegator");
        const operatorDelegator0 = await OperatorDelegator0.deploy();
        await operatorDelegator0.initialize(
            roleManager.target,
            strategyManager.target,
            restakeManager.target,
            delegationManager.target,
            eigenPodManager.target
        );

        const OperatorDelegator1 = await ethers.getContractFactory("OperatorDelegator");
        const operatorDelegator1 = await OperatorDelegator1.deploy();
        await operatorDelegator1.initialize(
            roleManager.target,
            strategyManager.target,
            restakeManager.target,
            delegationManager.target,
            eigenPodManager.target
        );

        const OperatorDelegator2 = await ethers.getContractFactory("OperatorDelegator");
        const operatorDelegator2 = await OperatorDelegator2.deploy();
        await operatorDelegator2.initialize(
            roleManager.target,
            strategyManager.target,
            restakeManager.target,
            delegationManager.target,
            eigenPodManager.target
        );

        // ERC20Faucet1
        const ERC20Faucet1 = await ethers.getContractFactory("ERC20Faucet");
        const oERC20Faucet1 = await ERC20Faucet1.deploy();
        await oERC20Faucet1.mint(10000);

        const ERC20Faucet2 = await ethers.getContractFactory("ERC20Faucet");
        const oERC20Faucet2 = await ERC20Faucet2.deploy();
        await oERC20Faucet2.mint(10000);

        const ERC20Faucet3 = await ethers.getContractFactory("ERC20Faucet");
        const oERC20Faucet3 = await ERC20Faucet3.deploy();
        await oERC20Faucet3.mint(10000);

        return { roleManager, ezEthToken, renzoOracle, strategyManager, delegationManager, depositQueue, restakeManager, operatorDelegator0, operatorDelegator1, operatorDelegator2, oERC20Faucet1, oERC20Faucet2, oERC20Faucet3 };
    }

    describe("Deployment", function () {

        it("init", async function () {

            const { roleManager, ezEthToken, renzoOracle, strategyManager, delegationManager, depositQueue, restakeManager, operatorDelegator0, operatorDelegator1, operatorDelegator2, oERC20Faucet1, oERC20Faucet2, oERC20Faucet3  } = await loadFixture(deployFixture);

            console.log(
                roleManager.target,
                ezEthToken.target,
                renzoOracle.target,
                strategyManager.target,
                delegationManager.target,
                depositQueue.target,
                restakeManager.target,
                operatorDelegator0.target,
                operatorDelegator1.target,
                operatorDelegator2.target,
                oERC20Faucet1.target,
                oERC20Faucet2.target,
                oERC20Faucet3.target,
            );
        });
    });

    describe("operatorDelegator manager", function () {

        describe("add", function () {
            
            it("", async function () {

                const { roleManager, ezEthToken, renzoOracle, strategyManager, delegationManager, depositQueue, restakeManager, operatorDelegator0, operatorDelegator1, operatorDelegator2, oERC20Faucet1, oERC20Faucet2, oERC20Faucet3  } = await loadFixture(deployFixture);


                // 不能超过10000
                await expect(restakeManager.addOperatorDelegator(operatorDelegator0.target, 10001)).to.be.reverted;

                // 设置三个
                await restakeManager.addOperatorDelegator(operatorDelegator0.target, 10000);
                await restakeManager.addOperatorDelegator(operatorDelegator1.target, 10000);
                await restakeManager.addOperatorDelegator(operatorDelegator2.target, 10000);

                let operatorDelegator_0            = await restakeManager.operatorDelegators(0);
                let operatorDelegator_0_allocation = await restakeManager.operatorDelegatorAllocations(operatorDelegator0.target);
                let operatorDelegator_1            = await restakeManager.operatorDelegators(1);
                let operatorDelegator_1_allocation = await restakeManager.operatorDelegatorAllocations(operatorDelegator1.target);
                let operatorDelegator_2            = await restakeManager.operatorDelegators(2);
                let operatorDelegator_2_allocation = await restakeManager.operatorDelegatorAllocations(operatorDelegator2.target);
                
                console.log(
                    "", 
                    [operatorDelegator_0, operatorDelegator_0_allocation], "\n", 
                    [operatorDelegator_1, operatorDelegator_1_allocation], "\n", 
                    [operatorDelegator_2, operatorDelegator_2_allocation], "\n", 
                );

                // 删除 1
                console.log("--- 删除后 ---","\n");

                await restakeManager.removeOperatorDelegator(operatorDelegator1.target);

                operatorDelegator_0            = await restakeManager.operatorDelegators(0);
                operatorDelegator_0_allocation = await restakeManager.operatorDelegatorAllocations(operatorDelegator0.target);

                operatorDelegator_1            = await restakeManager.operatorDelegators(1);
                operatorDelegator_1_allocation = await restakeManager.operatorDelegatorAllocations(operatorDelegator1.target);
                operatorDelegator_2_allocation = await restakeManager.operatorDelegatorAllocations(operatorDelegator2.target);

                // 数组越界 revert
                operatorDelegator_2            = await expect(restakeManager.operatorDelegators(2)).to.be.reverted;;

                console.log(
                    "", 
                    [operatorDelegator_0,operatorDelegator_0_allocation], "\n", 
                    [operatorDelegator_1, operatorDelegator_1_allocation, operatorDelegator_2_allocation], "\n"
                );

                // 修改点数
                console.log("--- 修改点数 -> 0 ---","\n");
                await restakeManager.setOperatorDelegatorAllocation(operatorDelegator2.target, 0);
                operatorDelegator_1            = await restakeManager.operatorDelegators(1);
                operatorDelegator_1_allocation = await restakeManager.operatorDelegatorAllocations(operatorDelegator1.target);

                console.log(
                    "", 
                    [operatorDelegator_1,operatorDelegator_1_allocation], "\n", 
                );



                console.log("---  --- ---  --- ---  --- ---  --- ---  --- ---  --- ---  --- ---  --- ---  --- ---  ---","\n");
                // 添加可以质押的 token 合约地址
                await restakeManager.addCollateralToken(oERC20Faucet1.target);
                await restakeManager.addCollateralToken(oERC20Faucet2.target);
                await restakeManager.addCollateralToken(oERC20Faucet3.target);
                

            });

        });

    });
});
