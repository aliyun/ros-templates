## **方案概览**

大语言模型（LLM）作为自然语言处理的核心技术能力，能在文档中为知识问答、内容生成、大数据清洗、办公流程自动化等场景挖掘出更多的价值，极大降低了普通人对于专业词汇多、结构复杂、图文混合的文档内容阅读门槛。但文档的处理十分具有挑战性，特别是在 PDF 格式下，多种合同、试卷、论文、财报、简历、报告场景中，对于输入给大模型所需要的就不仅仅是文本内容，同时包括表格内容、公式文本、图片内容处理，以及无关内容的过滤。

对于不同格式的文档输入，如何实现将文档智能和检索增强生成（RAG）结合起来构建强大的 LLM 知识库，关键是如何清洗文档内容、文档内容向量化、问答内容召回后通过特定的 Prompt ，提供给 LLM足够的上下文信息，以此来满足对企业级文档类型知识库的问答处理。

接下来我们将基于文档智能的文档解析处理，结合百炼平台构建单文档问答应用。

## **方案架构**

本方案主要分为 3 个阶段：

1. **文档解析**：通过调用文档智能提供的[文档解析（大模型版）](https://help.aliyun.com/document_detail/2834355.html)，将文件处理为 Json 对象，包含多个版面块单元。
2. **构建知识库**：文档内容切片向量化存储，将多个版面块过滤非正文内容，切分成多个切块，进行向量化服务，存入知识库中。
3. **创建问答服务**：当接收到一个提问时，服务首先将问题转换为内容向量，然后在知识库中进行召回，找到相关信息。接着，结合召回的内容和问题，通过语言模型进行智能问答，提供准确的回答。

方案架构如下图所示：

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6066216271/p848306.png)

本方案的技术架构包括以下云服务：

* 百炼：一站式的企业专属大模型生产平台。在本方案中，提供通义千问 LLM 模型的调用以及知识索引功能。
* 文档智能：多模态文档识别与理解引擎，为用户提供通用文档智能、行业文档智能和文档自学习能力，可满足各种场景下的智能文档处理需求。
* 1 个专有网络 VPC：将云服务器 ECS部署在专有网络中。
* 1 台交换机：将云服务器 ECS实例部署在交换机中。
* 1 台云服务器 ECS：用于部署应用程序。
## **方案部署**
### **部署准备**


#### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)：
   
   1. 本方案的云服务（包括文档智能和百炼）支持按量付费，且默认设置均采用按量付费引导操作。使用按量付费资源需要确保账户余额不少于 100 元。
   2. 完成本方案的部署及体验，预计产生费用不超过 5 元（假设您选择本文示例规格资源，且资源运行时间不超过 60 分钟。实际情况中可能会因您操作过程中实际使用的流量差异而导致费用有所变化，请以控制台显示的实际报价以及最终账单为准，如下表格仅供参考）。
      
      | **序号** | **产品** | **规格** | **地域** | **说明** |
      | --- | --- | --- | --- | --- |
      | 1 | ECS 云服务器 | * ECS 的实例规格及内核、vCPU数量。关于 ECS 选型的最佳实践请参见[实例规格选型指导](https://help.aliyun.com/document_detail/58291.html)。 * 本教程使用`ecs.e-c1m2.large`规格作为示例。 | 华东1（杭州） | 以 1 小时内流入和流出的数量总和未超过 1 GB 为例。注意：1、方案中建议配置可稳定运行，实际可适当降低配置，最低配置不低于 1vCPU 2GiB，如出现 CPU 和内存负载过高情况，再适当升配。相关计费说明请参考：[ECS计费概述。](https://help.aliyun.com/document_detail/25398.html) |
      | 2 | 百炼模型服务 | - | - | 相关计费说明请参考：[阿里云百炼计费概述。](https://help.aliyun.com/document_detail/2586397.html) |
3. 可领取权益：
   
   1. [免费试用](https://free.aliyun.com/)。
   2. 学生权益：[领取 300 元高校专属权益优惠券](https://university.aliyun.com/)（若已领取请跳过），当前领取的优惠券适用于多种 ECS 按量付费实例规格，包括但不限于 ecs.e-c1m1.large 、ecs.u1-c1m2.large 以及 ecs.e-c1m2.large 。在进行**一键部署**并创建资源时，当您在 **ECS 实例配置 > 实例规格**的搜索框输入上述任一实例规格并选中，即可使用学生权益来完成资源的开通。
   3. [云服务器ECS“99计划”](https://www.aliyun.com/benefit)（原价1507.56元/年，现价99元/年，新老同享，续费同价）
#### 开通百炼服务并创建 API-KEY

1. 登录[百炼控制台](https://bailian.console.aliyun.com/#/model-market)，点击**开通服务**按钮， 勾选同意协议，点击**确认开通**。
2. 点击右上角用户图标，点击下拉菜单进入 API-KEY 管理页面，点击**创建我的 API-KEY** 。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1263306271/p840035.png)
### **一键部署**


一键部署基于阿里云资源编排服务 ROS（Resource Orchestration Service）实现，ROS 模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。

#### 操作步骤

您可以通过下方提供的 ROS 一键部署链接，来自动化地完成这些资源的创建和配置：

* 创建 1 台云服务器 ECS 实例，并在服务器上部署 Python 环境和应用程序的示例代码。
* 创建 1 个专有网络 VPC 。
* 创建 1 台交换机。
* 创建 1 个安全组。

一键部署资源。

1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/bailian-document-app.yml&hideStepRow=true&hideStackConfig=true&pageTitle=文档智能&RAG，让你的AI大模型开启“外挂”之旅&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled)。
2. 在配置页面修改**资源栈名称**，按需选择 ECS 的实例配置，设置实例密码、模型应用系统的用户密码，输入百炼 API-KEY 和空间 ID 。
   
   **说明** 
   1. 打开[百炼 API KEY 管理页面](https://bailian.console.aliyun.com/?apiKey=1#/api-key)，点击操作栏中的**查看**。如果是首次使用百炼平台，则点击右上角**创建我的 API-KEY 。**![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9702041371/p871182.png)
   2. 复制 **API KEY** 和对应的**业务空间 ID** 。（**复制完毕后，请仔细核对内容准确，确保没有多余的符号****，例如多余的空格**）![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0710052371/p876846.png)
   3. **ECS 实例配置**推荐搜索规格：ecs.e-c1m2.large、ecs.e-c1m1.large和ecs.u1-c1m2.large，如果所选可用区没有满足条件的实例规格，可以切换其他可用区查看。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2202893371/p887066.png)
3. 完成配置模板参数后，点击**下一步：检查并确认**，预览确认，点击**创建**，创建资源需要 5 分钟左右的时间，请您耐心等待。
4. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
### **应用体验**


使用文档智能（Document Mind）提供的[文档解析（大模型版）](https://help.aliyun.com/document_detail/2834355.html)解析本地文档。并将解析结果接入百炼平台创建知识库。基于该知识库的内容，实现增强检索生成（RAG）的问答应用。这一应用开发是基于 LlamaIndex 社区框架，并使用百炼平台提供的相关组件能力实现的。

1. 单击资源栈的**输出**页签，再单击体验地址对应的URL进行访问。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p876156.png)
2. 文档上传：用户可以选择本地文档并设置知识库名称。点击上传后，系统将解析文档并构建相应的知识库，最终返回文档信息、文档摘要和文档结构。例如，您可以使用我们提供的[“百炼”手机详细参数.docx](https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20240701/geijms/%E7%99%BE%E7%82%BC%E7%B3%BB%E5%88%97%E6%89%8B%E6%9C%BA%E4%BA%A7%E5%93%81%E4%BB%8B%E7%BB%8D.docx)文档进行尝试。![PixPin_2024-11-14_14-46-05](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872495.png)
3. 问答服务：点击页面上方**问答服务**，切换到问答服务界面。系统将自动加载在上一步中创建的知识库。接着，您可以针对已载入知识库的文档提出具体问题，即可获得精准的回答。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872500.png)
4. 总结：通过该方案，企业用户可以高效地处理各类复杂文档，构建强大的知识库，并通过增强检索生成（RAG）技术实现智能问答服务，显著提升文档处理和信息获取的效率。

**说明** 

为了方便用户快速体验效果，当前应用为演示版本，体验完毕请及时释放资源。若想用于生产环境，建议[下载源码](https://atomgit.com/aliyun_solution/docmind-rag.git)，可以进行二次开发，同时打开登录鉴权功能。

### **移动端体验应用（可选）**


我们已经成功实现了文档解析与知识库的构建，并基于 LlamaIndex 框架开发部署了 RAG 应用。在此基础上，可以创建一个百炼 RAG 应用，并集成至钉钉或微信公众号中，以实现移动设备上的 AI 助手功能，提供更加便捷、高效的智能服务体验。

**一、创建百炼 RAG 应用**

1. 登录[百炼控制台](https://bailian.console.aliyun.com/)，在左侧导航栏中，选择**我的应用**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7639252371/p877423.png)
2. 单击**新增应用**按钮**。**![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7639252371/p877424.png)
3. 在弹窗中选择**智能体应用****>****创建 RAG 应用**，进入创建应用页面。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p875693.png)
4. 单击**设置 > 选择模型**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3638602371/p871090.png)
5. 在**选择模型**弹窗中，选择**通义千问-Max** ，点击**确认**按钮。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3638602371/p871096.png)
6. 单击**配置知识库**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3638602371/p871097.png)
7. 定位目标知识库，点击**添加**后关闭**配置知识库**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872505.png)
8. 单击**发布**按钮。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872508.png)
9. 在应用列表中可以查看所有百炼应用 ID 。保存应用 ID 到本地用于后续配置。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872526.png)
10. 在顶部导航栏右侧，点击人型图标，点击 API-KEY 进入我的 API-KEY 页面。保存 API-KEY 到本地用于后续配置。![2024-09-18_17-23-56](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872524.png)

