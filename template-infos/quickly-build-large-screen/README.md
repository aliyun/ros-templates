## **方案概览**

随着数字化建设快速推进，企业每天都在产生海量的经营数据，如何从这些纷繁复杂的业务数据中洞察趋势、辅助决策，成为了企业现代化管理的一项关键挑战。阿里云DataV数据可视化平台提供一站式企业经营数据大屏建设方案，支持`30+`数据源类型，可接入日常经营数据，提供监控大屏、PC看板、移动端看板等覆盖全端的经营数据实时监控与分析决策能力。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p826752.png)

## **方案架构**

按照本方案提供的配置完成部署后，会在阿里云上搭建一个如下图所示的运行环境。实际部署时，您可根据具体的资源规划调整部分配置，但最终的运行环境将与下图展示的架构相似。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7203395271/p846783.png)

本方案的相关资源及技术架构如下：

* 相关资源
  
  + 数据来源：采用云数据库RDS MySQL，用于存储用户的业务数据。本文示例存储账单数据。
  + 可视化编辑器：采用DataV数据可视化，用于接入用户数据，进行可视化展示及分析。本文示例创建PC数据看板。
* 技术架构
  
  本方案将RDS MySQL数据接入DataV，作为DataV的RDS MySQL数据源，并在DataV创建PC数据看板，通过相关组件进行数据的适配及展示，快速搭建企业经营大屏。

## **方案部署**
### **部署准备**

开始部署前，请按以下指引完成账号申请、账号充值。

