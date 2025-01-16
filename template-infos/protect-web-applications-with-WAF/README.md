## 方案概览

随着网络技术的不断发展，您的 Web 应用如果没有流量入口的防护，会面临如下风险：

* 网页被恶意篡改，导致信息不准确。
* 站点响应突然变慢或突然遇到海量的访问请求，影响正常用户访问。
* 账户、手机号等敏感数据泄漏或数据库数据被篡改，导致业务受影响。
* 面对新型的安全漏洞，修改代码做修复需要花时间，有阶段性的安全隐患。
* 为了满足各行业安全合规要求，需要花大量的开发成本来达到网站的安全防护水位。

如何高效灵活地避免以上问题，防护您的 Web 应用，我们推荐您使用[阿里云 Web 应用防火墙](https://www.aliyun.com/product/waf)（Web Application Firewall，简称 WAF）。WAF 通过对网站或者 App 的业务流量进行恶意特征识别及防护，在对流量进行清洗和过滤后，将正常、安全的流量返回给服务器，避免网站服务器被恶意入侵导致性能异常等问题，从而保障网站的业务安全和数据安全。

## 方案架构

WAF 支持为 ECS 实例开启安全防护。将 ECS 实例接入 WAF 后，实例所有的 Web 业务流量将被指定网关牵引到 WAF 进行检测。WAF 过滤 Web 应用攻击后，将正常的业务流量转发回 ECS 服务器。具体网络架构如架构图所示。


本方案的技术架构包括以下基础设施和云服务：

* 云服务器 ECS：部署了 Web 应用。
* WAF 3.0 按量付费版：用于防护 Web 应用。

## 方案部署
### 部署准备

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册并完成个人实名认证。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。为节省成本，本方案默认选择使用按量付费，使用按量付费资源需要确保账户余额不小于 100 元。选用最低规格的按量计费 ECS 实例，并在体验结束后释放资源，产生的费用不超过 5 元。实际费用以控制台账单为准。
### 一键部署


一键部署基于阿里云资源编排服务 ROS（Resource Orchestration Service）实现，ROS 模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。

您可以通过下方提供的 ROS 一键部署链接，来自动化地完成这些资源的创建和配置：

* 创建 ECS 实例
* 安装一个 Web 网站
* 开通 WAF 3.0 按量付费版。

#### 操作步骤

1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/protect-web-applications-with-WAF.yml&hideStepRow=true&hideStackConfig=true&pageTitle=高效防护 Web 应用&disableRollback=false&isSimplified=true&disaigation=true&productNavBar=disabled)，并选择地域。
2. 在配置页面选择可用区、ECS 规格、设置密码，确认好价格后单击下一步。
3. 在**价格预览**确认价格后，单击**创建**。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8535523171/p792027.png)
   
   本方案中，ECS 和 WAF 都是按量计费，其中，WAF 按量付费实例会根据每个完整小时内处理的业务请求量及您已启用的防护功能，计算该小时的**流量处理费**和**功能费**，生成分时账单，并在每个结算周期生成每日账单。实际产生费用以账单为准。
4. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
### 将 ECS 实例接入 WAF

**重要** 

* 实例接入WAF时，Web业务可能会出现秒级闪断。在客户端可自动重连的情况下该闪断会自动恢复，不会对您的业务造成影响，请您关注业务并根据业务系统评估准备重连或回源等相关容灾机制。
* **ECS**实例接入WAF后，如果进行如下操作，引流端口会自动取消接入。您需要重新添加端口，否则，业务流量将不会经过WAF防护。
  
  + 更换实例上绑定的公网IP
  + ECS创建迁移任务，变更可用区
  + 实例被释放
* **ECS**引流是对EIP或公网IP进行的引流。
* **ECS**解绑EIP后引流会被自动删除。
#### 操作步骤

1. [登录 Web 应用防火墙 3.0 控制台。](https://yundunnext.console.aliyun.com/?p=wafnew)
2. 在左侧导航栏，单击**接入管理**。
3. 选择**云产品接入**页签，在左侧云产品类型列表，选择 **ECS**。
4. 根据页面提示，单击**立即授权**，完成云产品授权（如果您已经完成云产品授权，则该页面不会出现，您可以直接执行后续步骤）。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6094701171/p782034.png)
5. 单击**同步最新资产**，等待约 60s 后，选择通过一键部署创建的实例，单击**添加端口****。**
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8535523171/p792054.png)
6. 在**添加端口**弹窗，填入端口号 **80**。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6094701171/p782069.png)
7. 完成接入后，WAF 会自动生成一个命名为“实例 id-端口-资产类型”的防护对象，并为该防护对象**默认开启基础防护规则**。您可以在**防护对象**页面，查看自动添加的防护对象。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6094701171/p782089.png)
   
   如果您希望继续使用 WAF 3.0 的更多防护功能，请参见[图说防护配置](https://help.aliyun.com/zh/waf/web-application-firewall-3-0/user-guide/protection-configuration)。
### 验证及清理


**方案验证**

**一、通过恶意 SQL 注入代码，验证 SQL 注入防护**

1. 登录 [ROS 控制台](https://ros.console.aliyun.com/overview)，在左侧导航栏，选择**资源栈**，找到本方案创建的资源栈。
2. 在资源栈详情页，单击**输出**页签，单击网站地址 url 打开部署的网站。此刻能正常访问。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7010623171/p792079.png)
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7010623171/p792080.png)
3. 在 IP 后输入 SQL 恶意攻击代码验证防护效果，例如`http://127.xxx.xxx?id=1 and 1=1`，返回如下 405 拦截提示页面，则表示攻击被拦截。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7010623171/p792085.png)

**二、查看 WAF 控制台安全报表，验证防护效果**

1. 打开 [Web 应用防火墙 3.0 控制台。](https://yundunnext.console.aliyun.com/?spm=a2c4g.2714251.0.0.60ca3f496wxuhI&p=wafnew)点击左侧导航栏**安全报表，**可以查看攻击类型分布、攻击来源、防护详情等数据。
![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6014798271/p858809.png)

2. 可以看到之前 SQL 注入攻击触发的拦截，基于这些详细的数据和图表展示，可以及时发现和处理潜在的安全威胁，并且制定有效的安全策略。
#### 清理资源

在本方案中，您创建了 1 个 ECS 实例、1 个 WAF 实例。体验完方案后，您可以参考以下规则处理对应产品的资源，避免继续产生费用。

1. 登录 [ROS 控制台](https://ros.console.aliyun.com/overview)，在左侧导航栏，选择**资源栈**。
2. 找到本方案部署的资源栈，然后在其右侧**操作**列，单击**删除**。
3. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
