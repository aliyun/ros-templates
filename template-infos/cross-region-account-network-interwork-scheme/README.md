## 方案概览

当您因业务需要，使用多个阿里云账号将服务部署分布在多个阿里云地域的同时，又希望能够实现网络资源互通，则可以使用阿里云云企业网 CEN 等产品来实现跨地域跨账号网络互通。

本技术方案将为您演示如何配置跨地域跨账号网络互通。

### 方案架构

方案提供的默认设置（如地域、VPC、实例等）完成部署后在阿里云上搭建的网站运行环境如架构图所示。实际部署时您可以根据实际情况修改部分设置，但最终形成的运行环境与架构图相似。


方案为了简化架构，暂不体现可用区及vSwitch、安全组等。

本方案的技术架构主要包括以下基础设施和云服务：

* 1个云企业网CEN实例：云企业网实例是管理一体化网络的基础资源。1个云企业网实例管理一张网络，可覆盖1个或多个地域。在实现网络实例互通前，需要先创建1个云企业网实例。
* 2个转发路由器TR实例：转发路由器实例作为地域内的核心转发网元，帮助您转发同地域或跨地域的流量。1个地域仅支持创建1个转发路由器实例。
* 3个专有网络VPC实例：专有网络是云上虚拟网络，可以将云资源部署在您自定义的专有网络中。专有网络是地域级别的资源，专有网络不可以跨地域，但包含所属地域的所有可用区。云资源不可以直接部署在专有网络中，必须属于专有网络内的1个交换机（子网）内。您可以在每个可用区内创建1个或多个交换机来划分子网。
* 3个云服务器ECS实例：ECS实例是云上的虚拟计算服务器，内含vCPU、内存、操作系统、网络、磁盘等基础组件。您可以使用阿里云提供的控制台、SDK等工具创建和管理ECS实例，像使用本地服务器一样管理ECS实例的状态、应用等，还可以灵活地升级计算、存储等能力。

## 方案部署
### 部署准备


开始部署前，请按以下指引完成账号申请、服务开通等准备工作。

**说明：本方案一键配置涉及到跨账号部署，过程中后台需要调用STS服务AssumeRole接口，该接口只能使用RAM用户或RAM角色调用，不支持主账号。因此一键配置方案中所使用的账号均需要为RAM用户账号，请勿使用主账号。**

#### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。本方案涉及两个阿里云账号实例网络互通，请您提前准备好两个阿里云账号。
2. 开通相关服务。
   
   1. 开通转发路由器服务。
   2. 针对CEN跨域流量，您可使用云数据传输CDT降低流量成本，如您未开通强烈建议您[快速入门](https://help.aliyun.com/zh/cdt/upgrade-to-cdt-billing)，仅开通CDT不收取任何费用。
3. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   1. 为节省成本，本方案默认全部选择使用按量付费资源，使用按量付费资源需要确保账户余额不小于100元。
   2. 完成本方案的部署及体验，预计产生费用不超过2元（假设您选择最低规格资源，且资源运行时间不超过1小时。实际情况中可能部分实例无法购买需要根据实际情况调整资源规格，同时因您操作过程中实际使用的流量差异，会导致费用有所变化，请以控制台显示的实际报价以及最终账单为准，如下表格仅供参考）。
      
      如下表格仅供参考，以实际情况为准
      
      | **序号** | **产品** | **费用来源** | **规格** | **地域** | **预估费用参考** | **说明** |
      | --- | --- | --- | --- | --- | --- | --- |
      | 1 | 云服务器ECS | ECS1配置费 | 实例：ecs.t5-lc2m1.nano（突发性能实例 t5，1 vCPU，0.5 GiB）  系统盘：cloud\_efficiency 40GiB | 华东1（杭州） | 0.083元/时 | - |
      | 2 | ECS2配置费 | 华东1（杭州） | 0.083元/时 | - |
      | 3 | ECS3配置费 | 华北1（青岛） | 0.083元/时 | - |
      | 4 | 云企业网CEN | TR1-VPC1连接费 | - | 华东1（杭州） | 0.350元/时 | 本方案所耗费流量极少。其中跨域流量由CDT云数据传输收取费用 |
      | 5 | TR1-VPC1流量费 | 华东1（杭州） | 0.130元/GB |
      | 6 | TR1-VPC2连接费 | 华东1（杭州） | 0.350元/时 |
      | 7 | TR1-VPC2流量费 | 华东1（杭州） | 0.130元/GB |
      | 8 | TR2-VPC3连接费 | 华北1（青岛） | 0.350元/时 |
      | 9 | TR2-VPC3流量费 | 华北1（青岛） | 0.130元/GB |
      | 10 | 跨域TR1地域出向流量费 | 华东1（杭州） | 0.600元/GB |
      | 11 | 跨域TR2地域出向流量费 | 华北1（青岛） | 0.600元/GB |
      | 按量费用：1.299元/时  流量费用：5个 | | | | | | |
4. 阿里云账号拥有操作所有资源的最高权限，从云资源安全角度考虑，建议您创建RAM用户。
   
   **（本方案中两个账号均需要配置为RAM用户账号，不支持使用阿里云主账号）**
   
   RAM用户需要获得相关云服务的访问权限才能完成方案部署，详情如下：
   
   相关云服务的访问权限
   
   | **云服务** | **需要的权限** | **描述** |
   | --- | --- | --- |
   | 云企业网CEN | AliyunCENFullAccess | 管理云企业网CEN、转发路由器TR等的权限 |
   | 专有网络VPC | AliyunVPCFullAccess | 管理专有网络VPC、交换机vSwitch等的权限 |
   | 云服务器ECS | AliyunECSFullAccess | 管理云服务器ECS、安全组等的权限 |
   | 访问控制RAM | AliyunRAMFullAccess | 管理访问控制RAM的权限，即管理用户以及授权的权限 |
   | 资源编排ROS | AliyunROSFullAccess | 管理资源编排服务ROS的权限 |
   | 安全令牌服务STS | AliyunSTSAssumeRoleAccess | 调用STS服务AssumeRole接口的权限 |
   
   创建RAM用户的操作指引请参见[创建RAM用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)。
   
   为RAM用户授权的操作指引请参见[为RAM用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。

### 一键配置


一键配置基于阿里云资源编排服务ROS（Resource Orchestration Service）实现，旨在帮助开发者通过IaC（Infrastructure as Code）的方式体验资源的自动化配置。

1. 账号B中配置RAM角色并授权：
   
   1. 登录账号B（账号B需要为RAM用户账号）。
   2. 打开[RAM控制台角色页面](https://ram.console.aliyun.com/roles)，单击**创建角色**。
   3. 选择可信实体类型为**阿里云账号**，单击**下一步**。
      
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6095579861/p695630.png)
   4. 配置角色信息。**选择信任的云账号**需要配置为**其他云账号**，并配置为**账号A的主账号ID**。
      
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6095579861/p695636.png)
   5. 单击**完成**，完成角色创建。
      
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6095579861/p695639.png)
   6. 单击**为角色授权**，参照下图授予相应权限，完成后单击**确定**。
      
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7356679861/p695739.png)
   7. 完成角色权限配置。
      
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7356679861/p695740.png)
2. 账号A中一键部署资源：
   
   1. 登录账号A（账号A需要为RAM用户账号）。
   2. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/cross-region-account-network-interwork-scheme.yml&pageTitle=跨地域跨账号网络互通方案&isSimplified=True&productNavBar=disabled)前往ROS控制台，系统自动打开**使用新资源（标准）**创建资源栈的页面。
   3. **资源栈名称**可保持默认值。
   4. 配置账号B的主账号ID以及在账号B中创建的角色名称。
      
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4158679861/p695752.png)
   5. **地域和可用区配置**、**网段配置**可保持默认值。
   6. ECS实例不同时刻在不同地域及可用区可售卖情况可能存在不同，因此可能出现默认参数无法选中的情况，需要手动微调。**地域1的ECS实例配置**、**地域2的ECS实例配置**可参照下图进行配置，需要选择实例及配置系统盘类型。
      
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6073762961/p709019.png)
   7. 配置ECS实例密码。该密码是所有ECS实例的root用户登录密码。
      
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4158679861/p695757.png)
   8. 单击**创建**开始资源创建。
   9. 资源创建过程中，可开启右上角**自动刷新**开关，及时了解资源部署进度。
      
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4158679861/p695758.png)
   10. 资源部署完成后，查看资源栈信息页面，**状态**将显示“创建成功”。
       
       ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4158679861/p695759.png)
   11. 单击**输出**页签，可查看3个ECS的IP地址，可复制记录用于后续验证。
       
       ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7323289861/p695828.png)
