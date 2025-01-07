## **方案概览**

本方案将引导您将网站的自建数据库平滑迁移至云数据库RDS。

通过使用RDS，您可以获得稳定、可靠和安全的企业级数据库服务，可以更加专注于发展核心业务，无需过多考虑数据库的管理和维护。

**本方案的体验预计产生费用不超过3元（假设资源运行时间不超过1小时）**。如果您调整了资源规格、使用时长，或执行了本方案以外的操作，可能导致费用发生变化，请以控制台显示的实际价格和最终账单为准。

### **方案架构**

* 由RDS实现数据库可靠性、可用性、安全性的保障。
* 应用部署在ECS上，通过内网（VPC）访问RDS。
* 使用数据传输服务DTS将ECS上的自建数据库迁移至云数据库RDS，迁移过程平滑、安全、高效，应用停机时间降低到分钟级别。

![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4679742171/p710973.png)


## **方案部署**
### **部署资源**

#### **一键部署资源**

您可以通过一键部署模板，快速创建一个云服务器ECS实例和一个云数据库RDS实例，ECS实例上已经部署了网站以及自建数据库。本方案以WordPress网站为例。

**方案资源配置**

专有网络VPC
-------

| **规划项** | **说明** | **示例值** |
| --- | --- | --- |
| VPC名称 | ROS会新建一个VPC作为本方案的专有网络，方案中的所有资源都会创建在该VPC下。ROS定义参见[什么是资源编排服务](https://help.aliyun.com/zh/ros/product-overview/what-is-ros)。 | database-migration-test |
| 网段 | 在创建VPC时，本方案会按照无类域间路由块（CIDR block）的格式为您的专有网络划分私网网段。阿里云VPC支持的网段信息请参见[专有网络组成部分](https://help.aliyun.com/zh/vpc/product-overview/virtual-private-cloud-overview/#section-w1b-tvz-ndb)。 | 192.168.0.0/16 |

虚拟交换机
-----

| **规划项** | **说明** | **示例值** |
| --- | --- | --- |
| 台数 | 方案中使用的虚拟交换机台数。 | 1 |
| 地域 | 您的云服务部署的地域。选择地域的基本原则请参见[地域和可用区](https://help.aliyun.com/document_detail/40654.html)。 | 华东1（杭州） |
| 可用区 | 在规划的地域内选择可用区部署交换机。  建议选择排序靠后的可用区，一般此类可用区较新，资源更充沛，新规格也会在新的可用区优先上线。 | 可用区G |
| 交换机子网段 | 交换机网段必须为专有网络子网段。 | 192.168.0.0/24 |

云服务器ECS
-------

| **规划项** | **说明** | **示例值** |
| --- | --- | --- |
| 实例数量 | 默认方案需要一台ECS实例。 | 1 |
| 实例规格 | ECS的实例规格及内核、vCPU数量。关于ECS选型的最佳实践请参见[实例规格选型指导](https://help.aliyun.com/zh/ecs/user-guide/best-practices-for-instance-type-selection)。 | ecs.e-c1m1.large |
| 镜像及版本 | ECS系统盘，为ECS实例提供操作系统、预装软件等。 | Alibaba Cloud Linux 3.2104 LTS 64位 |
| 系统盘类型 | 硬盘类型。 | ESSD PL1云盘 |
| 登录凭证 | root用户的登录密码。 | 用户自定义 |
| 可用区 | 与交换机可用区保持一致。 | 可用区G |
| 配置数据 | ECS实例初始化自动布置配置数据。 | 自动部署WordPress、MySQL及相关环境 |

云数据库RDS
-------

| **规划项** | **说明** | **示例值** |
| --- | --- | --- |
| 实例数量 | 方案默认需要一台RDS MySQL实例。 | 1 |
| 系列 | 基础系列为单节点。您也可以把实例从基础系列升级为高可用系列或集群系列。 | 基础系列 |
| 数据库版本及类型 | RDS支持多种数据库类型及对应版本，方案默认使用MySQL 8.0。 | MySQL 8.0 |
| 实例规格 | RDS实例的内存、vCPU数量等。如何选择合适的RDS MySQL实例请参见[RDS MySQL选型指南](https://help.aliyun.com/zh/rds/apsaradb-rds-for-mysql/selection-guide)。 | mysql.n2e.small.1 |
| 存储类型 | RDS支持本地盘与云盘存储，方案默认为ESSD PL1云盘。 | ESSD PL1云盘 |
| 存储空间 | RDS MySQL实例可用存储空间大小，方案默认为20GB。 | 20GB |
| 可用区 | 与ECS实例可用区保持一致。 | 可用区G |
| 白名单 | 允许访问RDS实例的IP列表 | 只允许通过本方案中ECS实例内网IP和弹性公网IP访问。IP由一键部署模板自动获取，无需手动添加。 |

1. 单击[一键部署](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/migrate-database-to-cloud.yml&hideStepRow=true&hideStackConfig=true&pageTitle=自建数据库迁移到云数据库&disableRollback=false&isSimplified=true&disabltrue&productNavBar=disabled)进入ROS控制台，在顶部选择**华东1（杭州）**。
2. 填写模板参数：为方便体验，您只需关注**可用区**、**ECS实例密码**和**RDS数据库密码**三个参数的选择，其它参数可使用方案默认值或按需选择。
3. 查看页面右下角的资源价格，确认无误后单击**创建**。
   
   等待资源栈创建，资源部署时间约为10分钟，请耐心等候，直至资源栈状态显示为**创建成功**。
   
   **说明** 
   * 为节省成本，本方案默认选择使用按量付费资源。使用按量付费资源需要确保账户余额不小于100元。
   * 如果创建失败，您可以选择其他可用区后重试。

![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3713311961/p702385.png)

#### **查看已部署的资源**

在资源页面，您可以查看上述步骤所生成的ECS实例、RDS实例、WordPress网站访问地址等。

1. 在**资源栈** > **资源栈列表**中单击上一步创建的资源栈。
2. 在顶部单击**资源**页签，可以查看已创建的资源及相关信息。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8649026271/p847975.png)
3. 在顶部单击**输出**页签，可以查看**输出关键字**列表，各关键字描述如下表所示。
   
   | **参数值** | **说明** | **示例值** |
   | --- | --- | --- |
   | ECSWordPressUrl | WordPress访问地址 | 系统自动生成 |
   | ECSInstanceUser | ECS实例登录账号和密码 | USERNAME: root  PASSWORD: 用户自定义 |
   | WPUserForSQL | ECS自建MySQL数据库账号和密码，该账号用于数据库SQL操作。 | USERNAME: wordpressuser  PASSWORD: password |
   | WPUserForDTS | ECS自建MySQL数据库账号和密码，该账号用于数据库（**源库**）在DTS中运行数据迁移任务。 | USERNAME: dtssync1  PASSWORD: P@ssw0rd |
   | RDSUserDTS | RDS数据库高权限账号和密码，用于数据库（**目标库**）在DTS中运行数据迁移任务。 | USERNAME: dbuser  PASSWORD: 用户自定义 |
   | RDSInternalAddress | RDS实例内网连接地址，用于WordPress网站连接至RDS实例。 | rm-bp\*\*\*\*\*.mysql.rds.aliyuncs.com |
### **网站安装及浏览**

**一、安装**WordPress**网站**

此时WordPress网站还不能访问，您需要进入WordPress安装页面，完成WordPress安装。

1. 访问[资源编排管理控制台](https://ros.console.aliyun.com/cn-hangzhou/stacks?resourceGroupId=)，在资源栈列表中单击刚创建的资源栈。
2. 在资源栈顶部单击**输出**页签，并在**输出关键字**列表中找到**ECSWordPressUrl**参数对应的值，单击进入网站。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3713311961/p702428.png)
3. 在WordPress安装页面，填写网站相关信息，然后单击**Install WordPress**。如下图所示：
   
   请记住设置的网站管理员用户名和密码，用于登录网站管理页面。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3713311961/p702396.png)![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7644448271/p855823.png)

**二、浏览**WordPress**网站**

1. 返回[资源编排管理控制台](https://ros.console.aliyun.com/cn-hangzhou/stacks?resourceGroupId=)，在资源栈列表中单击刚创建的资源栈。
2. 单击**输出**页签中**ECSWordPressUrl**参数对应的值，即可进入网站浏览。
### **迁移数据库**

现在，您可以使用DTS数据传输服务，配置源库和目标库信息，开始迁移数据库的库表结构、全量数据和增量数据。

1. 登录[DMS数据管理服务](https://dms.aliyun.com/new?spm=a2c4g.211596.0.0.99dc646bcQs6s4)。
2. 在顶部菜单栏选择**集成与开发（DTS）** > **数据传输（DTS）** > **数据迁移**。
   
   **说明** 
   
   如果顶部没有菜单，可以在右上角退出极简模式。
3. 单击**创建任务**。
4. 配置源库及目标库信息。
   
   1. 源库
      
      * **数据库类型**：MySQL
      * **接入方式**：ECS 自建数据库
      * **实例地区**：本示例中选择华东1（杭州）
      * **是否跨阿里云账号**：不跨账号
      * **ECS实例ID**：选择网站所在的ECS实例。
      * **端口**：3306
      * **数据库账号和密码**：输入前面创建的自建数据库账号和密码。本示例为`dtssync1`和`P@ssw0rd`。
      * **连接方式**：非加密连接
   2. 目标库
      
      * **数据库类型**：MySQL
      * **接入方式**：云实例
      * **实例地区**：本示例中选择华东1（杭州）
      * **是否跨阿里云账号**：不跨账号
      * **RDS实例ID**：选择前面创建的RDS实例。
      * **数据库账号和密码**：输入前面创建的RDS实例账号和密码。本示例为`dbuser`和您自定义的密码。
      * **连接方式**：非加密连接
5. 单击**测试连接以进行下一步**，系统会自动为ECS添加DTS安全组，为RDS添加DTS服务器IP至白名单，以允许DTS访问ECS和RDS。如果有失败信息，参考对应的错误提示进行修改即可。
6. 配置迁移任务。
   
   1. 对象配置：
      
      1. 迁移类型勾选**库表结构迁移**、**全量迁移**、**增量迁移**。
      2. 在**源库对象**框中选择要迁移的`wordpressdb`库，再单击![向右小箭头.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9907667861/p685630.png)将其移动至**已选择对象**框，然后单击**下一步高级配置**。
   2. 高级配置：默认配置项不作修改，单击**下一步数据校验**。
   3. 数据校验：勾选**全量校验**和**增量校验**、**结构校验**，然后单击**下一步保存任务并预检查**
7. **预检查通过率**达到100%后，单击**下一步购买**。选择数据迁移实例的链路规格（本案例以**small**规格为例），阅读并选中**《数据传输（按量付费）服务条款》**，单击**购买并启动**。
8. 迁移任务正式开始。
   
   单击迁移任务ID可以查看具体进度。当您看到如下界面，表示存量数据已迁移完成，增量数据会实时同步。此时您可以进入下一步，验证RDS里的数据。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8152855071/p759604.png)
### **方案验证**

**一、通过查看RDS实例中的数据，验证数据迁移结果**

1. 登录RDS实例
   
   1. 单击资源栈顶部**资源**按钮，然后单击**Database**资源ID进入RDS控制台，单击**登录数据库**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8649026271/p848002.png)
   2. 在弹出的DMS页面中，填写RDS高权限数据库账号和密码，然后单击**登录**。
      
      本示例中，RDS高权限数据库账号为`dbuser`，密码为您自定义的密码。
      
      如果报错“您暂未获取当前数据库实例的登录权限”，请单击**点此申请**，并由主账号完成审批。
2. 全量数据验证
   
   1. 在SQLConsole窗口，在左侧双击目标数据库名称`wordpressdb`，可以看到自建数据库所有库、表数据已经完成迁移。
      
      **说明** 
      
      如果找不到`wordpressdb`库，请右键单击RDS实例ID，选择**刷新/同步数据字典**。
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7644448271/p855990.png)
3. 增量数据验证
   
   1. 在SQLConsole窗口，双击`wp_comments`表名，再单击**执行**，查看`wp_comments`表的数据。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7644448271/p856108.png)
   2. 前往[资源编排管理控制台](https://ros.console.aliyun.com/cn-hangzhou/stacks?resourceGroupId=)，在资源栈列表中单击之前创建的资源栈。
   3. 在资源栈顶部单击**输出**页签，并在**输出关键字**列表中找到**ECSWordPressUrl**参数对应的值，单击进入网站，往下浏览找到如下图，点击进入评论区。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7644448271/p856088.png)
   4. 在网站中新增一条评论或多条评论，如下图![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7644448271/p855995.png)
   5. 再次查看RDS实例中`wp_comments`表的数据，执行查询语句可以看到增加的评论，说明增量数据已迁移成功。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7644448271/p856097.png)

