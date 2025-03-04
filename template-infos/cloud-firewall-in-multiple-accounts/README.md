## 方案概览

云防火墙提供统一账号管理功能，支持通过阿里云资源管理的可信服务将多个阿里云账号添加到一个资源目录，并委派购买了云防火墙的阿里云账号作为委派管理员，使其可以访问资源目录下所有成员账号包含的资源，从而实现单账号下的云防火墙防护跨账号资源的访问流量。

云防火墙多账号统一管理方案，提供统一的安全运营视图，实现云防火墙安全管理跨账号资源，降低了企业多账号维护的难度和成本。

### 方案架构

本方案以统一管理同地域的两个阿里云账号所部署的专有网络 VPC（Virtual Private Cloud）为例，介绍如何使用云防火墙实现跨账号资源的流量防护管控。

方案提供的默认设置完成部署后在阿里云上搭建的网站运行环境如架构图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与架构图相似。


本方案通过将多个阿里云账号加入同一个资源目录，建立云上企业业务组织关系。用户可以指派购买了云防火墙的账号为委派管理员账号，并建立云防火墙多账号体系。方案部署完成后，用户可以通过云防火墙控制台统一管理多个账号的云资源，防护多账号下的云资源的安全性。

## 方案部署
### 部署准备


开始部署前，请按以下指引完成账号申请、账号充值、RAM 用户创建和授权。

#### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
   
   本方案中，您需要创建 3 个阿里云账号，分别为管理账号、阿里云账号 A（同时作为委派管理员）和阿里云账号 B，并且 3 个阿里云账号为同一企业实名认证。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   本方案使用的云资源包括：云防火墙、资源目录 RD、专有网络 VPC、云服务器 ECS。为节省成本，本方案默认采用按量付费或包年包月版最小规格引导操作，所需的费用预估如下：
   
   * 云防火墙：当前仅云防火墙包年包月版支持多账号统一管理功能。本方案默认按最低规格购买，预估费用为 5,300 元/月。
     
     云防火墙支持五天无理由全额退订，每个用户在一个自然年内可申请一次五天无理由全额退订。如果您满足五天无理由全额退订条件，您可以通过[退订管理](https://usercenter2.aliyun.com/refund/refund)页面全额退订云防火墙。更多信息，请参见[自助退订](https://help.aliyun.com/zh/cloud-firewall/cloudfirewall/refunds)。
   * 资源目录 RD：资源目录为免费产品，开通后即可正常使用，不收取任何费用。
   * 专有网络 VPC：根据不同的使用情况和配置，VPC 的收费标准有所不同，本方案中的配置，VPC 不收取任何费用。
   * 云服务器 ECS：本方案默认按最低规格购买，预估费用如下图所示。
     
     ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3791082961/p709614.png)
   
   以上预估费用仅供参考，具体价格与您选择的资源规格有关，请以控制台显示的实际报价以及最终账单为准。
### 规划网络和资源


#### 网络规划

请参考表格中的说明和方案默认示例值为每个规划项做详细规划并在实际部署时将默认示例值修改为您的实际规划。

