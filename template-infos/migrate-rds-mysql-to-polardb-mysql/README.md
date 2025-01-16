## 方案概览

PolarDB MySQL 版是阿里云自研的云原生数据库，产品基于云原生架构、计算存储分离、软硬件一体化设计，具有一写多读或多写多读、共享存储、60亿行数据稳定运行、秒级DDL、主从切换无闪断、闪回查询等持续为业务提供高价值的特性。

通过本方案，您可以体验如何在不修改任何应用代码的情况下，将 MySQL 数据库中的数据迁移至 PolarDB MySQL 版，借助 PolarDB 的超高弹性、性能、高可用高可靠等特性来应对业务高速增长带来的数据库压力。

**本迁移方案具有以下优势：**

* **零改造成本**
  
  + 100%兼容MySQL，您可以像使用MySQL一样使用PolarDB MySQL版
  + 可保留数据库原连接地址，无需应用程序修改任何连接配置即可切换至PolarDB
* **安全可靠**
  
  + 支持在线热迁移（增量实时同步），迁移过程仅闪断一次（即当业务从RDS切换至PolarDB时），业务停机时间<10分钟
  + 支持一键回滚，迁移失败可以在10分钟内恢复

### 方案架构

方案提供的默认设置（如地域、VPC、实例名称等）完成部署后在阿里云上运行环境如架构图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与架构图相似。


本方案的技术架构包括以下基础设施和云服务：

* 地域和可用区：RDS MySQL实例和PolarDB MySQL版实例必须在同地域，可用区无限制
* 1个专有网络VPC：升级后的PolarDB MySQL版实例将与升级前RDS MySQL实例使用同一个VPC网络
* 核心系统：
  
  + 1个ECS实例，用于部署MySQL客户端，模拟业务读写RDS MySQL数据库
  + 1个RDS MySQL实例，通过一键升级，切换至PolarDB MySQL实例
## 方案部署
### 部署准备


开始部署前，请按以下指引完成账号申请、账号充值、RAM用户创建和授权。

#### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   1. 为节省成本，本方案默认选择使用按量付费资源，使用按量付费资源需要确保账户余额不小于100元。
   2. 完成本方案的部署及体验，预计产生费用不超过20元（假设您选择下表中的相关规格资源，且运行时间不超过2小时，如果调整了资源规格，请以控制台显示的实际报价以及最终账单为准）。
      
      | **云服务** | **规格配置** | **地域** | **预估费用参考** |
      | --- | --- | --- | --- |
      | 云数据库 PolarDB | polar.mysql.x4.large | 华东2（上海） | 4.17 元/小时 |
      | 云数据库 RDS MySQL | mysql.n2.medium.2c | 华东2（上海） | 1.381 元/小时 |
      | 云服务器 ECS | ecs.g7.xlarge | 华东2（上海） | 配置费用：1.089 元/小时  公网流量费用：0.800 元/GB |
      | 按量费用：6.64 元/小时  公网流量费用：0.800 元/GB | | | |
