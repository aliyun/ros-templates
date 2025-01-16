## 方案概览

分布式系统调用的特点是执行一个核心业务逻辑，同时需要调用多个下游业务进行处理，因此如何保证核心业务和多个下游业务执行结果的一致性，是分布式事务需要解决的主要问题。通过本教程，您将学习如何使用云消息队列 RocketMQ 版的事务消息功能，在分布式场景下保证本地主分支事务和下游消息发送事务的最终一致性，下游业务通过消费重试等手段保证消息正确处理，实现核心业务和多个下游业务执行结果的最终一致性。

## 方案架构

本方案旨在利用云消息队列RocketMQ版来实现一个高效、可靠的分布式事务处理系统。分布式事务在微服务架构中尤为重要，它确保了跨多个服务或数据库的操作能够保持一致性和完整性。RocketMQ的事务消息功能为这一需求提供了一种优雅的解决方案，它通过预提交、提交/回滚的两阶段提交模型来保证消息与业务操作的最终一致性。同时，该架构还利用专有网络VPC、交换机和安全组等基础设施，实现了私有网络下的系统通信。

方案提供的默认设置完成部署后在阿里云上搭建的高可用架构如架构图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与架构图相似。


本方案的技术架构包括以下基础设施和云服务：

* 1个专有网络VPC：为云服务器ECS、云数据库RDS、云消息队列RocketMQ等云资源构建云上私有网络。
* 4台交换机：部署在同一个可用区。
* 2台云服务器ECS：用于部署业务系统，生产者和消费者部署在不同的服务器中，实现分布式的业务场景，提供应用服务。
* 1个云数据库RDS MySQL基础版：为业务系统提供数据服务。
* 1个云消息队列RocketMQ标准版：通过事务消息确保分布式系统中的数据一致性和消息的可靠传递。

本方案实现分布式事务的整体流程：

1. 用户提交事务请求，触发分布式事务的执行。
2. 生产者发送半事务消息到云消息队列 RocketMQ 版服务端，此时消息处于预提交状态，并未真正投递给消费端。
3. 生产者执行本地事务逻辑，完成对RDS数据库的操作。
4. 根据本地事务的执行结果，生产者向RocketMQ服务端发送事务确认消息。确认消息可以是Commit（提交）或Rollback（回滚）。
5. 服务端处理事务二次确认结果：
   
   5.1 如果确认结果为Rollback，RocketMQ服务端将回滚该消息，即不投递给消费端，确保消息不会被消费。
   
   5.2 如果确认结果为Commit，RocketMQ服务端将正式投递该消息给消费端，确保消息能够被正确处理。
6. 若服务端未收到发送者提交的二次确认结果，将对消息生产者发起消息回查，生产者需检查本地事务最终结果并再次提交二次确认到服务端。
7. 消费端处理消息，对RDS进行操作，完成整个分布式事务流程。

## 方案部署
### 部署准备


开始部署前，请按以下指引完成账号申请、账号充值。

### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。如果确定任何一个云资源采用按量付费方式部署，账户余额必须大于等于100元。
### 一键部署


一键部署基于阿里云资源编排服务ROS（Resource Orchestration Service）实现，ROS模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。ROS模板完成的内容包括：

#### 操作步骤

您可以通过下方提供的ROS一键部署链接，来自动化地完成这些资源的创建和配置：

* 创建2台云服务器ECS实例。
* 创建1个专有网络VPC。
* 创建4台交换机。
* 创建1个安全组。
* 创建1个云数据库RDS MySQL基础版。
* 创建1个云消息队列RocketMQ标准版。

一键部署资源。

1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/through-RocketMQ-transaction-messages.yml&hideStepRow=true&hideStackConfig=true&pageTitle=通过RocketMQ事务消息实现分布式事务&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled)，在顶部导航栏选择地域。
2. 在配置页面修改**资源栈名称**，按需选择和配置参数。
3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
### 验证及清理


#### 方案验证

**一、通过模拟订单与物流信息创建，验证分布式事务一致性**

1. 单击资源栈的**输出**页签，再单击体验地址对应的URL进行访问。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9712055271/p840510.png)
2. 系统登录：在登录页面输入之前配置的用户名和密码，然后进行登录和体验（如果遗忘用户名可在创建ROS资源栈中的参数AppDemoAccountName找到您的设置信息）。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9712055271/p837683.png)
3. 模拟支付：登录成功后，系统将自动跳转至“模拟订单支付”页面。在此页面，输入整数形式的用户ID和订单号，点击“模拟支付”按钮。操作无误时，系统会显示“创建支付订单成功！”的消息，标志着支付过程的模拟顺利完成。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9712055271/p837687.png)![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9712055271/p837690.png)
4. 验证物流信息创建：为了验证分布式事务的完整性，我们接着验证物流信息是否随订单创建而生成。在浏览器地址栏输入`http://<ECS公网IP>/logistic`进入“模拟物流查询”页面。在这里，使用相同的用户ID和订单号进行查询。如果一切按照预期设计，系统将反馈“物流信息查询结果为已创建”，这直接证明了在订单创建的同时，对应的物流记录也已通过RocketMQ的事务消息机制成功建立。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9712055271/p837698.png)
5. 总结：当创建订单时，先发送半事务消息至RocketMQ，标志着过程启动。随后，执行订单初始化逻辑，视为预提交。依据订单结果，RocketMQ通过特定接口确认或回滚事务，确保操作一致性。一旦消息确认，消费者立即响应，创建物流信息，维持订单与物流状态同步。

**二、模拟执行失败场景，验证本地事务失败处理**

1. 模拟失败场景

在模拟订单支付页面，尝试创建已存在的订单号，此时页面将提示“创建支付订单失败”，说明本地事务执行失败。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1604316271/p848540.png)

在模拟物流查询页面，查询刚刚的用户ID和订单号组合，页面将显示物流未创建。这验证了在本地事务失败的情况下，物流信息也不会被创建，确保了数据一致性。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1604316271/p848541.png)

**三、通过消息轨迹，验证消息传递过程**

1. 登录[消息队列 RocketMQ 版控制台](https://ons.console.aliyun.com/overview)，找到当前RocketMQ实例，点击进入详情。
2. 在左侧导航栏点击**消息查询**，在搜索栏中Topic选择`ROCKETMQ_ORDER_TOPIC`，点击查询可以看到相关消息。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1604316271/p848547.png)

3. 查看消息轨迹
任选一条消息复制Message ID，点击左侧导航栏中的**消息轨迹**，在搜索栏中Topic选择`ROCKETMQ_ORDER_TOPIC`，输入之前复制的Message ID并点击查询。在搜索结果中，消息的操作栏中有一个**消息轨迹**按钮。点击该按钮后，可以查看这条消息的生产和投递轨迹详情。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1604316271/p848562.png)

#### 清理资源

您可以使用ROS一键删除创建的云资源，避免继续产生费用。

1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
2. 在左侧导航栏，选择**资源栈**。
3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
