## 方案概览

通过本教程，您将学习如何在阿里云容器服务上部署的应用，使用应用型负载均衡ALB（Application Load Balancer）七层负载均衡服务，将来自客户端的请求分发至后端容器Pod上，同时利用容器水平伸缩HPA（Horizontal Pod Autoscaler）功能实现弹性伸缩，能够在业务负载急剧飙升时快速扩容多个Pod副本来缓解压力，也可以在业务负载变小时根据实际情况适当缩容以节省资源，无需您人为干预。HPA适用于服务波动较大、服务数量多且需要频繁扩缩容的业务场景，例如电商服务、线上教育、金融服务等。

## 方案架构

本架构采用单地域双可用区部署，将系统部署在2个不同可用区，实现了可用区级故障灾备能力，同时在节点和Pod两个维度开启了弹性伸缩能力，保证了业务的连续性。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7033829171/p813621.png)

本方案的技术架构包括以下基础设施和云服务：

* 1个专有网络VPC和2个交换机：构建云上私有网络。
* 1个应用型负载均衡ALB：负载均衡服务。
* 1个容器服务Kubernetes版集群：容器服务平台，提供容器应用管理服务。
* 1个SLS Project和1个SLS Logstore：提供访问记录的存储服务。
* 2-3台云服务器ECS：由容器服务Kubernetes版集群创建并部署Nginx服务，作为Web站点。