| **规划项** | **数量** | **说明** |
| --- | --- | --- |
| 地域 | 1 | 您的云服务部署的地域。选择地域的基本原则请参见[地域和可用区](https://help.aliyun.com/document_detail/40654.html)。 |
| 专有网络 VPC | 2 | 在部署过程中新建 2 个 VPC 作为本方案的专有网络。 |
| 交换机 | 2 | 本方案需要至少 2 台交换机，用来连接不同的云资源实例。 |

#### 规划云资源

请参考表格中的说明和方案默认示例值为每个规划项做详细规划并在实际部署时将默认示例值修改为您的实际规划。

| **规划项** | **数量** | **说明** |
| --- | --- | --- |
| ECS | 2 | 本方案需要 2 台 ECS 实例，用于验证流量访问管控。 |
| 云防火墙 | 1 | 本方案需要 1 台云防火墙实例，用于对多账号下的访问流量进行安全防护。云防火墙可以根据设定的访问控制策略对访问流量进行拦截或放行，降低由于管控疏漏导致的网络安全事件。 |
| 资源目录 | 1 | 本方案需要开通资源目录服务，用于构建符合企业业务关系的资源目录结构。 |

### 部署资源


规划好资源后，请按照以下步骤部署方案中的所有资源。

#### 部署资源目录

开通资源目录的阿里云账号默认为资源目录的管理账号，具有管理资源目录的所有权限，承担对资源目录中的所有业务账号及其下资源的管理责任。建议您使用企业管理员账号开通资源目录，然后通过委派管理员账号，将组织管理任务与业务管理任务相分离，企业管理账号执行资源目录的组织管理任务，委派管理员账号执行可信服务的业务管理任务。

1. 使用管理账号登录[资源管理控制台](https://resourcemanager.console.aliyun.com/)。
2. 开通资源目录。
   
   1. 在左侧导航栏，选择**资源目录** > **概览**，单击**开通资源目录**。
   2. 选择**使用当前账号开通**，然后单击**开通**。
   3. 在**安全校验**对话框中，通过手机号码或电子邮箱完成安全验证，然后单击**确定**。
      
      开通资源目录后，系统会为您创建一个 **Root** 资源夹，并将当前的登录账号设置为管理账号。同时，系统会在管理账号内自动创建一个服务关联角色（AliyunServiceRoleForResourceDirectory），用于设置资源目录可信服务的访问权限。关于服务关联角色的更多信息，请参见[资源目录中的 RAM 角色](https://help.aliyun.com/zh/resource-management/security-and-compliance/ram-roles-in-a-resource-directory#concept-2469063)。
3. 邀请资源目录的成员账号。
   
   1. 在左侧导航栏，选择**资源目录** > **邀请成员**。
   2. 在**邀请成员**页面，单击**邀请成员**。
   3. 在**邀请成员**面板，填写**邀请的账号 UID/账号登录邮箱**为阿里云账号 A 的 ID 和阿里云账号 B 的 ID，确认并勾选风险提示。
      
      此处邮箱是注册账号时的登录邮箱，而非注册账号后绑定的备用邮箱。您可以一次性输入多个阿里云账号实现批量邀请，使用半角逗号（,）分隔。
   4. 单击**确定**。
4. 委派购买了云防火墙实例的账号为委派管理员。本方案以阿里云账号 A 为例。
   
   1. 在左侧导航栏，选择**资源目录** > **可信服务**。
   2. 在**可信服务**页面，找到**云防火墙**产品，在**操作**列单击**管理**。
      
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3791082961/p709716.png)
   3. 在**委派管理员账号**区域，单击**添加**。
   4. 在**委派管理员账号**面板，选中阿里云账号 A 账号。
   5. 单击**确定**。
      
      添加成功后，使用该委派管理员账号访问对应可信服务的多账号管理模块，即可进行资源目录组织范围内的管理操作。
#### 通过 ROS 一键部署 VPC 和 ECS

参考以下步骤，分别在账号 A 和账号 B 下各创建一个 VPC 和 ECS，并且为 ECS 绑定 EIP。

**方案资源配置**

执行一键部署操作后，您将创建以下资源：

* **专有网络 VPC**
  
  | **项目** | **说明** | **示例值** |
  | --- | --- | --- |
  | 专有网络名称 | 建议您在部署过程中新建一个 VPC 作为本方案的专有网络。部署过程中填写 VPC 名称即可创建对应名称的 VPC。  长度为 2~128 个字符，以英文大小字母或中文开头，可包含数字、下划线（\_）和连字符（-）。 | VPC-1 |
  | IPv4 网段 | 在创建 VPC 时，您必须按照无类域间路由块（CIDR block）的格式为您的专有网络划分私网网段。阿里云 VPC 支持的网段信息请参见[专有网络组成部分](https://help.aliyun.com/zh/vpc/product-overview/virtual-private-cloud-overview/#section-w1b-tvz-ndb)。  在网络规划时可以按照管理网段-开发网段-测试网段-生产网段等规则做好规划。网段一旦投入使用，调整过程复杂，因此规划十分重要。 | 192.168.0.0/16 |
* **交换机**
  
  | **项目** | **说明** | **示例值** |
  | --- | --- | --- |
  | Vswitch 名称 | 建议您在部署过程中在新建的 VPC 内创建虚拟交换机。部署过程中填写交换机名称即可创建对应名称的虚拟交换机。  长度为 2~128 个字符，以英文大小字母或中文开头，可包含数字、下划线（\_）和连字符（-）。 | vsw\_001 |
  | 可用区 | 在规划的地域内选择可用区，虚拟交换机将部署在选择的可用区。  建议选择排序靠后的，一般此类可用区较新。新可用区资源更充沛，新规格也会在新的可用区优先上线。 | 可用区 H |
  | IPv4 网段 | 每台虚拟交换机需要一个 IPv4 网段。 | 192.168.1.0/24 |
* **云服务器 ECS**
  
  | **项目** | **说明** | **示例值** |
  | --- | --- | --- |
  | 实例名称 | 自定义 ECS 实例名称。 | ECS-1 |
  | 可用区 | 选择 VPC 交换机所属的可用区。 | 可用区 H |
  | 支付方式 | ECS 实例的计费方式。  ECS 计费的详细信息请参见 [ECS 计费方式概述](https://help.aliyun.com/zh/ecs/overview-of-billing-methods)。 | 按量付费 |
  | 实例规格 | ECS 的实例规格及内核、vCPU 数量。关于ECS 选型的最佳实践请参见[实例规格选型指导](https://help.aliyun.com/zh/ecs/user-guide/best-practices-for-instance-type-selection)。 | 突发性能实例 t5 |
  | 镜像 | ECS 的“装机盘”，为 ECS 实例提供操作系统、预装软件等。 | CentOS |
  | 镜像版本 | 镜像的版本。 | CentOS 7.6 64 位 |
  | 系统盘类型 | 硬盘类型。 | SSD 云盘 |
  | 系统盘容量 | 硬盘容量。 | 20 GiB |
  | 公网 IP | 用于云服务器 ECS 访问互联网。 | 分配公网 IPv4 地址 |
  | 带宽计费方式 | 选择按使用流量，表示按实际使用的流量计费。 | 按使用流量 |
  | 带宽峰值 | 选择流量峰值。 | 1 Mbps |
  | 安全组 | 新建一个安全组，默认放行 22 端口和 80 端口。 | SecurityGroup\_1 |

1. 使用阿里云账号 A 登录[阿里云控制台](https://homenew.console.aliyun.com/)。
2. 单击[一键部署模板（账号 A）](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20230823/xysq/CFWmultiAccountDemo_01.json&isSimplified=true)进入 ROS 控制台，在顶部选择**华东 1（杭州）**。
3. 查看模板参数，配置以下参数，其他参数可使用默认值或按需修改。
   
   * 实例规格：选择 x86 计算架构、共享型的**突发性能实例 t5**。
   * 系统盘类型：选择 **SSD 云盘**。
   * 实例密码：自定义 ECS 实例的登录密码。
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9124572961/p709611.png)
4. 查看页面右下角的资源价格，确认无误后单击**创建**。
   
   等待资源栈创建，资源部署时间约为 10 分钟，请耐心等候。当资源栈状态显示为**创建成功**时，即为成功部署相关资源。
5. 使用阿里云账号 B 登录[阿里云控制台](https://homenew.console.aliyun.com/)，单击[一键部署模板（账号 B）](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/en-US/20230823/ecbk/CFWmultiAccountDemo_02.json&isSimplified=true)进入 ROS 控制台，参考上述步骤创建资源栈。
#### 开通云防火墙包年包月版

1. 使用阿里云账号 A 访问[云防火墙购买页](https://common-buy.aliyun.com/?&commodityCode=vipcloudfw#/buy)。
2. 选择**付费模式**为**包年包月**。
   
   目前仅云防火墙包年包月版支持开通多账号统一管理，云防火墙按量付费版暂不支持。
3. 按照业务需求，配置如下购买项。
   
   | **项目** | **说明** | **示例** |
   | --- | --- | --- |
   | 当前版本 | 选择云防火墙的版本。不同的版本支持的功能不同，您可以单击某个版本，在**版本描述**下查看当前版本的功能说明。更多信息，请参见[功能特性](https://help.aliyun.com/zh/cloud-firewall/cloudfirewall/functions-and-features#concept-xn2-hlj-bfb)。  关于不同版本的定价信息，请参见[包年包月](https://help.aliyun.com/zh/cloud-firewall/cloudfirewall/product-overview/subscription#concept-twk-1lk-bfb)。 | 高级版 |
   | 可防护公网 IP 数 | 互联网边界隔离防护支持添加保护的公网 IP 的数量。 | 20 个 |
   | 公网流量处理能力 | 云防火墙可以防护的公网方向的流量峰值，建议与您业务的公网带宽保持一致。 | 10 Mbps |
   | 访问控制全局扩展 | 支持的访问控制策略授权规格。 | 0 |
   | 多账号统一管理 | 是否开通多账号统一管理。 | 是 |
   | 多账号管控数 | 支持添加阿里云成员账号的数量。 | 2 |
   | 日志分析 | 是否开启日志分析功能。  云防火墙默认存储最近 7 天的日志，如果需要存储更长时间的日志或满足等保要求，您需要开启云防火墙的即日志分析功能。 | 否 |
   | 购买时长 | 服务购买时长。根据您的实际需求开启**到期自动续费**。 | 1 个月 |
4. 单击**立即购买**并完成支付。
### 配置云防火墙多账号统一管理

15

完成资源目录配置后，您可以通过云防火墙控制台添加资源目录下的成员账号到云防火墙的成员账号列表，然后您可以直接在云防火墙控制台查看成员账号的云资源、配置跨账号云资源流量访问控制等。

#### 1. 添加云防火墙成员账号

1. 使用阿里云账号 A 登录[云防火墙控制台](https://yundun.console.aliyun.com/?p=cfwnext)。
2. 在左侧导航栏，选择**设置** > **统一账号管理**。
3. 在**统一账号管理**页面，单击**添加成员账号**。
4. 在**添加成员账号**对话框，将阿里云账号 B 的 ID 添加到右侧**已选导入云防火墙成员账号**列表。
5. 在右侧**已选导入云防火墙成员账号**列表，选择阿里云账号 B 的 ID，单击**确定**。
   
   完成添加成员账号后，默认授权云防火墙可以访问成员账号下的云资源。
#### 2. 开启互联网边界防火墙

如果您在开启**新增资产自动保护**功能，则无需执行此步骤，云防火墙自动开启 ECS 资产防护。

1. 使用阿里云账号 A 登录[云防火墙控制台](https://yundun.console.aliyun.com/?p=cfwnext)。
2. 在左侧导航栏，单击**防火墙开关**。
3. 在**互联网边界防火墙**页签，单击**同步资产**，系统为您同步当前账号及其成员账号的资产信息。整个过程预计需要 1~2 分钟。
   
   您可以通过 **IP** 列的 **UID** 信息，判断当前资产所属的阿里云账号。
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3791082961/p710257.png)
4. 在资产列表中找到需要开启防护的云资产，在**操作**列单击**开启保护**。
   
   开启互联网边界防火墙后，**防火墙状态**更新为**保护中**，表示互联网边界防火墙的防护已生效。
#### 3. 配置访问控制策略

通过创建访问控制策略，管控 ECS 访问公网流量。按照本方案架构，ECS-1 可以访问互联网，ECS-2 无法访问互联网。云防火墙互联网边界访问控制策略默认放行所有流量，因此您只需要创建拦截 ECS-2 访问互联网的流量策略即可。

1. 使用阿里云账号 A 登录[云防火墙控制台](https://yundun.console.aliyun.com/?p=cfwnext)。
2. 在左侧导航栏，选择**访问控制** > **互联网边界**。
3. 在**出向**页签，单击**创建策略**。
4. 在**创建出向策略**面板，设置策略，然后单击**确定**。
   
   | **配置项** | **说明** | **示例值** |
   | --- | --- | --- |
   | **源类型** | 选择访问源的类型，本方案中为 ECS-2 的对外访问类型。 | IP |
   | **访问源** | 输入 ECS-2 的公网 IP 地址。 | 47.111.XX.XX/32 |
   | **目的类型** | 选择目的地址类型。 | IP |
   | **目的** | 设置接收流量的目的地址。 | 0.0.0.0/0 **说明**  0.0.0.0/0 表示所有主机的IP 地址。 |
   | **协议类型** | 设置该内到外访问流量的协议类型。 | ANY |
   | **端口** | 设置需要放开或限制的端口。 | 0/0 **说明**  0/0 表示主机的所有端口。 |
   | **应用** | 设置该内到外访问流量的应用类型。 | ANY |
   | **动作** | 设置允许或拒绝该流量通过互联网边界防火墙。 | 拒绝 |
   | **优先级** | 选择该策略的优先级，默认为最后，表示优先级最低。 | 最后 |
   | **启用状态** | 设置策略是否启用。 | 启用 |
### 完成及清理

15

#### 方案验证

**一、通过查看云防火墙开关配置界面，验证云防火墙统一管理的有效性**

1. 使用阿里云账号 A 登录[云防火墙控制台](https://yundun.console.aliyun.com/?spm=a2c4g.2509670.0.0.7ee74759spcwaE&p=cfwnext)。
2. 在左侧导航栏，单击**防火墙开关**，在**互联网边界防火墙**页签，点击 IPV4，查看当前账号及其成员账号的资产信息。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7371098271/p859112.png)![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7371098271/p859113.png)

**二、通过 Ping 命令，验证访问控制策略的有效性**

1. 使用阿里云**账号 A** 登录 [ECS 管理控制台](https://ecs.console.aliyun.com/)。在顶部菜单栏，选择 ECS 实例所在的地域
2. 在左侧导航栏，选择**实例与镜像>实例**。
3. 找到 ECS 实例，在**操作**列单击**远程连接**，选择**通过 Workbench 远程连接**方式连接 ECS 实例。
4. 在 ECS 实例上通过`ping`互联网域名或 IP（例如`ping aliyun.com`），可看到阿里云**账号 A** 下的 ECS-1 可以正常访问互联网。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7371098271/p859151.png)
5. 同样的步骤使用阿里云**账号 B** 登录 [ECS 管理控制台](https://ecs.console.aliyun.com/),执行`ping`互联网域名命令，可看到 ECS-2 无法访问互联网。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7371098271/p859146.png)
#### 清理资源

测试完方案后，您可以参考以下方式处理对应产品的实例，避免继续产生费用：

1. 释放资源目录服务：
   
   资源目录为免费产品，开通后即可正常使用，不收取任何费用，您无需手动释放。
2. 释放云防火墙包年包月版：
   
   * 退订资源：如果您开通实例未超过 5 天，并且满足五天无理由全额退订条件，您可以访问[费用与成本](https://billing-cost.console.aliyun.com/refund/refund)，在**订购订单** > **资源退订**页面，申请无理由全额退款。更多信息，请参见[自助退订](https://help.aliyun.com/zh/cloud-firewall/cloudfirewall/refunds)。
   * 自动释放：云防火墙包年包月版到期后，实例将停止服务，并且在到期后 7 天自动释放实例。
   * 手动释放：在云防火墙实例到期前 15 日~到期后 7 日期间，您可以登录[云防火墙控制台](https://yundun.console.aliyun.com/?p=cfwnext)，在**概览**页面右上角，选择****更多**** > ****提前释放****。提前手动释放云防火墙包年包月版不提供退款。
3. 释放的云服务器 ECS 实例、专有网络 VPC：
   
   分别使用阿里云账号 A、阿里云账号 B 登录[资源编排控制台](https://ros.console.aliyun.com/overview)，在[资源栈](https://ros.console.aliyun.com/cn-hangzhou/stacks?resourceGroupId=)页面，找到资源栈，然后在**操作**列单击**删除**，按照界面提示释放实例。
