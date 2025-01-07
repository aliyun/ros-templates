

**一键部署**
--------

45

https://www.aliyun.com/solution/tech-solution/nginx\_ingress

### **方案概览**

容器服务 Kubernetes 版 ACK（Container Service for Kubernetes）提供丰富的集群及应用的管理运维功能，支持企业级容器化应用的全生命周期管理。在自建Kubernetes集群中，手动部署集群步骤较为复杂，集群应用的运维管理往往需要您手动维护和探索。ACK支持在控制台快速创建集群，接入日志服务 SLS（Simple Log Service）提供日志采集方案和看板。

本技术解决方案以部署Nginx并通过Ingress暴露和监控服务为例，为您演示：

* 如何快速创建ACK集群并在集群中使用YAML文件部署无状态应用。
* 如何创建Service发布Nginx应用并通过Nginx Ingress组件暴露服务。
* 如何在SLS控制台查看Nginx Access日志。

#### **方案架构**

方案提供的默认设置完成部署后在阿里云上部署、发布并监控Nginx应用的架构如下图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与下图相似。

![使用YAML部署.jpg](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8008323961/p712204.jpg)

本方案的技术架构包括以下基础设施和云服务：

* 1个地域：ACK集群、SLS Project均部署在统一地域下。
* 1个专有网络VPC：形成云上私有网络，确保核心云资源的网络环境，如容器服务ACK。
* ACK集群：简单、低成本、高可用的Kubernetes集群，支持应用管理，无需您管理控制面板。
* 日志服务SLS：提供日志采集服务以及可视化看板。
### **部署准备**

10

开始部署前，请按以下指引完成账号申请、账号充值、RAM用户创建和授权。

#### **准备账号**

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   * 本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。请确保您的账户余额大于等于100元。
   * 完成本方案的部署及体验，预计产生费用约为5元（假设您配置ACK集群时选择本文指导的规格资源，且资源运行时间不超过45分钟。实际情况可能会因您操作过程中使用的资源规格和流量差异，导致费用有所变化，请以控制台显示的实际报价以及最终账单为准）。
     
     | **产品** | **费用来源** | **规格** | **预估费用参考** |
     | --- | --- | --- | --- |
     | 容器服务 Kubernetes 版 | CLB Ingress费用 | 标准型I（slb.s2.small） | 实例费用：0.34/小时  流量费用：0.8/GB |
     | CLB API Server费用 | 标准型I（slb.s1.small） | 0.1元/时 |
     | NAT费用 | 公网NAT网关 | + 实例费：0.195元/时 + 容量单位CU费：0.195元/CU |
     | EIP费用 | 不涉及 | + EIP配置费：0.02元/小时 + 流量费用：0.8元/GB |
     | ECS费用 | 3个计算型 c6 4 vCPU 8GiB的实例；系统盘为云盘ESSD，40GiB，PL1。 | 2.592元/小时 |
     | 集群管理费用 | 不涉及 | 0.64元/小时 |
     | 日志服务 SLS | 写入数据存储费用 | 不涉及 | 0.4 元/GB |
     | 按量费用：3.887元/时  CU容量费用产品：1个  流量费用产品：3个 | | | |
