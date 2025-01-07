## **方案概览**

在面对大规模业务数据的在线统计分析需求时，传统的数据库往往难以满足高性能和实时分析的要求，随着ClickHouse社区的不断发展壮大，越来越多的开发者寄希望于通过将MySQL的数据同步到ClickHouse进行加速分析，虽然ClickHouse官方推出了MaterializedMySQL的方式，然而如何将MySQL的数据简单方便、快速灵活地同步到ClickHouse却是一个比较繁琐的问题，需要依赖大量的黑屏操作来配置同步。

本解决方案通过产品化融合MySQL和ClickHouse，实现用户可视化和白屏化操作数据一键同步，灵活地配置MySQL与ClickHouse数据表的实时同步，构建更易用、更好用的一站式HTAP（混合事务/分析处理）解决方案。利用ClickHouse的在线实时分析能力，解决大规模业务数据的在线统计分析，如业务报表统计、交互式运营分析、对账以及实时数仓等业务场景，实现事务在线处理和在线分析的一体化。

### **方案架构**

方案提供的默认设置（如地域、VPC、安全组、vSwitch、实例名称等）完成部署后在阿里云上搭建的RDS MySQL实时数据同步到云数据库 ClickHouse 进行加速分析的架构图如下图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与下图相似。

![c5b570e594975b128c52b34ffb34f30a.jpg](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2696453961/p710275.jpg)

本方案的技术架构包括以下基础设施和云服务：

* 地域和可用区：RDS MySQL 实例和云数据库 ClickHouse 实例必须在同一个地域中，可以选择部署在不同的可用区。
* 1个专有网络 VPC：RDS MySQL 实例和云数据库 ClickHouse 实例必须在同一个 VPC 网络环境中。
* 1个 RDS MySQL 实例：RDS MySQL 实例，用于日常在线业务（OLTP）系统的数据库存取操作等。
* 1个云数据库 ClickHouse 实例：云数据库 ClickHouse 实例，用于将 RDS MySQL 实例的数据同步到云数据库 ClickHouse 中，实现针对 MySQL 数据的加速访问，用于实时报表、运营分析等 OLAP 业务。
## **方案部署**
### **部署准备**


开始部署前，请按以下指引完成账号申请、服务开通、网络规划、资源规划等准备工作。

#### **准备账号**

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   1. 为节省成本，本方案默认选择使用按量付费资源，使用按量付费资源需要确保账户余额不小于100元。
   2. 完成本方案的部署及体验，预计产生费用不超过20元（假设您选择下表中的相关规格资源，且运行时间不超过2小时，如果调整了资源规格，请以控制台显示的实际报价以及最终账单为准）。
      
      | **云服务** | **规格配置** | **地域** | **预估费用参考** |
      | --- | --- | --- | --- |
      | 云数据库 RDS MySQL 版 | 规格：mysql.x4.xlarge.2c（8 核 32GB）  存储空间：100 GB（ESSD PL1） | 华东2（上海） | 6.10 元/小时 |
      | 云数据库 ClickHouse 版 | 规格：单副本版 标准型 8 核 32GB  存储空间：100 GB（ESSD PL1） | 华东2（上海） | 2.981 元/小时 |
      | 云服务器 ECS | 规格：ecs.t6-c2m1.large  存储空间：40 GB（ESSD PL1） | 华东2（上海） | 配置费用：0.143 元/小时  公网流量费用：0.800 元/GB |
      | 按量费用：9.224 元/小时  公网流量费用：0.800 元/GB | | | |