**二、通过切换数据库连接并访问网站，验证RDS服务可用性**

#### 从自建数据库切换到RDS

为避免数据丢失，建议先停止写入数据，然后再将应用程序的数据库连接配置修改为云数据库RDS的连接地址。

1. 停止写入数据到源数据库。
2. 修改WordPress配置文件中的数据库连接配置。
   
   1. 在**资源**列表中单击**WebServer**资源ID进入ECS控制台，点击**远程连接**使用ECS账户登录。本示例中，ECS账号为`root`，密码为用户自定义密码。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8649026271/p848010.png)
      
      **说明** 
      
      如果提示用户名或密码不正确，可能是因为密码错误或者操作系统未完全启动，请确认输入的用户名和密码，或者稍后再尝试登录。
   2. 打开配置文件。
      
      ```
      sudo vim /usr/share/nginx/html/wp-config.php
      ```
   3. 按**i**进入插入模式。
   4. 修改数据库连接配置：
      
      * **修改数据库账号**：将`wordpressuser`改为RDS高权限账号`dbuser`。
      * **修改数据库密码**：将`password`修改为您自定义的密码。
      * **修改数据库连接地址**：将`localhost`修改为RDS内网连接地址（可以直接复制资源栈**输出**页签中**RDSInternalAddress**关键字对应的值）。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8649026271/p848019.png)
