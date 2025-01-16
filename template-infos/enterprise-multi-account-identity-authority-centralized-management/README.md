## 方案概览

越来越多大型企业从安全管控、资源隔离和成本优化等角度考虑，选择在阿里云上采用多账号的资源结构。当账号数量增多时，为企业员工分配云上多账号的身份权限，配置管理的成本成倍增加。同时由于身份权限分散在多个账号内，无法集中审计，容易导致安全风险。因此企业非常需要能在一个地方统一管理身份权限。多账号身份权限集中管理的解决方案适用于以下场景：

* 大型集团企业云上身份权限管理：基于复杂的多云账号资源结构，统一进行身份权限管理。
* 大中型企业运维：运维团队需要反复切换登录各个账号配置资源和排查故障，通过多账号身份权限统一管理，可以在账号间轻松切换。

### 方案架构

方案提供的默认设置完成部署后在阿里云上搭建的网站运行环境如架构图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与架构图相似。


本方案的技术架构包括以下基础设施和云服务：

* 资源目录：多账号资源结构，将云账号组织起来，是身份管理的基础。
* 云 SSO 目录：用于创建和管理企业需要访问阿里云的员工身份，并进行授权管理。
* 云治理中心：可以进行资源目录、云 SSO 的快速搭建。
## 方案部署
### 部署准备



开始部署前，请按以下指引完成账号申请、账号充值、RAM 用户创建和授权。

#### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。
2. 企业实名认证。云账号需要进行企业实名认证，才可以开通资源目录。
3. 创建用于方案部署的 RAM 用户。
   
   1. 创建 1 个 RAM 用户。具体操作，请参见[创建 RAM 用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)。
   2. 为 RAM 用户授予以下云服务的访问权限以完成方案部署。具体操作，请参见[为 RAM 用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。
      
      | **云服务** | **需要的权限** | **描述** |
      | --- | --- | --- |
      | 资源目录 | AliyunResourceDirectoryFullAccess | 管理资源目录服务（ResourceDirectory）的权限 |
      | 云 SSO | AliyunCloudSSOFullAccess | 管理云 SSO（CloudSSO）的权限。 |
### 搭建资源目录


准备好账号之后，首先根据企业的资源规划，搭建好资源目录结构，将需要统一管理的云账号创建或邀请至资源目录对应的资源夹中。

#### 一键部署

1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/enterprise-multi-account-identity-permissions.yml&hideStepRow=true&pageTitle=企业多账号身份权限集中管理&disableRollback=false&isSimplified=true&disabtrue&productNavBar=disabled)前往 ROS 控制台，系统自动打开使用新资源创建资源栈的面板。
2. 在**配置模板参数**页面上填写 **Core 资源目录名称**、**Application 资源目录名称**、**Core 文件夹下的账号名称**。
3. 等待 1 分钟左右，即可在**资源**中找到创建的资源夹和成员账号。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6409040171/p779190.png)
#### 手动部署

