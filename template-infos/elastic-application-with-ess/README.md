## 方案概览

通过本教程，您将学习如何在阿里云应用型负载均衡ALB上部署七层负载均衡服务，将来自客户端的请求分发至后端ECS上，同时利用阿里云弹性伸缩（ESS）产品实现服务器资源的动态调整能力，这不仅可以提高应用的高可用性和吞吐量，还能提升资源利用率、减小应用响应时间。

弹性伸缩（Elastic Scaling Service）：简称ESS，也称为Auto Scaling，能根据您设定的策略自动调整计算资源数量（即业务所需的实例数量），帮助您应对业务流量波动的同时，提高资源利用率，有效降低成本。更多信息，请参见[什么是弹性伸缩ESS](https://help.aliyun.com/document_detail/25857.html)。

应用型负载均衡ALB（Application Load Balancer）：专门面向七层应用，提供强大的应用层处理能力和丰富的高级转发规则。单ALB实例性能最大可达100万QPS。更多信息，请参见[什么是应用型负载均衡ALB](https://help.aliyun.com/document_detail/197202.html)。

本教程将以有规律的业务量波动为应用场景向您介绍部署过程，如某游戏公司每天18:00业务需求急速增长进入高峰期，到22:00业务需求降低，高峰期结束。该游戏公司的业务量波动有规律，但是每天手动调整计算能力浪费人力和时间成本。您可以利用弹性伸缩的定时任务，由阿里云定时自动进行弹性伸缩。您可以设置两个定时任务，一个定时任务用于在每天17:55自动为您增加1台实例，另一个定时任务用于在每天22:05自动为您减少1台实例。该方式可以很好地应对每天18:00~22:00高峰期的业务量，且在高峰期结束后及时释放实例，避免浪费多余的实例资源和成本。更多业务场景，请参见[弹性伸缩应用场景](https://help.aliyun.com/document_detail/324146.html)。

## 方案架构

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9126652271/p829400.png)

本方案的技术架构包括以下基础设施和云服务：

* 1个专有网络VPC和2个交换机：构建云上私有网络。
* 1个应用型负载均衡ALB：负载均衡服务。
* 1个弹性伸缩ESS：提供云服务器ECS弹性伸缩服务。
* 2-3台云服务器ECS：由弹性伸缩ESS创建并部署Nginx服务，作为Web站点。（本教程以最小化资源实例为例，在两个不同可用区各初始化一台ECS实例，并配置定时弹性伸缩任务扩容和缩容第三台ECS实例）

## 方案部署
### 部署准备


1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)
   
   1. 为节省成本，本方案默认全部选择使用按量付费资源，使用按量付费资源需要确保账户余额不小于100元。
   2. 完成本方案的部署及体验，预计产生费用不超过10元（假设您选择本文示例规格资源，且资源运行时间不超过60分钟。实际情况中可能会因您操作过程中实际使用的流量差异，会导致费用有所变化，请以控制台显示的实际报价以及最终账单为准，如下表格仅供参考）。
      
      | **序号** | **产品** | **规格** | **地域** |
      | --- | --- | --- | --- |
      | 1 | 云服务器 ECS | ECS的实例规格及内核、vCPU数量。关于ECS选型的最佳实践请参见[实例规格选型指导](https://help.aliyun.com/document_detail/58291.html)。  本教程使用ecs.e-c1m2.large规格作为示例。 | 华东1（杭州） |
      | 2 | 应用型负载均衡ALB | 功能版本：基础板。 | 华东1（杭州） |
3. 领取免费权益
   
   | **资源领取入口** | **本教程配置** |
   | --- | --- |
   | [开通云数据传输CDT](https://cdt.console.aliyun.com/overview) | CDT每月赠送200GB免费公网流量（其中20GB全地域可用，180GB仅限海外地域可用），可用于抵扣云服务器ECS、弹性公网IP、应用型负载均衡ALB的公网流量，超出部分采用阶梯计费，详情参考[CDT公网流量计费规则](https://help.aliyun.com/document_detail/410942.html)。 |
### 一键部署


单击[一键部署](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/elastic-application-with-ess.yml&hideStepRow=true&hideStackConfig=true&pageTitle=随需而动：自动弹性，稳定交付&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled&balanceIntercept=true)前往ROS控制台，选择两个ECS实例规格和可用区（注意需要选择两个不同的可用区），填写期望自动扩容和缩容的时间（自动扩缩容时间不要晚于当前时间）。具体产生的费用根据您选择的ECS规格而不同，以控制台显示为准。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3571395171/p801551.png)

开始创建后，等待约5分钟左右，显示创建成功。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3571395171/p801370.png)

### 验证及清理


#### 方案验证

**一、通过访问ALB的DNS名称，验证服务可用性**

1. 登录[ALB控制台](https://slb.console.aliyun.com/alb)，从实例列表中获取ALB实例的DNS名称，输入浏览器即可访问Nginx服务。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2080078271/p858084.png)

**二、****通过查看伸缩活动，验证定时任务的执行情况**

1. 访问[弹性伸缩ESS控制台](https://ess.console.aliyun.com/?spm=a2c4g.2766666.0.0.c7055911QDAwXZ)，选择伸缩组管理>选择目标伸缩组>查看详情>伸缩活动，查看每天的云服务器ECS伸缩情况。可以看到在上一步中设置的定时任务按期执行了![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2080078271/p858093.png)

**三、****通过停止ECS模拟故障，验证高可用性**

1. 访问[弹性伸缩ESS控制台](https://ess.console.aliyun.com/?spm=a2c4g.2766666.0.0.c7055911QDAwXZ)，选择伸缩组管理>选择目标伸缩组，点击操作列中**修改**按钮，在弹出的修改配置窗口中，将**组内最小实例数**设置为2并保存配置。然后返回伸缩组管理页面，点击**实例列表**标签，确认当前服务实例数量为2。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2080078271/p858095.png)
2. 打开[云服务器管理控制台](https://ecs.console.aliyun.com/home)，释放一台ECS实例以模拟故障下线。在伸缩组的**实例列表**中可以看到弹性伸缩ESS能够在实例故障时自动创建新的实例，以恢复系统的计算能力。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5040709271/p860018.png)![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2080078271/p858096.png)
#### 清理资源

在本方案中，您创建了2个云服务器ECS实例、1个应用型负载均衡ALB实例、1个弹性伸缩ESS实例。如果您无需继续使用，请尽快删除资源，避免继续产生费用：

1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
2. 在左侧导航栏，选择**资源栈**。
3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
