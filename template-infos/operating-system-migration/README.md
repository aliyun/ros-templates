## **方案概览**

2020年12月08日，CentOS官方宣布了停止维护CentOS Linux的计划，并推出了CentOS Stream项目。阿里云上CentOS Linux公共镜像来源于CentOS官方，当CentOS Linux停止维护后，阿里云将会同时停止对该操作系统的支持。操作系统停止维护会带来一系列安全的影响。操作系统迁移方案主要适用于以下应用场景：

* 操作系统结束生命周期，后续想得到维护和技术支持
  
  CentOS官方宣布了停止维护CentOS Linux的计划，如果您的操作系统后续想得到维护和技术支持，需要将CentOS操作系统变更为其他Linux LTS发行版。
* 架构优化
  
  当前操作系统无法满足业务需求，需要重新变更架构，提高系统的可靠性和性能。例如：当前的操作系统可能与某些软件、硬件或其他设备不兼容。

本方案将以一个部署了WordPress的云服务器为例，为您演示如何通过服务器迁移中心SMC来为ECS迁移操作系统，并保持原有应用正常运行。

### **方案架构**

方案提供的默认设置完成部署后在阿里云上搭建的网站运行环境如下图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与下图相似。

![操作系统迁移.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4739723961/p712232.png)

本方案的技术架构包括以下基础设施和云服务：

* 1个专有网络VPC：为云服务器ECS形成云上私有网络。
* 1台云服务器ECS：用于安装被迁移的操作系统。
* 服务器迁移中心SMC：用于创建管理迁移任务。
* 云盘快照服务：用于迁移前对ECS进行备份。

## **方案部署**
### **部署准备**


开始部署前，请按以下指引完成账号申请、账号充值、相关服务开通、RAM用户创建和授权。

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   1. 为节省成本，本方案默认全部选择使用按量付费资源，使用按量付费资源需要确保账户余额不小于100元。
   2. 完成本方案的部署及体验，预计费用不会超过1元（假设您选择1核2G规格的ECS，资源运行不超过 1 小时，且体验完后删除ECS快照。实际可能会因您操作过程中使用的资源规格和流量差异，导致费用有所变化，请以控制台显示的实际报价和最终账单为准）
3. 开通服务
   
   首次使用SMC，请登录[SMC控制台](https://smc.console.aliyun.com/)根据页面提示：
   
   1. **开通RAM服务并授权**
   2. **开通快照服务**
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9030009071/p769594.png)
### **准备迁移源**


您可以通过如下步骤，创建一个CentOS 7镜像且运行WordPress网站的ECS实例。

1. 单击[一键部署链接](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?productNavBar=disabled&templateUrl=https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20230704/kunb/wordpress-centos7.yml&isSimplified=true)进入ROS控制台，并根据需要选择地域。
2. 根据ROS控制台上的指引，选择新建ECS并部署WordPress（或在已有的ECS实例上部署WordPress）。
3. 确认信息无误后单击**创建**。然后等待资源栈状态显示为**创建成功**。（如您在已有ECS实例上部署，创建时间约为10分钟，您可以开启页面右上角的**自动刷新**开关，实时跟进创建进度）
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1744054961/p718827.png)
4. 资源栈创建成功后，单击**输出**页签，并在**输出关键字**列表中找到**ECSWordPressUrl**参数对应的值，单击进入WordPress网页，并根据指引完成 WordPress 网站的初始化。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2268416071/p762253.png)
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1744054961/p718830.png)
5. 根据提示完成注册安装后，填写上一步注册的邮件和密码登录WordPress管理后台。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868258.png)
6. 点击管理页面左上角站点图标，进入网站浏览。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868274.png)![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868276.png)可看到网站安装成功，并且成功访问。
### **迁移操作系统**


#### 迁移实施

在创建完ECS服务器后，您可以参考以下步骤，通过服务器迁移中心SMC实施操作系统迁移。

