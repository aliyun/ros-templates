## 方案概览

对于企业从IDC搬迁到云上，前期进行整体的网络设计，需要构建基于业务逻辑的云上网络整体架构，为业务上云奠定基础。随着企业规模和业务的增长，需要优化已有的网络架构，保障业务的安全、稳定及未来发展的可持续性。企业用户往往面临以下的场景：

* 实现灵活的内网互通、隔离、引流策略，根据业务逻辑规划网络资源布局。
* 内网互访流量经过防火墙进行安全审计，提高业务安全性。
* 网络架构具备较高的可扩展性和可持续性。

### 方案架构

方案提供的默认设置完成部署后在阿里云上搭建的网站运行环境如架构图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与架构图相似。

本方案的技术架构包括以下基础设施和云服务：

* 4个专有网络VPC：搭建可信的私有网络。
* 9个交换机：用于挂载ECS实例。
* 4台云服务器ECS：3台用于模拟业务互访，1台用于模拟防火墙。
* 1个云企业网实例：用于管理整个云上私网网络。
* 1个转发路由器实例：用于连接VPC。

其中，VPC-PRD1和VPC-PRD2互通需要经过VPC-SEC中的模拟防火墙审计，VPC-PRD3作为独立业务不允许与其他VPC互通。本方案中不涉及模拟防火墙审计的代码部分，仅涉及网络搭建。

## 方案部署
### 部署准备


开始部署前，请按以下指引完成账号申请、账号充值、RAM用户创建和授权。

#### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   * 本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。如果确定任何一个云资源采用按量付费方式部署，账户余额都必须大于等于100元。
   * 完成本方案的部署及体验，预计产生费用不超过2元。
     
     假设您选择可用的最低规格资源，且资源运行时间不超过1小时。实际情况中可能部分实例无法购买需要根据实际情况调整资源规格，同时因您操作过程中实际使用的流量差异，会导致费用有所变化，请以控制台显示的实际报价以及最终账单为准。
     
     下表仅供参考，具体费用以实际情况为准。
     
     | **序号** | **产品**         | **费用来源** | **规格**            | **地域**  | **预估费用参考** | **相关文档**                                                              |
     |--------|----------------|----------|-------------------|---------|------------|-----------------------------------------------------------------------|
     | 1      | 云服务器ECS        | 实例费      | ecs.s6-c1m1.small | 华东1（杭州） | 0.115元/时   | [按量付费](https://help.aliyun.com/zh/ecs/pay-as-you-go-1)                |
     | -      | -              | 系统盘费     | -                 | -       | 0.02元/时    | -                                                                     |
     | 2      | 云企业网CEN转发路由器TR | 连接费      | -                 | 华东1（杭州） | 0.35元/个    | [计费说明](https://help.aliyun.com/zh/cen/product-overview/billing-rules) |
     | -      | -              | 流量处理费    | -                 | -       | 0.13元/GB   | -                                                                     |

3. 创建用于方案部署的RAM用户。
   
   1. 创建1个RAM用户。具体操作，请参见[创建RAM用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)。
   2. 为RAM用户授予以下云服务的访问权限以完成方案部署。具体操作，请参见[为RAM用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。
      
      | **云服务** | **需要的权限**           | **描述**       |
      |---------|---------------------|--------------|
      | 云服务器ECS | AliyunECSFullAccess | 管理云服务器ECS的权限 |
      | 专有网络VPC | AliyunVPCFullAccess | 管理专有网络VPC的权限 |
      | 云企业网CEN | AliyunCENFullAccess | 管理云企业网CEN的权限 |
      | 资源编排ROS | AliyunROSFullAccess | 管理资源编排ROS的权限 |
### 规划网络和资源


#### 网络规划

请参考表格中的说明和方案默认示例值为每个规划项做详细规划并在实际部署时将默认示例值修改为您的实际规划。

| **规划项** | **数量** | **说明**                                                                               |
|---------|--------|--------------------------------------------------------------------------------------|
| 地域      | 1      | 您的云服务部署的地域。选择地域的基本原则请参见[地域和可用区](https://help.aliyun.com/document_detail/40654.html)。 |
| 专有网络VPC | 4      | 在部署过程中新建一个VPC作为本方案的专有网络。                                                             |
| 交换机     | 9      | 本方案需要至少9台交换机，用来挂载ECS实例。                                                              |
| 云企业网    | 1      | 本方案需要1个云企业网实例，用于管理整个云上私网网络。                                                          |
| 转发路由器   | 1      | 用于连接VPC。                                                                             |

#### 规划云资源

请参考表格中的说明和方案默认示例值为每个规划项做详细规划并在实际部署时将默认示例值修改为您的实际规划。

| **规划项** | 数量 | **说明**                     |
|---------|----|----------------------------|
| ECS     | 4  | 本方案需要3台用于模拟业务互访，1台用于模拟防火墙。 |

### 一键部署


一键配置基于阿里云资源编排服务ROS（Resource Orchestration Service）实现，旨在帮助开发者通过IaC（Infrastructure as Code）的方式体验资源的自动化配置。

1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/enterprise-cloud-network-architecture-planning.yml&pageTitle=企业云上网络架构规划&isSimplified=True&productNavBar=disabled&disableRollback=false)前往ROS控制台，系统自动跳转至**创建资源栈**页面，并默认进入**配置模板参数**向导页面。
   
   **说明** 
   
   ROS控制台默认处于您上一次访问控制台时的地域，请根据您创建的资源所在地域修改地域后再执行下一步。本方案选择**华东1（杭州）**。
2. **资源栈名称**可保持默认值。
3. 在**ECS实例配置**区域，选择**共享型实例**，推荐使用最低规格，并设置**实例密码**。
   
   **说明** 
   
   请确保您选择的实例规格无需停止即可绑定弹性网卡。详细规则，请参见[绑定辅助弹性网卡](https://help.aliyun.com/zh/ecs/user-guide/bind-an-eni)。本文示例为**ecs.s6-c1m1.small**。
4. 在**可用区配置**区域，分别选择**可用区J**和**可用区K**。
5. 单击**创建**。
### 完成及清理

#### 方案验证

**一、通过配置IP转发设置，验证模拟防火墙**

1. 登录VPC\_SEC的ECS实例，执行以下命令启用允许转发。当前命令临时生效，重启后会丢失。关于如何登录ECS实例，请参见[ECS远程连接方式概述](https://help.aliyun.com/zh/ecs/user-guide/connect-to-instance#concept-tmr-pgx-wdb)。
    ```
    echo 1 > /proc/sys/net/ipv4/ip_forward
    ```

2. 执行以下命令，查看ip转发功能开启情况。
    ```
    sysctl net.ipv4.ip_forward
    ```
**说明** 

如果返回值为 `1`，则表示已启用 IP 转发。VPC\_PRD1的ECS实例与VPC\_PRD2、VPC\_SEC之间是互通的。

**二、通过ping测试，验证内网服务器连通性**

完成上述操作后，VPC\_PRD1、VPC\_PRD2之间互访可以通过**ping**测试连通性，流量会通过VPC\_SEC中转，符合期望的安全互访需求。

1. 登录VPC\_PRD1的ECS实例，执行**ping**命令，如架构图，测试与VPC\_PRD2、VPC\_SEC之间的连通性。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0743538271/p855222.png)

    收到回复报文，则表示VPC\_PRD1与VPC\_PRD2之间可以正常通信；
    
    ```
    ping <网络实例下ECS实例的IP地址>
    ```

2. 登录VPC\_PRD3中的ECS实例执行**ping**命令，如架构图，发现无法ping通其他ECS，达到了隔离的效果。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0743538271/p855218.png)

**三、查看路由表详情，验证访问过程**

1. 登录[云企业网控制台](https://cen.console.aliyun.com/cen/list)，点击左侧导航栏中**云企业网实例**，在右侧表格中找到目标实例，点击转发路由器下的资源，进入到资源详情页。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0743538271/p855243.png)
2. 在资源详情列表中的**转发路由器**表格中，找到路由表项，点击对应的数字进入路由表详情![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0743538271/p855247.png)
3. 进入到路由表详情，可看到默认的第一条路由条目，如下，为VPC-SEC模拟防火墙的路由设置：流量都经过VPC-SEC的中转。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0743538271/p855250.png)
4. 点击左侧路由条目列表第二条如下，可看到VPC\_PRD1、VPC\_PRD2、VPC\_SEC的路径，没有配置跳转到VPC\_PRD3的路径。以此来达到隔离效果，实现灵活的内网互通、隔离、引流策略。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0743538271/p855255.png)
#### 清理资源

在本方案中，您创建了4台云服务器ECS实例、1个云企业网实例、1个转发路由器实例、9个交换机、4个专有网络VPC。测试完方案后，您可以参考以下步骤释放对应资源，避免继续产生费用。

1. 登录[资源编排管理控制台](https://ros.console.aliyun.com/)，左侧导航栏菜单选择**资源栈**。
2. 在页面的顶部选择部署的资源栈所在地域，找到部署的资源栈。单击其右侧**操作**列的**删除**并确认，可一键删除一键配置所创建的资源。
