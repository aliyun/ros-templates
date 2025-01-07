

**方案部署**
--------

50

https://www.aliyun.com/solution/tech-solution/ecosacna

### **方案概览**

当企业有新业务上线，一般会考虑部署在新的账号内。如果通过控制台注册新账号并完成账号内的安全合规基线配置往往周期较长且容易出错。利用账号工厂解决方案能够高效构建安全合规的新账号，在本方案中会介绍如何利用开源的 IaC 工具（Terraform）来快速创建安全合规的新账号。通过此方案可以统一企业内不同账号内的基线，灵活适配不同企业对账号初始化的个性需求。

#### **方案架构**

方案提供的默认设置完成部署后在阿里云上搭建的网站运行环境如下图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与下图相似。

![高效构建安全合规的新账号.jpg](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7955025961/p722289.jpg)

本方案的技术架构包括以下基础设施和云服务：

* 资源管理：利用资源管理中的资源目录可以快速创建一个企业实名认证的资源账号。
* 访问控制：给 RAM 用户分配 AssumeRole 及资源目录权限，可以利用这个 RAM 用户扮演到新账号内一个临时身份角色，利用这个临时身份完成新账号内基线配置。
* 专有网络：在账号内创建专有网络，为后续部署应用准备网络环境。
### **部署准备**

10

开始部署前，请按以下指引完成账号申请、账号实名认证、RAM 用户创建和授权。

#### **准备账号**

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. 为阿里云账号完成[企业实名认证](https://help.aliyun.com/zh/account/user-guide/enterprise-real-name-verification/)。只有通过企业实名认证的阿里云账号才能开通资源目录。
3. 创建用于方案部署的 RAM 用户。
   
   1. 创建 1 个 RAM 用户。具体操作，请参见[创建 RAM 用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)。
   2. 为 RAM 用户授予以下云服务的访问权限以完成方案部署。具体操作，请参见[为 RAM 用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。
   3. | 云服务 | 需要的权限 | 描述 |
      | --- | --- | --- |
      | 资源目录 RD | AliyunResourceDirectoryFullAccess | 管理资源目录 RD 的权限 |
      | 访问控制 RAM | AliyunSTSAssumeRoleAccess | 调用 STS 服务 AssumeRole 接口权限 |

#### 准备环境

为了能够高效创建出新的云账号，需要先开通资源目录

1. 登录[资源管理控制台](https://resourcemanager.console.aliyun.com/)。
2. 在左侧导航栏，选择**资源目录** > **概览**。
3. 单击**开通资源目录**。
4. 选择**使用当前账号开通**。
5. 单击**开通**。
6. 在**安全校验**对话框中，通过手机号码或电子邮箱完成安全验证，然后单击**确定**

创建两个资源文件夹（Core 和 Application）。

1. 登录[资源管理控制台](https://resourcemanager.console.aliyun.com/)。
2. 在左侧导航栏，选择**资源目录>概览**。
3. 单击**资源组织**页签。
4. 在左侧的 **Root** 资源夹下，选择目标资源夹，然后在右侧的页面中单击**创建资源夹**。
   
   您将会在目标资源夹下创建一个子资源夹。
5. 在**创建资源夹**面板，填写**资源夹名称**。
6. 单击**确定**。
### **一键部署**

30

一键部署基于阿里云资源编排服务 ROS（Resource Orchestration Service）实现，ROS 托管 Terraform 模板，已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。ROS 模板完成的内容包括：

* 在资源目录下创建新实名认证账号
  
  **说明** 
  
  只有通过企业实名认证的阿里云账号才能开通资源目录。
* 给新创建的账号配置安全合规基线

**操作步骤**
--------

1. 打开[一键配置模板链接](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/documents/solution/efficiently-build-a-new-account-with-security-and-compliance.yml&isSimplified=true)前往 ROS 控制台，系统自动打开使用新账号创建资源栈的面板，并在**模板内容**区域展示 YAML 文件的详细信息。
   
   **说明** 
   
   ROS 控制台默认处于您上一次访问控制台时的地域，请根据您创建的资源所在地域修改地域后再执行下一步。
2. 确认好地域后，选择新账号需要创建到的资源目录资源夹，点击创建。
3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3986359761/p606086.png)

### **完成及清理**

10

#### **方案验证**

**通过资源目录控制台登入新账号查看创建****配置****，验证新账号的安全合规性**

1. 登录[资源管理控制台](https://resourcemanager.console.aliyun.com/)。
2. 在左侧导航栏，选择**资源目录** > **概览**。
3. 单击**资源组织**或**成员列表**页签。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2852609271/p859860.png)
4. 在成员列表中，单击目标成员**操作**列的**登入账号**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2852609271/p859865.png)

登录之后，管理账号内的 RAM 用户将扮演新账号内的 RAM 角色，可以查看账号内配置的相关合规基线。在本演示方案中涉及到的基线包括：

* RAM 账号，可以登录[访问控制-身份管理](https://ram.console.aliyun.com/users)，查看账号工厂新创建出来的 RAM 用户。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2852609271/p859882.png)
* SSO 配置，可以登录[访问控制-集成管理](https://ram.console.aliyun.com/providers)，查看账号工厂新创建出来的 SSO 配置。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2852609271/p859884.png)
* VPC 配置，可以登录[专有网络](https://vpc.console.aliyun.com/)，查看账号工厂新创建出来的 VPC 资源。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2852609271/p859872.png)
#### 清理资源

在本方案中，您创建了资源文件夹、1 个 RAM 账号、ROS 模版里创建的 VPC、ROS 模版里创建的 vSwitch。测试完方案后，您可以参考以下规则处理对应账号和资源

1. 登录 [资源编排管理控制台](https://ros.console.aliyun.com/cn-beijing/stacks)。
   
   1. 在左侧导航栏选择**资源栈**。
   2. 找到目标资源栈，单击**操作**列的**删除**。
2. 登录 [资源目录控制台](https://resourcemanager.console.aliyun.com/resource-directory/folders/r-creKjI)。
   
   1. 单击**资源组织**或**成员列表**页签。
   2. 在成员列表中，找到资源账号类型的成员，单击**操作**列的**删除**。
   3. 在**删除成员**对话框，仔细阅读删除须知，然后输入成员的账号名称，最后单击**下一步**。
   4. 等待删除检查结果出来后，依据检查结果，进行后续操作。

* 检查通过
  
  + 直接删除：如果成员最近 30 天内不存在后付费资源，则单击**确认删除**，系统开始删除成员。
  + 静默期删除：如果成员最近 30 天内存在后付费资源，则单击**继续删除**，成员进入[管理成员的常见问题](https://help.aliyun.com/zh/resource-management/resource-directory/support/faq-about-managing-a-member-1)。等待静默期结束后，系统会自动开始删除该成员。关于静默期到期时间，请参见[管理成员的常见问题](https://help.aliyun.com/zh/resource-management/resource-directory/support/faq-about-managing-a-member-1)。
* 检查失败
  
  根据页面提示，手动处理不符合项，然后再重新删除成员。