3. 按**Esc**键退出插入模式.
4. 输入**:wq**，并按**Enter**键退出vim编辑器。
   
   **说明** 
   
   以上仅为本示例教程的切换步骤，关于生产环境的切换和回滚方案，请参见[业务切换流程](https://help.aliyun.com/zh/dts/user-guide/switch-workloads-to-the-destination-database-1)。

#### **验证切换后的服务可用性**

1. 返回[资源编排管理控制台](https://ros.console.aliyun.com/cn-hangzhou/stacks?resourceGroupId=)，在资源栈列表中单击刚创建的资源栈。
2. 单击**输出**页签中**ECSWordPressUrl**参数对应的值，进入网站浏览，可观察到网站与切换前保持一致。如下图![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7644448271/p856031.png)
3. 在网站新增一条评论，再次查看RDS实例中`wp_comments`表的数据，执行查询语句可以看到增加的评论。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7644448271/p856098.png)
### **清理资源**

完成教程后，建议及时释放不需要的资源，包括DTS数据迁移任务和ECS实例等。

* **释放DTS任务**
  
  1. 登录[DMS数据管理服务](https://dms.aliyun.com/new?spm=a2c4g.211596.0.0.99dc646bcQs6s4)。
  2. 在顶部菜单栏选择**集成与开发（DTS）** > **数据传输（DTS）** > **数据迁移**。
  3. 选择DTS任务所在地域，找到目标任务。
  4. 在操作列单击![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5443365071/p759636.png)，然后单击**释放任务**。
* **释放一键部署创建的所有资源**
  
  + 访问[资源编排管理控制台](https://ros.console.aliyun.com/cn-hangzhou/stacks?resourceGroupId=)，找到对应资源栈，单击**删除**。
  + 完成确认操作。
