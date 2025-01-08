## **方案概览**

高价值用户挖掘及触达方案实现营销触达全链路。本方案使用阿里云机器学习平台 PAI 的强大算法能力，通过对用户数据的计算和预测，辅助客户对人群营销决策的判断，在用户召回，流失预测，高价值用户寻找等多个运营场景，帮助客户降低成本，提高效率；客户可通过短信的方式触达用户，完成营销触达的全链路操作。

### **方案架构**

以下为您展示本技术方案的架构。![用户增长解决方案.jpg](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1445303961/p711571.jpg)

本架构重点包括以下几个模块：

* 数据支撑：可将业务相关数据存储在阿里云 OSS 、MaxCompute 或 EMR 中，并结合数据开发治理平台 DataWorks 进行数据清洗，生成符合运营要求的训练数据、人群数据等。
  
  **说明** 
  
  MaxCompute 、EMR 等非 OSS 相关数据需先同步至 OSS 中，再作为用户增长插件的数据。
* 智能用户增长：阿里云 PAI 为您提供的智能用户增长插件，可智能圈选待运营人群、生成运行策略。
* 运营管理与触达：阿里云 PAI 联合阿里云短信服务，可基于运营计划自动触达发起运营活动。

本部署文档以一份示例数据为例，为您示例将清洗好符合要求的运营数据存储至阿里云 OSS 后，如何通过 PAI 用户增长实现待运营人群的智能圈选、智能运营。

## **方案部署**
### **部署准备**