3. 阿里云账号拥有操作资源的最高权限，从云资源安全角度考虑，建议您创建一个RAM用户，使RAM用户仅能操作有限的资源，然后由RAM用户完成本方案。
   
   1. 访问[资源组](https://resourcemanager.console.aliyun.com/resource-groups)页面，单击**创建资源组**，创建一个资源组，例如命名为`rds2polardb`。
   2. 访问[RAM控制台-用户](https://ram.console.aliyun.com/users)页面，单击**创建用户**，勾选**控制台访问**和**OpenAPI 调用访问**，填写其他信息，创建一个RAM用户。
   3. 访问[RAM控制台-权限策略](https://ram.console.aliyun.com/policies)页面，单击**创建权限策略**，单击**脚本编辑**，并复制粘贴以下内容，完成创建自定义权限策略。
      
      自定义权限策略
      
      ```
      {
          "Version": "1",
          "Statement": [
              {
                  "Effect": "Allow",
                  "Action": [
                      "polardb:Describe*",
                      "ecs:Describe*",
                      "vpc:Describe*",
                      "ros:*"
                  ],
                  "Resource": "*"
              }
          ]
      }
      ```
   4. 访问[RAM控制台-用户](https://ram.console.aliyun.com/users)页面，授予权限。
      
      1. 单击目标RAM用户**操作**列的**添加权限**，选择**授权范围**为**指定资源组**（例如`rds2polardb`），然后选择系统策略AliyunECSFullAccess、AliyunRDSFullAccess、AliyunVPCFullAccess和AliyunPolardbFullAccess，单击**确定**。
      2. 再次单击目标RAM用户**操作**列的**添加权限**，选择**授权范围**为**整个云账号**，然后选择前面创建的自定义权限策略，单击**确定**。
   5. 创建**AliyunServiceRoleForPolarDB**角色，用于PolarDB服务访问其他云服务资源。
      
      访问[RAM访问控制台-角色](https://ram.console.aliyun.com/roles)页面，单击**创建角色**，**角色类型**选择**阿里云服务**，**角色类型**配置为**服务关联角色**，**选择云服务**为**云数据库 PolarDB**，单击**完成**。**说明** 
   
   详细步骤参考：
   
   * 创建RAM用户的操作指引请参见[创建RAM用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)。
   * 为RAM用户授权的操作指引请参见[为RAM用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。
### 一键部署


资源编排（ROS）可以让您通过YAML或JSON文件清晰简洁地描述所需的云资源及其依赖关系，然后自动化地创建和配置这些资源。您可以通过下方提供的ROS一键部署链接，来自动化地完成这些资源的创建和配置。

本文介绍的ROS模板主要完成了以下内容：

* 部署1个专有网络VPC。
* 部署1台交换机。
* 部署1台云服务器 ECS。
* 部署1个云数据库 RDS MySQL实例。
* 已在RDS MySQL实例中写入测试数据。
* 部署1个从云数据库 RDS MySQL实例迁移生成的云数据库 PolarDB MySQL实例。

1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/migrate-rds-mysql-to-polardb-mysql.yml&pageTitle=RDS MySQL迁移至PolarDB MySQL版&disableRollback=false&isSimplified=true&productNavBar=disabled)前往ROS控制台，系统自动打开使用新资源创建资源栈的面板。
   
   **说明** 
   
   ROS控制台默认处于您上一次访问控制台时的地域，请根据您创建的资源所在地域修改地域后再执行下一步。
2. 确认好地域后（本文以**华东2（上海）**为例），在**配置模板参数**步骤中配置**资源栈名称**、**ECS**等配置。
   
   | **配置项** | **参数** | **说明** | **示例值** |
   | --- | --- | --- | --- |
   | **资源栈名称** | 资源栈名称 | ROS一键部署任务名称，可自定义。 | rds2polardb |
   | **基础配置** | 可用区ID | ECS、RDS和PolarDB资源所在的可用区，同一地域下，不同可用区内网互通，按需选择即可。 | 可用区L |
   | **ECS** | 实例类型 | ECS实例的架构、分类和规格配置。 | 架构：x86计算  分类：通用型  实例规格：ecs.g7.xlarge |
   | 系统盘类型 | ECS实例的硬盘类型。 | ESSD云盘 |
   | 实例密码 | ECS实例的密码。 | |
   | **RDS配置** | RDS实例规格 | RDS MySQL实例的规格。 | mysql.n2.medium.2c |
   | 实例存储 | RDS实例的存储空间。单位GB。 | 100 |
   | 数据库账号密码 | 数据库账号的密码。 | |
   | **PolarDB配置** | PolarDB集群规格 | PolarDB MySQL实例的规格。 | polar.mysql.x4.large |
3. 单击两次**下一步**，跳转至**配置资源栈（可选）**步骤，选择**资源组**为被授权的资源组（本文以`rds2polardb`为例）。
4. 单击**创建**，系统将自动创建并部署本教程所需的资源。
5. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
   **说明**
   创建时间较久，耗时约30分钟，请耐心等待。
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2992023961/p711825.png)

6. 单击资源页签，找到已创建的PolarDB实例，单击实例ID，进入PolarDB实例详情页，查看RDS实例的数据是否已存在。
### 迁移切换


当目标PolarDB集群的**复制延迟**小于60秒时，即可进行迁移切换操作。正式业务切换，建议选择业务低峰期进行。

1. 本方案通过持续写入RDS MySQL，并查看RDS MySQL和PolarDB MySQL两边的最新时间和数据量来观察切换带来的中断耗时。
   
   **说明** 
   
   一键部署完成后，会生成2个脚本可用于模拟业务持续写入RDS MySQL，并实时观察RDS MySQL和PolarDB MySQL两边的最新时间和数据量来观察切换带来的中断耗时。**2个脚本包含：loop\_insert\_query\_mysql.sh、loop\_query\_polardb.sh**，其中
   
   * loop\_insert\_query\_mysql.sh 主要用于模拟每隔5秒向RDS MySQL写入数据，并打印系统时间、数据写入时间、数据的总行数、PolarDB的版本等信息。
   * loop\_query\_polardb.sh 主要用于模拟每隔5秒查询PolarDB数据库，并打印系统时间、数据写入时间、数据的总行数、PolarDB的版本等信息。
   * 可通过PolarDB版本信息判断当前连接的是RDS MySQL还是PolarDB，如下
     
     ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3610574961/p719988.png)
     
     + 左边是RDS MySQL（无polardb\_version返回值），右边是PolarDB MySQL(polardb\_version非空）
2. 登录ECS
   
   1. 返回ECS实例列表页面，找到已创建的实例，单击对应**操作**列下的**远程连接**。
   2. 在弹出的**远程连接**对话框中，单击**通过Workbench远程连接**对应的**立即登录**。
   3. 在弹出的**登录实例**对话框中，输入登录信息，单击**确定**。
      
      * **用户名**：输入用户名（例如root）
      * **密码**：创建ECS实例时，在**登录凭证**处设置的**登录密码**。
3. 在ECS上，执行脚本模拟业务持续在RDS MySQL写入数据，并观察RDS MySQL和PolarDB MySQL两边的最新时间和数据量来观察切换带来的中断耗时。
   
   ```
   ~]# ls /root/*.sh
   /root/loop_insert_query_mysql.sh  /root/loop_query_polardb.sh
   -- A窗口
   ~]# sh /root/loop_insert_query_mysql.sh
   -- B窗口
   ~]# sh loop_query_polardb.sh 
   ```
   **说明** 
   * 为便于观察，建议开2个窗口对比观察，可参考
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3610574961/p719991.png)
4. 在**基本信息**页面的**RDS迁移功能**中，单击**迁移切换**。
   
   **说明** 
   
   本操作将交换源RDS实例和目标PolarDB集群的读写状态（即将源RDS实例修改为**只读**，将PolarDB集群修改为**可读可写**），同时会更换复制方向（即将PolarDB集群的新增数据同步到RDS实例）。
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9376193961/p715591.png)
   
   **警告** 
   
   您需要在30天内进行**完成迁移**操作。
5. 在**开始切换**对话框中，选择**带地址切换（应用程序不用改连接配置）**
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9376193961/p715594.png)
6. 在**基本信息**页的**RDS迁移功能**中，查看RDS至PolarDB的迁移状态。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5171690371/p869443.png)
7. 切换成功
   
   **说明** 
   * 本方案重点介绍在线不更改连接地址完成RDS MySQL一键升级至PolarDB MySQL
   * 影响中断时间的因素较多，实际生产业务升级中，切换过程一般小于5分钟。
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9376193961/p715622.png)
### 完成及清理