### 完成及清理


#### 方案验证

**通过不同账号下ECS实例执行ping命令，验证跨地域跨账号网络互通**

1. **登录阿里云账号A。**如下操作均在账号A中完成。
   
   1. 验证ECS1与ECS2、ECS3之间的网络连通性。
      
      1. 打开[Workbench远程连接](https://ecs-workbench.aliyun.com/)，选择ECS1实例并登录。
      2. 执行ping命令访问对方地址，例如`ping -c 4 10.0.20.100`命令，尝试访问ECS2实例。如果出现如下返回信息，则表示ECS1和ECS2之间网络已连通，可以实现资源互访。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3293807861/p684353.png)
      3. 执行ping命令访问对方地址，例如`ping -c 4 192.168.20.100`命令，尝试访问ECS3实例。如果出现如下返回信息，则表示ECS1和ECS3之间网络已连通，可以实现资源互访。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3293807861/p684354.png)
   2. 验证ECS3与ECS1、ECS2之间的网络连通性。
      
      1. 打开[Workbench远程连接](https://ecs-workbench.aliyun.com/)，选择ECS3实例并登录。
      2. 执行ping命令访问对方地址，例如`ping -c 4 172.16.20.100`命令，尝试访问ECS1实例。如果出现如下返回信息，则表示ECS3和ECS1之间网络已连通，可以实现资源互访。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3293807861/p684355.png)
      3. 执行ping命令访问对方地址，例如`ping -c 4 10.0.20.100`命令，尝试访问ECS2实例。如果出现如下返回信息，则表示ECS3和ECS2之间网络已连通，可以实现资源互访。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3293807861/p684356.png)
2. **退出阿里云账号A，切换登录为阿里云账号B。**如下操作均在账号B中完成。
   
   1. 验证ECS2与ECS1、ECS3之间的网络连通性。
      
      1. 执行ping命令访问对方地址，例如`ping -c 4 172.16.20.100`命令，尝试访问ECS1实例。如果出现如下返回信息，则表示ECS2和ECS1之间网络已连通，可以实现资源互访。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3293807861/p684357.png)
      2. 执行ping命令访问对方地址，例如`ping -c 4 192.168.20.100`命令，尝试访问ECS3实例。如果出现如下返回信息，则表示ECS2和ECS3之间网络已连通，可以实现资源互访。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3293807861/p684356.png)

#### 清理资源

1. 登录[资源编排管理控制台](https://ros.console.aliyun.com/)，左侧导航栏菜单选择**资源栈**。
2. 在页面的顶部选择部署的资源栈所在地域，找到部署的资源栈。单击其右侧**操作**列的**删除**并确认，可一键删除所有创建的资源。
