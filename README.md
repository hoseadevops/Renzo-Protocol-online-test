# RENZO 测试

> RENZO 深度依赖 EL(EigenLayer)

### 简介

* LSD 项目
    * > 以太坊 从 pow 转 pos 后 产生了 "原生质押挖矿"；在几种挖矿形式中 - 联合质押 产生了很多项目：（这些项目 大都 以 1:1 产生 LSD 即：流动性质押衍生品，LSD赛道 ）
    * 部分LSD项目 
        * Binance Staked Ether wBETH
        * Coinbase Staked Ether cbETH
        * Lido Staked Ether stETH
        * Stader Staked Ether ETHx
        * Mantle Staked Ether mETH
        * Origin Staked Ether oETH
        * Rocket Pool Ether rETH
        * Liquid Staked Ether lsETH
        * Swell Staked Ether swETH
        * StakeWise Staked Ether osETH
        * Ankr Staked Ether ankrETH
        * Staked Frax Ethe sfrxETH

* EL（EigenLayer ）项目 
    * > 通过"在质押" 为 中间件（DA、bridge、sidechain、oracle..） 提供共享安全. 
    * 角色
        * Staker 质押者
        * Operator 运营商
        * Actively Validated Services (AVS): 主动验证服务
        * 以太坊 pos 验证节点
    * EL的 第一个 AVS：EigenDA

* liquid restaking protocols (LRT) 项目 
    * > 基于 EL（EigenLayer） 的 流动性重新抵押协议；(LRT: Liquid Restaking Token 流动性在质押的 token ) 这些项目都是去调用 EigenLayer 
    * 部分：LRT 项目  
        * Etherfi:  https://app.ether.fi
        * Swell: https://app.swellnetwork.io
        * RENZO: https://app.renzoprotocol.com
        * Kelp: https://kelpdao.xyz/restake
        * eigenpie ：https://eigenpie.magpiexyz.connect-token.vip/
 
### 测试代码

* 合约
    * Renzo ezETH Contract
        * 主网代理合约地址：0xbf5495Efe5DB9ce00f80364C8B423567e58d2110
        * 当前代理实现版本：0x1e756b7bcca7b26fb9d85344b3525f5559bbacb0
    * Renzo Restake Manager Contract
        * 主网代理合约地址：0x74a09653A083691711cF8215a6ab074BB4e99ef5
        * 当前代理实现版本：0x6921c63fcf9796c9733690804e116be3520ba468
    * OperatorDelegator
        * 主网代理合约地址 0：0xbAf5f3A05BD7Af6f3a0BBA207803bf77e2657c8F
        * 主网代理合约地址 1：0x0B1981a9Fcc24A445dE15141390d3E46DA0e425c
        * 当前代理实现版本：0x85c211be9d3c8933eeeaa2f13d4f5970c76bf39d
    * DepositQueue
        * 主网代理合约地址：0xf2F305D14DCD8aaef887E0428B3c9534795D0d60
        * 当前代理实现版本：0xc23535d7f3634634a1e2cf101863db64a7054410
    * DelegationManager
        * 主网代理合约地址：0x39053D51B77DC0d36036Fc1fCc8Cb819df8Ef37A
        * 当前代理实现版本：0xf97E97649Da958d290e84E6D571c32F4b7F475e4
    * RenzoOracle
        * 主网代理合约地址：0x5a12796f7e7EBbbc8a402667d266d2e65A814042
        * 当前代理实现版本：0x1cd98C9d4e570d138aeD4269dA6ffb821a56fca2
* 依赖
    * eigenlayer
    * chainlink : AggregatorV3Interface



### Reference 

* 以太坊官网 
    * 关于 POS 质押： https://ethereum.org/zh/staking
    * 单独质押：https://ethereum.org/zh/staking/solo
    * 质押提款：https://ethereum.org/zh/staking/withdrawals
* EigenLayer 
    * 术语：https://docs.eigenlayer.xyz/eigenlayer/overview/key-terms
    * 白皮书
        * https://docs.eigenlayer.xyz/assets/files/EigenLayer_WhitePaper-88c47923ca0319870c611decd6e562ad.pdf
        * （中文版）https://zhuanlan.zhihu.com/p/609186933
    * 文档 https://docs.eigenlayer.xyz
* renzo
    * 文档 https://docs.renzoprotocol.com/docs/



### 工具

* 整体流程图  audit/RestakeManager.sol.png

* 函数调用流程图（在fn.dot 文件夹下）
    * DEMO : 生成图片：dot RestakeManager.call-graph.dot -Tpng -o ./RestakeManager.sol.png

### 测试

```shell

npx hardhat compile --force

npx hardhat test ./test/RestakeManager.js

```


