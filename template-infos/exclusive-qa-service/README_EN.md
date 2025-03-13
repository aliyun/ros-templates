Please translate the following content into English, retaining the original format:
## Overview

Large Language Models (LLMs) as core technologies in the field of natural language processing have rich natural language processing capabilities. However, their training corpus has certain limitations, generally consisting of general knowledge, common sense knowledge such as Wikipedia, news, novels, and various domain-specific professional knowledge. This leads to certain limitations in LLMs when processing specific domain knowledge representation and application, especially for vertical domains or private domain knowledge within enterprises.

The key to achieving knowledge Q&A in exclusive domains lies in how to enable LLMs to understand and obtain specific domain knowledge that exists outside its training knowledge scope. At the same time, through specific prompt construction, it can prompt LLMs to understand the intent when answering specific domain questions and make answers based on injected domain knowledge. In most cases, users' questions are complete sentences, unlike search engines that only input a few keywords. In this case, directly using keywords to match with enterprise knowledge bases often yields unsatisfactory results, and long sentences also involve tokenization, weighting, etc. In contrast, if we convert both the question text and the knowledge base content into high-quality vectors first, and then use vector retrieval to transform the matching process into semantic search, extracting relevant knowledge points will become simple and efficient.

Next, we will demonstrate knowledge Q&A about sudden event news reports based on the [Chinese Sudden Event Corpus](https://github.com/shijiebei2009/CEC-Corpus/) (CEC Corpus).

## Architecture

This scheme mainly consists of three stages:

1. **Vectorization of local knowledge bases**. Convert them into high-quality low-dimensional vector data through text vector models, and write them into DashVector vector retrieval service. Here, the vectorization of data adopts Embedding API on Bailian Model Service on Aliyun.
2. **Extraction of relevant knowledge points**. After converting the question text into vectors, extract relevant knowledge points from DashVector.
3. **Constructing prompts for questioning**. Use related knowledge points as "limited context + questioning" together as prompts to ask Tongyi Qianwen.

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9015427271/p852870.png)

The technical architecture of this scheme includes the following infrastructure and cloud services:

* 1 VPC: 1 Virtual Private Cloud provides a private network in the cloud.
* 1 Switch: Divide subnets inside the VPC.
* 1 Security Group: Provides network security access.
* 1 Cloud Server ECS: Deploy example applications.
* 1 Vector Retrieval Service: DashVector Vector Retrieval Service.
## Deployment
### Preparation


**Account preparation**

#### Account preparation

1. If you do not have an Alibaba Cloud account, please visit the [Alibaba Cloud account registration page](https://account.aliyun.com/register/qr_register.htm) and follow the instructions to register. An Alibaba Cloud account is the entity that pays for cloud resources, so it is a prerequisite for deploying the solution.
2. [Top up your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html). The cloud resources in this solution support pay-as-you-go, and the default settings all adopt the pay-as-you-go guided operation. If you determine that any cloud resource uses the pay-as-you-go deployment method, the account balance must be greater than or equal to 100 yuan.

**Enable Bailian Model Service**

1. Enable Bailian: Go to the [Bailian console](https://bailian.console.aliyun.com/#/model-market). If the message below appears at the top of the page, you need to enable the model service of Bailian to get the free quota. If you do not see this message, it means you have already enabled it. ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2586651371/p872475.png)
2. Get API Key : Select API-KEY in the upper right corner of the console, and then create an API Key to call the large model through API. ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2586651371/p872477.png)

**Enable DashVector Vector Retrieval Service**

1. Enable the vector retrieval service, get the DashVector API-KEY, and create a Cluster.
   
   1. Log in to the [DashVector console](https://dashvector.console.aliyun.com/), and enable the DashVector vector retrieval service.
   2. Go to the DashVector [API-Key management](https://dashvector.console.aliyun.com/api-key), click **Create new API-KEY**, and copy and save it.
   3. Switch to the left **Cluster list**, click **Create free Cluster**, and create a free vector retrieval service Cluster. (It is recommended to use a free Cluster for this solution. After 30 calendar days, it will automatically release and delete all data. If there are important business data, please transfer them to a paid Cluster or upgrade the free trial Cluster to a paid Cluster.)
2. Click **Details** in the **Operations** column of the Cluster list to get the Cluster's access port **Endpoint**.
### One-click deployment


Click [One-click deployment](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/exclusive-qa-service.yml&hideStepRow=true&hideStackConfig=true&pageTitle=向量检索与通义千问搭建专属问答服务&disableRollback=false&isSimplified=true&dtrue&productNavBar=disabled&disableNavigation=true&balanceIntercept=true) to go to the ROS console, and enter the **Bailian API-KEY** and **DashVector API-KEY** obtained in the deployment preparation. This template will automatically create a free DashVector cluster. At the same time, it will also create an additional preemptible ECS instance for front-end effect display. According to the specifications selected in this article, it costs approximately 0.471 yuan per hour. The actual cost depends on the ECS specification you choose, and is subject to the console display.

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3219724171/p795667.png)

After starting the creation, wait for about 5 minutes, and the creation will be successful.

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5556182171/p790685.png)

### Completion and cleanup


#### Solution verification

1. In the created resource stack, click the **Outputs** tab to get the **WebUrl**.
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3219724171/p790824.png)
2. Copy the WebUrl to the browser to experience the Q&A service in an interface manner.
3. Input the sudden event news report `Hainan Ding'an rear-end accident, where did it happen? What was the cause? How many casualties?`
   
   ![small-clip.gif](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6248099271/p863886.gif)

#### Resource cleanup

In this solution, you created 1 cloud server ECS instance and 1 free DashVector Cluster. If you no longer need to use them, please delete the resources as soon as possible to avoid continued charges:

1. Log in to the [ROS console](https://ros.console.aliyun.com/overview).
2. In the left navigation bar, select the resource stack where you deployed.
3. In the **Resource Stack** page, at the top, select the region where the resource stack you deployed is located, find the resource stack, and then in the **Operations** column on the right side, click **Delete**.
4. In the **Delete Resource Stack** dialog box, select **Deletion mode** as **Release Resources**, and then click **OK** to complete the resource release according to the prompt.


The sentence is from Ali Cloud IT domain. It mainly involves computer-related software development and usage methods, including many terms related to computer software and hardware. Pay attention to professional troubleshooting terminologies and sentence patterns when translating. Translate into this IT domain style. 