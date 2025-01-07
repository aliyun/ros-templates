## **方案概览**

DataWorks 数据集成可以将 Mysql、PG 等数据库中数据进行单表、整库、分库分表实时同步到 Hologres，也可以将 Clickhouse 等整体迁移到 Hologres，整个过程全程界面化操作，方便简洁，按量付费成本低。数据存储在 Hologres 中，通过 Hologres 强大的查询性能，可以直接对数据进行查询。除了 OLAP 分析，还可以同时满足交互式分析、即席查询、KV 查询等多种查询方式，构建有一站式实时数据分析平台。

## **方案架构**

本方案基于阿里云实时数仓 Hologres 和 DataWorks 数据集成，通过简单的产品操作即可完成数据库 RDS 实时同步数据到 Hologres，并通过 Hologres 强大的查询分析性能，完成一站式高性能的 OLAP 数据分析。

![p823795](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7760132271/p825431.png)

本方案的技术架构包含以下基础设施和云服务：

* 数据源集成
  
  本方案以 Github 公共事件作为示例数据，数据存储在云数据库 RDS MySQL 中。

**说明** 

更多数据源集成请参考[数据导入导出](https://help.aliyun.com/zh/hologres/user-guide/data-import-and-export/)，更多关于数据集的介绍请参见[业务与数据认知](https://help.aliyun.com/zh/hologres/use-cases/integration-of-offline-and-real-time-processing-of-data-in-github-public-event-datasets#f52c81c0cca5h)。

* 网络资源
  
  + 1 个专有网络 VPC：为实时数仓 Hologres、大数据开发治理平台 DataWorks 等云资源构建云上私有网络。
  + 1 台交换机：将大数据开发治理平台 DataWorks 资源组和 1 个公网 NAT 网关连接在同一网络上，实现 MySQL 与 DataWorks 之间的通信。
* 数据服务
  
  + 大数据开发治理平台 DataWorks：通过 DataWorks 的数据同步功能，可以直接将实时数据流写入 Hologres。
  + 实时数仓 Hologres：与 DataWorks 的深度集成，支持海量数据实时写入与更新、实时数据写入即可查询。

## **方案部署**
### **部署准备**

开始部署前，请按以下指引完成账号申请、账号充值。

### **准备账号**

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。如果确定任何一个云资源采用按量付费方式部署，账户余额都必须大于等于 100 元。
### **一键部署**

一键部署基于阿里云资源编排服务 ROS（Resource Orchestration Service）实现，ROS 模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。ROS 模板完成部署的资源包括：

* 专有网络 VPC 和交换机
* Hologres 实例

#### 操作步骤

1. 一键部署资源。
   
   1. 单击[一键部署](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/OLAP-analysis-based-on-Hologres.yml&hideStepRow=true&hideStackConfig=true&pageTitle=%E5%A4%9A%E6%BA%90%E9%9B%86%E6%88%90%EF%BC%8C%E6%9E%81%E8%87%B4%E6%80%A7%E8%83%BD%EF%BC%8C%E6%90%AD%E5%BB%BA%E8%BD%BB%E9%87%8FOLAP%E5%88%86%E6%9E%90%E5%B9%B3%E5%8F%B0&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled)，在顶部导航栏选择地域**华东 1（杭州）**。
   2. 自定义**资源栈名称**并选择可用区，然后单击**下一步**。
   3. 确定部署资源信息和价格，单击**创建**。
      
      **资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成，您可以在**资源**页签，查看一键部署的资源。
2. 创建 Hologres 数据库和内部表。
   
   **说明** 
   
   Hologres **独享实例（按量付费）**实例会根据写入和查询操作消耗的计算资源进行计费，因此在进行相应操作时需谨慎操作，避免消耗资源。关于计费详情，请参见[计费概述](https://help.aliyun.com/zh/hologres/product-overview/billing-overview)。
   
   1. 登录 [Hologres 管理控制台](https://hologram.console.aliyun.com/cn-hangzhou/instance)，单击一键部署的 Hologres 实例名称，进入**实例详情**页面，然后单击右上方的**登录实例**。
   2. 在 **HoloWeb** 页面，选择**元数据管理** > **新建库**。
   3. 在**新建数据库**对话框中配置如下参数，并单击**确认**。
      
      | **配置项**   | **说明**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      |-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
      | **实例名**   | 选择在刚创建的 Hologres 实例上创建数据库。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
      | **数据库名称** | 本示例数据库名称设置为 holo\_tutorial。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | **权限策略**  | 选择 **SPM**。更多关于权限策略的说明，请参见：  * [SPM](https://help.aliyun.com/zh/hologres/security-and-compliance/simple-permission-model/)：简单权限模型，该权限模型授权是以 DB 为粒度，划分 admin（管理员）、developer（开发者）、writer（读写者）以及 viewer（分析师）四种角色，您可以通过少量的权限管理函数，即可对 DB 中的对象进行方便且安全的权限管理。 * [SLPM](https://help.aliyun.com/zh/hologres/security-and-compliance/schema-level-simple-permission-model/)：基于 Schema 级别的简单权限模型，该权限模型以 Schema 为粒度，划分 <db>.admin（DB 管理员）、<db>.<schema>.developer（开发者）、<db>.<schema>.writer（读写者）以及 <db>.<schema>.viewer（分析师），相比于简单权限模型更为细粒度。 * [专家](https://help.aliyun.com/zh/hologres/security-and-compliance/standard-postgresql-authorization-model)：Hologres 兼容 PostgreSQL，使用与 Postgres 完全一致的权限系统。 |
      | **立即登录**  | 选择**是**。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
   4. 选择 **SQL 编辑器**，然后单击![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9115081271/p820297.png)新建**临时 Query 查询**。
   5. 在**临时 Query 查询**页面，创建 Hologres 内部表，用于后续数据实时写入，示例代码如下。便于快速了解 Hologres 的开发，可参考 [Hologres 开发规范](https://help.aliyun.com/zh/hologres/use-cases/hologres-development-standards)。
      
      ```
      -- 新建schema用于创建内表并导入数据
      CREATE SCHEMA IF NOT EXISTS hologres_dataset_github_event;
      
      DROP TABLE IF EXISTS hologres_dataset_github_event.hologres_github_event;
      
      BEGIN;
      CREATE TABLE hologres_dataset_github_event.hologres_github_event (
        id bigint PRIMARY KEY,
        actor_id bigint,
        actor_login text,
        repo_id bigint,
        repo_name text,
        org_id bigint,
        org_login text,
        type text,
        created_at timestamp with time zone NOT NULL,
        action text,    
        commit_id text,
        member_id bigint,
        language text
      );
      CALL set_table_property ('hologres_dataset_github_event.hologres_github_event', 'distribution_key', 'id');
      CALL set_table_property ('hologres_dataset_github_event.hologres_github_event', 'event_time_column', 'created_at');
      CALL set_table_property ('hologres_dataset_github_event.hologres_github_event', 'clustering_key', 'created_at');
      
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.id IS '事件ID';
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.actor_id IS '事件发起人ID';
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.actor_login IS '事件发起人登录名';
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.repo_id IS 'repoID';
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.repo_name IS 'repo名称';
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.org_id IS 'repo所属组织ID';
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.org_login IS 'repo所属组织名称';
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.type IS '事件类型';
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.created_at IS '事件发生时间';
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.action IS '事件行为';
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.commit_id IS '提交记录ID';
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.member_id IS '成员ID';
      COMMENT ON COLUMN hologres_dataset_github_event.hologres_github_event.language IS '编程语言';
      
      COMMIT;
      ```
3. 部署 DataWorks 服务。
   
   1. 进入 [DataWorks 服务开通页](https://dataworks.console.aliyun.com/commonBuy?spm=5176.14066233.J_1329129980.3.17299325jgwd3G&hideTopbar=true&sso=true)，选择需要开通的产品配置。
      
      | **配置项**           | **说明**                                                                                                                                                                                                                                              |
      |-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
      | **地域**            | 选择**华东 1（杭州）**。                                                                                                                                                                                                                                     |
      | **DataWorks 版本**  | 选择**基础版**。                                                                                                                                                                                                                                          |
      | **DataWorks 资源组** | 选择资源组并配置网络信息。  * **付费模式**：选择**按量付费**。 * **专有网络（VPC）**：选择之前已创建的专有网络 VPC。 * **交换机（V-Switch）**：选择之前已创建的专有网络交换机。 * **服务关联角色**：您需具备如下服务关联角色才可开通资源组，请按照界面指引创建相关角色。    + 角色名称：AliyunServiceRoleForDataWorks   + 角色权限策略：AliyunServiceRolePolicyForDataWorks |
   2. 确认配置无误后，勾选服务协议。
   3. 确认订单。
      
      **说明** 
      
      某地域首次开通 DataWorks 服务后，平台自动为您创建默认工作空间，详情请参见[默认工作空间内置逻辑说明](https://help.aliyun.com/zh/dataworks/user-guide/built-in-logic-of-dataworks-default-workspace)。
      
      1. 单击**确认订单并支付**，在**资源校验**对话框查看购买的商品详情。
      2. 资源校验无误后，单击**下一步：价格清单**，确认商品价格。
         
         **说明** 
         
         价格清单包括 DataWorks 版本费用、资源组费用、MaxCompute 产品费用及其他按量付费商品费用（即 DataWorks 按量付费）。
      3. 价格确认无误后，单击**下一步：创建订单**。
      4. 进入**待支付订单页面**，单击**支付**进行购买。
   4. （可选）为 DataWorks 资源组的 VPC 配置 NAT 网关并绑定弹性公网 IP（Elastic IP Address，简称 EIP）。
      
      **说明** 
      
      DataWorks 新版**资源组**默认不具备公网访问能力，为确保公共 MySQL（公网）与 DataWorks 之间的网络连通性，需要为 VPC 配置[公网 NAT 网关](https://help.aliyun.com/zh/nat-gateway/getting-started/use-the-snat-feature-of-an-internet-nat-gateway-to-access-the-internet)并绑定 EIP。详情请参见[网络连通方案](https://help.aliyun.com/zh/dataworks/user-guide/establish-a-network-connection-between-a-resource-group-and-a-data-source-1)。
      
      1. 登录[专有网络管理控制台](https://vpcnext.console.aliyun.com/vpc)，选择**NAT 网关** > **公网 NAT 网关**。
      2. 在**公网 NAT 网关**页面，单击**创建公网 NAT 网关**配置相关参数。
         
         | **配置项**     | **说明**                                                                                                        |
         |-------------|---------------------------------------------------------------------------------------------------------------|
         | **所属地域**    | 选择**华东 1（杭州）**。                                                                                               |
         | **所属专有网络**  | 选择之前已创建的专有网络 VPC。                                                                                             |
         | **关联交换机**   | 选择之前已创建的专有网络交换机。                                                                                              |
         | **实例名称**    | 自定义公网 NAT 网关名称。                                                                                               |
         | **访问模式**    | 选择公网 NAT 网关的访问模式，本文选择 **VPC 全通模式（SNAT）**。 **说明**  选择了 VPC 全通模式，在公网 NAT 网关创建成功后当前 VPC 内所有实例即可通过该公网 NAT 网关访问公网。 |
         | **弹性公网 IP** | 选择**新购弹性公网 IP**。  系统会为您创建弹性公网 IP，并绑定到当前的公网 NAT 网关。                                                            |
         | **带宽峰值**    | 默认为 200 Mbps， 建议设置为 1 Mbps，避免产生更多费用。                                                                          |
      3. 单击**立即购买**，并在**确认订单**页面确认公网 NAT 网关的配置信息，选中服务协议并单击**立即开通**。
         
         购买成功后，您可以在**公网 NAT 网关**页面查看已创建的公网 NAT 网关实例。
4. 配置实时同步任务。
   
   1. 配置数据源。
      
      1. 登录 [DataWorks 控制台](https://dataworks.console.aliyun.com/overview)，切换至目标地域后，单击左侧导航栏的**更多** > **管理中心**，在下拉列表中选择默认创建的工作空间，然后单击**进入管理中心**。
      2. 选择左侧导航栏的**数据源** > **数据源列表**，然后单击**新增数据源**。
         
         按照界面指引创建 MySQL 数据源和 Hologres 数据源，主要参数配置如下：
         
         * [MySQL 数据源](https://help.aliyun.com/zh/dataworks/user-guide/mysql-data-source)（来源数据）：
           
           | **配置项**       | **说明**                                                                                                                                 |
           |---------------|----------------------------------------------------------------------------------------------------------------------------------------|
           | **数据源名称**     | 自定义。本文以 MySQLData 为例。                                                                                                                  |
           | **配置模式**      | 选择**连接串模式**。                                                                                                                           |
           | **JDBC 连接地址** | + 主机地址 IP：rm-bp1z69dodhh85z9qa.mysql.rds.aliyuncs.com + 端口号：3306                                                                       |
           | **数据库名称**     | github\_events\_share  备注：输入数据库名称后，完整的 JDBC URL 为 jdbc:mysql://rm-bp1z69dodhh85z9qa.mysql.rds.aliyuncs.com:3306/github\_events\_share。 |
           | **用户名**       | workshop                                                                                                                               |
           | **密码**        | workshop#2017  此密码仅为本教程示例，请勿在实际业务中使用。                                                                                                  |
           | **认证选项**      | 选择**无认证**。                                                                                                                             |
         * [Hologres 数据源](https://help.aliyun.com/zh/dataworks/user-guide/create-a-hologres-data-source)（目标数据）：
           
           | **配置项**         | **说明**                                  |
           |-----------------|-----------------------------------------|
           | **数据源名称**       | 自定义。本文示例为 HologresData。                 |
           | **认证方式**        | 默认为**阿里云账号及阿里云 RAM 角色**。                |
           | **所属云账号**       | 选择**当前阿里云主账号**。                         |
           | **地域**          | 选择 Hologres 实例所在地域**华东 1（杭州）**。         |
           | **Hologres 实例** | 选择已创建的 Hologres 实例。                     |
           | **数据库名称**       | 填写上述已创建的 Hologres 数据库名称 holo\_tutorial。 |
           | **默认访问身份**      | 选择**阿里云主账号**。                           |
           | **认证选项**        | 选择**无认证**。                              |
   2. 创建实时同步任务。
      
      1. 访问 [DataWorks 数据集成](https://sso.data.aliyun.com/aliyun/aliyunCallback?redirect=https%3A%2F%2Fdataworks.console.aliyun.com%2Fdi)页面。
      2. 在**同步任务**页面，选择**来源**和**去向**，单击**新建同步任务**。
         
         * 来源：选择 MySQL。
         * 去向：选择 Hologres。
      3. 在**新建同步任务**页面，配置任务相关信息。
         
         **说明** 
         * 为保持公共数据源连接稳定，资源组与公共 MySQL 数据源创建连接后 7 天将进行释放，不影响资源组与您自己的 MySQL 创建的连接。
         * 基本配置
           
           + 新任务名称：Sync\_Task。
           + 同步类型：整库实时。
         * 网络与资源配置
           
           + 来源数据源：选择 MySQLData。
           + 去向数据源：选择 HologresData。
           + 资源组：选择开通 DataWorks 时创建的资源组，占用的 CU 量配置为 2 CU。
      4. 单击**测试连通性**，确认数据源与资源组网络连通，测试连通后，单击**下一步**。关于网络连通详情，请参见[网络连通方案](https://help.aliyun.com/zh/dataworks/user-guide/establish-a-network-connection-between-a-resource-group-and-a-data-source-1)。
      5. 配置要同步的库表和目标表映射。
         
         1. 在**选择要同步的库表**区域，勾选 MySQL 中的 github\_public\_event 表，添加至**已选库表**。
            
            ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9115081271/p820731.png)
         2. 在**目标表映射**区域，勾选对应表，单击**批量刷新映射**。
         3. 将**目标 Schema 名**和**目标表名**修改为上述已创建 Hologres 内部表，然后单击**完成配置**。
            
            ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0034181271/p825202.png)
            
            **说明** 
            
            优先配置**目标 Schema 名**后再修改**目标表名**，否则会修改失败。
   3. 实时任务配置完成后，在**任务列表**页面，单击**操作**列中**启动**。
      
      您可以单击同步任务名称，查看同步任务详情，预计 50 分钟左右数据同步任务将完成后，随后您可以前往 Hologres 进行实时数据分析。
### **验证与清理**

#### 方案验证

**一、通过查看同步任务详情，验证 DataWorks 数据同步的过程**

1. 访问数据集成的[同步任务](https://dataworks.data.aliyun.com/cn-hangzhou/di)页面，点击任务名称进入任务详情页。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3158189271/p861500.png)
2. **执行状态**可以看到任务执行的进度，分为三个阶段：结构迁移、全量初始化、实时数据同步。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3158189271/p861501.png)
3. 启动实时数据同步后，点击页面下面的**实时同步**标签，可以查看详细的同步信息，这包括业务延时、已同步的数据条数以及数据同步的速率等关键指标。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3158189271/p861502.png)

**二、通过执行复杂查询，验证 Hologres 实现即席查询的能力**

1. 登录 [Hologres 管理控制台](https://hologram.console.aliyun.com/cn-hangzhou/instance?spm=a2c4g.2835288.0.0.60825b401QCqYn)，点击实例 ID 进入 Hologres 实例详情页。点击**登录实例**，导航至 **SQL 编辑器页面**并点击**新建 SQL 查询**，运行如下示例命令，查询今日最活跃项目。
   
   ```
   SELECT
       repo_name,
       COUNT(*) AS events
   FROM
       hologres_dataset_github_event.hologres_github_event
   WHERE
       created_at >= CURRENT_DATE
   GROUP BY
       repo_name
   ORDER BY
       events DESC
   LIMIT 5;
   ```
2. 查询执行完成后，结果将显示在 SQL 编辑器下方。
   
   ```
   repo_name	                             events
   --------------------------------------+---------
   Hardwaregore/gimmie-commits	           59672
   happyfish2024/mins	                   12626
   bullet-dev-team/demo-app-env-list	     9002
   bullet-dev-team/python-pyramid-public	 8255
   SSlam1234/StatSlamImagesCDN	           6618
   ```
3. 点击“运行日志”检查详细的查询执行信息，特别是查询的响应时间。毫秒级的响应时间表明 Hologres 能够高效处理复杂的即席查询，满足快速数据分析的需求。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3158189271/p861504.png)
#### **资源**清理

在体验完成本教程后，如果您不再使用，请及时释放相关资源，否则 Hologres 与 DataWorks 资源将会持续运行产生费用。

1. 删除 DataWorks 资源组和同步任务。
   
   * 删除 DataWorks 资源组
     
     1. 登录 [DataWorks 控制台](https://dataworks.console.aliyun.com/overview?spm=a2c4g.11186623.0.0.4d295c6cwu1D83)，单击左侧导航栏的**资源组列表**。
     2. 在**资源组列表**页面，单击目标资源组**操作**列中**![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4741504271/p836699.png)** > **退订**，按照界面提示删除 DataWorks 资源组。
        
        **说明** 
        
        删除 DataWorks 资源组时，预计 1~2 分钟后会释放相应的弹性网卡资源。弹性网卡资源释放后，才支持释放交换机资源。
   * 删除 DataWorks 同步任务
     
     1. 登录 [DataWorks 控制台](https://dataworks.console.aliyun.com/overview?spm=a2c4g.11186623.0.0.4d295c6cwu1D83)，单击左侧导航栏的**数据开发与治理** > **数据集成**，在下拉框中选择对应工作空间后单击**进入数据集成**。
     2. 在**数据源**页面，勾选 MySQLData 和 HologresData 数据源，然后单击**批量删除**，按照界面提示删除数据源。具体操作，请参见[管理数据源](https://help.aliyun.com/zh/dataworks/user-guide/add-and-manage-data-sources#b44d90a94en3l)。
     3. 在**同步任务**页面，选择**操作**列**更多** > **删除**，按照界面提示删除同步任务。
2. 解绑并释放弹性公网 IP。
   
   1. 登录 [NAT 网关管理控制台](https://vpc.console.aliyun.com/nat?spm=a2c4g.11186623.0.0.4c5e6c9ekdDN7e)，选择**公网访问** > **弹性公网 IP**。
   2. 在**弹性公网 IP** 页面，单击目标弹性公网IP实例**操作**列中的**![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4741504271/p836699.png)** > **强制释放**，并按照界面提示进行解绑。
      
      **说明** 
      
      通过强制释放，系统将优先解绑弹性公网 IP 资源和共享带宽包，然后再去释放 EIP。
3. 释放 NAT 网关。
   
   1. 登录 [NAT 网关管理控制台](https://vpc.console.aliyun.com/nat?spm=a2c4g.11186623.0.0.4c5e6c9ekdDN7e)，选择 **NAT 网关** > **公网 NAT 网关**。
   2. 在**公网 NAT 网关**页面，单击目标 NAT 网关实例操作列中的****![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4741504271/p836699.png)** > **删除****，并按照界面提示进行删除 NAT 网关。**说明** 
   
   公网 NAT 网关实例**基本信息**页面默认未开启**删除保护**。如开启，请关闭**删除保护**。
4. 登录 [ROS 控制台](https://ros.console.aliyun.com/overview)，释放使用 ROS 一键部署的资源：专有网络 VPC、交换机和 Hologres 实例。
   
   1. 在左侧导航栏，选择**资源栈**。
   2. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
   3. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