应用型负载均衡ALB（Application Load Balancer）：专门面向七层应用，提供强大的应用层处理能力和丰富的高级转发规则。单ALB实例性能最大可达100万QPS。更多信息，请参见[什么是应用型负载均衡ALB](https://help.aliyun.com/document_detail/197202.html)。

Pod水平自动扩缩HPA（Horizontal Pod Autoscaler）：Kubernetes内置组件，提供Pod水平扩缩容能力。

此外阿里云容器服务提供了多种工作负载伸缩（调度层弹性）和节点伸缩（资源层弹性）方案，更多信息，请参见[弹性伸缩概述](https://help.aliyun.com/document_detail/176660.html)，了解不同方案的适用场景、使用限制等。

默认HPA只支持基于CPU和内存的自动伸缩，并不能满足全部业务场景的运维需求，以IO密集型系统为例，CPU和内存并不是系统的唯一瓶颈。本教程将介绍如何实现基于QPS数据的应用弹性伸缩，更多应用弹性伸缩场景，请参见[容器水平伸缩](https://help.aliyun.com/document_detail/2746980.html)。

## 方案部署
### 部署准备


1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)
   
   1. 为节省成本，本方案默认全部选择使用按量付费资源，使用按量付费资源需要确保账户余额不小于100元。
   2. 完成本方案的部署及体验，预计产生费用不超过10元（假设您选择本文示例规格资源，且资源运行时间不超过60分钟。实际情况中可能会因您操作过程中实际使用的流量差异，会导致费用有所变化，请以控制台显示的实际报价以及最终账单为准，如下表格仅供参考）。
      
      | **序号** | **产品** | **规格** | **地域** |
      | --- | --- | --- | --- |
      | 1 | 云服务器 ECS | ECS的实例规格及内核、vCPU数量。关于ECS选型的最佳实践请参见[ECS选型最佳实践](https://help.aliyun.com/document_detail/58291.html)。  本教程使用ecs.c6.xlarge和ecs.c7.xlarge规格作为示例，如果您发现目标可用区无推荐规格的实例，可以选择其他可用区或者其他规格的实例。 | 华东1（杭州） |
      | 2 | 应用型负载均衡ALB | 功能版本：标准版。 | 华东1（杭州） |
      | 3 | 容器服务Kubernetes版 | 集群版本：ACK托管集群Pro版。 | 华东1（杭州） |
      | 4 | 日志服务SLS | 无规格要求。 | 华东1（杭州） |
### 一键部署


单击[一键部署](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/elastic-scaling-container-through-hpa.yml&hideStepRow=true&hideStackConfig=true&pageTitle=%E6%99%BA%E8%83%BD%E5%BA%94%E5%AF%B9%E6%B5%81%E9%87%8F%E5%8F%98%E5%8C%96%EF%BC%8C%E5%AE%B9%E5%99%A8%E5%8C%96%E9%9B%86%E7%BE%A4%E7%9A%84%E5%BC%B9%E6%80%A7%E6%94%BB%E7%95%A5&disableRollback=false&isSdisableNavigation=true&productNavBar=disabled&balanceIntercept=true&isSimplified=true)前往ROS控制台，选择ECS实例规格和可用区（注意需要选择两个不同的可用区），填写ACK托管版集群名称等额外信息。具体产生的费用根据您选择的ECS规格而不同，以控制台显示为准。

**说明** 

本教程使用ecs.c6.xlarge和ecs.c7.xlarge规格作为示例，如果您发现目标可用区无推荐规格的实例，可以选择其他可用区或者其他规格的实例。

**说明** 

请您参见[公有云支持的地域和可用区](https://help.aliyun.com/document_detail/258300.html#0813f699c7x4t)，选择应用型负载均衡ALB产品支持的地域和可用区，否则会导致后续步骤无法操作，建议您选择杭州地域可用区 J和可用区 K。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7033829171/p813904.png)

开始创建后，等待约10分钟左右，显示创建成功。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7033829171/p813909.png)

### 验证及清理


#### 方案验证

**一、通过访问应用服务，验证容器服务的可用性**

1. 请访问[容器服务控制台](https://cs.console.aliyun.com/#/k8s/cluster/list)，在左侧导航栏，选择集群，进入集群列表页。
2. 在**集群列表**页面，单击目标集群名称，然后在左侧导航栏，选择**网络** > **路由**。
3. 在路由列表页，找到前一步创建的Ingress，查看目标Ingress的端点信息。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7033829171/p805024.png)
4. 通过**端点信息**，拼装访问地址，分别是http://alb-xxx.cn-hangzhou.alb.aliyuncs.com/tea和http://alb-xxx.cn-hangzhou.alb.aliyuncs.com/coffee
5. 通过浏览器或curl命令请求拼装的两个地址，访问应用服务
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7033829171/p805032.png)
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7033829171/p805037.png)

**二、****通过Apache Benchmark测试工具，执行压测脚本，验证容器化集群的弹性伸缩**

1. 安装测试工具Apache Benchmark，Mac OS操作系统默认安装了该测试工具，其他操作系统安装教程请参见[官方文档](https://httpd.apache.org/docs/2.4/install.html)。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7033829171/p814072.png)
2. 使用Apache Benchmark测试工具，执行压测脚本对应用进行压测，校验QPS变化后，观察Pod的弹性伸缩的执行情况。
   
   压测脚本：
   
   ```
   ab -c 5 -n 5000 http://alb-***.cn-hangzhou.alb.aliyuncs.com/tea
   ```
   
   命令说明：
   
   | **命令** | **说明** |
   | --- | --- |
   | ab | Apache Benchmark提供的压测工具命令。 |
   | -c 5 | 一次创建的请求个数。 |
   | -n 5000 | 一次测试会话中执行的请求个数。 |
   | http://alb-\*\*\*.cn-hangzhou.alb.aliyuncs.com/tea | tea服务应用的访问地址，在应用验证步骤中讲解了如何获取服务应用的访问地址。 |
3. 等待压测命令执行一段时间后，请访问[容器服务控制台](https://cs.console.aliyun.com/#/k8s/cluster/list)，在左侧导航栏，选择集群，进入集群列表页。
4. 在**集群列表**页面，单击目标集群名称，然后在左侧导航栏，选择**工作负载** > **无状态**，在应用列表页单击tea应用名称。
5. 在tea应用详情页面，选择**容器伸缩**，在前面步骤创建名称为k8s-alb-tea-hpa的HPA，单击事件查看HPA的弹性伸缩执行情况，随着QPS的增加，Pod数目从2扩容到10，之后随着QPS的降低，Pod数目从10缩容到2，基于QPS指标的HPA已经生效。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7033829171/p806047.png)
6. 继续等待一段时间后，在集群详情页的左侧导航栏，选择**节点管理** > **节点池**，在节点池列表页单击前面步骤创建名称为k8s-hpa-cluster-nodepool的节点池。
7. 在节点池详情页面，选择**伸缩活动**，查看节点池的弹性伸缩执行情况，随着Pod数目的增加，节点数目从2扩容到3，之后随着Pod数目的降低，节点数目从3缩容到2，节点池的弹性伸缩已经生效。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7033829171/p813861.png)
#### 清理资源

如果您无需继续使用，请尽快删除资源，避免继续产生费用：

1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
2. 在左侧导航栏，选择**资源栈**。
3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