**二、在钉钉集成百炼 RAG 应用**

接下来我们创建钉钉应用，并集成百炼 RAG 应用，作为 AI 助手回答用户问题。

**重要** 

创建钉钉应用需要您的钉钉账号有开发者权限。您可以联系您的组织管理员获取钉钉开放平台的开发权限，具体操作请参见[获取开发者权限](https://open.dingtalk.com/document/orgapp/obtain-developer-permissions)。

**1.创建钉钉应用**

#### **1.1 创建应用**

1. 访问[钉钉开放平台](https://open-dev.dingtalk.com/)，点击**创建**。如果创建过应用未展示应用开发指引，点击**立即开始**进入钉钉应用页面。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872468.png)
2. 在应用开发的左侧导航栏中，点击**钉钉应用**，在**钉钉应用**页面右上角点击**创建应用**。![11](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872466.png)
3. 在**创建应用**面板，填写**应用名称**和**应用描述**，上传应用图标，完成后点击保存。![12](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872463.png)

#### **1.2 查看应用 Client ID 和 Client Secret**

在左侧菜单选择**凭证与基础信息**，复制 Client ID 和 Client Secret，用于下一步创建连接流。![21](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872465.png)

#### 1.3 创建消息卡片

1. 钉钉机器人通过卡片消息支持流式返回结果，您需要创建卡片模板供消息发送使用。访问[卡片平台](https://open-dev.dingtalk.com/fe/card)，点击**新建模板**。![29](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872464.png)
2. 在创建模板输入框，填入模板信息，**关联应用**选择之前创建的钉钉应用。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872512.png)
3. 在模拟编辑页面，**保存**并**发布**模板。然后点击**返回**模板列表页面。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872471.png)
4. 复制模板 ID ，用于创建钉钉连接流使用。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872531.png)

#### **1.4 授予应用发送卡片消息权限**

创建卡片后，需要给应用授予发送卡片消息的权限。

1. 访问[钉钉应用列表](https://open-dev.dingtalk.com/fe/app)。找到刚刚创建的应用，点击应用名称进入详情页面。
2. 在左侧菜单选择**开发配置** > **权限管理**，在左侧搜索框分别输入`Card.Streaming.Write`和`Card.Instance.Write`，并在操作列点击**申请权限**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872469.png)

**2.创建钉钉连接流**

AppFlow 可以让您在不写代码的情况下，通过界面配置就可以将大模型应用和钉钉连接起来。您可以通过预置的 AppFlow 模板创建一个钉钉机器人连接流。

1. 使用 [AppFlow 模板](https://appflow.console.aliyun.com/vendor/cn-hangzhou/flow/fastTemplate/tl-cd7c3c45885f4de68777?from=solution)创建连接流，点击**立即使用**进入创建流程。![18](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872518.png)
2. 在连接流的**账户授权**配置向导页，点击步骤1中的**添加新凭证**。在创建凭证对话框中，填入之前获取的钉钉应用的 Client ID 和 Client Secret，并设置一个自定义凭证名称。创建完毕后，在下拉列表中选择该凭证。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872604.png)
3. 在连接流的**账户授权**配置向导页，点击步骤2中的**添加新凭证**。在创建凭证对话框中，填入之前获取的 API-KEY，并设置一个自定义凭证名称。创建完毕后，在下拉列表中选择该凭证。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872606.png)
4. 在**执行动作**配置向导页，填写**应用 ID** 和**模版 ID** ，完成后点击**下一步**。![26](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872516.png)
5. 在**基本信息**配置向导页，填写**连接流名称**和**连接流描述**（建议保持默认），完成后点击**下一步**。
6. 界面提示流程配置成功，复制 **WebhookUrl** ，点击**发布**。![27](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872519.png)

