## 方案概览

本方案介绍了使用模型在线服务 PAI-EAS 部署 [Stable-Diffusion-WebUI](https://github.com/AUTOMATIC1111/stable-diffusion-webui)，并在 WebUI 进行 AI 绘画的详细过程。完成本方案的部署及体验，预计产生费用不超过 15 元。（假设您选择最低规格 PAI-EAS 资源，且资源运行时间不超过 40 分钟。如调整了资源规格，请以控制台显示的实际报价以及最终账单为准）。

Stable Diffusion 是一种基于潜在扩散模型的文本到图像生成模型。它是一个免费开源的项目，能够通过文字描述生成对应的图片，具有时延低、生成效果好等诸多优点。Stable-Diffusion-WebUI 在其基础上进行封装，提供更加简洁易操作的 UI 。**本方案以模型在线服务 PAI-EAS 为基础，实现对Stable-Diffusion-WebUI（以下简称 SD WebUI）进行云端便捷部署，并使用其进行 AI 绘画。**

阿里云以保证与开源版本兼容为前提，针对云端形态和企业用户需求进行二次开发，并发布 PAI SD WebUI 解决方案。具体优势与功能如下：

* 使用便捷：快捷部署，开箱即用；可根据需求动态切换 GPU 等底层资源。
* 企业级功能：前后端分离改造，支持多用户对多 GPU 的集群调度；支持用户隔离；支持账单拆分。
* 插件及优化：支持 PAI-Blade 性能优化工具；提供 FileBrowser 插件，允许用户在桌面端上传和下载云端模型、图片；提供自研的 ModelZoo 插件，支持开源模型下载加速。

### 方案架构

在实际部署时，您可以按本方案提供的默认设置完成部署。部署完成后，运行架构如下：

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3732017071/p762308.png)

本方案的技术架构包括以下基础设施和云服务：

* 专有网络 VPC ：形成云上私有网络。
* 交换机：提供基本的网络分段和隔离功能。
* 公网 NAT 网关：用于将私网资源的请求转发到公网，实现私网资源对外提供服务的能力。
* 弹性公网IP：与 NAT 网关结合使用，帮助用户实现出口流量转发、入口地址转换和公网访问等功能，更灵活地管理和使用公网资源。
* 安全组：用于限制专有网络 VPC 下交换机的网络流入和流出。
* 存储系统：推荐使用文件存储 NAS 。大容量、高性价比、弹性扩展，适合通用类文件共享业务，用于存储使用 SD WebUI 生成的各类结果。
* 模型在线服务 PAI-EAS 实例：用于部署 SD WebUI 。

相对于一键部署，您还可以通过手动部署进行自定义部分设置，从而更好的满足您的实际需求，详情请参见[手动部署 Stable Diffusion WebUI 服务](https://help.aliyun.com/zh/pai/use-cases/manually-deploy-the-stable-diffusion-webui-service)。

## 方案部署
### 部署资源


资源编排 ROS 可以通过 YAML 或 JSON 文件描述所需的云资源及其依赖关系，然后自动化地创建和配置这些资源。您可以通过下方提供的 ROS 一键部署链接，自动化地完成以下资源的创建和配置：

* 创建 1 个 VPC
* 创建 1 个 交换机
* 创建 1 个安全组
* 创建 1 个弹性公网 IP
* 创建 1 个公网 NAT 网关
* 创建 1 个 NAS 文件系统
* 部署 1 个 PAI-EAS 服务

1. 单击[一键部署](https://ros.console.aliyun.com/ap-southeast-1/stacks/create?spm=a2c4g.2509703.0.0.30393abas2QwOs&templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/pai-ai-painting-solution.yml&hideStepRow=true&pageTitle=PAI%E9%83%A8%E7%BD%B2%E5%A4%9A%E5%BD%A2%E6%80%81%E7%9A%84Stable%20Diffusion%20WebUI%E6%9C%8D%E5%8A%A1&isSimplified=true&disableNavigation=true&productNavBar=disabled)，前往 **PAI 部署多形态的 Stable Diffusion WebUI 服务** ROS 一键部署页面。
2. 确认**地域**、**可用区 ID**、**失败时回滚**等参数后，单击**创建**，大约等待 10 分钟后即可完成模型部署。
   
   本解决方案的地域采用**新加坡**。**由于在新加坡地域开通弹性公网 IP 服务后，访问 Civitai 和Github 的网速高效稳定，您可以直接通过 WebUI 下载插件和 Civitai 模型，且 WebUI 的网页操作体验与国内的部署一致，因此推荐选择新加坡。**
3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
### 方案验证


完成以上操作后，您已经成功完成了 SD WebUI 集群版的部署。您可以启动 WebUI 页面，进行模型推理验证。

1. 进入**模型在线服务（EAS）**页面。
   
   1. 登录 [PAI 控制台](https://pai.console.aliyun.com/?regionId=ap-southeast-1#/workspace/overview)。
   2. 在顶部菜单栏，选择**新加坡**地域。
   3. 在左侧导航栏单击**工作空间列表**，在工作空间列表页面中单击任意一个工作空间名称，进入对应工作空间内。如果没有可用的工作空间，请[创建工作空间](https://help.aliyun.com/zh/pai/user-guide/create-a-workspace)。
   4. 在工作空间页面的左侧导航栏选择**模型部署** > **模型在线服务（EAS）**，进入**模型在线服务（EAS）**页面。
2. 在**模型在线服务（EAS）**页面中，单击上述步骤中已部署的模型服务**服务方式**列的**查看 Web 应用**。
   
   首次登录时，您需要在您的专属工作空间首页中等待约 5 分钟，然后单击**进入 Stable Diffusion WebUI** ，进入 WebUI 页面。
3. 在 SD WebUI 页面**文生图**页签中，输入正向提示词 Prompt ，例如`a monkey is eating a green banana`，然后单击**生成**，即可完成AI绘图，效果图如下：![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4732017071/p762417.png)
   
   后续，您可以通过 SD WebUI 完成文生图、图生图等任务，还可以使用 SD WebUI 进行后期处理、模型融合和训练等操作。另外，您还可以使用 FileBrowser 进行文件管理，FileBrowser 支持在桌面端上传和下载云端模型和图片。
### 资源清理


在本方案中，您部署了 1 个 PAI-EAS 服务，创建了 1 个专有网络 VPC 、1 个交换机、1 个公网 NAT 网关、1 个弹性公网 IP 、1 个安全组和 1 个文件存储 NAS 。测试完方案后，您可以参考以下规则处理对应产品的实例，避免继续产生费用：

1. 登录 [ROS 控制台](https://ros.console.aliyun.com/overview)。
2. 在左侧导航栏选择**资源栈**。
3. 在顶部选择部署的资源栈所在地域（本案例为新加坡），单击指定资源栈**操作**列的**删除**。
4. 在**删除资源栈**对话框中**删除方式**选择为**释放资源**，然后单击**确定**，根据提示完成资源释放。