20

#### 方案验证

**一、通过查看RDS同步任务状态，验证迁移完成**

1. 登录[PolarDB控制台](https://polardb.console.aliyun.com/?spm=a2c4g.11186623.0.0.2c421133e6pESE)，在左侧导航栏，单击**集群列表**，在左侧顶部菜单栏，选择ROS创建的地域，点击创建的目标实例，进入基本信息页面，找到RDS迁移功能界面如下：![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5171690371/p869371.png)可看到RDS迁移功能状态已更新为数据库切换完成，源RDS读写状态变成只读，PolarDB读写状态为读写。
2. 点击DTS数据同步任务，进入到如下界面可以看到数据传输的状态：![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5171690371/p869372.png)
3. 点击对应任务id，进入到任务管理界面，在左侧导航栏**性能监控**如下：![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5171690371/p869374.png)可以看到PolarDB MySQL实例已经成为数据源端，迁移已经完成。

**二、通过执行写入数据脚本，验证迁移成功**

1. 登录[ECS管理控制台](https://ecs.console.aliyun.com/?spm=a2c4g.11186623.0.0.2c421133e6pESE)，找到创建的实例，单击对应**操作**列下的**远程连接**。
2. 在弹出的**远程连接**对话框中，单击**通过Workbench远程连接**对应的**立即登录**。
3. 在弹出的**登录实例**对话框中，输入登录信息，单击**确定**。
   
   **说明** 
   * **用户名**：输入用户名（例如root）
   * **密码**：创建ECS实例时，在**登录凭证**处设置的**登录密码**。
4. 在ECS上，执行脚本模拟业务持续在RDS MySQL写入数据，如下图所示：
   
   **重要** 
   
   一键部署完成后，会生成2个脚本包含：loop\_insert\_query\_mysql.sh、loop\_query\_polardb.sh
   
   * loop\_insert\_query\_mysql.sh 主要用于模拟每隔5秒向RDS MySQL写入数据，并打印系统时间、数据写入时间、数据的总行数、PolarDB的版本等信息。loop\_query\_polardb.sh 主要用于模拟每隔5秒查询PolarDB数据库，并打印系统时间、数据写入时间、数据的总行数、PolarDB的版本等信息。
   ```
   sh /root/loop_insert_query_mysql.sh
   ```
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5171690371/p869318.png)可看到目前已经链接至PolarDB实例，数据写入进PolarDB实例中。
5. 登录[PolarDB控制台](https://polardb.console.aliyun.com/?spm=a2c4g.11186623.0.0.2c421133e6pESE)，在左侧导航栏，单击**集群列表**，在左侧顶部菜单栏，选择ROS创建的地域，点击创建的目标实例，点击**登录数据库**按钮。
6. 在SQL Console界面，执行如下查询语句：
   
   ```
   SELECT * FROM  t_rds2polardb;
   ```
   
   可得到如下结果：![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5171690371/p869367.png)经查询可以看到通过在RDS MySQL实例写入的数据已经在PolarDB MySQL实例中。迁移成功。

#### 清理资源

在本方案中，您创建了1个专有网络VPC、1台交换机、1台ECS云服务器、1个云数据库 RDS MySQL 实例、1个云原生数据库 PolarDB MySQL 实例。测试完方案后，您可以在ROS控制台直接删除资源栈并删除相关资源。

