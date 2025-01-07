## **方案概览**

当您因业务需要，服务部署分布在多个阿里云地域的同时，又希望能够实现跨地域的服务高可用，则可以使用阿里云应用型负载均衡 ALB 以及云企业网 CEN 等产品来实现跨地域的负载均衡。

本技术方案将为您演示如何配置跨地域负载均衡。

### **方案架构**

方案提供的默认设置（如地域、VPC、安全组、vSwitch、实例名称等）完成部署后在阿里云上搭建的网站运行环境如下图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与下图相似。

![ALB.jpg](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0535633961/p712894.jpg)

方案为了简化架构，暂不体现可用区及vSwitch、安全组等。

本方案的技术架构主要包括以下基础设施和云服务：

* 1个云企业网CEN实例：云企业网实例是管理一体化网络的基础资源。1个云企业网实例管理一张网络，可覆盖1个或多个地域。在实现网络实例互通前，需要先创建1个云企业网实例。
* 3个转发路由器TR实例：转发路由器实例作为地域内的核心转发网元，帮助您转发同地域或跨地域的流量。1个地域仅支持创建1个转发路由器实例。
* 3个专有网络VPC实例：专有网络是云上虚拟网络，可以将云资源部署在您自定义的专有网络中。专有网络是地域级别的资源，专有网络不可以跨地域，但包含所属地域的所有可用区。云资源不可以直接部署在专有网络中，必须属于专有网络内的1个交换机（子网）内。您可以在每个可用区内创建1个或多个交换机来划分子网。
* 3个云服务器ECS实例：ECS实例是云上的虚拟计算服务器，内含vCPU、内存、操作系统、网络、磁盘等基础组件。您可以使用阿里云提供的控制台、SDK等工具创建和管理ECS实例，像使用本地服务器一样管理ECS实例的状态、应用等，还可以灵活地升级计算、存储等能力。
* 1个应用型负载均衡ALB实例：ALB实例是一种高可用、高性能的负载均衡服务，可以用于将流量分发到多个云服务器、容器等资源上，从而提高应用的可用性和响应速度。ALB支持丰富的负载均衡算法、会话保持、安全策略和流量控制等功能，可以根据业务需求进行灵活配置。同时，ALB还支持多协议转发，如HTTP、HTTPS等，可以满足不同场景的负载均衡需求。

## **方案部署**
### **部署准备**


开始部署前，请按以下指引完成账号申请、服务开通等准备工作。

