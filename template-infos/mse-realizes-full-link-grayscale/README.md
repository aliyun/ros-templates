## **方案概览**

微服务场景下，随着业务不断迭代，新功能上线时通常会涉及到多个应用需要同时发布新版本。在新版本正式上线之前，往往需要同时对多个应用进行灰度验证，确认无误后再将应用正式上线。MSE微服务治理提供全链路灰度能力，让您在不修改业务代码的情况下实现全链路流量控制，端到端构建从网关到多个后端服务的全链路灰度。

本技术解决方案以基于MSE实现ACK应用的全链路灰度为例，为您演示：

* 如何创建ACK集群并创建应用。
* 如何搭建业务应用的基线环境，包括部署后端业务应用的基线版本，将后端业务应用接入MSE微服务治理并通过MSE云原生网关暴露应用A。完成后，测试基线版本流量是否正常。
* 如何搭建业务应用的灰度环境，包括后端业务应用的灰度版本并创建灰度环境泳道。完成后，测试灰度版本的流量路由链路是否正常。

### **方案架构**

方案提供的默认设置（如地域、VPC、ACK集群、MSE网关实例、MSE Nacos等）完成部署后在阿里云上搭建的网站运行环境如下图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与下图相似。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1827572961/p709625.png)

本方案的技术架构包括以下基础设施和云服务：

