## **方案概览**

本解决方案展示了如何利用检索分析服务 Elasticsearch版的向量检索能力实现商品个性化推荐功能。通过利用Elasticsearch的向量检索功能，将用户行为数据（如搜索记录、点击行为、偏好等）与商品或内容特征进行向量化表示，从而实现高效的相似性计算。通过这种方式，可以为用户快速生成个性化推荐，提升用户体验并增加用户粘性。此外，借助阿里云的强大基础设施，企业可以轻松扩展其推荐系统，有效应对流量波动和数据增长的挑战。该解决方案不仅适用于电商平台，也广泛适用于内容推荐、音乐推荐等多个场景，为企业带来更高的商业价值。

## **方案架构**

本方案中提供的默认设置一旦完成部署，将在阿里云上搭建一个与下图类似的运行环境。实际部署时，您可以根据具体的资源规划调整部分设置，但最终的运行环境将与下图展示的架构相似。

![Elasticsearch的向量检索能力@2x 2](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8536934271/p839416.png)

本方案的技术架构包括以下基础设施和云服务：

* 1个专有网络VPC：云服务器ECS和检索分析服务 Elasticsearch版创建于此VPC下。
* 1台交换机：云服务器ECS和检索分析服务 Elasticsearch版创建于此交换机下。
* 1台云服务器ECS：用于部署示例应用程序。
* 1个检索分析服务 Elasticsearch版实例：索引商品数据并用于进行个性化推荐。
## **方案部署**
### **部署准备**

开始部署前，请按以下指引完成账号申请、账号充值、服务开通及授权。

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   1. 为节省成本，本方案默认全部选择使用按量付费资源，使用按量付费资源需要确保账户余额不小于100元。
   2. 完成本方案的部署及体验，预计产生费用不超过10元（假设您选择本文示例规格资源，且资源运行时间不超过60分钟。实际情况中可能会因您操作过程中实际使用的流量差异，会导致费用有所变化，请以控制台显示的实际报价以及最终账单为准，如下表格仅供参考）。
      
      | **序号** | **产品** | **规格** | **地域** | **说明** |
      | --- | --- | --- | --- | --- |
      | 1 | ECS云服务器 | * 关于ECS选型的最佳实践请参见[实例规格选型指导](https://help.aliyun.com/zh/ecs/user-guide/best-practices-for-instance-type-selection)。 * 本教程使用`ecs.e-c1m2.large`规格作为示例。 | 华东1（杭州） | 以1小时内流入和流出的数量总和未超过1GB为例。 |
      | 2 | 检索分析服务 Elasticsearch版 | * 本教程使用**内核增强版**`7.10`作为示例。 | 华东1（杭州） | 以1小时内存储量及索引写入量均未超过1GB为例。 |
### **部署资源**


单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/ES-vector-retrieval-capabilities.yml&hideStepRow=true&hideStackConfig=true&pageTitle=使用精准分析检索，打造商品推荐体验&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled)前往ROS控制台，选择ECS实例规格和可用区，输入ECS实例密码、Elasticsearch实例密码、示例应用程序初始账号用户名及密码。具体产生的费用根据您选择的ECS规格而不同，以控制台显示为准。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3609304271/p837146.png)

开始创建后，等待约40分钟左右，显示创建成功。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3609304271/p837218.png)

### 完成及清理

#### **方案验证**

完成上一步“部署资源”步骤后，可以进行以下操作来体验本服务。

1. 登录[ROS 控制台](https://ros.console.aliyun.com/cn-hangzhou/stacks)。
2. 在顶部菜单栏，选择**华东1（杭州**）地域。
3. 在左侧导航栏，选择**部署** > **资源栈**。
4. 在**资源栈列表**选择创建的资源，点击**资源栈名称**。
5. 点击**输出**栏获取并访问地址。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3609304271/p837229.png)
6. 在登录页面上输入之前配置的用户名和密码，然后进行登录。最后可看到如下界面，选择商品分类后，即可推荐分类相关商品。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3609304271/p832792.png)
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3609304271/p832793.png)
#### **清理资源**

单击[一键部署](https://ros.console.aliyun.com/cn-hangzhou/stacks)前往ROS控制台，在左侧导航栏找到**部署** > **资源栈**，在**资源栈列表**中找到创建的资源，点击删除，等待删除完成。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3609304271/p837235.png)