#### **准备账号**

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。针对CEN跨域流量，您可使用云数据传输CDT降低流量成本，如您未开通强烈建议您[快速入门](https://help.aliyun.com/zh/cdt/upgrade-to-cdt-billing)，仅开通CDT不收取任何费用。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   1. 为节省成本，本方案默认全部选择使用按量付费资源，使用按量付费资源需要确保账户余额不小于100元。
   2. 完成本方案的部署及体验，预计产生费用不超过2元（假设您选择最低规格资源，且资源运行时间不超过1小时。实际情况中可能部分实例无法购买需要根据实际情况调整资源规格，同时因您操作过程中实际使用的流量差异，会导致费用有所变化，请以控制台显示的实际报价以及最终账单为准，如下表格仅供参考）。
      
      如下表格仅供参考，以实际情况为准
      
      | **序号** | **产品** | **费用来源** | **规格** | **地域** | **预估费用参考** | **说明** |
      | --- | --- | --- | --- | --- | --- | --- |
      | 1 | 应用型负载均衡ALB | ALB实例费 | 基础版 | 西南1（成都） | 0.049元/时 | - |
      | 2 | ALB容量费 | - | 西南1（成都） | 0.049元/LCU | - |
      | 3 | 云服务器ECS | ECS1配置费 | 实例：ecs.t5-lc2m1.nano（突发性能实例 t5，1 vCPU，0.5 GiB）  系统盘：cloud\_efficiency 40GiB | 西南1（成都） | 0.080元/时 | - |
      | 4 | ECS2配置费 | 华东2（上海） | 0.083元/时 | - |
      | 5 | ECS3配置费 | 华北1（青岛） | 0.083元/时 | - |
      | 6 | 云企业网CEN | TR1-VPC1连接费 | - | 西南1（成都） | 0.350元/时 | 本方案所耗费流量极少。其中跨域流量由CDT云数据传输收取费用 |
      | 7 | TR1-VPC1流量费 | 西南1（成都） | 0.130元/GB |
      | 8 | TR2-VPC2连接费 | 华东2（上海） | 0.350元/时 |
      | 9 | TR2-VPC2流量费 | 华东2（上海） | 0.130元/GB |
      | 10 | TR3-VPC3连接费 | 华北1（青岛） | 0.350元/时 |
      | 11 | TR3-VPC3流量费 | 华北1（青岛） | 0.130元/GB |
      | 12 | 跨域TR1地域出向流量费 | 西南1（成都） | 0.600元/GB |
      | 13 | 跨域TR2地域出向流量费 | 华东2（上海） | 0.600元/GB |
      | 14 | 跨域TR3地域出向流量费 | 华北1（青岛） | 0.600元/GB |
      | 按量费用：1.345元/时  LCU容量费用：1个  流量费用：6个 | | | | | | |
3. 阿里云账号拥有操作所有资源的最高权限，为了安全起见，建议您使用RAM用户。RAM用户需要获得相关权限才能完成方案部署，详情如下：
   
   1. 涉及的云服务：应用型负载均衡 ALB、云服务器 ECS、专有网络 VPC、云企业网 CEN、资源编排 ROS。
   2. 自定义权限策略参考：
      
      **OneClickAlbCrossRegionDeployPolicy**
      
      示例权限策略限制了仅能进行如下操作，您也可以根据需要适当调整权限策略。
      
      ```
      {
          "Version": "1",
          "Statement": [
              {
                  "Effect": "Allow",
                  "Action": [
                      "alb:AddServersToServerGroup",
                      "alb:CreateListener",
                      "alb:CreateLoadBalancer",
                      "alb:CreateServerGroup",
                      "alb:DeleteListener",
                      "alb:DeleteLoadBalancer",
                      "alb:DeleteServerGroup",
                      "alb:GetListenerAttribute",
                      "alb:GetLoadBalancerAttribute",
                      "alb:ListServerGroupServers",
                      "alb:ListServerGroups",
                      "alb:ListTagResources",
                      "alb:UpdateServerGroupAttribute",
                      "cen:AssociateTransitRouterAttachmentWithRouteTable",
                      "cen:CreateCen",
                      "cen:CreateTransitRouter",
                      "cen:CreateTransitRouterPeerAttachment",
                      "cen:CreateTransitRouterRouteEntry",
                      "cen:CreateTransitRouterRouteTable",
                      "cen:CreateTransitRouterVpcAttachment",
                      "cen:DeleteCen",
                      "cen:DeleteTransitRouter",
                      "cen:DeleteTransitRouterPeerAttachment",
                      "cen:DeleteTransitRouterRouteEntry",
                      "cen:DeleteTransitRouterRouteTable",
                      "cen:DeleteTransitRouterVpcAttachment",
                      "cen:DescribeCens",
                      "cen:DisableTransitRouterRouteTablePropagation",
                      "cen:DissociateTransitRouterAttachmentFromRouteTable",
                      "cen:EnableTransitRouterRouteTablePropagation",
                      "cen:ListTagResources",
                      "cen:ListTransitRouterPeerAttachments",
                      "cen:ListTransitRouterRouteEntries",
                      "cen:ListTransitRouterRouteTableAssociations",
                      "cen:ListTransitRouterRouteTablePropagations",
                      "cen:ListTransitRouterRouteTables",
                      "cen:ListTransitRouterVpcAttachments",
                      "cen:ListTransitRouters",
                      "ecs:AuthorizeSecurityGroup",
                      "ecs:CreateDisk",
                      "ecs:CreateNetworkInterface",
                      "ecs:CreateSecurityGroup",
                      "ecs:DeleteDisk",
                      "ecs:DeleteInstance",
                      "ecs:DeleteNetworkInterface",
                      "ecs:DeleteSecurityGroup",
                      "ecs:DescribeAvailableResource",
                      "ecs:DescribeCloudAssistantStatus",
                      "ecs:DescribeDisks",
                      "ecs:DescribeEcsScenarioFacade",
                      "ecs:DescribeImages",
                      "ecs:DescribeInstanceHealthStatus",
                      "ecs:DescribeInstanceHistoryEvents",
                      "ecs:DescribeInstanceMaintenanceAttributes",
                      "ecs:DescribeInstanceNeedReboot",
                      "ecs:DescribeInstancePerformanceRestrictHistory",
                      "ecs:DescribeInstanceRamRole",
                      "ecs:DescribeInstances",
                      "ecs:DescribeInvocations",
                      "ecs:DescribeLocalDiskRepairActivities",
                      "ecs:DescribeNetworkInterfaces",
                      "ecs:DescribePrice",
                      "ecs:DescribeResourceAggregations",
                      "ecs:DescribeSecurityGroupAttribute",
                      "ecs:DescribeSecurityGroups",
                      "ecs:DescribeTagKeys",
                      "ecs:DescribeUserData",
                      "ecs:DescribeZones",
                      "ecs:ListTagResources",
                      "ecs:ModifySecurityGroupPolicy",
                      "ecs:QueryImageByImageId",
                      "ecs:RevokeSecurityGroup",
                      "ecs:RunCommand",
                      "ecs:RunInstances",
                      "ros:CreateStack",
                      "ros:DeleteStack",
                      "ros:GetStack",
                      "ros:GetStackResource",
                      "ros:GetTemplateEstimateCost",
                      "ros:ListStackEvents",
                      "ros:ListStackOperationRisks",
                      "ros:ListStackResources",
                      "ros:ListStacks",
                      "vpc:CreateRouteEntry",
                      "vpc:CreateVSwitch",
                      "vpc:CreateVpc",
                      "vpc:DeleteRouteEntry",
                      "vpc:DeleteVSwitch",
                      "vpc:DeleteVpc",
                      "vpc:DescribeRouteTableList",
                      "vpc:DescribeRouteTables",
                      "vpc:DescribeVSwitchAttributes",
                      "vpc:DescribeVSwitches",
                      "vpc:DescribeVpcAttribute",
                      "vpc:DescribeVpcs",
                      "vpc:ListTagResources"
                  ],
                  "Resource": "*"
              }
          ]
      }
      
      ```
   3. RAM用户的使用请参见[创建RAM用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)、[创建自定义权限策略](https://help.aliyun.com/zh/ram/user-guide/create-a-custom-policy)、[为RAM用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。
### **一键部署**


一键配置基于阿里云资源编排服务ROS（Resource Orchestration Service）实现，旨在帮助开发者通过IaC（Infrastructure as Code）的方式体验资源的自动化配置。

1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/alb-cross-region-load-balance.yml&pageTitle=ALB实现跨地域负载均衡&isSimplified=true&productNavBar=disabled)前往ROS控制台，系统自动打开**使用新资源（标准）**创建资源栈的页面。
2. **资源栈名称**可保持默认值。
3. 在**ECS1实例配置**、**ECS2实例配置**、**ECS3实例配置**处，根据实际情况选择实例规格及系统盘类型。
4. 在**ECS实例密码配置**处，配置ECS实例的登录密码。
5. 单击**创建**开始资源创建。
6. 资源创建过程中，可开启右上角**自动刷新**开关，及时了解资源部署进度。
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2446821961/p702706.png)
7. 资源部署完成后，在该页面查看部署结果，资源栈信息的**状态**将显示**创建成功**。
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2446821961/p702707.png)
8. 单击**输出**页签，可查看到**ALB域名**。复制用于后续验证。
### **验证及清理**

