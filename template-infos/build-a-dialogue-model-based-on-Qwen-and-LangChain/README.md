## 方案概览

本方案介绍如何通过通义千问和LangChain构建高效的对话模型。该对话模型基于自然语言处理技术提升语义理解和交互体验。该方案广泛应用于聊天机器人、智能客服、社交媒体等场景中，可以有效解决对话模型中的语义理解和交互问题，并提高用户交互的自然性和流畅度。

## 方案架构

以下为您展示本技术方案的架构。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7029968171/p812076.png)

本方案的实现原理如下：

* 通过PAI-EAS的预置镜像，一键拉起应用服务。
* 通过预置的LangChain插件，快速集成企业内业务的知识库文件（支持配置`.txt`、`.md`、`.docx`、`.pdf`格式的文件），将业务文件通过向量化的方法一键集成到向量存储检索库中。LangChain首先将用户上传的知识库进行自然语言处理，并作为大模型的知识库存储在本地，每次推理时，会首先在本地知识库中查找与输入问题相关的文本块（chunk），并将知识库答案与用户输入的问题一起输入大模型，生成基于本地知识库的定制答案。
* 支持各种主流的开源大模型，包括通义千问、Llama和Falcon等。

本方案内容以一个官方预置镜像为例，为您介绍如何快速部署通义千问模型并通过WebUI快速体验智能对话效果。您在实际部署时可以根据业务场景调整部署方案。

## 方案部署
### 部署准备


### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   * 本方案的云资源（包括PAI-EAS、NAS和函数计算等服务）支持按量付费，且默认设置均采用按量付费引导操作。使用按量付费资源需要确保账户余额不少于100元。
   * 完成本方案的部署及体验，根据您选择的资源规格和模型大小，将产生不同的费用。本方案以通义千问7B模型为例。（如调整了资源规格和模型，请以控制台显示的实际报价以及最终账单为准。）
     
     + 选择GU类型的资源规格ml.gu7i.c8m30.1-gu30（推荐，性价比高）：预计产生费用不超过8元/60分钟。
     + 选择A10类型的资源规格ecs.gn7i-c8g1.2xlarge：预计产生费用不超过15元/60分钟。
     + 选择V100类型的资源规格ecs.gn6e-c12g1.3xlarge：预计产生费用不超过22元/60分钟。
   * 按量付费包括了PAI-EAS服务运行所消耗的公共资源费用和NAS存储费用。关于PAI-EAS的相关计费逻辑与单价详情，请参见[模型在线服务（EAS）计费说明](https://help.aliyun.com/zh/pai/product-overview/billing-of-eas)。关于NAS的相关计费逻辑和单价详情，请参见[通用型NAS计费](https://help.aliyun.com/zh/nas/product-overview/billing-of-general-purpose-nas-file-systems)。函数计算上传文件属于入流量，不计费。更多关于函数计算计费的详情，请参见[计费概述](https://help.aliyun.com/zh/functioncompute/fc-2-0/product-overview/billing-overview#concept-2557114)。

#### 开通服务

【说明】在使用PAI进行AI开发部署通义千问和LangChain应用前，您需要先开通PAI。如果此前已开通过PAI，可跳过此步骤。

使用已准备好的阿里云账号登录[PAI控制台](https://pai.console.aliyun.com/)，单击**开通PAI并创建默认工作空间**，在弹出的开通页面中配置订单详情，配置要点如下，更多详细内容，请参见[开通并创建默认工作空间](https://help.aliyun.com/zh/pai/user-guide/activate-pai-and-create-the-default-workspace)。

* 本方案地域选择：**华东2（上海）**。
* **组合开通**：本方案不需要开通其他产品，您需要在组合开通配置模块，去勾选其他产品的复选框。
* **服务角色授权**：单击**去授权**，根据界面提示为PAI完成授权，然后返回开通页面，刷新页面，继续开通操作。
### 一键部署

资源编排（ROS）可以让您通过YAML或JSON文件清晰简洁地描述所需的云资源及其依赖关系，然后自动化地创建和配置这些资源。您可以通过下方提供的ROS一键部署链接，来自动化地完成这些资源的创建和配置：

* 创建1个工作空间。
* 创建1个专有网络VPC。
* 创建1台交换机。
* 创建1个安全组。
* 创建1个NAS文件系统。
* 使用开源公共模型（通义千问-7B）部署1个PAI-EAS服务。

1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/build-a-dialogue-model-based-on-Qwen-and-LangChain.yml&hideStepRow=true&hideStackConfig=true&pageTitle=通义千问和LangChain搭建对话服务&disableRollback=false&isSimplified=true&disabltion=true&productNavBar=disabled&disableNavigation=true)前往ROS控制台，系统自动打开使用新资源创建资源栈的面板，并在模板内容区域展示模板内容的详细信息。
2. 配置以下参数。
   
   * 确认已选择的地域。本方案选择**华东2（上海）**。
   * 选择可用区。
   * 选择**PAI-EAS实例规格**：推荐使用ml.gu7i.c8m30.1-gu30（性价比最高）。
     
     【说明】若ml.gu7i.c8m30.1-gu30规格不可选，请尝试更换至其他可用区或选择V100（ecs.gn6e-c12g1.3xlarge）、A10（ecs.gn7i-c8g1.2xlarge）类型的资源规格。
3. 参数配置完成后，点击**下一步**，单击**创建**。
   
   当**资源栈信息**页面的**状态**显示为**创建成功**时，表示一键配置完成。
### 部署自持微调模型


若您希望挂载自定义模型，请先删除已部署的通用千问-7B模型服务，然后重新部署一个经过微调的模型。具体操作步骤如下所示：

1. 进入模型在线服务页面。
   
   1. 登录[PAI控制台](https://pai.console.aliyun.com/)。
   2. 在左侧导航栏单击**工作空间列表**，在工作空间列表页面中单击待操作的工作空间名称，进入对应工作空间内。
   3. 在工作空间页面的左侧导航栏选择**模型部署**>**模型在线服务（EAS）**，进入**模型在线服务（EAS）**页面。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0076534171/p795953.png)
2. 单击目标服务**操作**列下的**删除**。
3. 准备自定义模型文件。本方案以开源的[通义千问-7B-Chat-Int8模型](https://zh-dev-data.oss-cn-hangzhou.aliyuncs.com/models/models--Qwen--Qwen-7B-Chat-Int8.tar.gz)为例。
   
   【说明】自定义模型文件中必须包含config.json文件，您需要按照[Huggingface](https://huggingface.co/meta-llama/Llama-2-70b-chat-hf/tree/main)的模型格式配置config文件。示例文件详情，请参见[config.json](https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20240229/zxorsu/config.json)。
4. 通过函数计算部署fc-nas-filemgr应用。
   
   1. 在函数计算控制台，搭建NAS浏览器应用，其中关键参数配置如下，其他参数配置详情，请参见[步骤二：创建并部署fc-nas-filemgr应用](https://help.aliyun.com/zh/functioncompute/fc-2-0/use-cases/use-function-compute-to-build-a-visualized-nas-application#8e0115cffauo1)。
      
      * **部署类型**：选择**直接部署**。
      * **地域**：选择华东2（上海）。
      * **NAS挂载点地址**：选择已创建的NAS挂载地址。
   2. 进入NAS根目录，具体操作请参见[步骤三：管理NAS文件系统](https://help.aliyun.com/zh/functioncompute/fc-2-0/use-cases/use-function-compute-to-build-a-visualized-nas-application#eebdbaeb4duug)。
5. 登录[函数计算控制台](https://fcnext.console.aliyun.com/)，通过NAS浏览器应用，上传已准备好的模型文件到`/Qwen-7B-Chat-Int8`目录。具体操作，请参见[步骤三：管理NAS文件系统](https://help.aliyun.com/zh/functioncompute/use-function-compute-to-build-a-visualized-nas-application-1)。您也可以通过NAT网关的形式，将本地模型文件上传到NAS文件系统，详情请参见[通过NAT网关实现本地数据中心访问阿里云NAS](https://help.aliyun.com/zh/nas/user-guide/access-a-nas-file-system-from-a-data-center-through-a-nat-gateway)。
6. 在**模型在线服务（EAS）**页面，单击**部署服务**，在**场景化模型部署**区域，单击**LLM大语言模型部署**。
7. 在**部署LLM大语言模型**页面，配置以下关键参数，其他参数取默认配置即可。
   
   | **参数** | | **描述** |
   | --- | --- | --- |
   | **基本信息** | **服务名称** | 自定义服务名称。本方案使用的示例值为：**llm\_qwen\_demo001**。  【说明】：服务名称在同一地域内唯一。 |
   | **模型来源** | 选择**自持微调模型**。 |
   | **模型类别** | 根据您的微调模型，分别选择模型类别、参数量和精度。本方案分别选择qwen1.5、7b、fp16。 |
   | **模型配置** | 选择**文件存储（NAS）**，并配置以下参数：  * **NAS挂载点**：选择已创建的NAS文件系统和挂载点。 * **NAS源路径**：配置为`/Qwen-7B-Chat-Int8`。 |
   | **资源配置** | **资源配置选择** | **实例规格**推荐使用**ml.gu7i.c8m30.1-gu30**（性价比最高）。  **【**说明**】**：如果当前地域的资源不足，您还可以选择V100（ecs.gn6e-c12g1.3xlarge）或A10（ecs.gn7i-c8g1.2xlarge）类型的资源规格。 |
   | **推理加速** | 选择**无加速**。 |
   | **专有网络配置** | **VPC** | 配置NAS挂载后，系统将自动匹配与NAS一致的VPC、交换机和安全组。如果自动匹配存在问题，请根据界面提示进行修改。 |
   | **交换机** |
   | **安全组名称** |
8. 单击**部署**，等待一段时间即可完成模型部署。
   
   当**服务状态**为**运行中**时，表明服务部署成功。
### 方案验证


**一、通过访问WebUI页面，验证模型推理服务**

1. 登录[PAI控制台](https://pai.console.aliyun.com/?spm=a2c4g.11186623.0.0.5e9a5be2xYXP7T)。
2. 在左侧导航栏单击**工作空间列表**，在工作空间列表页面中单击待操作的工作空间名称，进入对应工作空间内。
3. 在工作空间页面的左侧导航栏选择**模型部署**>**模型在线服务（EAS）**，进入**模型在线服务（EAS）**页面。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1742516371/p894551.png)
4. **模型在线服务（EAS）**页面中，单击上述步骤中已部署服务的**服务方式**列下的**查看Web应用**，进入**ChatLLM-WebUI**页面。
5. 在**ChatLLM-WebUI**页面，进行模型推理验证。在①位置输入请求数据，单击②位置的**Send**按钮，即可在③位置输出推理结果。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5761402171/p788599.png)

**二、通过使用LangChain集成业务数据，验证模型推理结果**

1. 在**ChatLLM-WebUI**页面上方的选项卡中选择**LangChain**，在页面左下角，按照界面操作指引上传自定义数据，支持配置.txt、.md、.docx、.pdf格式的文件。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5761402171/p788603.png)
2. 上传业务数据文件，单击左下角的**Vectorstore knowledge**按钮，返回如下结果表明 text2vec-base 模型下上传地自定义文件知识向量存储已完成。示例上传[README.md](https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20230707/vgve/README.md)文件。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5761402171/p788601.png)
3. 在**ChatLLM-LangChain-WebUI**页面底部的输入框中，输入与业务数据相关的问题进行对话即可。例如在输入框中输入`如何安装deepspeed`，单击**Send**，返回结果如图所示。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5761402171/p788606.png)上传的示例文件截图：![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1742516371/p894563.png)通过对比可看到得出的结果是对示例文件内容的提取归纳并进行了语言转译。

### 清理资源


* 如果需要继续使用EAS服务，请为您的阿里云账号充值，到期未续费的EAS服务会因欠费而被自动停止。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5103090171/p770734.png)
  
  1. 登录[PAI控制台](https://pai.console.aliyun.com/)。
  2. 在页面左上方，选择服务的地域。
  3. 在左侧导航栏单击**工作空间列表**，在工作空间列表页面中单击默认工作空间名称，进入对应工作空间内。
  4. 在工作空间页面的左侧导航栏选择**模型部署**>**模型在线服务（EAS）**，进入**模型在线服务（EAS）**页面。
  5. 在**推理服务**页签，单击目标服务**操作**列下的**停止**或**删除**，将模型服务停止或删除。
* 删除**安全组**。
  
  1. 登录[ECS控制台](https://ecs.console.aliyun.com/home)，在左侧导航栏，选择**网络与安全** > **安全组**。
  2. 在**安全组**列表页面，找到目标安全组，在**操作**列单击**删除**。并按照界面操作指引删除。
* 删除fc-nas-filemgr应用。
  
  1. 登录[函数计算控制台](https://fcnext.console.aliyun.com/)，在左侧导航栏，单击**应用**。
  2. 在应用列表中，找到目标应用。在**操作**列单击**删除应用**。并按照界面操作指引删除fc-nas-filemgr应用。
* 按照以下操作步骤释放资源栈下的资源，即1个工作空间、1个专有网络VPC、1个交换机、1个安全组、1个NAS文件系统和1个PAI-EAS服务。
  
  1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
  2. 在左侧导航栏，选择**资源栈**。
  3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
  4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
