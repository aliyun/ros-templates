## 方案概览

多账号配置统一合规审计为企业的各中心管理团队提供一种面向多账号的合规管理方案，从上而下地实施统一的合规基线并强制管理资源，可中心化地持续检测所有业务的合规状态。提升中心管理团队工作的可见性和可控性，切实起到监管效力和规避潜在风险作用。

### 方案架构

企业采用多账号架构后，在配置审计中基于[资源目录](https://help.aliyun.com/zh/resource-management/resource-directory/product-overview/resource-directory-overview)的组织结构创建[账号组](https://help.aliyun.com/document_detail/211534.html)，圈定合规管理的账号范围，再对账号组创建合规规则，以实现跨账号的资源合规审计。多账号资源合规审计的架构如架构图所示。


本方案的优势如下：

* 持续的合规审计
  
  配置审计为您持续监控资源的配置变更，并在变更时自动触发合规评估，为您实现合规性的自主监管。
* 丰富的预置模板
  
  您可以根据自身要求启动相应的合规项，配置审计将对目标资源进行持续检测，并通过修正模板对不合规资源进行修正。
* 跨区域整合
  
  配置审计将您各地域的资源整合为一份完整清单，并通过资源列表和资源详情 API 快速的将云上资源配置集成到企业的 CMDB 中，实现企业对资源的统一管理。

## 方案部署
### 部署准备


开始部署前，请按以下指引完成账号申请、账号充值、资源目录开通等准备工作。

#### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成账号注册。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。如果确定任何一个云资源采用按量付费方式部署，账户余额都必须大于等于 100 元。
   
   **说明** 
   
   配置审计和资源管理均不收费，本方案涉及的对象存储 OSS 用于存储审计结果，会产生少量费用。
3. 完成企业实名认证。
   
   具体操作，请参见[企业实名认证](https://help.aliyun.com/zh/account/user-guide/enterprise-real-name-verification/)。
#### 开通资源目录并搭建企业的多账号资源结构

开通资源目录的账号即为资源目录的管理账号。

1. 在[资源管理控制台](https://resourcemanager.console.aliyun.com/)，开通资源目录。
   
   具体操作，请参见[开通资源目录](https://help.aliyun.com/zh/resource-management/resource-directory/user-guide/enable-a-resource-directory#task-2152699)。
2. 在[资源管理控制台](https://resourcemanager.console.aliyun.com/)，搭建企业的组织结构。您可以创建新的成员，也可以邀请已有的阿里云账号加入组织。
   
   管理账号在资源目录中至少准备 2 个成员。具体操作，请参见[创建资源夹](https://help.aliyun.com/zh/resource-management/resource-directory/user-guide/create-a-folder#task-hjk-vq1-dhb)、[创建成员](https://help.aliyun.com/zh/resource-management/resource-directory/user-guide/create-a-member#task-tzh-bs1-dhb)和[邀请阿里云账号加入资源目录](https://help.aliyun.com/zh/resource-management/resource-directory/user-guide/invite-an-alibaba-cloud-account-to-join-a-resource-directory#task-2039327)。
### 规划资源


**说明** 

如果您的账号中已有相关云资源（例如：ECS 实例、RDS 实例等），则无需执行本操作。

请参考表格中的说明和方案规划云资源。

| **规划项** | 数量 | **说明** |
| --- | --- | --- |
| 对象存储 OSS | 2 | 本方案需要为 2 个成员各创建一个存储空间，用于检测存储空间是否合规。创建存储空间时，默认**读写权限**为**私有**。 |

### 部署资源


规划好资源后，请按照以下步骤部署方案中的所有资源。

#### 一键部署

单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/multiple-accounts-support-configuration-auditing.yml&hideStepRow=true&pageTitle=%E4%BC%81%E4%B8%9A%E5%A4%9A%E8%B4%A6%E5%8F%B7%E9%85%8D%E7%BD%AE%E7%BB%9F%E4%B8%80%E5%90%88%E8%A7%84%E5%AE%A1%E8%AE%A1&disableRollback=false&isSimplified=true&dion=true&productNavBar=disabled)前往 ROS 控制台，在控制台资源栈页面配置模板参数，根据页面提示完成创建。

本模板为您完成了以下操作：

√开通配置审计

√新建账号组

√新建合规包（本方案通过等保三级预检合规包中的规则 **OSS 存储空间 ACL 禁止公共读**和 **OSS 存储空间 ACL 禁止公共读写**检测 2 个成员下资源（存储空间）的合规性）

您可以点击创建完成的资源栈，在资源中查看资源名称、类型和 ID。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5220940171/p779691.png)

#### 手动部署

1. **开通配置审计**
   管理账号在使用配置审计之前，必须先开通配置审计服务，才能获取跨地域的资源清单，并对资源进行合规审计。
   
   1. 登录[配置审计控制台](https://config.console.aliyun.com)。
   2. 单击**立即启用**。
      
      配置审计自动创建配置审计服务关联角色，该服务关联角色用于获取其他云服务的访问权限。更多信息，请参见[配置审计服务关联角色](https://help.aliyun.com/document_detail/162994.html)。
   
   **说明** 
   
   配置审计需要 2~10 分钟对您当前账号下的资源进行扫描，并构建资源列表，请耐心等待。

2. **新建账号组**
   企业为了实现定制化管理某个账号组内成员的资源及其合规性，需要创建一个账号组。本方案以创建自定义账号组为例。
   
   1. 登录[配置审计控制台](https://config.console.aliyun.com)。
   2. 在左侧导航栏，单击**账号组**。
   3. 在**账号组**页面，单击**新建账号组**。
   4. 在**新建账号组**页面，先设置账号组名称和描述，再单击**添加成员**。
   5. 在资源目录中选中目标成员，单击**确定**。
   6. 单击**提交**。
      
      在**账号组**列表中，目标账号组的状态为**创建完成**，说明新建账号组成功。
3. **查看资源清单**
   
   创建账号组成功后，企业的管理账号可以查看账号组中所有成员的跨地域聚合的资源清单。
   
   1. 在左上角选择目标账号组。
   2. 在左侧导航栏，选择**资源** > **全局资源**。
4. **新建合规包**
   
   企业的管理账号可以通过合规包模板（例如：等保三级预检合规包）为账号组新建合规包，检测该场景下所有资源的合规性。本方案通过合规包中的规则 **OSS 存储空间 ACL 禁止公共读**和 **OSS 存储空间 ACL 禁止公共读写**检测 2 个成员下资源（存储空间）的合规性。
   
   1. 在左侧导航栏，选择**合规审计** > **合规包**。
   2. 在**合规包**页面，单击**新建合规包**。
   3. 在**选择模板（可选）**页面，先单击**等保三级预检合规包**右上角的![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3016358861/p689766.png)图标，然后单击**下一步**。
   4. 在**设置基本属性**页面，先设置合规包名称，其他参数均保持默认值，然后单击**下一步**。
   5. 在**选择规则**页面，先从合规包模板中选择目标规则，然后单击**下一步**。
   6. 在**设置规则参数**页面，先为规则设置参数，然后单击**确定**。
### 完成及清理


#### 方案验证

**通过登录管理账号查看合规审计监控页面，验证统一合规审计功能**

1. 企业管理账号登录[配置审计控制台](https://config.console.aliyun.com/)。
2. 在左上角选择目标账号组。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6325409271/p859670.png)
3. 在左侧导航栏，选择**合规审计** > **合规包**。
4. 在**合规包**页面，单击目标合规包 ID。（查看合规包中规则对目标账号组中 2 个成员资源的评估结果，评估结果均为**合规**。）![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6325409271/p859673.png)![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6325409271/p859674.png)
   
   * 在**规则检测结果**页签，您可以从规则维度查看不合规资源数。
   * 在**资源检测结果**页签，您可以从资源维度查看不合规资源列表。
   * 在**成员检测结果**页签，您可以查看不合规成员。
#### 清理资源

在本方案中，您创建了 2 个存储空间。测试完方案后，请您及时删除资源，避免继续产生费用。

1. 登录[OSS管理控制台](https://oss.console.aliyun.com/)。
2. 单击 **Bucket 列表**。
3. 单击目标 Bucket 名称。
4. 在目标 Bucket 的左侧导航栏，单击**删除 Bucket**，然后按照界面指引完成删除操作。
