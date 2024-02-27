# Sample Hardhat Project


### 工具

##### 流程图 

* audit/RestakeManager.sol.png

* 函数调用流程图（在fn.dot 文件夹下）

    生成图片：dot RestakeManager.call-graph.dot -Tpng -o ./RestakeManager.sol.png

###

### 测试

```shell

npx hardhat compile --force

npx hardhat test ./test/RestakeManager.js

```