* 1个地域：ACK集群、微服务应用、MSE实例均部署在同一地域下。
* 1个专有网络VPC：形成云上私有网络，确保核心云资源的网络环境，如容器服务ACK、微服务引擎MSE。
* ACK集群：简单、低成本、高可用的Kubernetes集群，支持应用管理，无需您管理控制面板。
* MSE云原生网关：提供可靠高效的符合K8s Ingress标准的下一代Gateway，将Ingress流量网关和微服务网关二合一。
* MSE微服务治理：无侵入增强主流Spring Cloud、Apache Dubbo等开源微服务框架，提供丰富的服务治理和流量防护功能，将中间件与业务解耦。
* MSE注册配置中心：全托管的注册配置中心，兼容[Nacos](https://help.aliyun.com/zh/mse/product-overview/edition-features)、[ZooKeeper](https://help.aliyun.com/zh/mse/product-overview/features-of-zookeeper-editions)、[Eureka](https://help.aliyun.com/zh/mse/support/)，具备丰富完善的监控报警、控制台运维操作和引擎类型。您可以根据原有业务依赖进行选择，本方案将以MSE Nacos为例演示。

## **方案部署**
### **部署准备**


开始部署前，请按以下指引完成账号申请、账号充值、RAM用户创建和授权。

#### **准备账号**

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   * 本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。请确保您的账户余额大于等于100元。
   * 完成本方案的部署及体验，预计产生费用约为13元（假设您配置ACK集群和MSE实例时选择本文指导的规格资源，且资源运行时间不超过1个小时。实际情况可能会因您操作过程中使用的资源规格和流量差异，导致费用有所变化，请以控制台显示的实际报价以及最终账单为准）。
     
     | **产品** | **费用来源** | **规格** | **预估费用参考** |
     | --- | --- | --- | --- |
     | 容器服务 Kubernetes 版 | CLB Ingress费用 | 标准型I（slb.s2.small） | 实例费用：0.34/小时  流量费用：0.8/GB |
     | CLB API Server费用 | 标准型I（slb.s2.small） | 0.320元/时 |
     | NAT费用 | 公网NAT网关 | + 实例费：0.195元/时 + 容量单位CU费：0.195元/CU |
     | EIP费用 | 不涉及 | + EIP配置费：0.02元/小时 + 流量费用：0.8元/GB |
     | ECS费用 | 3个通用型g6 4vCPU 16GiB的实例；系统盘为云盘ESSD，40GiB，PL0。 | 3.126元/小时 |
     | 集群管理费用 | 不涉及 | 0.64元/小时 |
     | 微服务引擎 MSE | MSE微服务治理 | 专业版 | 约为3元/时 |
     | MSE注册配置中心 | 专业版，2核4G | 2.31/时 |
     | MSE云原生网关 | 2核4G | 1.68元/时 |
     | 按量费用：11.631元/时待确认  CU容量费用产品：1个  流量费用产品：2个 | | | |
3. 阿里云账号拥有操作资源的最高权限，从云资源安全角度考虑，建议您创建RAM用户。RAM用户需要获得相关云服务的访问权限才能完成方案部署，详情如下：
   
   1. 访问[RAM控制台-用户页面](https://ram.console.aliyun.com/users)，单击**创建用户**，填写相关信息，勾选**控制台访问**和**OpenAPI 调用访问**，自定义密码并选择无需重置密码，创建一个RAM用户。
   2. 在RAM用户列表的操作列，单击目标RAM用户对应的**添加权限**。在**添加权限**面板，在**选择权限**策略的**系统策略**区域，搜索并新增如下权限，然后单击**确定**。
      
      涉及的云服务：资源编排 ROS、容器服务 Kubernetes 版、微服务引擎 MSE、专有网络 VPC、云服务器 ECS、访问控制RAM、费用中心 BSS。
      
      每次支持最多绑定5条策略，请分2次操作添加如下权限。
      
      | **云服务** | **需要的权限** | **描述** |
      | --- | --- | --- |
      | 资源编排 ROS | AliyunROSFullAccess | 管理资源编排服务 ROS的权限。 |
      | 容器服务 ACK | AliyunCSFullAccess | 管理容器服务 ACK的权限。 |
      | 微服务引擎 MSE | AliyunMSEFullAccess | 管理微服务引擎 MSE的权限。 |
      | 专有网络 VPC | AliyunVPCFullAccess | 管理专有网络 VPC的权限。 |
      | 云服务器 ECS | AliyunECSFullAccess | 管理云服务器服务 ECS的权限。 |
      | 访问控制 RAM | AliyunRAMFullAccess | 管理访问控制 RAM的权限，即管理用户以及授权的权限 |
      | 费用中心 BSS | AliyunBSSReadOnlyAccess | 只读访问费用中心 BSS的权限。 |
      
      创建RAM用户后，您可以使用RAM用户登录阿里云控制台，开始本方案的部署和体验。
      
      RAM用户的使用请参见[创建RAM用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)、[创建自定义权限策略](https://help.aliyun.com/zh/ram/user-guide/create-a-custom-policy)和[为RAM用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。
   3. 单击[云资源访问权限](https://ram.console.aliyun.com/role/authorization?request=%7B%22Services%22%3A%5B%7B%22Service%22%3A%22CS%22%2C%22Roles%22%3A%5B%7B%22RoleName%22%3A%22AliyunCSManagedLogRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedLogRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedCmsRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedCmsRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedCsiRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedCsiRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedVKRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedVKRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSClusterRole%22%2C%22TemplateId%22%3A%22Cluster%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSServerlessKubernetesRole%22%2C%22TemplateId%22%3A%22ServerlessKubernetes%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSKubernetesAuditRole%22%2C%22TemplateId%22%3A%22KubernetesAudit%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedNetworkRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedNetworkRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSDefaultRole%22%2C%22TemplateId%22%3A%22Default%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedKubernetesRole%22%2C%22TemplateId%22%3A%22ManagedKubernetes%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedArmsRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedArmsRole%22%7D%5D%7D%5D%2C%22ReturnUrl%22%3A%22https%3A%2F%2Fcs.console.aliyun.com%2F%22%7D)，然后单击**同意授权**。
      
      此页权限为可供容器服务 ACK使用的角色。授权后，ACK拥有对您云资源相应的访问权限。
### **一键部署**


您可以通过下方提供的ROS一键部署链接，来自动化地完成以下资源的创建和配置。部署完成后，您可以参见教程实现并体验如何通过MSE微服务治理完成ACK应用的全链路灰度。

* 创建一个ACK Pro版集群
* 开通MSE云原生网关并创建MSE网关实例
* 开通MSE注册配置中心并创建MSE Nacos实例
* 关联MSE Nacos与MSE云原生网关

#### **1、ROS部署前置资源**

1. 打开[一键配置模板链接](https://ros.console.aliyun.com/cn-beijing/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/mse-realizes-full-link-grayscale.yml&pageTitle=MSE%E5%AE%9E%E7%8E%B0%E5%85%A8%E9%93%BE%E8%B7%AF%E7%81%B0%E5%BA%A6&isSimplified=True&productNavBar=disabled&disableRollback=false)前往ROS控制台，系统自动打开并停留在**配置模板参数**页面，请在配置资源栈前在页面上方选择地域。本方案示例地域为华东1（杭州）。
2. 在**配置模板参数**页面，配置基础信息，确认无误后单击**创建**。
   
   | **配置项** | **说明** | **示例** |
   | --- | --- | --- |
   | **资源栈名称** | 本资源栈的名称。保持默认即可。 | 保持默认 |
   | **ACK托管版集群名称** | ACK托管版集群的名称。本方案中的ACK集群名称默认为**testcluster**。如您的账号下已存在同名ACK集群，请更改该名称，避免集群名称重复导致的资源栈创建失败。 | testcluster |
   | **可用区** | 在规划的地域内选择主、备可用区（选择备可用区以实现多可用区容灾）。 | 可用区I、可用区H |
   | **ACK配置** | * Worker节点规格：支持选择多个**实例规格**。可通过**vCPU**、**内存**筛选**实例规格**，也可选择**架构**和**分类**。本方案选择通用型实例规格即可。关于ECS选型的最佳实践请参见[实例规格选型指导](https://help.aliyun.com/zh/ecs/user-guide/best-practices-for-instance-type-selection)。 * Worker节点系统盘磁盘类型：系统盘可选的类型与选择的实例规格相关。查询实例规格支持的云盘类型，请参见[实例规格族](https://help.aliyun.com/zh/ecs/user-guide/overview-of-instance-families#concept-sx4-lxv-tdb)。本方案保持默认即可。 * Worker节点系统盘大小(GB)：保持默认即可。 | * 通用型 g6 4 vCPU 16GiB * cloud\_essd * 120 |
   | **MSE配置** | 注册配置中心实例MSE Nacos的名称。本方案中的MSE Nacos名称默认为**test**。如您的账号下已存在同名MSE Nacos实例，请更改该名称，避免名称重复导致的资源栈创建失败。 | test |
3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
#### **2、开通MSE微服务治理**

1. 访问[MSE微服务治理开通页面](https://common-buy.aliyun.com/?commodityCode=mse_basic_public_cn)，单击**微服务治理**页签，配置商品类型为**按量付费**、版本为**专业版**，然后在**服务协议**区域，仔细阅读并勾选服务协议，然后单击**立即开通**，开通微服务治理专业版。详细信息，请参见[开通MSE微服务治理](https://help.aliyun.com/zh/mse/product-overview/activate-microservices-governance)。
2. 开通成功后，单击**管理控制台**，在欢迎访问页面单击**立即授权**，然后单击**确定**。
3. 单击**下一步**，然后单击**立即体验微服务引擎MSE**。
### 搭建基线环境


1、部署后端业务应用的基线版本
---------------

本小节提供YAML示例，展示如何部署后端应用A、B、C的基线版本。

1. 登录，在左侧导航栏选择**集群**。
2. 在**集群列表**页面，单击目标集群名称，然后在左侧导航栏，选择**工作负载** > **无状态**。
3. 在页面上方，选择集群的**命名空间**，本示例使用默认的default命名空间，然后单击右上角的**使用YAML创建资源**，选择**示例模板**为自定义，然后在**模板**区域复制以下YAML文件内容，部署A、B、C三个应用的基线版本，然后单击**创建**。
   
   以下示例代码中的{nacos server address}需要替换为MSE Nacos的内网域名，并删去大括号{}。您可以登录[MSE网关管理控制台](https://mse.console.aliyun.com/#/microgw)，在左侧导航栏，选择**注册配置中心****>****实例列表**，然后在**访问方式**列，获取MSE Nacos的内网域名。
   
   ```
   # 应用A的基线版本
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: spring-cloud-a
     namespace: default
   spec:
     selector:
       matchLabels:
         app: spring-cloud-a
     template:
       metadata:
         labels:
           app: spring-cloud-a
           msePilotCreateAppName: spring-cloud-a
           msePilotAutoEnable: 'on'
       spec:
         containers:
         - name: spring-cloud-a
           image: registry.cn-shanghai.aliyuncs.com/yizhan/spring-cloud-a:1.0.0
           imagePullPolicy: Always
           ports:
             - containerPort: 20001
           livenessProbe:
             tcpSocket:
               port: 20001
             initialDelaySeconds: 30
             periodSeconds: 60
           env:
           - name: spring.cloud.nacos.discovery.server-addr
             value: {nacos server address}
           - name: dubbo.registry.address
             value: 'nacos://{nacos server address}:8848'
   ---
   # 应用B的基线版本
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: spring-cloud-b
     namespace: default
   spec:
     selector:
       matchLabels:
         app: spring-cloud-b
     template:
       metadata:
         labels:
           app: spring-cloud-b
           msePilotCreateAppName: spring-cloud-b
           msePilotAutoEnable: 'on'
       spec:
         containers:
         - name: spring-cloud-b
           image: registry.cn-shanghai.aliyuncs.com/yizhan/spring-cloud-b:1.0.0
           imagePullPolicy: Always
           ports:
             - containerPort: 20002
           livenessProbe:
             tcpSocket:
               port: 20002
             initialDelaySeconds: 30
             periodSeconds: 60
           env:
           - name: spring.cloud.nacos.discovery.server-addr
             value: {nacos server address}
           - name: dubbo.registry.address
             value: 'nacos://{nacos server address}:8848'
   ---
   # 应用C的基线版本
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: spring-cloud-c
     namespace: default
   spec:
     selector:
       matchLabels:
         app: spring-cloud-c
     template:
       metadata:
         labels:
           app: spring-cloud-c
           msePilotCreateAppName: spring-cloud-c
           msePilotAutoEnable: 'on'
       spec:
         containers:
         - name: spring-cloud-c
           image: registry.cn-shanghai.aliyuncs.com/yizhan/spring-cloud-c:1.0.0
           imagePullPolicy: Always
           ports:
             - containerPort: 20003
           livenessProbe:
             tcpSocket:
               port: 20003
             initialDelaySeconds: 30
             periodSeconds: 60
           env:
           - name: spring.cloud.nacos.discovery.server-addr
             value: {nacos server address}
           - name: dubbo.registry.address
             value: 'nacos://{nacos server address}:8848'
   ```
   
   创建成功后，您可以在**无状态**页面的应用列表中查看创建成功的应用A、B、C的基线版本。

2、将后端业务应用接入MSE微服务治理
-------------------

ACK应用部署成功后，您需要在MSE微服务治理控制台接入该应用。

1. 登录[MSE治理中心控制台](https://mse.console.aliyun.com/?spm=5176.14952521.J_5253785160.4.7fcb23bcZbYgjb#/msc/home)，在顶部菜单栏选择地域，在左侧导航栏，选择**治理中心****>应用治理**。
2. 单击**ACK应用接入**，参照下文完成配置后，单击**确定**。
   
   1. 安装ack-onepilot：在ack-onepilot区域，单击**点击安装**。
      
      安装成功后，此区域显示已安装版本。
   2. 配置ACK集群和命名空间信息：
      
      * 接入类型：命名空间接入
      * 集群类型：ACK集群
      * 集群名称/ID：testcluster
      * 集群命名空间：应用所在的命名空间，default
      * 接入治理命名空间：default
3. 在接入成功提示对话框，阅读提示，然后单击**去重启**，跳转至的集群列表，单击目标集群testcluster，然后在左侧导航栏单击**工作负载**>**无状态**，勾选应用列表的spring-cloud-a、spring-cloud-b、spring-cloud-c，然后单击下方的**重新部署**。
4. 返回[MSE治理中心控制台](https://mse.console.aliyun.com/?spm=5176.14952521.J_5253785160.4.7fcb23bcZbYgjb#/msc/home)，单击接入成功提示对话框的**我已知晓**。
   
   此时，应用列表区域将显示spring-cloud-a、spring-cloud-b、spring-cloud-c对应的应用概览卡片，表明ACK应用接入成功。

**3、通过MSE云原生网关暴露应用A**
---------------------

应用基线版本部署成功后，您需要通过MSE云原生网关添加并暴露应用A。

1. 登录[MSE网关管理控制台](https://mse.console.aliyun.com/#/microgw)，在左侧导航栏，选择**云原生网关>网关列表**，然后在顶部菜单栏选择地域。
2. 在**网关列表**页面，单击目标网关名称test。
3. 在左侧导航栏，选择**路由管理**，然后选择**服务**页签。
4. 单击**创建服务**。在**创建服务**面板，配置服务相关参数，然后单击**确定**。
5. 在**创建服务**面板，选择**服务来源**为**MSE Nacos**，选择对应命名空间，并在**服务列表**选择sc-A，将sc-A移动到右侧**已选择**区域，然后单击**确定**。
   
   关于创建服务的更多信息，请参见[创建服务](https://help.aliyun.com/zh/mse/user-guide/create-service)。
6. 在服务列表的**操作**列点击![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1561720371/p865286.png)，单击sc-A对应的**策略配置**，在**服务版本**区域，确认如下配置信息。
   
   * **版本名称**为**base**。
   * **标签名**为**opensergo.io/canary**。
   * **标签值**为空。
     
     ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5040748861/p689806.png)
     
     正常情况下，云原生网关默认为导入的Nacos的服务添加以上base版本，且base版本的**实例数**大于0。
     
     如果base版本**实例数**显示为0，表明您安装的MSE Java Agent版本太低。请卸载原有的**ack-onepliot**，重新安装**ack-onepliot**，并确保**ack-onepliot**的版本为2.8.0及以上，然后重新部署应用A，部署完毕之后确认**实例数**是否大于0。关于的操作步骤，请参见[为ACK命名空间中的应用开启MSE微服务治理](https://help.aliyun.com/zh/mse/user-guide/enable-microservices-governance-for-microservice-applications-in-an-ack-cluster#p-osd-8q3-wvd)。
7. 查看完成后，单击页面左上角的![image..png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7234376861/p682802.png)返回服务列表页面，然后在左侧导航栏单击**路由管理****>****路由配置**，然后单击**创建路由**。
8. 在**创建路由**面板，配置**请求信息**和**目标服务**，配置完成后单击**保存并上线**。
   
   1. **请求信息**：配置**路由名称**（本示例配置为`test`）和**关联域名**（本示例配置为`*`），**匹配规则**选择**前缀匹配**（本示例配置为`/a`），其他配置选择默认，然后单击**下一步**。
   2. **目标服务**：**路由指向**选择**单服务**，添加服务并选择**服务**为**sc-A**，勾选**设置fallback服务**，选择**服务**为**sc-A**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0646630371/p866545.png)

**4、测试基线版本流量**
--------------

应用暴露完成后，您可以使用curl命令测试基线版本的流量路由链路。

1. 登录[MSE网关管理控制台](https://mse.console.aliyun.com/#/microgw)，在左侧导航栏，选择**云原生网关****>****网关列表**，然后在顶部菜单栏选择地域。
2. 在**网关列表**页面，单击目标网关名称，在左侧导航栏，单击**基本概览**，然后单击**网关入口**页签，查看并记录SLB的**入口地址（ip）**用于下一步的流量测试。
3. 用curl命令，测试基线版本流量，发现流量经过了A、B和C的基线版本。如下所示。
   
   ```
   # 测试命令
   curl x.x.1.1/a
   ```
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0646630371/p866521.png)
### **搭建灰度环境**

20

1、部署后端业务应用的灰度版本
---------------

如果业务应用要发布新功能，新功能要求应用A和应用C同时发版，此时需要借助全链路灰度来同时验证不同应用的灰度版本。基线版本准备完成后，您需要搭建业务应用的灰度环境。

1. 登录，在左侧导航栏选择**集群**。
2. 在**集群列表**页面，单击目标集群名称，然后在左侧导航栏，选择**工作负载** > **无状态**。
3. 在页面上方，选择集群的**命名空间**，然后单击右上角的**使用YAML创建资源**，选择**示例模板**为自定义，然后在**模板**区域复制以下YAML文件内容，部署A、C两个应用的灰度版本。
   
   以下示例代码中的{nacos server address}需要替换为MSE Nacos的内网域名，并删去大括号{}。
   
   ```
   # 应用A的灰度版本
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: spring-cloud-a-gray
     namespace: default
   spec:
     selector:
       matchLabels:
         app: spring-cloud-a-gray
     template:
       metadata:
         labels:
           alicloud.service.tag: gray
           app: spring-cloud-a-gray
           msePilotCreateAppName: spring-cloud-a
           msePilotAutoEnable: 'on'
       spec:
         containers:
         - name: spring-cloud-a
           image: registry.cn-shanghai.aliyuncs.com/yizhan/spring-cloud-a:1.0.0
           imagePullPolicy: Always
           ports:
             - containerPort: 20001
           livenessProbe:
             tcpSocket:
               port: 20001
             initialDelaySeconds: 30
             periodSeconds: 60
           env:
           - name: spring.cloud.nacos.discovery.server-addr
             value: {nacos server address}
           - name: dubbo.registry.address
             value: 'nacos://{nacos server address}:8848'
   ---
   # 应用C的灰度版本
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: spring-cloud-c-gray
     namespace: default
   spec:
     selector:
       matchLabels:
         app: spring-cloud-c-gray
     template:
       metadata:
         labels:
           alicloud.service.tag: gray
           app: spring-cloud-c-gray
           msePilotCreateAppName: spring-cloud-c
           msePilotAutoEnable: 'on'
       spec:
         containers:
         - name: spring-cloud-c
           image: registry.cn-shanghai.aliyuncs.com/yizhan/spring-cloud-c:1.0.0
           imagePullPolicy: Always
           ports:
             - containerPort: 20003
           livenessProbe:
             tcpSocket:
               port: 20003
             initialDelaySeconds: 30
             periodSeconds: 60
           env:
           - name: spring.cloud.nacos.discovery.server-addr
             value: {nacos server address}
           - name: dubbo.registry.address
             value: 'nacos://{nacos server address}:8848'
   ```

2、创建灰度环境泳道
----------

1. 登录[MSE治理中心控制台](https://mse.console.aliyun.com/?spm=5176.14952521.J_5253785160.4.7fcb23bcZbYgjb#/msc/home)，在顶部菜单栏选择地域，在左侧导航栏，选择**治理中心****>****全链路灰度**。
2. 在页面上方选择命名空间，然后单击**创建泳道组**，在**创建泳道组**面板，设置如下相关配置，然后单击**确定**。
   
   | **配置项** | **描述** | **示例** |
   | --- | --- | --- |
   | **泳道组名称** | 自定义泳道组的名称。 | demo |
   | **入口类型** | 网关入口类型。 | **MSE 云原生网关** |
   | **泳道组流量入口** | 流量入口网关。 | 此前创建的MSE Nacos网关 |
   | **泳道组涉及应用** | 泳道组中涉及的应用。 | **spring-cloud-a**、**spring-cloud-b**、**spring-cloud-c** |
3. 在**全链路灰度**页面下方，单击**点击创建第一个分流泳道**，在**创建泳道**面板，设置流控泳道相关配置，然后单击**确定**。
   
   | **配置项** | **描述** | **示例** |
   | --- | --- | --- |
   | **配置节点标签** | 配置方式：登录，在左侧导航栏单击集群，然后在**集群列表**页面，单击目标集群名称，然后在左侧导航栏，选择**工作负载****>****无状态**。在**操作**列，依次单击应用对应的**更多****>****查看Yaml**，在YAML的`spec.template.metadata.labels`下增加`alicloud.service.tag:{tag}`，然后单击**更新**。  修改示例可参照下图。image.png | 在应用A、B、C（spring-cloud-a、spring-cloud-b、spring-cloud-c）的YAML的`spec.template.metadata.labels`下增加`alicloud.service.tag: gray`。 |
   | **添加应用** | 选择或输入应用所属泳道标签后，将自动显示泳道名称。 | gray |
   | **路由规则** | **选择已在网关创建的基线路由**：选择此前创建的路由。 | test |
   | **灰度模式** | **按内容灰度** |
   | **条件列表**：单击下方的**+ 添加新的规则条件**，新增规则条件，配置**参数类型**、**参数**、**条件**和**值**。 | * **参数类型**：Header * **参数**：canary * **条件**：== * **值**：gray |
### **完成及清理**

#### **方案验证**

**一、通过对比基线和灰度版本流量路由，验证MSE微服务的全链路灰度能力**

1. 登录[MSE网关管理控制台](https://mse.console.aliyun.com/#/microgw)，在左侧导航栏，选择**云原生网关****>****网关列表**，然后在顶部菜单栏选择地域。
2. 在**网关列表**页面，单击目标网关名称，在左侧导航栏，单击**基本概览**，然后单击**网关入口**页签，查看并记录SLB的**入口地址（ip）**用于下一步的流量测试。
3. 用curl命令，测试灰度版本流量。
   
   ```
   # 测试命令
   curl -H "canary: gray" x.x.x.x/a
   ```
4. 与之前测试的基线版本流量对比如下：![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0646630371/p866373.png)预期输出表明，流量经过了A、C的灰度环境，由于B没有gray环境，所以流量自动容灾到基线版本。

**二、查看应用治理监控，验证微服务治理的流量治理**

1. 打开[MES管理控制台](https://mse.console.aliyun.com/)，点击左侧导航栏**治理中心 > 应用治理**，可以看到当前应用列表罗列了spring-cloud-a、spring-cloud-b、spring-cloud-c三个应用当前的访问情况。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0646630371/p866569.png)
2. 点击任意一个应用，进入详情页面，点击左侧导航栏中的**流量治理**，点击**金丝雀**标签，查看当前标签、对应的实例数量及流量比例。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0646630371/p866568.png)
#### 清理资源

完成本方案后，如您无需使用相关资源，请清理相关数据和资源。

* **ROS资源**
  
  如果无需使用资源，可以资源栈下的资源，包括1个ACK集群、1个MSE Nacos实例、1个MSE网关云原生网关实例。
  
  1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)，然后在左侧导航栏，选择**资源栈**。
  2. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
     
     本方案会自动创建两个资源栈，一个由您部署时创建，另一个以`k8s-`开头，由ACK创建集群时创建。请删除非`k8s-`开头的资源栈，删除此资源栈时将自动删除`k8s-`开头的资源栈。
  3. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
* **MSE微服务治理**
  
  1. 如果无需继续使用，请登录[MSE治理中心控制台](https://mse.console.aliyun.com/?spm=5176.14952521.J_5253785160.4.7fcb23bcZbYgjb#/msc/home)，在左侧导航栏单击**治理中心****>****应用治理**，找到目标应用，在目标应用卡片上单击![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5330700861/p611945.png)图标，然后单击**移除**。在弹出的**删除**对话框，单击**确定**。删除应用后，此应用对应的所有规则也将被清空。
  2. 然后，请删除泳道及其流量分配。在左侧导航栏单击**治理中心****>全链路灰度**，单击创建泳道组右侧的![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9657748861/p689976.png)，然后单击泳道组页签的![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9657748861/p689977.png)，在对话框单击**确定**。在下方**流量分配**区域，单击**操作列**的**删除**，然后在对话框单击**确定**。