3. 阿里云账号拥有操作资源的最高权限，从云资源安全角度考虑，建议您创建RAM用户。RAM用户需要获得相关云服务的访问权限才能完成方案部署，详情如下：
   
   1. 访问[RAM控制台-用户页面](https://ram.console.aliyun.com/users)，单击**创建用户**，填写相关信息，勾选**控制台访问**和**OpenAPI 调用访问**，自定义密码并选择无需重置密码，创建一个RAM用户。
   2. 在RAM用户列表的操作列，单击目标RAM用户对应的**添加权限**。在**添加权限**面板，在**选择权限**策略的**系统策略**区域，搜索并新增如下权限，然后单击**确定**。
      
      涉及的云服务：资源编排 ROS、容器服务 Kubernetes 版、日志服务SLS、专有网络 VPC、云服务器 ECS、费用中心 BSS。
      
      每次支持最多绑定5条策略，请分2次操作添加如下权限。
      
      | **云服务** | **需要的权限** | **描述** |
      | --- | --- | --- |
      | 资源编排 ROS | AliyunROSFullAccess | 管理资源编排服务 ROS的权限。 |
      | 容器服务 ACK | AliyunCSFullAccess | 管理容器服务 ACK的权限。 |
      | 日志服务 SLS | AliyunLogFullAccess | 管理日志服务 SLS的权限 |
      | 专有网络 VPC | AliyunVPCFullAccess | 管理专有网络 VPC的权限。 |
      | 云服务器 ECS | AliyunECSFullAccess | 管理云服务器服务 ECS的权限。 |
      | 访问控制 RAM | AliyunRAMFullAccess | 管理访问控制 RAM的权限，即管理用户以及授权的权限 |
      | 费用中心 BSS | AliyunBSSReadOnlyAccess | 只读访问费用中心 BSS的权限。 |
      
      创建RAM用户后，您可以使用RAM用户登录阿里云控制台，开始本方案的部署和体验。
      
      RAM用户的使用请参见[创建RAM用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)、[创建自定义权限策略](https://help.aliyun.com/zh/ram/user-guide/create-a-custom-policy)和[为RAM用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。
   3. 单击[云资源访问权限](https://ram.console.aliyun.com/role/authorization?request=%7B%22Services%22%3A%5B%7B%22Service%22%3A%22CS%22%2C%22Roles%22%3A%5B%7B%22RoleName%22%3A%22AliyunCSManagedLogRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedLogRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedCmsRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedCmsRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedCsiRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedCsiRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedVKRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedVKRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSClusterRole%22%2C%22TemplateId%22%3A%22Cluster%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSServerlessKubernetesRole%22%2C%22TemplateId%22%3A%22ServerlessKubernetes%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSKubernetesAuditRole%22%2C%22TemplateId%22%3A%22KubernetesAudit%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedNetworkRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedNetworkRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSDefaultRole%22%2C%22TemplateId%22%3A%22Default%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedKubernetesRole%22%2C%22TemplateId%22%3A%22ManagedKubernetes%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedArmsRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedArmsRole%22%7D%5D%7D%5D%2C%22ReturnUrl%22%3A%22https%3A%2F%2Fcs.console.aliyun.com%2F%22%7D)，然后单击**同意授权**。
      
      此页权限为可供容器服务 ACK使用的角色。授权后，ACK拥有对您云资源相应的访问权限。
### **一键部署**

10

您可以通过下方提供的ROS一键部署链接，来自动化地完成以下资源的创建和配置。部署完成后，您可以参见教程实现并体验如何通过MSE微服务治理完成ACK应用的全链路灰度。

* 创建一个ACK Pro版集群
* 开通日志服务SLS

#### **ROS部署前置资源**

1. 单击[一键配置](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/deploy-nginx-services-through-ingress.yml&pageTitle=部署Nginx并通过Ingress暴露和监控服务&isSimplified=True&productNavBar=disabled&disableRollback=false)前往ROS控制台，系统自动打开并停留在**配置模板参数**页面，请在配置资源栈前在页面上方选择地域。本方案示例地域为华东1（杭州）。
2. 在**配置模板参数**页面，配置基础信息，确认无误后单击**创建**。
   
   | **配置项** | **说明** | **示例** |
   | --- | --- | --- |
   | **资源栈名称** | 本资源栈的名称。保持默认即可。 | 保持默认 |
   | **集群名称** | ACK托管版集群的名称。本方案中的ACK集群名称默认为`cluster-for-nginx`。如您的账号下已存在同名ACK集群，请更改该名称，避免集群名称重复导致的资源栈创建失败。 | cluster-for-nginx |
   | **可用区** | 在规划的地域内选择可用区。 | 可用区I |
   | **节点规格** | Worker节点规格：支持选择多个**实例规格**。可通过**vCPU**、**内存**筛选**实例规格**，也可选择**架构**和**分类**。本方案选择通用型实例规格即可。关于ECS选型的最佳实践请参见[ECS选型最佳实践](https://help.aliyun.com/zh/ecs/user-guide/best-practices-for-instance-type-selection)。 | * 计算型 c6 4 vCPU 8GiB |
3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
### 部署、发布并对外暴露应用

15

Nginx是一个开源反向代理服务器，部署Nginx应用并创建Service后，Nginx Service可通过集群虚拟IP（Cluster IP）、节点端口（NodePort）或负载均衡（LoadBalancer）来公开端口，将流量分到Pod，暴露应用程序。而Nginx Ingress支持通过Nginx Ingress Controller组件定义从集群外部访问集群内部服务的规则，将集群外部流量转发到相应的后端Service或Pod上。更多信息，请参见[管理Nginx Ingress Controller组件](https://help.aliyun.com/zh/ack/ack-managed-and-ack-dedicated/user-guide/manage-the-nginx-ingress-controller)。

1、部署Nginx应用
-----------

1. 登录[容器镜像服务](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors)控制台，找到并复制加速器地址。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7600566271/p850478.png)
2. 登录[容器服务管理控制台](https://cs.console.aliyun.com)，在左侧导航栏选择**集群**。
3. 在**集群列表**页面，单击目标集群名称，然后在左侧导航栏，选择**工作负载** > **无状态**。
4. 在**无状态**页面，单击**使用YAML创建资源**，对模板进行相关配置，完成配置后单击**创建**。
   
   * 在页面顶部设置**命名空间**为**default**，并设置**示例模板**为**Resource - basic Deployment**。
   * 配置日志采集。有关更多日志参数的配置信息，请参见[通过日志服务采集Kubernetes容器日志](https://help.aliyun.com/zh/ack/ack-managed-and-ack-dedicated/user-guide/collect-log-data-from-containers-by-using-log-service#task-1797722)。
     
     在模板中的`spec`字段下添加以下内容。
     
     **说明** 
     
     下方示例代码中`aliyun_logs_log-nginxvarlog`表示创建一个名为log-nginxvarlog的Logstore，日志采集路径为stdout的配置，从而将容器的标准输出采集到Logstore中。
     
     ```
     env:
     - name: aliyun_logs_log-nginxvarlog
       value: stdout
     ```
     
     ![配置日志采集](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9781067061/p189745.png)
   * 修改当前模板中nginx的版本，并加上前缀，修改后完整的镜像配置是：<加速器地址>/library/nginx:1.9.1。（注意：加速器地址不包括https前缀）。![image (1)](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7600566271/p850483.png)
   
   创建成功后，单击页面左上方的![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4978813961/p711223.png)，可以在无状态页签下查看创建成功的Nginx应用。![Nginx](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9781067061/p189752.jpg)

2、创建Service发布Nginx应用
--------------------

1. 在集群管理页左侧导航栏，选择**网络** > **服务**。
2. 在**服务**页面，单击**创建**，然后在**创建服务**对话框，配置服务信息，然后单击**创建**。
   
   | 参数 | 说明 | 示例值 |
   | --- | --- | --- |
   | 名称 | 设置服务名称。 | nginxservice |
   | 类型 | 支持多种设置**类型**为**虚拟集群IP**。 | **虚拟集群IP** |
   | 关联 | 设置关联对象。 | nginx-deployment-basic |
   | 端口映射 | 自定义端口名称，配置**服务端口**为80，**容器端口**为80，**协议**为**TCP**。 | * test * 80 * 80 * TCP |

**3、**创建Nginx Ingress路由对外暴露Nginx应用
----------------------------------

1. 在集群管理页左侧导航栏，选择**网络** > **路由**。
2. 在**路由**页面，单击**创建 Ingress**。
3. 选择**网关类型**为**Nginx**，参照下方内容配置路由，然后单击**确定**。
   
   以下为重点配置项，其他配置项的说明请参见[创建Nginx Ingress](https://help.aliyun.com/zh/ack/ack-managed-and-ack-dedicated/user-guide/create-an-nginx-ingress-1#section-g4f-wex-ruo)。
   
   * 名称：自定义路由名称，本示例设置为ingress-demo。
   * 规则：**域名**置空，设置**路径**为`/`，匹配规则为默认，设置服务名称为上文创建的服务名称，即nginxservice，**端口**自动绑定为80。
   
   等待1分钟左右，**路由**列表的**端点**列将显示路由的IP。在浏览器中输入端点IP，显示以下页面，表明路由创建成功。![Nginx](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9781067061/p189883.png)
### **完成及清理**

10

#### **方案验证**

Nginx应用成功发布并对外暴露后，Nginx Ingress Controller支持将所有HTTP请求日志记录到标准输出中。可以通过**Ingress概览**或者**日志服务**的**仪表盘**监控Nginx Ingress实时状态。

**一、通过Ingress概览页面，实现Nginx Ingress监控**

1. 登录[容器服务管理控制台](https://cs.console.aliyun.com/)，在左侧导航栏选择**网络 > 路由**，点击**Ingress概览**。

![image (4)](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7600566271/p850503.png)

**Ingress概览**页面提供了整体架构状态、网站实时状态、用户请求类信息、TOPURL统计。通过这些信息，可以较为全面地了解集群中Ingress的工作状态和访问情况。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7600566271/p850488.png)

**二、通过日志服务，实现Nginx Ingress监控**

1. 登录[容器服务管理控制台](https://cs.console.aliyun.com/)，在左侧导航栏选择**集群**。
2. 在**集群列表**页面，单击目标集群名称，然后在左侧导航栏，选择**集群信息**。
3. 单击**集群资源**页签，单击**日志服务Project**的ID，跳转至日志库。![image (1)](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7600566271/p850491.png)
4. 在日志库中，选择log-nginxvarlog，查看最近访问日志。![image (5)](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7600566271/p850506.png)
5. 单击左侧列表的仪表盘图标，可以查看Nginx Ingress相关的分析报表。仪表盘提供了更全面、更直观的监控结果。![image (3)](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7600566271/p850493.png)

在Ingress详细监控中，可以看到“请求成功率”、“访问PV”、“平均延迟”等关键指标，可以全面了解Nginx Ingress的运行状态和服务质量。

#### 清理资源

完成本方案后，如您无需使用相关资源，请清理相关数据和资源。

* **ROS资源**
  
  如果无需使用资源，可以资源栈下的资源，包括1个ACK集群、1个MSE Nacos实例、1个MSE网关云原生网关实例。
  
  1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)，然后在左侧导航栏，选择**资源栈**。
  2. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
     
     本方案会自动创建两个资源栈，一个由您部署时创建，另一个以`k8s-`开头，由ACK创建集群时创建。请删除非`k8s-`开头的资源栈，删除此资源栈时将自动删除`k8s-`开头的资源栈。
  3. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
* **日志服务 SLS**
  
  1. 登录[日志服务控制台](https://sls.console.aliyun.com/)，在**Project列表**区域定位目标Project并复制Project名称，然后在**操作**列，单击**删除**。
  2. 在删除面板，输入Project名称，选择删除原因，然后单击**确定**。