1. 选择合适的账号作为管理账号，开通资源目录。具体操作，请参见[开通资源目录](https://help.aliyun.com/zh/resource-management/resource-directory/user-guide/enable-a-resource-directory)。
2. 创建名为 Core 和 Application 的两个资源夹。具体操作，请参见[创建资源夹](https://help.aliyun.com/zh/resource-management/resource-directory/user-guide/create-a-folder)。
3. 邀请企业云账号或邀请已有云账号加入资源目录。具体操作，请参见[邀请阿里云账号加入资源目录](https://help.aliyun.com/zh/resource-management/resource-directory/user-guide/invite-an-alibaba-cloud-account-to-join-a-resource-directory)。
   
   本示例中，需要在 Core 文件夹下，创建成员账号（Sandbox Account）。
### 多账号身份权限管理


规划资源结构后，根据以下步骤为需要访问阿里云的员工创建身份。

#### 开通云 SSO

为了实现多账号身份权限的集中管理，需要开通云 SSO 产品，为所有需要访问阿里云的员工身份配置身份目录。

1. 登录[云 SSO 控制台](https://cloudsso.console.aliyun.com)。
2. 单击**立即开通**。
#### 创建云 SSO 身份目录

开通之后需要选择合适的地域创建目录，用于存放所有用户身份和授权信息。

1. 登录[云 SSO 控制台](https://cloudsso.console.aliyun.com)。
2. 在顶部菜单栏左上角，选择地域。
3. 单击**创建目录**。
4. 在**创建目录**面板，输入目录名称，然后单击**确定**。
#### 创建用户

接下来为需要访问阿里云资源的员工创建云 SSO 用户身份，可以选择手动创建或通过配置 SCIM 同步，将企业身份系统中的用户同步创建到云 SSO。

手动创建用户

1. 登录[云 SSO 控制台](https://cloudsso.console.aliyun.com)。
2. 在左侧导航栏，选择**人员管理** > **用户**。
3. 在**用户**页面，单击**创建用户**。
4. 在**创建用户**面板，输入**用户名**。
   
   本示例中，选择用户（user1）。
5. **可选：**输入**姓名**、**显示名称**和**Email**。
6. 设置密码。
   
   * 手动设置密码：单击**手动设置**，然后输入自定义的用户密码。
   * 自动设置密码：单击**自动设置**，系统会自动生成密码，您需要及时保存。
   * 设置用户在下一次登录时是否重置密码：选择**要求用户下次登录时重置密码**，用户在下一次登录时需要重置密码。否则，则不需要。
7. 设置用户的状态。
8. **可选：**输入**描述**信息。
9. 单击**确定**。

配置 SCIM 同步

1. 登录[云 SSO 控制台](https://cloudsso.console.aliyun.com)。
2. 在左侧导航栏，单击**设置**。
3. 在**用户同步配置**区域，单击**生成密钥**。
4. 在 **SCIM 密钥生成成功**对话框，复制 SCIM 密钥，然后单击**关闭**。
5. 前往企业 IdP 配置与阿里云的 SCIM 同步，配置完成之后回到[云 SSO 控制台](https://cloudsso.console.aliyun.com)。
6. 在**用户同步配置**区域，打开 SCIM 同步开关，启用 SCIM 同步。
#### 配置单点登录

您可以将企业身份系统与云 SSO 集成，实现单点登录。即用户登录时通过企业身份系统进行登录认证，直接跳转登录到阿里云控制台。

1. 登录[云 SSO 控制台](https://cloudsso.console.aliyun.com)。
2. 在左侧导航栏，单击**设置**。
3. 在 **SSO 登录**区域，单击**配置身份提供商信息**。
4. 在**配置身份提供商信息**对话框，选择**上传元数据文档**或**手动配置**，然后配置身份提供商信息。
   
   以下两种方式您可以任选其一进行配置，相关元数据文件或配置信息请从身份提供商处获取。
   
   * 上传元数据文档
     
     单击**上传文件**，上传身份提供商元数据文件。
   * 手动配置
     
     + **Entity ID**：身份提供商标识。
     + **登录地址**：身份提供商登录地址。
     + **证书**：身份提供商用于 SAML 响应签名的证书，支持 PEM 格式的 X509 证书。您可以单击**上传证书**，上传身份提供商的证书。
5. 单击**确定**。
#### 创建访问配置

访问配置可以理解为是一种权限模板，同时代表用户最终访问云账号时所扮演的角色（授予对应权限）。首先创建一系列代表典型用户身份权限的访问配置，当授权时可以为同样职责的员工授予相同的访问配置。

1. 登录[云 SSO 控制台](https://cloudsso.console.aliyun.com)。
2. 在左侧导航栏，单击**访问配置管理**。
3. 在**创建访问配置**面板，配置以下基本信息，然后单击**确定**。
4. 配置系统策略。
   
   * 使用系统策略
     
     1. 选择**使用系统策略**。
     2. 选择对应的系统策略。
        
        **说明** 
        
        每次最多选择 5 个系统策略。每个访问配置最多可以配置 20 个系统策略。
     3. 单击**绑定并继续**。
     4. 单击**下一步**。
   * 不使用系统策略
     
     1. 选择**不使用系统策略**。
     2. 单击**继续**。
5. 配置内置策略。
   
   * 使用内置策略
     
     1. 选择**使用内置策略**。
     2. 编辑策略内容。
        
        内置策略复用 RAM 的权限策略语法。关于策略语法的更多信息，请参见[权限策略语法和结构](https://help.aliyun.com/zh/ram/user-guide/policy-structure-and-syntax#concept-srq-fbk-xdb)。
     3. 单击**确定**。
   * 不使用内置策略
     
     1. 选择**不使用内置策略**。
     2. 单击**确定**。
6. 常用访问配置：
   
   
   | **访问配置** | **权限说明** |
   | --- | --- |
   | Administrator | 具有账号内全局权限，即管理所有阿里云资源的权限。 |
   | Iam | 具有访问控制管理员权限，负责企业员工在阿里云的身份权限管理。 |
   | Billing | 具有查询和管理账单、账户资金管理、发票合同管理等全部财务管理权限。 |
   | AuditAdministrator | 具有配置审计、操作审计和日志管理的全部权限，同时有权查看所有阿里云资源现状。 |
   | LogAdministrator | 具有日志的管理权限。 |
   | LogAudit | 具有日志的查看权限。 |
   | NetworkAdministrator | 具有网络相关服务的所有权限，并有安全组的权限。 |
   | SecurityAudit | 具有安全产品的查询安全数据的权限，但不可管理安全产品的配置。 |
   | SecurityAdministrator | 具有所有安全产品的管理权限。 |
#### 多账号授权

接下来您可以为用户授予所需要的访问权限，通过将访问的云账号、访问的用户或用户组身份和访问配置进行三元组的关联，实现为用户分配各云账号下的资源访问权限。

1. 登录[云 SSO 控制台](https://cloudsso.console.aliyun.com)。
2. 在左侧导航栏，单击**多账号权限配置**。
3. 在**多账号权限配置**页面，选择目标 RD 账号。
   
   本示例中，选择成员账号（Sandbox Account）。
4. 单击**配置权限**。
5. 在**配置权限**页面，选择目标用户或用户组，然后单击**下一步**。
   
   本示例中，选择用户（user1）。
6. 选择目标访问配置，然后单击**下一步**。
7. 浏览配置信息，然后单击**开始配置**。
8. 等待配置完成，然后单击**完成**。
#### 创建 RAM 用户同步

针对不适宜使用 RAM 角色身份访问，提供 RAM 用户同步模式，为云 SSO 用户同步创建成员账号内的 RAM 用户，最终以 RAM 用户身份登录账号访问资源。

1. 登录[云 SSO 控制台](https://cloudsso.console.aliyun.com)。
2. 在左侧导航栏，单击**多账号权限配置**。
3. 在**多账号权限配置**页面，选择目标 RD 账号。
   
   本示例中，选择成员账号（Sandbox Account）。
4. 单击**配置 RAM 用户同步**。
5. 在**配置 RAM 用户同步**面板，选择目标用户或用户组，然后单击**下一步**。
   
   本示例中，选择云 SSO 用户（user1）。
6. 设置以下基本信息，然后单击**下一步**。
   
   1. 输入 RAM 用户同步的描述。
   2. 配置**处理模式**。
   3. 配置**冲突策略**和**删除策略**。
      
      | **项目** | **说明** | **示例值** |
      | --- | --- | --- |
      | 描述 | 备注同步用户的用途等 | 纯文本 |
      | 处理模式 | 逐条处理：针对每一个同步用户设置规则。  批量处理：对所有同步用户统一设置规则。 | 批量处理 |
      | 冲突策略 | 当云账号内已有同名用户时，如何处理。  替换：替换原用户  两者都保留：保留两个用户，新建用户名增加\_cloudsso。 | 替换 |
      | 删除规则 | 当删除 RAM 用户同步任务时，对已同步创建的 RAM 用户如何处理。  删除：删除已同步 RAM 用户。  保留：保留已同步 RAM 用户。 | 保留 |
7. 单击**提交**。
8. 单击**关闭**。
   
   配置成功后，会在目标 RD 账号内创建一个同名的 RAM 用户。本示例中，将会在 RD 成员（Sandbox Account）中同步创建一个与云 SSO 用户（user1）同名的 RAM 用户（user1@xxx.onaliyun.com）。
### 完成及清理

30

#### 方案验证

完成了身份权限配置后，您可以使用云 SSO 用户登录云账号访问资源，来验证配置是否成功。

#### 步骤一：获取云 SSO 登录地址

1. 云 SSO 管理员登录[云 SSO 控制台](https://cloudsso.console.aliyun.com)。
2. 在左侧导航栏，单击**概览**。
3. 在**概览**页面的右侧，查看或复制**用户登录 URL**。

**步骤二：登录云 SSO 用户门户**

1. 云 SSO 用户访问从**步骤一**获取的**用户登录 URL**。
2. 根据已配置的登录方式，登录云 SSO 用户门户。
   
   * SSO 登录：
     
     1. 单击**跳转**，系统会自动跳转到企业 IdP 的登录页面。
     2. 使用企业 IdP 的用户名和密码登录。
   * 用户名密码登录
     
     1. 输入云 SSO 用户名和密码，然后单击**登录**。
     2. （可选）如果启用了 MFA，需要完成 MFA 验证。
        
        + 如果是首次登录用户门户，则需要添加 MFA 设备。具体操作，请参见[添加第一个 MFA 设备](https://help.aliyun.com/zh/cloudsso/user-guide/bind-or-unbind-mfa-devices#section-8hh-7vf-7go)。
        + 如果 MFA 设备已经绑定，请直接输入从移动设备端获取的验证码，然后单击**验证**。
#### 步骤三：访问 RD 账号资源

对于支持 RAM 角色的云服务，且在云 SSO 中通过访问配置设置了访问权限，就可以通过 RAM 角色访问 RD 账号资源。该方式适用大部分的云服务。

**以 RAM 角色身份登录**

1. 在**以 RAM 角色登录**页签，单击目标 RD 账号**权限**列的**显示详情**。
   
   本示例中，选择成员账号（Sandbox Account）。
2. 单击目标权限**操作**列的**登录**。
3. 以 RAM 角色身份访问 RD 账号资源。
   
   您可以将鼠标悬浮在控制台右上角的头像图标上，查看当前登录用户的身份。

**以 RAM 用户身份登录**

1. 在**以 RAM 用户登录**页签，单击目标 RD 账号**操作**列的**登录**。
2. 以 RAM 用户身份访问 RD 账号资源。
   
   您可以将鼠标悬浮在控制台右上角的头像图标上，查看当前登录用户的身份。
#### 清理资源

在本方案中，您创建了资源目录和云 SSO 身份目录，均为免费产品，并且对您原账号内配置的 RAM 身份权限不产生任何影响和冲突。如果您确定不希望保留测试环境，可以执行以下删除步骤。

**前提条件**

1. 移除所有用户和用户组在 RD 账号上的授权。具体操作，请参见[移除 RD 账号的授权](https://help.aliyun.com/zh/cloudsso/user-guide/remove-the-existing-access-permissions-on-an-account-in-a-resource-directory#task-2092358)。
2. 删除用户：具体操作，请参见[删除用户](https://help.aliyun.com/zh/cloudsso/user-guide/perform-basic-operations#section-ql8-xit-c4i)。
3. 删除用户组：具体操作，请参见[删除用户组](https://help.aliyun.com/zh/cloudsso/user-guide/perform-basic-operations-1#section-1eu-jig-ove)。
4. 删除访问配置：具体操作，请参见[删除访问配置](https://help.aliyun.com/zh/cloudsso/user-guide/delete-an-access-configuration#task-2091284)。
5. 删除 SCIM 密钥：具体操作，请参见[删除 SCIM 密钥](https://help.aliyun.com/zh/cloudsso/user-guide/manage-scim-credentials#section-7ch-dhx-tku)。
6. 删除单点登录配置：具体操作，请参见[清空身份提供商（IdP）信息](https://help.aliyun.com/zh/cloudsso/user-guide/configure-sso#section-31l-ts6-emf)。

**删除目录**

1. 登录[云 SSO 控制台](https://cloudsso.console.aliyun.com)。
2. 在左侧导航栏，单击**设置**。
3. 在**全局管理**区域，单击**删除目录**。
4. 在**删除目录**对话框，按照界面提示输入对应信息后，单击**确定**。
