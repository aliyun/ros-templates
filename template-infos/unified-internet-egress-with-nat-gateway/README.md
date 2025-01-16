## 方案概览

随着业务规模提升，业务VPC内多台ECS都有访问公网的需求。如果仍保持每台ECS分别绑定IP，会消耗大量的公网IP资源，这对企业的资源管理、权限管控等都是巨大挑战。本方案为您提供如何使用公网NAT 网关实现统一云上出口IP，帮助您高效地管理互联网业务。

## 方案架构

创建公网NAT网关实例，并自定义配置SNAT规则，将弹性公网IP绑定至公网NAT网关实现统一云上出入口IP，最终实现ECS实例访问公网。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7692199171/p816777.png)

本方案的技术架构包括以下基础设施和云服务：

* 1个专有网络VPC：为云服务器ECS等云资源构建云上私有网络。
* 3台交换机：将云服务器ECS和1个公网NAT网关连接在同一网络上，实现它们之间的通信。
* 2台云服务器ECS：分别部署在2个不同可用区，用于部署业务系统，提供应用服务。
* 1个弹性公网IP：简称EIP，与公网NAT网关绑定，实现VPC内的多个ECS实例共享EIP上网。
* 1个公网NAT网关：用于为云上服务提供主动访问公网能力。

## 方案部署
### 部署准备


开始部署前，请按以下指引完成账号申请、账号充值。

### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册并进行个人实名认证。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。如果确定任何一个云资源采用按量付费方式部署，账户余额都必须大于等于100元。
### 一键部署


一键部署基于阿里云资源编排服务ROS（Resource Orchestration Service）实现，ROS模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。

#### 操作步骤

您可以通过下方提供的ROS一键部署链接，来自动化地完成这些资源的创建和配置：

* 创建2台云服务器ECS实例（配置推荐ecs.e-c1m2.large，可用区建议分别选择J和K）。
* 创建1个专有网络VPC。
* 创建3台交换机。
* 创建1个公网NAT网关。
* 创建1个弹性公网IP。

1. 一键部署资源。
   
   1. 单击[一键部署](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/unified-internet-egress-with-nat-gateway.yml&hideStepRow=true&hideStackConfig=true&pageTitle=高效安全：企业统一公网出口&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled)，在顶部导航栏选择地域。
   2. 在配置页面修改**资源栈名称**，按需选择和配置参数。
   3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
### 验证与清理


#### 方案验证

#### 一、通过执行Ping命令，验证ECS实例公网连通性

1. 登录[云服务器ECS控制台](https://ecs.console.aliyun.com/home)，点击左侧导航栏**实例**，分别连接刚才创建的两台ECS实例。具体操作，请参见[ECS远程连接方式概述](https://help.aliyun.com/zh/ecs/user-guide/connect-to-instance)。
2. 分别执行`ping www.aliyun.com`命令，测试网络连通性。执行 Ping 命令后，还需手动中断输出，macOS 系统使用`Ctrl+C`，Windows系统使用`Cmd+C`来中断连通。
   
   如果都能接收到类似以下回复报文，表示连接成功。![测试连通性](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7692199171/p813788.png)
#### 二、通过查看公网出口IP，验证两台ECS实例IP一致

1. 分别在两个ECS实例下执行以下命令，查看公网出口IP。
   
   ```
   curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/install-script/ip.sh|bash
   ```
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2760453271/p834502.png)
2. 登录[NAT网关管理控制台](https://vpc.console.aliyun.com/nat?spm=a2c4g.2808484.0.0.74d566b8aHEmhw)，点击创建的NAT网关实例。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1981538271/p855480.png)
3. 进入到NAT网关资源详情中，点击**绑定的弹性公网IP，**查看**IP地址**，与上一步查询的公网出口IP一致。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1981538271/p855484.png)
4. 点击**监控和日志**，选择**网关流量情况，**可查看两台ECS实例的出入网状况。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1981538271/p855488.png)
   
   **说明** 
   
   若账号未开通NIS公测服务，请按照页面提示点击**开通服务**即可
#### 清理资源

您可以使用ROS一键删除创建的云资源，避免继续产生费用。

1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
2. 在左侧导航栏，选择**资源栈**。
3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