1. 登录[SMC控制台](https://smc.console.aliyun.com/)。
2. 在左侧导航栏，单击**操作系统迁移**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868286.png)
3. 在操作界面左侧，单击**开始迁移**，在弹出的选项框中，选中您部署WordPress的ECS服务器，单击**前期检测**。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868297.png)
4. 在弹出的在**操作系统迁移**确认表中，勾选相关授权按钮，单击下一步，进入迁移设置。
5. 在**迁移设置**选择框中，按如下图配置，选择要切换的**目标操作系统**，**检测是否可以迁移，**等迁移检测结果为可迁移时，最后点击**确定迁移。**![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868335.png)
   
   * **源操作系统**：默认显示当前操作系统，不可修改。例如：CentOS 7。
   * **目标操作系统**：在下拉列表中选择目标操作系统。例如：Alibaba Cloud Linux 3。
6. 创建迁移任务成功后，点击关闭，任务自动执行中，浏览器刷新当前页面，即可看到迁移任务执行状态。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868336.png)![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868338.png)
7. 待**迁移实时状态**进度为100%时，表示操作系统迁移已经成功。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868354.png)
#### 异常处理

如果需要回滚源系统云盘数据，您可以在快照列表使用自动备份的快照进行恢复数据。操作步骤如下：

1. 登录[ECS管理控制台](https://ecs.console.aliyun.com/)。
2. 在左侧导航栏，选择**存储与快照****>****快照**。
3. 在**云盘快照**页签下，在自动备份的快照**操作**列，单击**回滚磁盘**。
4. 在弹出的**回滚云盘**对话框中，单击**确定**。
#### 限制说明

如果您希望将已有的ECS实例作为迁移源，请在迁移前参考[SMC 操作系统迁移限制说明](https://help.aliyun.com/zh/ecs/user-guide/migrate-the-operating-system-of-an-ecs-instance-1#section-8bd-lsl-sft)，评估迁移可行性。

### **完成及清理**


#### **方案验证**

**一、通过监控迁移过程，验证迁移任务的执行状态**

1. 登录[SMC控制台](https://smc.console.aliyun.com/)，在左侧导航栏点击**操作系统迁移**，在任务界面点击迁移源id。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868415.png)
2. 在迁移任务选项卡中可看到迁移任务的完成状态，起止时间，以及目标ECS实例ID。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868420.png)
3. 登录[ECS控制台](https://ecs.console.aliyun.com)，在左侧导航栏选择快照选项，找到带有SMC标签的快照如下：![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868422.png)可看到迁移前已经对原操作系统版本数据做了备份，并上传至OSS,可确保迁移失败后的顺利还原。

**二、通过查看ECS控制台实例操作系统版本，验证操作系统迁移成功**

1. 登录[ECS控制台](https://ecs.console.aliyun.com)，在左侧导航栏选择实例，选择地域（示例为杭州），找到创建的ECS实例，查看操作系统版本是否已变更为目标操作系统。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868361.png)可看到当前操作系统已经变更为Alibaba Cloud Linux 3.2104 LTS 64位，迁移操作系统成功。

**三、通过访问之前的网站地址，验证迁移后网站连通性正常**

1. 等待 10 分钟左右，再次访问之前步骤中的WordPress网站地址，确认网站依然可以访问。
2. 登录[ECS控制台](https://ecs.console.aliyun.com)，在左侧导航栏选择实例，选择地域（示例为杭州），找到创建的ECS实例，复制公网IP地址,打开浏览器输入IP地址,访问之前创建WordPress网站。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868364.png)可看到网站正常访问，迁移操作系统成功，迁移后并未影响网站服务。
#### 清理资源

在本方案中，您创建了1台云服务器ECS实例、1个专有网络VPC、1个云盘快照。测试完方案后，您可以参考以下步骤，避免继续产生费用：

1. 释放一键部署创建的所有资源：访问[资源编排管理控制台](https://ros.console.aliyun.com/cn-hangzhou/stacks?resourceGroupId=)，找到对应资源栈，单击**删除**。
2. 释放1个云盘快照：登录[ECS控制台](https://ecs.console.aliyun.com)，在左侧导航栏，选择**存储与快照****>****快照**。在**云盘快照**页签下，在自动备份的快照**操作**列点击**删除**，按照界面提示释放实例。
