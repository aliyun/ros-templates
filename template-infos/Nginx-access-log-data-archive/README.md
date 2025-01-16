## 方案概览

随着业务增长，您的应用访问日志数据量可能会激增，因此需要将历史数据进行整理和压缩，从而节省存储成本和优化磁盘空间的利用率，并方便后续的管理和分析。

本技术解决方案以Nginx访问日志数据归档为例，为您演示：

* 如何搭建一个Nginx访问日志数据采集和归档服务
* 模拟Nginx访问日志数据归档，观察归档后的日志

### 方案架构

方案提供的默认设置完成部署后在阿里云上搭建的网站运行环境如架构图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与架构图相似。


本方案的技术架构包括以下基础设施和云服务：

* 云服务器ECS：部署Nginx服务。
* 日志服务SLS：采集并分析云服务器ECS产生的日志数据。
* 对象存储OSS：归档日志服务采集的日志数据。

## 方案部署

### 部署准备

开始部署前，请按以下指引完成账号申请、账号充值、RAM用户创建和授权。

#### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。

   1. 为节省成本，本方案默认选择使用按量付费及抢占式资源，使用按量付费资源需要确保账户余额不小于100元。
   2. 完成本方案的部署及体验，预计产生费用不超过1元（假设您选择最低规格资源，且资源运行时间不超过30分钟。如调整了资源规格，请以控制台显示的实际报价以及最终账单为准）。

      ![2023-08-18_15-09-40.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8893062961/p707920.png)
3. 创建用于方案部署的RAM用户。

   1. 创建1个RAM用户。具体操作，请参见[创建RAM用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)。
   2. 为RAM用户授予以下云服务的访问权限以完成方案部署。具体操作，请参见[为RAM用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。


      | **云服务**            | **需要的权限**         | **描述**                                        |
      | --------------------- | ---------------------- | ----------------------------------------------- |
      | 云服务器ECS           | AliyunECSFullAccess    | 管理云服务器ECS的权限                           |
      | 专有网络VPC           | AliyunVPCFullAccess    | 管理专有网络VPC的权限                           |
      | 日志服务SLS           | AliyunLogFullAccess    | 管理日志服务SLS的权限                           |
      | 对象存储OSS           | AliyunOSSFullAccess    | 管理对象存储OSS权限                             |
      | 资源编排服务ROS       | AliyunROSFullAccess    | 管理资源编排服务ROS的权限                       |
      | 轻量消息队列（原MNS） | AliyunMNSFullAccess    | 管理轻量消息队列(原MNS)的权限                   |
      | 运维编排服务OOS       | AliyunOOSFullAccess    | 管理运维编排服务OOS的权限                       |
      | 配额Quotas            | AliyunQuotasFullAccess | 管理配额Quotas的权限                            |
      | 访问控制RAM           | AliyunRAMFullAccess    | 管理访问控制RAM的权限，即管理用户以及授权的权限 |
      | 标签服务TAG           | AliyunTagManagerAccess | 管理标签服务TAG的权限                           |

### 一键部署

---

您可以通过下方提供的 ROS 一键部署链接，来自动化地完成这些资源的创建和配置：

* 1个专有网络VPC。
* 1台交换机。
* 1台云服务器ECS。
* 1个日志服务SLS Project。
* 1个对象存储OSS Bucket。

1. 打开[一键配置链接](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/Nginx-access-log-data-archive.yml&pageTitle=应用日志数据归档&disableRollback=false&isSimplified=true&productNavBar=disabled)，并选择地域。
2. 在**配置模板参数**页面修改资源栈名称，配置ECS实例、SLS Project和LogStore、OSS Bucket。填写完所有必选信息并确认后单击**创建**开始一键配置。

   **说明**

   如控制台提示出现如下提示，您需要点击**立即修复**，跳转开通相关服务后，再返回刷新弹窗，点击**继续创建**，继续创建资源栈。

   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2779378961/p733479.png)

   需要注意的是，中断后继续创建有可能会出现日志项目、日志库、存储空间名称重复的报错，建议您修改后再执行操作。
