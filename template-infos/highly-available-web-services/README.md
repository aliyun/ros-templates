## 方案概览

随着业务规模的增长，数据请求和并发访问量增大、静态文件高频变更，企业需要搭建一个高可用和共享存储的网站架构，以确保网站服务能够7\*24小时运行的同时，可保障数据一致性和共享性，并降低数据重复存储的成本。

## 方案架构

方案提供的默认设置完成部署后在阿里云上搭建的高可用及共享存储Web服务运行环境如架构图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与架构图相似。


本方案的技术架构包括以下基础设施和云服务：

* 1个专有网络VPC：为负载均衡CLB、云服务器ECS、文件存储NAS等云资源形成云上私有网络。
* 2台交换机：将2台云服务器ECS连接在同一网络上，实现它们之间的通信，并提供基本的网络分段和隔离功能。
* 2台云服务器ECS：同地域不同可用区的2台ECS，组成一个高性能和高可用的后端服务。
* 1个公网负载均衡CLB：基于对流量按需分发的能力，可以将流量分发到不同的后端服务器，可消除系统中的单点故障，当某个服务器发生故障时，CLB会自动将请求分配到其他正常的服务器上，从而保证服务的连续性和稳定性。
* 2个文件存储NAS：实现多个Web服务器之间的数据共享和同步，确保数据的一致性。同时通过自动化脚本、inotify-tools和sync工具，实现主备NAS自动增量备份和主备自动切换。

## 方案部署
### 部署准备

开始部署前，请按以下指引完成账号申请、账号充值、RAM用户创建和授权。

### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   1. 为节省成本，本方案默认全部选择使用按量付费资源，使用按量付费资源需要确保账户余额不小于100元。
   2. 完成本方案的部署及体验，预计产生费用不超过5元（假设您选择本文示例规格资源，且资源运行时间不超过60分钟。实际情况中可能会因您操作过程中实际使用的流量差异，会导致费用有所变化，请以控制台显示的实际报价以及最终账单为准，如下表格仅供参考）。
      
      | **序号** | **产品** | **计费项** | **规格** | **地域** | **预估费用参考** |
      | --- | --- | --- | --- | --- | --- |
      | 1 | 云服务器 ECS | ECS\_01配置费 | * 实例：ecs.u1-c1m1.large（2 vCPU 2 GiB，抢占型实例） * 系统盘：ESSD云盘 40GiB | 华东1（杭州） | 0.376/元/时 |
      | 2 | ECS\_02配置费 | 华东1（杭州） | 0.376/元/时 |
      | 2 | 专有网络 VPC | 公网流量费 | 按使用流量计费：带宽峰值5 Mbps | 华东1（杭州） | 0.800元/GB |
      | 3 | 文件存储 NAS | nas\_master存储容量费 | 通用型NAS | 华东1（杭州） | 0.35元/GB |
      | 4 | nas\_backup存储容量费 | 0.35元/GB |
      | 4 | 传统型负载均衡 CLB | CLB LCU费 | 按使用量计费 | 华东1（杭州） | 0.017元/小时 |
      | CLB实例费 | 按使用量计费 | 华东1（杭州） | 0.042元/LCU |
