## **方案概览**

应用业务日志监控与告警是指基于阿里云日志服务满足用户数据采集，完成监控、告警的需求。本技术解决方案以模拟教育类应用服务日志的日志库作为样例，将会演示：

* 如何实现一个监控看板
* 如何根据业务日志触发邮件告警

## **方案架构**

方案提供的默认设置完成部署后在阿里云上搭建的网站运行环境如下图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与下图相似。

![业务日志备份 3✅@2x.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2901546171/p803163.png)

本方案包括如下基础设施和云服务：

* 地域和可用区：ECS实例和SLS项目建议在同地域，可用区无限制
* 1个专有网络VPC：ECS实例将使用一个VPC网络
* 核心系统：
  
  + 2个ECS实例，用于部署模拟业务客户端，模拟写入业务日志
  + 1个日志库：通过已收集日志进行查询和分析，产出监控看板，配置告警规则
## **方案部署**
### **部署准备**

10

开始部署前，请按以下指引完成账号申请、账号充值。

### **准备账号**

* 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
* [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
  
  1. 本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。如果确定任何一个云资源采用按量付费方式部署，账户余额都必须大于等于100元。
  2. 完成本方案的部署及体验，预计产生费用不超过10元（假设您选择下表中的相关规格资源，且运行时间不超过2小时，如果调整了资源规格，请以控制台显示的实际报价以及最终账单为准）。

| **云服务** | **规格配置** | **地域** | **预估费用参考** |
| --- | --- | --- | --- |
| 日志服务 SLS | 计费模式：按使用功能计费  Logstore类型：标准型（Standard）  原始数据量（GB / 每天写入）：1  保存天数（天）：30  智能存储分层：关闭  索引字段占比：100% | 华东1（杭州） | 0.76 元/天 |
| 云服务器 ECS | 规格：ecs.e-c1m1.large  存储空间：40 GB（高效云盘） | 华东1（杭州） | 配置费用：0.27元/小时  公网流量费用：0.800 元/GB |
| 按量费用：约0.57 元/小时  公网流量费用：0.800 元/GB | | | |

### **一键部署**

15

一键部署基于阿里云资源编排服务ROS（Resource Orchestration Service）实现，ROS模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。

#### 操作步骤

您可以通过下方提供的ROS一键部署链接，自动化地完成这些资源的创建和配置：

* 创建一个专有网络VPC和一个虚拟交换机VSwitch。
* 创建2个ECS服务器。
* 创建1个SLS日志服务项目（Project），并创建一个日志库。

1. 一键部署资源。
   
   1. 单击[一键部署](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/collect-application-log.yml&hideStepRow=true&hideStackConfig=true&pageTitle=实时可观测，即时应对风险&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled&balanceIntercept=true)，并选择地域。
   2. 在**配置模板参数**页面修改资源栈名称，配置ECS实例和日志项目名称，然后单击**创建**开始一键配置。
   3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
### **方案验证**

20

**一、通过查看用户登录状态日志，验证日志服务功能**

1. 日志内容样例
   
   1. 访问日志服务[管理控制台](https://sls.console.aliyun.com/)，找到创建的项目，点击名称进入，找到创建的日志库进行查看。
   2. 用户登录成功日志内容样例为：
      
      ```
      level: INFO userid: 476847 action: login code: success client_ip: xxx.xxx.xxx.xxx
      ```
   3. 用户登录失败日志内容样例为：
      
      ```
      level: WARNING userid 638239 action: login code: failed client_ip: xxx.xxx.xxx.xxx
      ```
2. 筛选用户登录失败日志
   
   1. 选择时间范围为15分钟，筛选带有关键字**login**以及 **failed**的日志。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8073558271/p857158.png)
   2. 如果无法查询，点击**开启索引**，选择**自动生成索引**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p801427.png)
   3. 如果已经开启索引，即按钮显示**查询分析属性**，下拉菜单中选择**属性**，查看是否正确生成了索引。
3. 统计失败次数
   
   1. 通过如下[SQL](https://help.aliyun.com/document_detail/63443.html)进行筛选，在日志数据中时间戳 **\_\_time\_\_**，以时间为维度统计失败次数（设置别名为 **failed\_count** ）：
      
      ```
      * and content: login and content: failed | SELECT __time__,count(*) AS failed_count GROUP BY __time__ LIMIT 10000
      ```
   2. 输入后点击**查询/分析**，检查是否可以筛选出所需数据。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8073558271/p857160.png)