3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。

   ![p733488.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6080478961/p733492.png)

### 验证及清理

#### 方案验证

**一、通过查看OSS中的归档日志，验证日志归档功能**

完成部署后，可以在OSS中查看归档后的Nginx访问日志。

1. 登录[OSS管理控制台](https://oss.console.aliyun.com/overview)。
2. 在左侧导航栏，选择**Bucket列表**。
3. 在**Bucket列表**页面，单击创建的Bucket。
4. 在左侧导航栏，选择**文件管理 > 文件列表**。

   在app01目录下，可以看到Nginx访问日志文件。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2122607271/p852020.png)

**二、通过对比日志服务和ECS中的日志信息，验证日志采集与存储**

1. 登录[日志服务控制台](https://sls.console.aliyun.com/lognext/profile)，选择之前创建的项目app01，然后选择日志库app01，在当前页面可以看到采集到的日志信息。
![image (1)](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2122607271/p852021.png)

2. 打开[ECS控制台](https://ecs.console.aliyun.com/home)，重置实例密码后，通过**Workbench远程连接**登录ECS服务器，执行以下命令可以查看Nginx日志文件的大小。

```
ls -lh /var/log/nginx/access.log
```

对比OSS中存储的压缩文件，可以看到日志在归档后节省了存储空间。

![image (2)](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2122607271/p852023.png)

**三、通过下载并解压归档日志，验证日志还原功能**

从OSS下载已归档的日志文件，解压缩后打开内容如下。

```
{"__source__":"192.168.1.39","__tag__:__path__":"/var/log/nginx/access.log","time_local":"23/Sep/2024:10:56:00","remote_user":"-","request_method":"GET","__time__":"1727060160","status":"","remote_addr":"127.0.0.0","http_referer":"-","__tag__:__pack_id__":"334C07E6CE9342E3-2","request_length":"4897","body_bytes_sent":"","http_user_agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36","__tag__:__hostname__":"iZbp115tqn0z78hbsa33fkZ","request_time":"200","request_uri":"/"}
{"__tag__:__hostname__":"iZbp115tqn0z78hbsa33fkZ","request_method":"GET","http_referer":"-","remote_addr":"127.0.0.0","__tag__:__pack_id__":"334C07E6CE9342E3-3","request_time":"200","time_local":"23/Sep/2024:10:57:00","__tag__:__path__":"/var/log/nginx/access.log","__source__":"192.168.1.39","body_bytes_sent":"","request_length":"4897","status":"","__time__":"1727060220","request_uri":"/","remote_user":"-","http_user_agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36"}
{"request_length":"4897","time_local":"23/Sep/2024:10:58:00","__time__":"1727060280","__tag__:__path__":"/var/log/nginx/access.log","__tag__:__pack_id__":"334C07E6CE9342E3-4","http_user_agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36","remote_addr":"127.0.0.0","body_bytes_sent":"","__tag__:__hostname__":"iZbp115tqn0z78hbsa33fkZ","http_referer":"-","remote_user":"-","request_uri":"/","request_time":"200","status":"","__source__":"192.168.1.39","request_method":"GET"}
{"request_uri":"/","__tag__:__hostname__":"iZbp115tqn0z78hbsa33fkZ","__tag__:__pack_id__":"334C07E6CE9342E3-6","status":"","http_user_agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36","time_local":"23/Sep/2024:10:59:00","__source__":"192.168.1.39","body_bytes_sent":"","request_length":"4897","remote_addr":"127.0.0.0","remote_user":"-","request_time":"200","__time__":"1727060340","__tag__:__path__":"/var/log/nginx/access.log","request_method":"GET","http_referer":"-"}
```

解压后的日志文件包含了原始Nginx访问日志的所有关键字段，并且字段内容一致。

#### 清理资源

在本方案中，您创建了1台云服务器ECS实例、1个交换机、1个专有网络VPC、1个日志服务SLS Project、1个OSS Bucket。测试完方案后，您可以参考以下规则处理对应产品的实例，避免继续产生费用：

1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
2. 在左侧导航栏，选择**资源栈**
3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