3. 阿里云账号拥有操作资源的最高权限，从云资源安全角度考虑，建议您创建一个RAM用户，使RAM用户仅能操作有限的资源，然后由RAM用户完成本方案。
   
   1. 访问[RAM控制台-用户页面](https://ram.console.aliyun.com/users/)，单击**创建用户**，填写相关信息，勾选**控制台访问**和**OpenAPI 调用访问**，创建一个RAM用户。
   2. 单击已创建的RAM用户**操作**列的**添加权限**，选择授权范围为指定资源组（例如`高可用测试资源组`），然后授权。以下为本解决方案所需权限策略，您也可以根据需要适当调整。
      
      | **授权范围** | **授权策略** | **描述** |
      | --- | --- | --- |
      | 整个云账号 | AliyunECSFullAccess | 管理云服务器ECS的权限 |
      | AliyunSLBFullAccess | 管理负载均衡服务的权限 |
      | AliyunVPCFullAccess | 管理专有网络VPC的权限 |
      | AliyunECSWorkbenchFullAccess | 使用ECS-Workbench的完整权限 |
      | AliyunROSFullAccess | 管理资源编排服务ROS的权限 |
      | AliyunNASFullAccess | 管理文件存储NAS的权限 |
### 规划网络和资源

#### 网络规划

请参考表格中的说明和方案默认示例值为每个规划项做详细规划并在实际部署时将默认示例值修改为您的实际规划。

| **规划项** | **数量** | **说明** |
| --- | --- | --- |
| 地域 | 1 | 您的云服务部署的地域。选择地域的基本原则请参见[地域和可用区](https://help.aliyun.com/document_detail/40654.html)。 |
| 专有网络VPC | 1 | 在部署过程中新建一个VPC作为本方案的专有网络。 |
| 交换机 | 2 | 本方案需要至少2台交换机，用来连接不同的云资源实例。 |
| 传统型负载均衡CLB | 1 | 本方案需要1台负载均衡CLB实例，用于对网站的多台云服务器进行流量分发。它可以通过流量分发扩展应用系统的服务能力，消除单点故障，提升应用系统的可用性。 |
| 公网IP | 1 | 创建负载均衡CLB实例时，选择公网类型，自动为负载均衡CLB实例创建1个公网IP。 |
| 安全组 | 1 | 用于限制专有网络VPC下云服务器ECS的网络流入和流出规则。 |

#### 规划云资源

请参考表格中的说明和方案默认示例值为每个规划项做详细规划并在实际部署时将默认示例值修改为您的实际规划。

| **规划项** | 数量 | **说明** |
| --- | --- | --- |
| 云服务器 ECS | 2 | 本方案需要2台ECS实例，用于同时部署Web服务。 |
| 文件存储 NAS | 2 | 本方案需要2个通用型NAS文件系统，实现共享存储和NAS多可用区容灾。 |

### 一键部署

本文将通过资源编排ROS实现一键自动化完成本教程所需资源的创建和配置：

* 创建1个专有网络VPC。
* 创建2台交换机。
* 创建一个安全组并配置安全组规则。
* 创建2个抢占式云服务器ECS，并部署Web服务。
* 创建1个公网传统型负载均衡CLB，并挂载这2台ECS作为后端服务器。
* 创建2个不同可用区的通用型NAS文件系统。
* 通过inotify-tools和sync工具和自动化脚本，实现主备NAS增量备份和主备切换。
  
  **主备NAS增量备份和主备切换脚本说明**
  
  您可访问以下路径查看脚本详细信息：
  
  + 增量备份脚本：`/etc/systemd/system/sync_nas.sh`
    
    Master NAS有数据变化时，自动同步到Backup NAS。
  + 主备切换脚本：`/etc/systemd/system/sync_check_switch.sh`
    
    自动检测Master NAS是否可用，若可用则使用Master NAS，否则自动切换到备用NAS；Master NAS恢复后，自动切换回Master NAS。**重要** 
  
  当前NAS容灾备份方案是一个最简单的示例和基本思路，还存在一些局限性，需要用户您结合自身业务去做一些完善和补充。
  
  例如，当前NAS容灾备份方案是单向的（Master -> Backup），在真实的业务场景中，如果文件不只是读，还有写操作的情况下，Master NAS出现故障后，需要结合自身业务做一些额外的策略：
  
  + 如果对于写的可用性要求不高，可以在切换到Backup NAS时，禁止写入文件。
  + 如果对于写有可用性要求，那么在Master NAS故障恢复后，不应该立即将 ECS 应用的操作文件目录切换到Master NAS的挂载点目录上，应该先将故障期间，Backup NAS上产生的新文件，同步到Master NAS之后，再做切换，并且要确保切切换期间，Backup NAS上不要产生文件变更，或者产生的文件变更也能同步到Master NAS中。

#### 操作步骤

1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/highly-available-web-services.yml&hideStepRow=true&pageTitle=高可用及共享存储Web服务&isSimplified=true&disableNavigation=true&productNavBar=disabled)，在页面左上角选择地域（本文示例：华东1（杭州））。
2. 在**配置模板参数**页面修改资源栈名称，选择ECS实例和NAS可用区、选择ECS实例规格、配置ECS实例密。填写完所有必选信息并确认后单击**创建**开始一键配置。
3. 当**资源栈信息**页签的状态栏变成**创建成功**时，表示已完成资源创建和模型部署。
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0784862961/p709073.png)
4. 单击**输出**页签，可查看并访问已创建资源，以便验证方案。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8216485171/p801017.png)
### 完成及清理