**二、通过创建仪表盘，实现日志可视化监控**

1. 创建趋势图表
   
   1. 选择**图表类型**为**线图Pro**。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793116.png)
   2. 点击查询分析配置，配置**y轴字段**为 **failed\_count**，移动鼠标到任意曲线节点之上，检验是否数据生效。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793120.png)
   3. 在**基本设置**中设置**标题**为**近15分钟用户登录失败次数趋势**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793119.png)
   4. 点击**预览图表**面板中的**添加到仪表盘**。在弹出的**添加到仪表盘**对话框中，设置以下配置项目，然后点击**确定**。主要配置项说明如下，其余配置项保持默认值即可。
      
      | 配置项 | 示例值 |
      | --- | --- |
      | 操作类型 | 新建仪表盘 |
      | 布局模式 | 网格布局 |
      | 仪表盘名称 | biz-log-test应用业务日志监控 |
      
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793110.png)
2. 查看仪表盘
   
   1. 移动到左侧菜单**仪表盘**，鼠标悬停，在弹出菜单中选择**仪表盘列表**，点击已创建的仪表盘名称，即可查看新建的图表。
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2901546171/p802635.png)
   2. 如需其他图表，请参考[统计图表](https://help.aliyun.com/document_detail/347681.html) 。

**三、通过配置邮件告警，验证日志服务通知**

1. 配置告警规则
   
   1. 访问日志服务[管理控制台](https://sls.console.aliyun.com/)，找到创建的项目，点击名称进入下一步配置。
   2. 左边栏点击**告警**按钮，进入**告警中心**界面：
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p801412.png)
   3. 点击**通知对象**下的**用户管理**，点击**创建**按钮。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793130.png)
   4. 在弹出窗口中按照实际情况输入个人期望接收告警消息的邮箱。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793122.png)
   5. 点击**告警规则**，点击**新建告警**按钮。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793129.png)
   6. 在右侧弹出**新建告警**面板中，配置**规则名称**为**近15分钟用户登录失败次数**，**检查间隔**可以设定为预期的检查间隔，这里设定为**固定间隔1分钟**，即**每分钟统计1次**，统计时间范围是**最近15分钟**的登录失败次数。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793121.png)
   7. 点击**查询统计**右侧的**添加**按钮。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793128.png)
   8. 在弹出的**查询统计**对话框中，选择项目和日志库，在查询中通过如下[SQL分析语法与功能](https://help.aliyun.com/document_detail/63443.html)进行筛选，统计失败次数（设置别名为 **failed\_count** ）
      
      ```
      * and content: login and content: failed | SELECT count(*) AS failed_count
      ```
      
      输入后点击**预览**，检查是否可以筛选出所需数据，能够统计结果则点击**确认**按钮。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793127.png)
2. 配置触发条件与通知
   
   1. 配置**触发条件**，**当**字之后的下拉菜单选择**有数据匹配**，填写表达式：
      
      ```
      failed_count > 100
      ```
      
      表示当统计结果中 **failed\_count** 值大于 100 触发一次告警。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p801562.png)
   2. 在**添加标注**中，标签为desc的输入框设置为**近15分钟用户登录失败次数${failed\_count}**，表示会在告警信息的描述中携带 **failed\_count** 的数值。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793125.png)
   3. 在**输出目标**中，选择**SLS通知**；在**告警策略**中，选择**极简模式**；在**行动组**界面选择**渠道**为**邮件**；**接收人类型**为**静态接收人**；**接收人**选择创建的接收人（本次演示设定为biz-log-test）；**内容模板**选择**SLS内置内容模板**，点击**确定**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793124.png)
   4. 查看是否新增了告警规则![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793123.png)
3. 验证告警触发
   
   1. 等待约2分钟后，再点击**告警中心**中**告警规则**下新增的告警规则标题，查看告警运行情况，检查是否有告警触发（如遇异常提示，请等待约1分钟后重试）。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1921395171/p793133.png)
   2. 当存在告警触发时，检查个人邮箱**收件箱**（如收件箱不存在邮件可查看垃圾邮件列表），可以看到标题为**日志服务告警**的邮件，正文内容带有近15分钟登录失败次数等信息。
### **清理资源**

10

#### 清理资源

您可以使用ROS一键删除创建的云资源，避免继续产生费用。

1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
2. 在左侧导航栏，选择**资源栈**。
3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