5

#### **方案验证**

**一、通过执行请求命令，验证跨地域的负载均衡**

1. 登录[西南1（成都）地域云服务器ECS实例控制台](https://ecs.console.aliyun.com/server/region/cn-chengdu)，单击ECS1实例右侧的**远程连接**，通过Workbench远程连接至ECS后台。
2. 多次执行`curl http://ALB域名`命令，访问ALB。如果返回信息类似下图在ECS2与ECS3之间切换，则表示实现了跨地域的负载均衡。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1491880961/p700810.png)

**二、通过执行负载测试，验证跨地域的负载均衡**

1. 登录[西南1（成都）地域云服务器ECS实例控制台](https://ecs.console.aliyun.com/server/region/cn-chengdu)，单击ECS1实例右侧的**远程连接**，通过Workbench远程连接至ECS后台。
2. 执行以下命令，安装测试工具。
   
   ```
   sudo yum install httpd-tools
   ```
   
   安装完毕显示如下截图![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6157440371/p866948.png)
3. 通过以下命令来验证`ab`安装是否成功。
   
   ```
   ab -V
   ```
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6157440371/p866949.png)
4. 使用如下ab命令进行负载请求测试。
   
   ```
   ab -n 50 -c 5 http://ALB域名/
   ```
   **说明** 
   
   返回[资源编排管理控制台](https://ros.console.aliyun.com/)，找到上一步创建的资源栈，点击进入资源栈详情页，点击**输出**页签，即可复制ALB域名。
5. 可得到如下反馈结果：![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6157440371/p866965.png)可以看到发送的50个请求，每次5个并发已经处理完毕，并且均通过ALB处理完成。
   
   **说明** 
   * Concurrency Level：并发请求数。
   * Time taken for tests：完成所有请求所花费的总时间。
   * Complete requests：成功完成的请求数。
   * Failed requests：失败的请求数。
   * Requests per second：每秒处理的请求数。
   * Time per request：平均每个请求的响应时间。
   * Transfer rate：传输速率。
6. 登录[负载均衡管理控制台](https://slb.console.aliyun.com/alb/cn-chengdu/albs)，找到创建的目标实例，点击监控图标![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6157440371/p866977.png)，查看ALB连接情况。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6157440371/p866987.png)点击监听选项，查看后端相应情况：![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6157440371/p866991.png)可看到后端状态码2xx的每秒相应次数，可验证ALB负载均衡分发流量正常，后端响应正常。
7. 登录[云企业网实例](https://cen.console.aliyun.com/cen/list)，点击创建的目标实例，进入到基本信息页面，点击**监控图标**页签，选择**跨地域带宽监控**，在监控实例中可依次切换选择成都-上海、成都-青岛，查看跨地域的带宽状况。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6157440371/p867006.png)
#### 清理资源

1. 登录[资源编排管理控制台](https://ros.console.aliyun.com/)，左侧导航栏菜单选择**资源栈**。
2. 在页面的顶部选择部署的资源栈所在地域，找到部署的资源栈。单击其右侧**操作**列的**删除**并确认，可一键删除所有创建的资源。