#### 方案验证

**一、****通过ECS停机模拟服务器故障，验证服务高可用**

可以通过停机一台ECS模拟故障进而验证服务的可用性。操作如下：

1. [登录云服务器管理控制台](https://ecs.console.aliyun.com/?spm=a2c4g.2400018.0.0.1ab95945VgCL3E)，选择**概览**，在资源列表选择一台ECS实例（假设为ECS\_01），单击**停止**。
2. 等ECS状态为**已停止**后，输入负载均衡公网IP访问网站，能正常访问网站，则表明服务高可用。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6392186271/p851599.png)

3. 打开[传统型负载均衡（CLB）控制台](https://slb.console.aliyun.com/slb)，可以看到当前负载均衡实例的“健康检查”提示异常，显示一台后端服务器检测到故障，但这并不影响用户的使用体验。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6392186271/p851601.png)

**二、****通过文件同步测试，验证共享存储功能**

1. 打开[云服务器管理控制台](https://ecs.console.aliyun.com/)，启动先前停机的ECS实例，然后点击远程连接。在命令行中输入以下命令：`echo "Test content" > /nas_master/testfile.txt`。
2. 远程连接另一台ECS实例，检查 /nas\_master 路径下的文件是否同步更新，输入以下命令：`cat /nas_master/testfile.txt`。

![image (1)](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6392186271/p851605.png)

挂载NAS文件系统的路径为 /nas\_master 和 /nas\_backup。在其中一台ECS实例上更新、新增或删除文件，另一台ECS实例对应路径下的文件也应同步更新。若文件同步更新，则表明存储共享已成功，确保了数据的一致性和共享性。

**三、****通过主备切换，验证NAS容灾高可用性**

1. [打开NAS控制台](https://nasnext.console.aliyun.com/)，点击**文件系统 > 文件系统列表**，找到Maser NAS的文件系统，点击操作栏中的**管理**。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6392186271/p851618.png)

2. 在管理页面中，点击左侧导航栏中的**挂载使用**，参考[管理挂载点](https://help.aliyun.com/zh/nas/user-guide/manage-mount-targets#section-bqs-vnm-hfb)移除当前挂载。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6392186271/p851621.png)

3. 约4秒后，再次输入负载均衡公网IP访问网站，若网站能正常访问，则表明已成功从主NAS切换至备份NAS，验证了NAS的容灾高可用性。

**重要** 

* NAS容灾恢复策略需要结合业务定制，本文只是简单的示例参考。
* 若移除挂载点后，出现无法重新挂载文件系统至ECS的情况，可尝试执行`sudo umount -f <挂载地址>`或重启ECS后，再添加挂载点并将文件系统挂载至ECS。[如何添加挂载点？](https://help.aliyun.com/zh/nas/user-guide/manage-mount-targets#section-6xi-a3u-zkq)
#### 清理资源

1. 登录[资源编排管理控制台](https://ros.console.aliyun.com/)，左侧导航栏菜单选择**资源栈**。
2. 在页面的顶部选择部署的资源栈所在地域，找到部署的资源栈。单击其右侧**操作**列的**删除**并确认，可一键删除一键配置所创建的资源。