3. 阿里云账号拥有操作资源的最高权限，从云资源安全角度考虑，建议您创建RAM用户。RAM用户需要获得相关云服务的访问权限才能完成方案部署，详情如下：
   
   | **云服务** | **需要的权限** | **描述** |
   | --- | --- | --- |
   | 资源编排 ROS | * AliyunROSFullAccess * AliyunOOSFullAccess | 管理资源编排服务ROS的权限 |
   | 专有网络 VPC | AliyunVPCFullAccess | 管理专有网络VPC的权限 |
   | 云数据库 RDS MySQL 版 | AliyunRDSFullAccess | 管理云数据库RDS的权限 |
   | 云数据库 ClickHouse 版 | AliyunClickHouseFullAccess | 管理云数据库ClickHouse的权限 |
   | 云服务器 ECS | AliyunECSFullAccess | 管理云服务器服务ECS的权限 |
   
   创建RAM用户的操作指引请参见[创建RAM用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)。
   
   为RAM用户授权的操作指引请参见[为RAM用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。
### **一键部署**


资源编排（ROS）可以让您通过YAML或JSON文件清晰简洁地描述所需的云资源及其依赖关系，然后自动化地创建和配置这些资源。您可以通过下方提供的ROS一键部署链接，来自动化地完成这些资源的创建和配置。

本文介绍的ROS模板主要完成了以下内容：

* 部署1个专有网络VPC。
* 部署1台交换机。
* 部署1台云服务器 ECS。
* 部署1个云数据库 ClickHouse 版。
* 部署1个云数据库 RDS MySQL 版。
* 在ECS中已下载并且编译[tpcc-mysql](https://database-plg.oss-cn-beijing.aliyuncs.com/dbbp/rds2ck/tpcc-mysql.tar)压测程序。
* 已配置RDS MySQL与ClickHouse间的数据同步。

1. 打开[一键配置模板链接](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/documents/solution/one-stop-htap-service.yml&isSimplified=true)前往ROS控制台，系统自动打开使用新资源创建资源栈的面板。
   
   **说明** 
   
   ROS控制台默认处于您上一次访问控制台时的地域，请根据您创建的资源所在地域修改地域后再执行下一步。
2. 确认好地域后，在创建资源栈面板中配置**资源栈名称**、**数据库配置**和**客户端ECS配置**。
   
   | **配置项** | **参数** | **说明** | **示例值** |
   | --- | --- | --- | --- |
   | **资源栈名称** | 资源栈名称 | ROS一键部署任务名称，可自定义。 | htap-service |
   | **数据库配置** | 数据库实例规格 | RDS实例和ClickHouse实例的实例规格，选择后两个数据库规格相同。 | 8C32G |
   | RDS数据库账号 | 用于登录RDS数据库的账号。 | |
   | ClickHouse数据库账号 | 用于登录ClickHouse数据库的账号。 | |
   | 数据库密码 | RDS数据库用户和ClickHouse数据库用户的密码，设置后两个数据库用户的密码相同。 | |
   | **客户端ECS配置** | 可用区 | ECS实例所在的可用区，同一地域下，不同可用区内网互通，按需选择即可。 | 可用区 G |
   | 实例类型 | ECS实例的架构、分类和规格配置。 | x86计算型：ecs.g6.large |
   | 实例密码 | ECS实例的密码。 | |
3. 单击**创建**，系统将自动创建并部署本教程所需的资源。
4. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
   
   **说明** 
   
   创建时间较久，耗时约30分钟，请耐心等待。
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0349702961/p706062.png)
5. 单击资源页签，找到已创建的RDS实例和ClickHouse实例，单击实例ID，获取RDS和ClickHouse的连接地址，分别登录到云数据库 RDS MySQL 实例和云数据库 ClickHouse 实例进行查询性能的体验。
### **方案验证**


**一、通过执行复杂查询命令，验证云数据库ClickHouse高性能查询**

1. 登录**[云数据库 ClickHouse 管理控制台](https://clickhouse.console.aliyun.com/clickhouse/cn-shanghai/list)**。
2. 在顶部菜单栏，选择**华东2（上海）**地域。
3. 在左侧导航栏，单击**集群列表**。
4. 在**集群信息**页面中，找到上述步骤中创建出来的云数据库 ClickHouse 实例，单击右上角按钮**登录数据库**可以进入DMS界面。
   
   **说明** 
   
   除了DMS，也可以通过 **clickhouse-client** 命令行的方式登录云数据库 ClickHouse 数据库进行查询分析。（本方案以DMS登录为例）
5. 由于 MySQL 和 ClickHouse 之间的同步原理是基于 MaterializedMySQL 数据库引擎的机制实现同步的，在ClickHouse中的表采用的是 ReplicatedReplacingMergeTree 引擎。故表结构会新增两个额外的字段：_sign 和 _version。其中：
   
   1. _sign 字段：对于源端 insert 操作，此字段的值为1；对于源端 delete 操作，此字段的值为-1。
   2. _version 字段：此字段的值用来表示操作的顺序，每次 insert、update 和 delete 操作，此字段的值都会增加；
6. 基于上面的 MySQL 和 ClickHouse 之间的数据同步原理，由于可能存在 MySQL 和 ClickHouse 之间数据同步延迟的情况，故在 ClickHouse 端进行数据查询和分析时，需要特别注意数据一致性的问题，要想查询最新的数据，有如下两种方法：
   
   1. 使用 ClickHouse 的 FINAL 关键字：在 ClickHouse 中 FINAL 关键字可以用于获取已经合并的数据（但是使用 FINAL 关键字会增加消耗查询的计算资源），比如可以使用如下的语句进行查询：
      
      ```
      SELECT w_id, w_name, w_street_1, w_street_2, w_city, w_state, w_zip, w_tax, w_ytd
      FROM tpcc.warehouse FINAL
      WHERE _sign = 1;
      ```
   2. 通过 order by + group by 配合_version&_sign 的方式来获取最新数据：比如可以使用如下的语句进行查询：
      
      ```
      SELECT
          w_id,
          w_name,
          w_street_1,
          w_street_2,
          w_city,
          w_state,
          w_zip,
          w_tax,
          w_ytd
      FROM tpcc.warehouse
      WHERE (_sign = 1) AND ((w_id, _version) GLOBAL IN (
          SELECT
              w_id,
              max(_version)
          FROM tpcc.warehouse
          GROUP BY w_id
      ))
      ```

**二、通过登录云数据库ClickHouse实例后台，验证云数据库MySQL实时同步状态**

1. 登录**[云数据库 ClickHouse 管理控制台](https://clickhouse.console.aliyun.com/clickhouse/cn-shanghai/list)**。
2. 在顶部菜单栏，选择**华东2（上海）**地域。
3. 在左侧导航栏，单击**MySQL实时同步**。
4. 查看同步任务状态如下：![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2753610961/p696568.png)
   
   **说明** 
   
   检查当前正在进行的同步任务，可以查看同步状态、同步库表对象，同时也可以**修改同步任务**等
### **清理资源**


在本方案中，您创建了1个专有网络VPC、1台交换机、1个云数据库 RDS MySQL 实例、1个云数据库 ClickHouse 实例。测试完方案后，您可以在[ROS控制台](https://ros.console.aliyun.com/overview)找到目标资源栈，然后直接删除资源栈即可（删除时，**删除方式**选择为**释放资源**）。