**3.配置钉钉机器人**

有了 webhook 地址后，接下来您可以在钉钉应用中配置机器人来回答用户问题了。

#### 3.1 配置钉钉机器人

1. 访问[钉钉应用列表](https://open-dev.dingtalk.com/fe/app)。找到刚刚创建的应用，点击应用名称进入详情页面。
2. 在**添加应用能力**页面，找到机器人卡片，点击**添加**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872621.png)
3. 在机器人配置页面，打开**机器人配置**开关，您可以参考下图完成配置。**消息接收模式**请选择**HTTP 模式**，**消息接收地址**为刚刚的 **WebhookUrl** 。然后点击**发布**。
   
   **重要** 
   
   **消息接收模式**请选择 **HTTP 模式**，目前 AppFlow 仅支持 HTTP 模式，选择 Stream 模式会导致无法返回消息。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872625.png)

#### 3.2 发布应用版本

应用创建完成后，如果需要将应用供企业内其他用户使用，需要发布一个版本。

1. 点击**应用开发**，在**钉钉应用**页面，点击目标应用（**百炼手机答疑**）。![8](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872712.png)
2. 在目标应用开发导航栏，点击版本管理与发布，在版本管理与发布页面，点击**创建新版本**。进入版本详情页面，输入**应用版本号**和**版本描述**信息，选择合适的应用可见范围，完成后点击**保存**。并在弹窗中点击**直接发布**。![10](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872711.png)

#### 3.3 测试机器人

可以创建群聊或在已有群聊中添加机器人，并与机器人对话，查看效果。

1. 在钉钉**群管理**中添加机器人​。进入钉钉群**群设置**页面，点击**机器人**卡片区域，在**机器人管理**页面，点击**添加机器人**。在**添加机器人**的**搜索**文本框中输入目标机器人名称，并选中要添加的机器人。点击**添加**，完成后再点击**完成添加**。![14](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872723.png)
2. 在钉钉群中@机器人，进行交流互动。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872724.png)

**三、在微信公众号集成百炼 RAG 应用**

AppFlow 可以让您在不写代码的情况下，通过界面配置就可以将百炼 RAG 应用和微信公众号连接起来。您可以通过预置的 AppFlow 模板创建一个微信公众号连接流。