1. 若您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   为节省成本，本方案中云数据库RDS MySQL选择使用按量付费资源，使用按量付费资源需确保账户余额不小于`100`元；DataV数据可视化选择试用版本。产品规格及费用如下。
   
   **说明** 
   
   实际使用时，可能会因您操作过程中使用的流量差异，导致费用产生变化。请以控制台显示的实际报价及最终账单为准。
   
   | **产品** | **规格** | **费用** | **相关参考** |
   | --- | --- | --- | --- |
   | 云数据库RDS MySQL | 本教程示例使用`mysql.n1e.small.1`（MySQL8.0基础系列）规格。 | 按量付费 | * 计费详情，请参见[计费概览](https://help.aliyun.com/zh/rds/apsaradb-rds-for-mysql/billing-overview)。 * 更多关于RDS MySQL实例的选型，请参见[产品系列概述](https://help.aliyun.com/zh/rds/apsaradb-rds-for-mysql/overview-11)。 |
   | DataV数据可视化 | 本教程示例使用**专业版试用**。 **说明**  * **专业版试用**为新用户（即未开通过DataV产品的用户）专享。若您已购买非**个人版**DataV产品，则可直接进入控制台开始本实验。 * **个人版**DataV产品，不支持通过数据源接入数据。 | **9.9元** | 更多关于DataV的规格介绍及计费方式，请参见[规格说明](https://help.aliyun.com/zh/datav/datav-7-0/product-overview/datav-editions)、[计费方式](https://help.aliyun.com/zh/datav/datav-7-0/product-overview/billing-methods-for-datav-7)。 |
### **部署资源**


您需按照规划好的方案部署资源。一键部署基于阿里云资源编排服务ROS（Resource Orchestration Service）实现，ROS模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。本方案中仅支持通过ROS模板完成云数据库RDS MySQL的创建，DataV服务的资源部署仍需手动完成。具体操作如下。

#### **创建云数据库RDS MySQL**（单击即可展开查看详情）

1. 单击[一键部署](https://ros.console.aliyun.com/cn-shanghai/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/quickly-build-large-screen.yml&hideStepRow=true&hideStackConfig=true&pageTitle=%E5%BF%AB%E9%80%9F%E6%90%AD%E5%BB%BA%E4%BC%81%E4%B8%9A%E7%BB%8F%E8%90%A5%E5%A4%A7%E5%B1%8F&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled)，在顶部导航栏选择地域。示例选择**华东1（杭州）**。
2. 按需配置**资源栈名称**及模板参数。
   
   实际使用时请根据自身需要配置。本文示例配置如下：
   
   * 资源栈名称：采用默认生成的名称。
   * 可用区ID：选择可用区J。
   * 规格：本教程示例使用`mysql.n1e.small.1`（MySQL8.0基础系列）规格。
   * 数据库账号：`user_test`，后续登录数据库使用。
   * MySQL数据库密码：自定义密码，后续登录数据库使用。
3. 单击下一步，按照界面指引完成创建。
   
   当**资源栈信息**页面的**状态**显示为**创建成功**，表示一键配置完成。您可进入资源栈详情页，查看创建的资源信息，后续需使用该资源进入RDS MySQL及DataV控制台执行后续开发操作。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5748034271/p837980.png)
   
   * VSwitch：创建的交换机。
   * Account：数据库登录账号，示例为`user_test`。登录密码为您配置资源时设置的密码。
   * VPC：创建的专有网络，用于DataV添加RDS MySQL数据源使用。
   * Database：创建的RDS MySQL版实例。同时，平台默认为您创建了名为`mysqltest`的数据库，用于后续创建表并导入数据操作。
4. 设置白名单。
   
   您需将RDS MySQL数据库所在地域的白名单IP地址，添加至您的实例白名单中，以确保后续在DataV创建数据源时能正常访问您的RDS MySQL实例。
   
   1. 获取白名单地址。
      
      您可参考[配置数据库白名单](https://help.aliyun.com/zh/datav/datav-6-0/user-guide/configure-a-database-whitelist-for-datav-6)，查看各地域白名单地址。本文示例数据库部署在**华东1（杭州）**地域，且使用内网VPC网络，因此需要添加的白名单为`100.104.70.0/24`。
   2. 登录[云数据库RDS MySQL控制台](https://rdsnext.console.aliyun.com/)，在左侧导航栏单击**实例列表**，在顶部菜单栏切换至**华东1（杭州）**地域。
   3. 单击目标实例名称，进入实例详情页。
   4. 在RDS MySQL实例详情页，单击左侧导航栏的**白名单与安全组**，按下图步骤添加白名单。
      
      **说明** 
      * 多个IP地址，需使用英文逗号（,）隔开。
      * 更多添加白名单的介绍，请参见[设置IP白名单](https://help.aliyun.com/zh/rds/apsaradb-rds-for-mysql/configure-an-ip-address-whitelist-for-an-apsaradb-rds-for-mysql-instance)。
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5748034271/p838125.png)
#### 连接数据库并准备测试数据（单击即可展开查看详情）

1. 连接数据库。
   
   1. 在目标RDS MySQL实例详情页，单击**登录数据库**。
   2. 在登录对话框，输入数据库账号（即`user_test`）及密码，单击**登录**。
      
      **说明** 
      * 其他参数均使用默认配置。
      * 登录后需切换使用本方案示例的`mysqltest`数据库进行后续操作。
2. 创建表并导入数据。
   
   在已创建的数据库中创建如下测试表并导入数据。
   
   示例创建一个账单表`Bill`，并生成100条模拟账单数据，日期范围设定在`2023年1月1号~2023年1月10号`之间，语句如下。
   
   ```
   CREATE TABLE IF NOT EXISTS Bill (
       `id` INT AUTO_INCREMENT PRIMARY KEY,
       `bill_date` DATE NOT NULL COMMENT '账单日期',
       `amount` DECIMAL(10, 2) NOT NULL COMMENT '金额'
   ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='账单信息表';
   
   DELIMITER ;;
   CREATE PROCEDURE GenerateBillData()
   BEGIN
       DECLARE v_counter INT DEFAULT 1;
       DECLARE v_random_date DATE;
       DECLARE v_random_amount DECIMAL(10, 2);
       
       WHILE v_counter <= 100 DO
           SET v_random_date = DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 10) DAY);
           SET v_random_amount = ROUND(RAND() * 1000, 2);
           
           INSERT INTO Bill (bill_date, amount)
           VALUES (v_random_date, v_random_amount);
           
           SET v_counter = v_counter + 1;
       END WHILE;
   END;;
   DELIMITER ;
   
   -- 调用存储过程生成数据
   CALL GenerateBillData();
   ```
#### **开通DataV服务并创建数据源**（单击即可展开查看详情）

##### **开通DataV服务**

**说明** 

* **专业版试用**为新用户（即未开通过DataV产品的用户）专享。若您已购买非**个人版**DataV产品，则可直接进入控制台开始本实验。
* **个人版**DataV产品，不支持通过数据源接入数据。

1. 进入[DataV购买页面](https://common-buy.aliyun.com/?commodityCode=datav&accounttraceid=0293b10e21ac482eb81653cba8959ab0jebz)。
2. 选择**试用版本** > **专业版试用**。
3. 单击**立即购买**，完成支付，成功开通试用版DataV服务。
##### **创建RDS MySQL数据源**

您需要将RDS MySQL数据库创建为DataV的数据源，以便DataV通过该数据源访问数据库的数据。

**说明** 

本文以RDS MySQL示例，实际使用时，您可按需创建数据源。

1. 登录[DataV控制台](https://datav.aliyun.com/v/console/)，在左侧导航栏单击**功能导航** > **数据准备** > **数据源**。
2. 单击**新建数据源**。
3. 在**添加数据源**对话框，配置数据源信息。
   
   | **参数** | **描述** |
   | --- | --- |
   | **类型** | 选择RDS for MySQL，并且网络类型选择**内网**的**华东1**（即杭州地域）。 |
   | **名称** | 自定义数据源名称。本文示例为`mysql_data`。 |
   | **VPC ID**及**VPC实例ID** | * VPC ID：RDS MySQL实例所绑定的专有网络ID。 * VPC实例ID：RDS MySQL实例ID。 您可进入[RDS实例列表](https://rdsnext.console.aliyun.com/rdsList/basic?spm=a2c4g.11186623.0.0.4c5d4fa0BACSmz)查看。image |
   | **域名**及**端口** | * 域名：RDS MySQL实例所绑定专有网络的内网地址。 * 端口：RDS MySQL实例所绑定专有网络的内网端口。 您可在[RDS实例列表](https://rdsnext.console.aliyun.com/rdsList/basic?spm=a2c4g.11186623.0.0.4c5d4fa0BACSmz)，单击目标实例名称，进入实例详情页，按下图步骤查看。image |
   | **用户名**及**密码** | 数据库登录账号及密码。本文示例数据库账号为`user_test`，密码为您自定义的数据库密码。 |
   | **数据库** | 单击**获取数据列表**，在下拉框选择已创建的数据库。本文示例为`mysqltest`。 |
### **快速创建大屏并展示数据**

#### **步骤一：快速创建大屏**

DataV支持**通过空白看板创建大屏**、**通过模板快速创建大屏**、**通过Copilot智能创建大屏**，您可按需选择。本文以通过模板快速创建大屏示例。

**说明** 

DataV Copilot支持通过对话的方式输入业务需求及相关指标，DataV Copilot收到指令后会动态输出符合需求的可视化应用。详情请参见[使用AI智能生成PC端看板](https://help.aliyun.com/zh/datav/datav-7-0/user-guide/use-ai-to-intelligently-generate-pc-side-kanban)。

1. 登录[DataV控制台](https://datav.aliyun.com/v/console/)。
2. 创建大屏。
   
   1. 单击**全部应用** > **创建PC端看板**。
   2. 鼠标悬停至目标模板上，单击**创建看板**。
      
      本文示例选择`晴山蓝数据面板通用模板`。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5748034271/p838448.png)
   3. 输入看板名称，单击**创建看板**。
      
      本文示例看板名称为`mysql_display`。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828219.png)

看板创建后，将自动跳转至画布编辑器页面，您可按需接入数据源并配置画布信息。

#### **步骤二：接入数据源数据**

**说明** 

* 本文以RDS MySQL示例，实际使用时，您可按需选择数据源。
* 本文仅以看板的两个组件（折线图、轮播列表）示例，为您展示如何接入及配置数据源，其他组件配置方法类似。
##### 使用折线图接入数据

折线图可按需查看指定条件下的数据增长趋势。示例：查看`Bill`表中`2023年01月03日`相较`2023年01月02日`总账单金额的趋势。

1. 选择待编辑组件。
   
   您需先确定接入数据的组件，后续会通过该组件样式展示您的数据，示例将数据接入看板的折线图。
   
   双击画布中的折线图，即可在右侧组件编辑区域按需调整组件的样式、数据源等信息。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828744.png)
2. 查看组件代码配置。
   
   您可通过静态数据（即模板内置的默认固定值）了解组件所需的数据格式，包括字段数量、字段名称等。通过下图步骤可获取折线图的字段详情及代码格式。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828315.png)
   
   折线图代码格式如下。
   
   ```
   [
     {
       "x": "23:00",
       "y": 20,
       "colorField": "标签A"
     },
     {
       "x": "23:00",
       "y": 12,
       "colorField": "标签B"
     },
     {
       "x": "24:00",
       "y": 10,
       "colorField": "标签B"
     }
   ]
   ```
3. 接入数据源数据。
   
   1. 接入数据源并查看数据。
      
      在**数据源**区域，选择已创建的数据源，并通过查询语句查看数据表的字段情况。示例配置如下：
      
      * 数据源类型：`RDS for MySQL`
      * 数据源名称：`mysql_data`
      * 查询语句：查看`Bill`表中`2023年01月02日`~`2023年01月03日`每天的总账单金额。
        
        ```
        SELECT
            DATE(bill_date) AS 日期,
            SUM(amount) AS 日总金额
        FROM
            Bill
        WHERE
            bill_date BETWEEN '2023-01-02' AND '2023-01-03'
        GROUP BY
            DATE(bill_date)
        ORDER BY
            日期;
        ```
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828318.png)
   2. 使用过滤器适配数据源数据。
      
      若您的数据表字段与组件字段不一致，需使用[过滤器](https://help.aliyun.com/zh/datav/datav-7-0/user-guide/filter/)自定义过滤代码，将数据源数据适配至组件中。
      
      勾选**过滤器**，即可通过手动**新建**或**智能推荐**方式自定义过滤代码。
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828354.png)
      
      本文示例的过滤代码如下。
      
      ```
      var result = [];
      for (var i = 0; i < data.length; i++) {
        result.push({
          x: data[i].日期,
          y: data[i].日总金额,
          colorField: "type1"
        });
      }
      return result;
      ```
      * X轴：展示购买日期。
      * Y轴：展示日总金额。
      * 字段颜色：定义为固定颜色`type1`。
4. 查看最新组件数据。
   
   配置完成后，您即可看到看板中折线图组件已接入您的数据。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828391.png)
##### 使用轮播列表接入数据

轮播列表可动态展示数据表中的所有信息。示例：轮播`Bill`表中所有账单记录。

1. 选择待编辑组件。
   
   您需先确定接入数据的组件，后续会通过该组件样式展示您的数据，示例将数据接入看板的轮播列表。
   
   双击画布中的轮播列表，即可在右侧组件编辑区域按需调整组件的样式、数据源等信息。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828745.png)
2. 适配组件样式。
   
   由于RDS MySQL表仅需展示三个字段（id、bill\_date、amount）数据，轮播组件模板的列数（除第一列排序列，还剩4列）大于表的字段数，因此我们需在组件样式中删除冗余列，并依次更改列标题为“序号、用户ID、消费日期、金额”，操作方法如下。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828832.png)
3. 查看组件代码配置。
   
   您可通过静态数据（即模板内置的默认固定值）了解组件所需的数据格式，包括字段数量、字段名称等。通过下图步骤可获取轮播列表的字段详情及代码格式。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828774.png)
   
   轮播列表代码格式如下。
   
   ```
   [
     {
       "1": "列表项描述",
       "2": 12,
       "3": 9,
       "4": "https://cdn-upload.datav.aliyun.com/upload/download/1673857716919-VA3XG6Od.png"
     },
     {
       "1": "列表项描述",
       "2": 5,
       "3": 11.8,
       "4": "https://cdn-upload.datav.aliyun.com/upload/download/1673857716297-0o1s9KWZ.png"
     },
     {
       "1": "列表项描述",
       "2": 5,
       "3": 8,
       "4": "https://cdn-upload.datav.aliyun.com/upload/download/1673857715630-Z9jHcw74.png"
     },
     {
       "1": "列表项描述",
       "2": 8,
       "3": 16,
       "4": "https://cdn-upload.datav.aliyun.com/upload/download/1673857715630-Z9jHcw74.png"
     },
     {
       "1": "列表项描述",
       "2": 3,
       "3": 12,
       "4": "https://cdn-upload.datav.aliyun.com/upload/download/1673857715630-Z9jHcw74.png"
     },
     {
       "1": "列表项描述",
       "2": 6,
       "3": 7,
       "4": "https://cdn-upload.datav.aliyun.com/upload/download/1673857715630-Z9jHcw74.png"
     }
   ]
   ```
4. 接入数据源数据。
   
   1. 接入数据源并查看数据。
      
      在**数据源**区域，选择已创建的数据源，并通过查询语句查看数据表的字段情况。示例配置如下：
      
      * 数据源类型：`RDS for MySQL`
      * 数据源名称：`mysql_data`
      * 查询语句：查看`Bill`表中所有账单记录，语句如下。
        
        ```
        select * from Bill;
        ```
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828775.png)
   2. 使用过滤器适配数据源数据。
      
      若您的数据表字段与组件字段不一致，需使用[过滤器](https://help.aliyun.com/zh/datav/datav-7-0/user-guide/filter/)自定义过滤代码，将数据源数据适配至组件中。
      
      勾选**过滤器**，即可通过手动**新建**或**智能推荐**方式自定义过滤代码。
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828884.png)
      
      本文示例的过滤代码如下。
      
      ```
      var result = [];
      for (var i = 0; i < data.length; i++) {
        result.push({
          1: data[i].id,
          2: data[i].bill_date,
          3: data[i].amount
        });
      }
      return result;
      ```
      * 1（用户ID列）：展示购买用户ID。
      * 2（消费日期列）：展示购买日期。
      * 3（金额列）：展示购买金额。