#### **准备账号**

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. 为阿里云账号完成[企业实名认证](https://help.aliyun.com/zh/account/user-guide/enterprise-real-name-verification/)。只有通过企业实名认证的阿里云账号才能开通短信服务。
3. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   1. 本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。如果确定任何一个云资源采用按量付费方式部署，账户余额必须大于等于 100 元。
   2. 本方案的部署及体验中，假设对 10,000 人进行智能圈选，将过程中的所有文件均存储于OSS ，按量付费资源预计产生费用不超过 30 元。
      
      **说明** 
      1. 方案步骤的运营阶段需对圈选出的人群发送运营短信，会需收取对应的短信费用。
      2. 本示例中的示例数据中电话号码为无效的虚拟号码，不建议您在进行体验操作时创建短信发送计划。
   3. 其中智能用户增长相关计费逻辑与单价详情请参见[用户增长插件计费说明](https://help.aliyun.com/zh/pai/product-overview/billing-of-the-user-growth-plug-in)，OSS 计费逻辑与单价详情请参见[存储费用](https://help.aliyun.com/zh/oss/product-overview/storage-fees)。
4. 阿里云账号拥有操作资源的最高权限，从云资源安全角度考虑，建议您创建 RAM 用户。RAM 用户需要获得相关云服务的访问权限才能完成方案部署，详情如下：
   
   | 云服务 | 需要的权限 | 描述 |
   | --- | --- | --- |
   | PAI | **AliyunPAIFullAccess** | 管理 PAI 服务的权限。 |
   | 添加为 PAI 工作空间的成员，并授予算法开发等具有开发权限的角色。 | 使用 PAI-DSW 和 PAI-DLC 进行模型训练。 |
   | 对象存储 OSS | **AliyunOSSFullAccess** | 管理对象存储 OSS 的权限。 |
   
   创建 RAM 用户的操作指引请参见[创建RAM用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)。
   
   为 RAM 用户授权的操作指引请参见[为RAM用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。
5. 使用人工智能平台 PAI 的用户增长插件需要使用企业账号申请，并且创建签名这一步骤需要提供真实的已备案的网站名称、公司名称、商标名称等信息，用来审核您是否具有发送短信的资质，请您提前准备相关信息。

#### **开通服务**

1. 登录 [PAI 控制台](https://pai.console.aliyun.com/)，单击**开通 PAI 并创建默认工作空间**，在弹出的开通页面中配置订单详情，配置要点如下，更多详细内容，请参见[开通并创建默认工作空间](https://help.aliyun.com/zh/pai/user-guide/activate-pai-and-create-the-default-workspace)。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4599147271/p854809.png)
   
   * 本方案地域选择：**华东 2（上海）**。
   * **组合开通**：本方案需要使用对象存储 OSS ，勾选开通 OSS 产品，去掉勾选其他产品即可。
   * **服务角色授权**：单击**去授权**，根据界面提示为PAI完成授权，然后返回开通页面，刷新页面，继续开通操作。
2. 开通成功后，单击**进入 PAI 控制台**。
### **规划网络和资源**

#### **规划云资源**

请参考表格中的说明和方案默认示例值为每个规划项做详细规划，并在实际部署时将默认示例值修改为您的实际规划。未提及的规划项请保持默认值。

| **规划项** | **说明** | **方案默认示例** |
| --- | --- | --- |
| **PAI-用户增长插件** | | |
| 地域 | 您的云服务部署的地域。 | 华东 2（上海） |
| 付费模式 | 您的用户增长插件付费模式，包括按量付费和包年包月两种模式。 | 按量付费 |
| 人群数据 | 您需要结合业务情况及阿里云 PAI 用户增长的数据要求，准备人群数据。 | 本示例的人群数据包含以下几个数据文件：   * user ：某 APP 的全量用户信息维表。 * item ：某 APP 的全量商品数据维表。 * behavior ：一段时间内的内容，某 APP 的用户行为数据维表。 * operation ：历史时间中已做过的运营活动信息维表。 * population ：待圈选去做运营的用户信息维表。 |
| **对象存储 OSS** | | |
| 地域 | 您的云服务部署的地域。 | 华东 2（上海） |
| Bucket | 建议创建一个 Bucket 存储空间和目录，用来存放训练数据。 | * Bucket ：usergrowth-doctest * 目录：    + pai-usergrowth-doctest ：用于存储训练数据。   + population/task1：用于存储待圈选的人群数据。   + population\_output/task1 ：用于存储人群圈选后数据。 |

### **部署资源**


规划好资源后，请按照以下步骤部署方案中的所有资源。

#### **开通PAI用户增长插件**

首次使用时，您需要申请开通用户增长插件，本示例在默认工作空间中进行申请，根据规划选择**付费模式**为**按量付费**，选择**服务形态**为**智能营销短信**，勾选协议后单击**立即开通**即可。

**说明** 

首次使用该功能时，需要执行该操作步骤。

1. 在左侧导航栏，选择**场景化解决方案** > **用户增长**。
2. 单击**点击开通**。
3. 在PAI用户增长页面，按照控制台界面操作指引，开通该功能。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5663040271/p816963.png)

更多详细内容，请参见[开通用户增长插件](https://help.aliyun.com/zh/pai/user-guide/activate-the-user-growth-plug-in-and-create-operations-activities#section-cof-3dp-3r2)。

#### **创建 OSS Bucket**

1. 登录，在左侧导航栏，选择 **Bucket 列表**。
2. 在 Bucket 列表，单击**创建 Bucket** 来创建 Bucket 存储空间，本方案命名为：usergrowth-doctest。
3. 在 OSS Bucket 中创建以下目录，分别用于存储训练数据和人群圈选结果数据。
   
   本示例中的目录名称为：pai-usergrowth-doctest，用于存储训练数据，内包含 user、item、behavior、operation 固定目录（后续上传文件时可自动创建，无需手动创建），此外本示例中还需创建以下两个目录。
   
   * population/task1 ：用于存储待圈选的人群数据。
   * population\_output/task1 ：用于存储智能圈选后的人群数据。
     
     **说明** 
     
     population\_output/task1 目录需为一个空目录，否则后续使用智能圈选人群功能时，配置会报错。
### **准备数据**


本示例为您演示如何使用 PAI 提供的智能圈选人群的功能，对目标用户数据进行智能筛选过滤，帮助您高效找到目标人群。

1. 按照数据格式要求准备数据。
   
   您需要根据以下数据要求，将实际用户、物品数据按要求整理为 CSV 格式的数据。参考本示例进行操作时，您可直接[下载示例数据](https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20230803/ocwq/usergroth_test_data.zip)进行操作。
   
   + 策略训练任务输入数据（训练数据集）。
     
     您需要为训练数据集准备用户特征数据，即用户基础信息（user）、物品基础信息（item）、用户行为（behavior）和运营记录（operation）4张维表数据。目录及表的各字段要求，详情请参见[策略训练任务输入数据格式说明](https://help.aliyun.com/zh/pai/user-guide/data-description-of-strategic-training-jobs#section-17o-uw0-v27)。
   + 人群圈选任务输入数据（预测数据集）。
     
     您需要按照以下两种场景准备预测数据集。
     
     | **场景** | **输入数据** |
     | --- | --- |
     | 训练数据集和预测数据集完全一致。 | 您只需准备包含user\_id、item\_id和phone字段的人群数据表即可，系统会自动从训练数据集读取用户特征数据，具体格式要求，请参见[策略训练任务数据说明](https://help.aliyun.com/zh/pai/user-guide/data-description-of-strategic-training-jobs#section-h6t-bqo-eqw)。  在**人群管理**页面，使用已准备的人群数据表手动创建人群，方便后续圈选人群时选择人群，具体操作，请参见[管理人群](https://help.aliyun.com/zh/pai/user-guide/manage-user-groups#task-2230160)。 |
     | 训练数据集和预测数据集不完全一致。 | 您需要按照训练数据集格式要求，为预测数据集准备全量用户特征数据，即用户基础信息（user）、物品基础信息（item）、用户行为（behavior）和运营记录（operation）4张维表数据。目录及表的各字段要求，详情请参见[策略训练任务输入数据格式说明](https://help.aliyun.com/zh/pai/user-guide/data-description-of-strategic-training-jobs#section-17o-uw0-v27)。 |
2. 将训练数据和预测数据集上传到 OSS ，具体操作，详情请参见[控制台上传文件](https://help.aliyun.com/zh/oss/getting-started/console-quick-start)。
3. 为 OSS Bucket 添加`pai=plugin`标签，具体操作，详情请参见[管理存储空间标签](https://help.aliyun.com/zh/oss/user-guide/manage-bucket-tags#concept-1925905)。
### **创建运营活动及运营策略**


#### **1、创建运营活动**

使用阿里云账号登录进入[创建运营活动页面](https://pai.console.aliyun.com/?regionId=cn-shanghai#/user-growth/campaigns?DialogCampaignId=new)，在**创建运营活动**对话框，配置**活动名称**和**备注**，并单击**提交**。

![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0087590961/p700012.png)

#### **2、创建策略训练**

您可以根据不同的运营目的，选择不同的算法策略类型，通过PAI预置的模型在后台分析您的数据并进行训练，当前支持回流概率和流式预测等模型，本示例以使用回流概率为例，配置要点如下。

1. 使用阿里云账号登录进入[策略训练任务页面](https://pai.console.aliyun.com/?spm=a2c4g.2412384.0.0.3b7b30f9BxBhTc&regionId=cn-shanghai#/user-growth/smart-select/training?DrawerTrainingJobId=new)，在**创建策略训练**面板，配置参数，并单击**提交****。**
   
   其中关键参数说明如下。
   
   | **参数** | **描述** | **配置示例** |
   | --- | --- | --- |
   | **算法类型** | 选择不同的算法类型会训练出不同效果的模型，请您根据业务需求和运营目的进行选择。支持以下两种算法类型：  * **回流概率**：更有可能被短信触达召回的用户的概率。 * **流失预测**：根据活跃度对每个用户进行打分，从流失率最高到最低的用户依次进行排序。 | **回流概率** |
   | **输入数据** | 从 OSS 导入用户基础信息（user）、物品基础信息（item）、用户行为（behavior）、运营记录（operation）四类数据进行模型训练。 **说明**  首次使用时，您需要单击**未授权，点击一键授权**进行授权，如果一键授权失败，请参见[附录：PAI-Plugin相关服务说明](https://help.aliyun.com/zh/pai/user-guide/appendix-pai-plugin-related-services#task-2223222)。 | 选择上述步骤中上传至OSS 的数据目录：pai-usergrowth-doctest |
   | **训练参数** | 选择训练数据的**起始日期**和**结束日期**。  * 当算法类型选择**回流概率**时，需要配置**运营表目标**，即运营记录（operation）表中target 列的目标值。 * 当算法类型选择**流失预测**时，需要配置**流失天数**。 | * 起始日期：2022-01-01 * 结束日期：2022-02-28 * 运营表目标：sms |
2. 等待策略训练创建完成。当策略训练的状态变为**成功**时，表明策略训练创建成功。
   
   本示例的策略训练创建需约 20min ，请耐心等待创建完成。
#### **3、创建人群圈选任务并创建人群**

当模型训练完成并生成圈选策略时，即策略训练任务状态为成功时，您可以使用圈选策略对您的目标用户进行预测并圈选，具体操作步骤如下。

1. 使用阿里云账号登录进入[创建人群圈选页面](https://pai.console.aliyun.com/?regionId=cn-shanghai#/user-growth/smart-select/inferences?DrawerInferenceJobId=new)，在**创建人群圈选**面板，配置参数，并单击**提交。**
   
   | **参数** | **描述** | **配置示例** |
   | --- | --- | --- |
   | **输入数据** | 支持以下两种输入方式：  * **选择人群**：当您的训练数据集和预测数据集完全一致时，您可以从已创建的人群列表中选择人群。 * **选定 OSS 文件或目录**：当您的训练数据集和预测数据集不完全一致时，您可以通过该方式上传预测数据集。 | 选择上述步骤中上传至OSS 的数据目录：pai-usergrowth-doctest/population/task1 |
   | **输出数据** | 选择输出数据所在的地域和 OSS 目录。 **重要**  输出数据路径需要为空目录，否则可能会导致输出目录中存在多个任务的人群文件。 | 选择上述步骤中创建的OSS Bucket 目录：population\_output/task1 |
   | **圈选参数** | 输入**预测阈值**，取值范围（0，1），Double 类型。  模型对待圈选用户的打分大于该值时，该用户会被圈选出来。 | * **预测阈值**：0.5 * **任务执行日期**：2022-02-01 |
2. 等待人群圈选完成。当人群圈选任务的状态变为**成功**时，表明人群圈选运行完成。
   
   本示例大约需要 10min ，请您耐心等待。
3. 查看圈选出来的人群数据。
   
   * 您可以使用阿里云账号登录进入[人群管理页面](https://pai.console.aliyun.com/?regionId=cn-shanghai#/user-growth/groups)，智能圈选完成后会自动将圈选出的人群数据将生在人群管理页面。
     
     ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0087590961/p700978.png)
     
     **说明** 
     
     如果您实际使用时，智能圈选前的人群数据中没有包含手机号数据，此时需单击**关联号码**补充人群的手机号数据，本示例中已有手机号数据示例，无需操作。
   * 您可以在**输出数据**配置的 OSS 目录，找到名为 **output.csv** 的文件，该文件即为圈选出的人群数据，CSV 文件不包含表头，各字段含义，详情请参见[策略训练任务数据说明](https://help.aliyun.com/zh/pai/user-guide/data-description-of-strategic-training-jobs#section-iv2-xh1-mfu)。
### **创建签名和模板（需审核）**


创建短信发送计划之前，您需要创建签名，用来审核您是否具有发送短信的资质。签名审核通过后，您可以通过创建模板来编辑短信发送的内容。

**重要** 

发送短信会按照短信内容计费，请您了解以下计费规则，在编写模板内容时对计费条数做好预估。

* 短信内容包含签名、模板内容和变量内容。
  
  **说明** 
  
  变量内容为定制化短信内容，按实际定制化短信内容字数计算。
* 当短信字数为70个以内（包含70）时，按1条短信计费；超出70个字数为长短信，每条短信按67个字数计算。具体短信计费规则，详情请参见[计费概述](https://help.aliyun.com/zh/sms/product-overview/billing-overview#topic1441)。
#### 1、创建签名并提交申请

1. 登录[PAI控制台](https://pai.console.aliyun.com/)。
2. 单击[直达创建签名页面](https://pai.console.aliyun.com/?regionId=cn-shanghai#/user-growth/content/signatures?DrawerSignatureId=new)。
   
   您可以直接打开**创建签名**面板。
3. 在**创建签名**面板，配置以下参数。
   
   ![创建签名](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6269717561/p464096.png)其中
   
   * **签名**：建议参考界面注意事项，填写为真实的已备案的网站名称、公司名称、商标名称等信息。
   * **申请说明**：建议详细描述使用场景，并提供产品链接、APP、公众号、公司标准全称等其他信息，便于审核人员参考审核，提高审核效率。
4. 单击**提交**。
   
   您需要等待大约24小时，才能审核完成。您可以在**签名管理**页签，查看审核状态，当**审核状态**为**审核通过**后，您可以继续创建短信模板。
#### 2、创建短信模板

1. 单击[直达创建模板页面](https://pai.console.aliyun.com/?regionId=cn-shanghai#/user-growth/content/templates?DrawerTemplateId=new)。
   
   您可以直接打开**创建模板**面板。
2. 在**创建模板**面板，配置参数。
   
   ![模板内容](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4224935661/p502501.png)其中关键参数说明如下。
   
   | **参数** | **描述** |
   | --- | --- |
   | **模板内容** | 发送短信的内容模板。您也可以使用带参数的模板定制个性化短信，比如在**模板内容**中输入参数${variable}，${variable}会在发送时解析为variable变量的内容。 **说明**  variable变量的内容即为圈选人群时，上传的人群表中variable列的内容。  建议您参考界面提示信息，了解短信内容计费说明。具体短信计费规则，详情请参见[计费概述](https://help.aliyun.com/zh/sms/product-overview/billing-overview#topic1441)。 |
   | **申请说明** | 说明模板内容适用的场景。 |
3. 单击**提交**。
   
   您需要等待大约24小时，才能审核完成。您可以在**模板管理**页签，查看审核状态，当**审核状态**为**审核通过**后，您可以继续创建触达计划。
### **创建短信发送计划**


用户增长插件基于机器学习算法提供用户圈选和触达能力。针对高风险的流失用户，您可以基于用户增长插件功能，通过控制台创建短信发送计划进行流失用户的触达和召回。

**重要** 

对圈选出人群发送运营短信时，也需收取对应的费用，进行体验操作时不建议直接操作短信发送相关步骤，否则可能会引起短信费用。

1. 使用阿里云账号登录进入[创建触达计划页面](https://pai.console.aliyun.com/?regionId=cn-shanghai#/user-growth/touch/schedules?DrawerMessageScheduleId=new)，在**创建触达计划**面板，根据界面提示创建触达计划。
   
   | **参数** | **描述** | **配置示例** |
   | --- | --- | --- |
   | **目标人群** | 选择已创建的人群作为目标人群。 **说明**  人群必须包含手机号，且状态为已通过。 | 选择上述步骤中已创建的人群 |
   | **发送时间** | 支持以下三种发送方式：  * **立刻发送** * **定时发送**：您需要配置定时发送时间。 * **智能发送**：仅当**目标人群**选择**算法生成**的人群时，支持配置该参数。 | 定时发送 |
   | **重复周期** | 当**发送时间**选择**定时发送**时，支持配置该参数，包含：  * **一次性执行** * **重复执行** | 一次性执行 |
2. 创建完成后，系统会按照发送时间，向目标人群发送短信。
### **完成及清理**


#### **方案验证**

完成以上操作后，您可以在自己业务的报表平台比对短信发送后的运营效果，查看回流效果。

#### **清理资源**

如后续您无需再使用请及时清除 OSS 相关存储空间中的数据，并关注 PAI- 用户增长资源的使用情况，避免产生额外费用。

1. 删除 1 个 OSS Bucket 存储空间：
   
   登录 [OSS 管理控制台](https://oss.console.aliyun.com/overview)，在 **Bucket 列表**页面，单击目标 Bucket 名称，在左侧导航栏单击**删除 Bucket** ，并按照界面提示删除 Bucket 存储空间。
2. 暂停 PAI- 用户增长资源的使用。
   
   开通 PAI- 用户增长及后续使用资源时，如果您使用的是按量付费的模式，则暂停使用智能圈选、发送运营短信，即不会产生费用，如果您开通的是包年包月的规格，则到期后会自动释放资源，不会产生额外费用。