如果您的微信公众号已经完成认证，您可以使用微信[客户消息](https://developers.weixin.qq.com/doc/offiaccount/Message_Management/Service_Center_messages.html#%E5%AE%A2%E6%9C%8D%E6%8E%A5%E5%8F%A3-%E5%8F%91%E6%B6%88%E6%81%AF)回复用户在公众号的咨询，如果您没有完成认证，只能使用[被动回复消息功能](https://developers.weixin.qq.com/doc/offiaccount/Message_Management/Passive_user_reply_message.html)回复用户，该功能将消息响应时间限制为 5 秒，超时将无法回复。

是否完成认证可以在[微信公众号后台](https://mp.weixin.qq.com/)，在左侧菜单选择**设置与开发** > **公众号设置**，在公众号设置页面中查看。您可以根据认证情况选择下面的创建方案。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p875509.png)

#### 已经认证的公众号

1. 使用 [AppFlow 模板](https://appflow.console.aliyun.com/vendor/cn-hangzhou/flow/fastTemplate/tl-kdjfhj1kg123jsj5439fj2?from=solution)创建连接流，点击**立即使用**进入创建流程。![2024-11-07_16-57-05](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872867.png)
2. 访问[微信公众号后台](https://mp.weixin.qq.com/)，在左侧菜单选择**设置与开发** > **开发接口管理**。选择基本配置页签，获取 AppID 。![2024-11-07_16-27-30](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872862.png)
3. 在连接流的**账户授权**配置向导页，点击步骤 1 中的**添加新凭证**。在授权页面填入 AppID ，点击授权并在新的页面使用微信扫描完成授权。授权后，Appflow 会自动帮您配置公众号，您无需任何操作。授权完成后，您需要回到连接流的**账户授权**配置向导页，选择刚刚授权的微信公众号。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872858.png)![2024-11-07_16-24-15](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872863.png)
4. 在连接流的**账户授权**配置向导页，点击步骤2中的**添加新凭证**。在创建凭证对话框中，填入之前获取的 API-KEY ，并设置一个自定义凭证名称。![2024-08-15_15-11-04](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872864.png)
5. 在**执行动作**配置向导页，填写百炼的**应用 ID** ，**应用 ID** 可以[在百炼控制台我的应用](https://bailian.console.aliyun.com/#/app-center)获取，完成后点击**下一步**。![2024-08-29_16-49-04](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872860.png)![2024-08-15_15-13-51](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872865.png)
6. 在**基本信息**配置向导页，填写**连接流名称**和**连接流描述**（建议保持默认），完成后点击**下一步**。
7. 界面提示流程配置成功，点击**发布**。![2024-11-07_17-04-51](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872861.png)
#### 没有认证的公众号

1. 使用 [AppFlow 模板](https://appflow.console.aliyun.com/vendor/cn-hangzhou/flow/fastTemplate/tl-djfhj1kg124jsj5439fj2k?from=solution)创建连接流，点击**立即使用**进入创建流程。![2024-11-07_17-07-32](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872854.png)
2. 访问[微信公众号后台](https://mp.weixin.qq.com/)，在左侧菜单选择**设置与开发** > **开发接口管理**。选择基本配置页签，获取 AppID 。![2024-11-07_16-27-30](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872857.png)
3. 在连接流的**账户授权**配置向导页，点击步骤 1 中的**添加新凭证**。在授权页面填入 AppID ，点击授权并在新的页面使用微信扫描完成授权。授权后，Appflow 会自动帮您配置公众号，您无需任何操作。授权完成后，您需要回到连接流的**账户授权**配置向导页，选择刚刚授权的微信公众号。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872858.png)![2024-11-07_16-24-15](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872851.png)![2024-11-07_16-50-48](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872855.png)
4. 在连接流的**账户授权**配置向导页，点击步骤 2 中的**添加新凭证**。在创建凭证对话框中，填入之前获取的 API-KEY，并设置一个自定义凭证名称。![2024-08-13_09-33-07](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872853.png)
5. 在**执行动作**配置向导页，填写百炼的**应用 ID**，**应用 ID** 可以[在百炼控制台我的应用](https://bailian.console.aliyun.com/#/app-center)获取，完成后点击**下一步**。![2024-08-29_16-49-04](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872850.png)![2024-08-13_09-36-39](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872849.png)
6. 在**基本信息**配置向导页，填写**连接流名称**和**连接流描述**（建议保持默认），完成后点击**下一步**。
7. 界面提示流程配置成功，点击**发布**。![2024-11-07_16-53-08](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872852.png)

在完成 AppFlow 创建连接流后，用户可以访问相应的公众号，向其发送消息体验 AI 智能客服提供的自动回复。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p872859.png)

### **验证及清理**


#### 清理资源

测试完方案后，您可以参考以下规则处理对应产品的实例，避免继续产生费用。

1. ROS 一键删除创建的云资源。
   
   1. 登录 [ROS 控制台](https://ros.console.aliyun.com/overview)。
   2. 在左侧导航栏，选择**资源栈**。
   3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
   4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
2. 删除百炼 **API-KEY** ：
   
   在 [API-KEY 管理](https://bailian.console.aliyun.com/?apiKey=1)页面，找到目标 API-KEY ，单击右侧**操作**列下的**删除**，根据页面提示进行删除。
3. 删除百炼应用和数据：
   
   1. 登录[百炼控制台](https://bailian.console.aliyun.com/)，在**我的应用**中，找到应用并单击右下角**更多**，在下拉列表中点击**删除应用**。
   2. 登录[百炼控制台](https://bailian.console.aliyun.com/app-center#/app-center)，在**数据应用 > 知识索引**页面，找到知识库并点击操作栏中的**删除**。
   3. 在**数据管理**页面，找到上传的文档并点击操作栏中的**删除。**
4. 删除钉钉应用：
   
   1. 登录[钉钉开放平台](https://open-dev.dingtalk.com/)，点击导航栏中的**应用开发**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p873970.png)
   2. 在左侧导航栏点击**钉钉应用**，找到目标应用，点击应用名称进入应用详情。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p873971.png)
   3. 点击左侧导航栏中的**凭证与基础信息**，先点击**停用**按钮，然后点击**删除应用**按钮。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2369622371/p873963.png)
5. 删除钉钉连接流：登录 [AppFlow 控制台](https://appflow.console.aliyun.com/vendor/cn-hangzhou/flow/manage)，找到目标连接流，然后在其右侧**操作**列，单击**删除**。
6. 删除微信连接流：登录 [AppFlow 控制台](https://appflow.console.aliyun.com/vendor/cn-hangzhou/flow/manage)，找到目标连接流，然后在其右侧**操作**列，单击**删除**。