5. 查看最新组件数据。
   
   配置完成后，您即可看到看板中轮播列表已接入您的数据。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828901.png)
#### **步骤三：修改组件样式**

若组件样式不符合您的业务需要，您也可进入看板编辑页面，按下图步骤进行修改。详情请参见[配置项说明](https://help.aliyun.com/zh/datav/datav-7-0/user-guide/configuration-items)。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828399.png)

#### **步骤四：发布及部署大屏**

数据大屏创建完成后，您需要将其发布上线，部署至相关设备使用。

1. 单击看板编辑页面右上角的**发布**，选择**发布大屏**。
2. 获取大屏访问信息并配置访问限制。
   
   大屏发布后，您可在看板编辑页面右上角单击**已发布**，获取大屏访问信息并配置访问权限。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6951214271/p828425.png)
   
   * 支持通过二维码、链接地址等方式访问。
   * 可按需配置访问权限（例如，密码验证、通过Token验证）。通常，如需与其他系统整合并控制访问权限，可开启Token验证。
   * 可在发布快照区域，查看大屏发布版本，也可执行新增版本、回滚至历史版本等管理操作。
3. 获取大屏访问信息后（例如，访问地址），您可将其投放至渲染主机、PC、手机等设备进行访问。
### **清理资源**


在本方案中，您通过一键部署创建了一个云数据库RDS MySQL，并手动开通了试用版DataV产品。方案执行完成后，您可参考以下规则处理对应产品，避免继续产生费用：

* 云数据库RDS MySQL
  
  1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
  2. 在左侧导航栏，选择**部署** > **资源栈**。
  3. 在**资源栈列表**页面的顶部菜单栏，切换至资源栈所在地域，单击目标资源栈**操作**列的**删除**。
  4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，单击**确定**，根据提示完成资源释放。
* DataV试用版产品
  
  该产品开通后，默认保有一个月，一个月后将自动退订并释放。
