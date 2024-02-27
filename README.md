# RENZO 审计

> RENZO 深度依赖 EL(EigenLayer)，RENZO 除了自己的风险问题，也会继承 EigenLayer 的风险，细审需要了解 EL 项目以及开放接口情况，知道这类项目的风险点才能知道基于EL的项目 如：RENZO 的风险（比如：稳定币清算流程、闪电贷，dex 的无偿损失、交易对LP等）深度调研一次EL后，之后基于EL的项目 则不在需要在 EL上耗费时间.

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
 

### 预估

* RENZO 大概需要 2周 
* EL（EigenLayer）大概需要 3 周

### 进度

* TODO
    * [ ] 版本一致 : 
        * [x] RENZO 的 online 和 github 代码不一致 需要抓取online代码组装项目
        * [ ] EL(EigenLayer) 
    * [ ] 环境搭建 
        * [x] RENZO: 、mock（EL、chainlink）、升级转本地测试
        * [ ] EL（EigenLayer）
    * [ ] 深度调研 : 以太坊pos质押（了解原生质押挖矿、提款权、罚没）；熟悉 EigenLayer（模型、架构、产品、代码）； 编码深度（upgrade、assembly)
    * [ ] 测试脚本
        * [ ] RENZO（正在进行）
        * [ ] EL（EigenLayer）

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


