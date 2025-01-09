## **方案概览**

大语言模型（LLM）作为自然语言处理领域的核心技术，具有丰富的自然语言处理能力。但其训练语料库具有一定的局限性，一般由普适知识、常识性知识，如维基百科、新闻、小说，和各种领域的专业知识组成。导致 LLM 在处理特定领域的知识表示和应用时存在一定的局限性，特别对于垂直领域内，或者企业内部等私域专属知识。

实现专属领域的知识问答的关键，在于如何让LLM能够理解并获取存在于其训练知识范围外的特定领域知识。同时可以通过特定Prompt构造，提示LLM在回答特定领域问题的时候，理解意图并根据注入的领域知识来做出回答。在通常情况下，用户的提问是完整的句子，而不像搜索引擎只输入几个关键字。这种情况下，直接使用关键字与企业知识库进行匹配的效果往往不太理想，同时长句本身还涉及分词、权重等处理。相比之下，倘若我们把提问的文本，和知识库的内容，都先转化为高质量向量，再通过向量检索将匹配过程转化为语义搜索，那么提取相关知识点就会变得简单而高效。

接下来我们将基于[中文突发事件语料库](https://github.com/shijiebei2009/CEC-Corpus/)（CEC Corpus）演示关于突发事件新闻报道的知识问答。

## **方案架构**

本方案主要分为 3 个阶段：

1. **本地知识库的向量化**。通过文本向量模型将其转化为高质量低维度的向量数据，再写入DashVector 向量检索服务。这里数据的向量化我们采用了[百炼模型服务](https://www.aliyun.com/product/bailian)上的 Embedding API 实现。
2. **相关知识点的提取**。将提问文本向量化后，通过 DashVector 提取相关知识点的原文。
3. **构造 Prompt 进行提问**。将相关知识点作为“限定上下文+提问” 一起作为 prompt 询问通义千问。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9015427271/p852870.png)

本方案的技术架构包括以下基础设施和云服务：

* 1 个专有网络 VPC ：1 个专有网络，提供云上私有网络。
* 1 台交换机：在 VPC 内部划分子网。
* 1 个安全组：提供网络安全访问。
* 1 台云服务器 ECS ：部署示例应用。
* 1 个向量检索服务：DashVector 向量检索服务。
## **方案部署**
### **部署准备**


**准备账号**

#### **准备账号**

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。如果确定任何一个云资源采用按量付费方式部署，账户余额必须大于等于 100 元。

**开通百炼模型服务**

1. 开通百炼：前往[百炼控制台](https://bailian.console.aliyun.com/#/model-market)，如果页面顶部显示以下消息，您需要开通百炼的模型服务，以获得免费额度。如果未显示该消息，则表示您已经开通。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2586651371/p872475.png)
2. 获取 API Key ：在控制台的右上角选择 API-KEY ，然后创建 API Key ，用于通过 API 调用大模型。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2586651371/p872477.png)

**开通 DashVector 向量检索服务**

1. 开通向量检索服务，获取 DashVector API-KEY ，并创建 Cluster 。
   
   1. 登录[向量检索服务控制台](https://dashvector.console.aliyun.com/)，开通 DashVector 向量检索服务。
   2. 前往 DashVector [API-Key 管理](https://dashvector.console.aliyun.com/api-key)，点击**创建新的 API-KEY** ，并复制保存。
   3. 切换到左侧 **Cluster 列表**，单击**创建免费 Cluster** ，创建一个免费的向量检索服务Cluster 。（体验本方案建议采用免费 Cluster ，创建后 30 个自然日到期会自动释放，删除所有数据。如有重要业务数据，请及时转移到付费 Cluster 或者将免费试用 Cluster 升配为付费 Cluster。）
2. 单击 Cluster 列表右侧**操作**栏中的**详情**，获取 Cluster 的访问端口 **Endpoint** 。
### **一键部署**


单击[一键部署](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/exclusive-qa-service.yml&hideStepRow=true&hideStackConfig=true&pageTitle=向量检索与通义千问搭建专属问答服务&disableRollback=false&isSimplified=true&dtrue&productNavBar=disabled&disableNavigation=true&balanceIntercept=true)前往 ROS 控制台，填入您在部署准备中获取的**百炼 API-KEY** 和 **DashVector API-KEY** 。本模板会自动创建一个免费的 DashVector 集群。同时，还会额外创建一个抢占式 ECS 实例，用于前端效果展示。按照本文选择规格，约花费 0.471 元/小时。具体产生的费用根据您选择的 ECS 规格而不同，以控制台显示为准。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3219724171/p795667.png)

开始创建后，等待约 5 分钟左右，显示创建成功。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5556182171/p790685.png)

### **完成及清理**


#### **方案验证**

1. 在创建成功的资源栈单击**输出**页签，获取到 **WebUrl** 。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3219724171/p790824.png)
2. 将 WebUrl 复制到浏览器，即可用界面化的方式体验问答服务。
3. 输入突发事件新闻报道`海南安定追尾事故，发生在哪里？原因是什么？人员伤亡情况如何？`
   
   ![small-clip.gif](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6248099271/p863886.gif)

#### 清理资源

在本方案中，您创建了 1 个云服务器 ECS 实例、1 个免费的 DashVectorCluster 。如果您无需继续使用，请尽快删除资源，避免继续产生费用：

1. 登录 [ROS 控制台](https://ros.console.aliyun.com/overview)。
2. 在左侧导航栏，选择**资源栈**。
3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
