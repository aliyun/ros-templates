## **方案概览**

业务的持续稳定可服务，决定着企业对客户的服务质量，是企业发展的基础。应用部署的高可用架构和弹性能力对于业务的稳定与发展起着至关重要的作用，但企业同时需要考虑资源维护成本和费用成本。本方案采用云上的Serverless架构，原生支持弹性伸缩、按量付费和服务托管，减少企业手动资源管理和性能成本优化的工作，同时通过高可用的配置，避免可能遇到的单点故障风险。

## **方案架构**

本架构采用单地域双可用区部署，将业务系统、数据库部署在2个不同可用区，实现了可用区级故障灾备能力，从而保证了业务的连续性。服务和数据库都采用了阿里云Serverless产品采用按需付费产生更低的成本，同时支持弹性伸缩更好的适应业务增长。该架构还利用专有网络VPC、交换机和跨可用区安全组等基础设施，实现了私有网络下的系统通信。

方案提供的默认设置完成部署后在阿里云上搭建的Serverless高可用架构如下图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与下图相似。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5119189171/p816264.png)

本方案的技术架构包括以下基础设施和云服务：

* 1个专有网络VPC：为应用型负载均衡ALB、Serverless应用引擎、云数据库PolarDB MySQL版Serverless集群等云资源构建云上私有网络。
* 5台交换机Vswitch：按照经典架构设计3个子网平面（公网平面、业务平面、数据平面），分别部署在两个可用区，提供基本的网络分段和隔离功能。ALB横跨两个可用区部署在公网平面，两个Serverless应用引擎实例分别部署在两个可用区的业务平面，一对云数据库PolarDB MySQL版Serverless主备集群分别部署在两个可用区的数据平面。
* 1个公网应用型负载均衡ALB：将公网访问流量分发到不同的Serverless应用引擎实例。公网ALB通过EIP提供公网服务能力。
* 2个Serverless应用引擎实例：用于部署业务系统，提供应用服务。
* 1个云数据库PolarDB MySQL版Serverless集群：为业务系统提供数据服务。

## **方案部署**
### **部署准备**


开始部署前，请按以下指引完成账号申请、账号充值。

### **准备账号**

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。开通 Serverless 应用引擎 SAE，您的账户余额必须大于0元，请充值后再开通。
3. 开通 Serverless 应用引擎 SAE。打开[Serverless 应用引擎 SAE 控制台](https://saenext.console.aliyun.com/overview)，按照界面指引完成开通操作。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4658812371/p876352.png)
### **一键部署**


一键部署基于阿里云资源编排服务ROS（Resource Orchestration Service）实现，ROS模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。

#### 操作步骤

您可以通过下方提供的ROS一键部署链接，来自动化地完成这些资源的创建和配置：

* 创建2个Serverless应用引擎实例。
* 创建1个专有网络VPC。
* 创建5台交换机。
* 创建1个云数据库PolarDB MySQL版Serverless集群。

1. 一键部署资源。
   
   1. 单击[一键部署](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/serverless-high-availability-architecture.yml&hideStepRow=true&hideStackConfig=true&pageTitle=卓越效能,极简运维,Serverless高可用架构 &disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled&balanceIntercept=true)，在顶部导航栏选择地域。
   2. 在配置页面修改**资源栈名称**，按需选择和配置参数。
   3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
### **完成及清理**


#### 方案验证

**一、通过访问ALB的DNS名称，验证服务可用性**

1. 登录[应用型负载均衡ALB控制台](https://slb.console.aliyun.com/alb)，从实例列表中获取ALB实例的DNS名称。
2. 通过浏览器访问该DNS名称，检查是否可以正常访问到示例应用。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4347407171/p803472.png)

**二、配置弹性伸缩并通过Apache Benchmark进行负载测试，验证Serverless架构的弹性和高可用性**

##### **配置弹性伸缩**

1. 打开[Serverless应用引擎SAE控制台](https://saenext.console.aliyun.com/overview)，点击左侧导航栏选择**应用管理 > 应用列表**。点击当前应用名称，进入应用详情页。
2. 在**弹性伸缩**页签添加弹性策略，请按照图片进行配置。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9428313371/p879276.png)
3. 添加完毕后，在**弹性伸缩**页签下的**监控指标策略列表**中点击启用。更多配置方式可参考[配置弹性伸缩策略](https://help.aliyun.com/zh/sae/serverless-app-engine-classic/user-guide/configure-an-auto-scaling-policy)。

##### **进行负载测试**

1. 安装测试工具Apache Benchmark，Mac OS操作系统默认安装了该测试工具，其他操作系统安装教程请参见[官方文档](https://httpd.apache.org/docs/2.4/install.html)。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7033829171/p814072.png)
2. 请在本地终端中，使用Apache Benchmark命令进行负载测试，模拟不同的并发请求和持续时间。从[应用型负载均衡ALB控制台](https://slb.console.aliyun.com/alb)实例详情中获取DNS名称，将`<ALB实例的DNS名称>`替换成实际值。
   
   ```
   ab -n 20000 -c 200 http://<ALB实例的DNS名称>/
   ```
   
   | **命令** | **说明** |
   | --- | --- |
   | ab | Apache Benchmark提供的压测工具命令。 |
   | -c | 一次创建的请求个数。 |
   | -n | 一次测试会话中执行的请求个数。 |

##### **验证弹性伸缩能力**

1. 命令执行完毕后，单击**应用事件**，在**全部来源类型**下拉列表，选择**自动弹性（HorizontalPodAutoscaler）**，可以看到弹性伸缩原因。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5360078271/p857616.png)
2. 在**基本信息**页**，**单击**实例部署信息****，**可以看到实例数量的变化，运行中实例从最初的2个变成6个。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9428313371/p881361.png)

以上操作验证了Serverless架构的弹性伸缩能力。系统能够根据负载自动调整资源，确保业务的高效运行。此外，当前方案采用单地域双可用区部署，业务系统和数据库分别部署在不同的可用区，确保了系统的高可用性。即使一个可用区发生故障，另一个可用区的资源仍然能够继续提供服务，保证业务的连续性和稳定性。

#### 清理资源

您可以使用ROS一键删除创建的云资源，避免继续产生费用。

1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
2. 在左侧导航栏，选择**资源栈**。
3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
