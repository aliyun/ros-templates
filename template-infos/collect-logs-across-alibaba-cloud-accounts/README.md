## 方案概览

当您希望在统一的位置收集多个账号里的应用日志、或需要进行合并不同账号下的云产品日志进行数据分析时，需要进行跨阿里云账号采集日志。

本技术解决方案以跨阿里云账号采集日志为例，为您演示：

* 如何通过Logtail跨账号采集ECS服务器日志。
* 如何通过日志审计服务跨账号采集对象存储OSS日志。

## 方案架构

![跨账号日志采集.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5329403961/p711572.png)

本方案的技术架构包括以下基础设施和云服务：

**说明** 

阿里云产品包括但不限于对象存储OSS、数据库RDS、负载均衡SLB等均可通过日志审计服务完成跨账号采集日志，本文以跨账号采集对象存储OSS日志为例。

* 2个阿里云账号：实现跨账号数据采集。
* 2个云服务器ECS：2个阿里云账号分别部署1个云服务器ECS，用于产生相关日志数据进行采集。
* 2个日志服务SLS：2个阿里云账号分别开通1个日志服务SLS，用于互相采集数据进行分析。
* 2个对象存储OSS：2个阿里云账号分别开通1个对象存储OSS，用于产生相关日志进行采集。
## 方案部署
### 部署准备


开始部署前，请按以下指引完成账号申请、账号充值、RAM用户创建和授权。

### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，本方案需要申请两个阿里云账号。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   * 本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。请确保您的账户余额大于等于100元。
   * 完成本方案的部署及体验，预计产生费用约为1元（假设您选择最低规格资源，且资源运行时间不超过1小时。实际情况中可能部分实例无法购买需要根据实际情况调整资源规格，同时因您操作过程中实际使用的流量差异，会导致费用有所变化，请以控制台显示的实际报价以及最终账单为准，如下表格仅供参考）。
     
     如下表格仅供参考，以实际情况为准
     
     | **序号** | **产品** | **费用来源** | **规格** | **地域** | **预估费用参考** | **说明** |
     | --- | --- | --- | --- | --- | --- | --- |
     | 1 | 云服务器ECS | ECS配置费 | 实例：ecs.t5-lc2m1.nano（突发性能实例 t5，1 vCPU，0.5 GiB）  系统盘：cloud\_efficiency 40GiB | 华东1（杭州） | 0.083元/时 | - |
     | 2 | 日志服务SLS | 读写流量费用 | / | 华东1（杭州） | + 500 MB以内：0元 + 超出部分：0.180 元/GB | 本方案涉及读写流量与跨账号采集的日志数据量有关，本文以500MB以内流量进行计费，实际价格请以实际数据量费用为准。 |
     | 按量费用：0.083元/时 | | | | | | |
3. 阿里云账号拥有操作资源的最高权限，从云资源安全角度考虑，建议您创建RAM用户。RAM用户需要获得相关云服务的访问权限才能完成方案部署。
   
   | **云服务** | **需要的权限** | **描述** |
   | --- | --- | --- |
   | 云服务器ECS | AliyunECSFullAccess | 管理云服务器ECS的权限 |
   | 日志服务SLS | AliyunLogFullAccess | 管理日志服务SLS的权限 |
   | 对象存储OSS | AliyunOSSFullAccess | 管理对象存储OSS的权限 |
   
   创建RAM用户并进行授权的操作指引请参见[创建RAM用户及授权](https://help.aliyun.com/zh/sls/create-a-ram-user-and-authorize-the-ram-user-to-access-log-service)。
### 一键部署


一键部署基于阿里云资源编排服务ROS（Resource Orchestration Service）实现，ROS模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。ROS模板完成的内容包括：

#### 操作步骤

#### 通过Logtail跨账号采集ECS日志

1. 在账号B中创建RAM角色并完成授权。
   
   1. 使用账号B登录。
   2. 创建RAM角色。
      
      其中，选择**选择可信实体类型**为**阿里云账号**，设置**选择信任的云账号**为**其他云账号**并输入账号A的ID。具体操作，请参见[创建可信实体为阿里云账号的RAM角色](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-role-for-a-trusted-alibaba-cloud-account)。
      
      记录该RAM角色名称，您在配置ROS模板时需输入该名称。
   3. 授予RAM角色AliyunECSFullAccess权限和AliyunSTSAssumeRoleAccess权限。
      
      具体操作，请参见[为RAM角色授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-a-ram-role)。
2. 在账号A中配置ROS模板。
   
   1. 单击[一键配置ROS模板链接](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/documents/solution/collect-logs-across-Alibaba-cloud-accounts.yml&isSimplified=true)，打开ROS控制台。
      
      系统自动打开使用新资源创建资源栈的面板。
   2. 在页面上面菜单栏中，选择地域。
      
      该地域需为您账号A下的日志服务Project所在地域。
   3. 输入日志服务信息。
      
      | **参数** | **说明** |
      | --- | --- |
      | **SLS日志服务项目名称** | project-test |
      | **日志样例** | 日志样例，例如：  ``` 127.0.0.1 - - [10/Sep/2018:12:36:49 +0800] "GET /index.html HTTP/1.1" 200 612 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36" ``` |
      | **日志路径** | 根据日志在ECS实例上的位置，设置日志文件路径。  * 如果是Linux系统中的日志路径，必须以正斜线（/）开头，例如/apsara/nuwa。 * 如果是Windows系统中的日志路径，必须以盘符开头，例如C:\Program Files\Intel。 |
      | **日志文件名** | 设置日志文件的名称。 |
   4. 设置B账号信息。
      
      | **参数** | **说明** |
      | --- | --- |
      | **阿里云账号B的uid** | 阿里云账号B的ID。您可以在[账号中心](https://account.console.aliyun.com/v2/#/basic-info/index)查看阿里云账号ID。 |
      | **扮演账号B的角色名称** | 输入您在步骤1中创建的RAM角色的名称。 |
      | **账号B下的ECS实例Id** | 日志所在的ECS实例ID。 |
   5. 单击**创建**。
      
      当**资源栈信息**页签的状态栏变成**已创建**时，表示已完成资源和模型部署。
#### 通过日志审计服务跨账号采集云产品日志

1. 打开[一键配置ROS模板链接](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/documents/solution/collect-oss-logs.yml&isSimplified=true)前往ROS控制台，系统自动打开使用新资源创建资源栈的面板。
2. 选择**鉴权模式**进行资源创建。
   
   **重要** 
   
   仅支持企业账号开通资源管理（Resource Management），个人账号请通过自定义鉴权模式（User-defined）完成多账号配置。
   
   * 选择**鉴权模式**为**Resource Management**，单击**创建**，当**资源栈信息**页签的状态栏变成**已创建**时，表示已完成资源和模型部署。
   * 选择**鉴权模式**为**User-defined**，输入**AccessKey ID**和**AccessKey Secret**，并单击**创建**。AccessKey说明，请参见[自定义鉴权管理模式](https://help.aliyun.com/zh/sls/user-guide/configure-multi-account-collection#section-5kq-v6q-6ea)。
     
     当**资源栈信息**页签的状态栏变成**已创建**时，表示已完成资源和模型部署。
### 完成及清理


### 方案验证

完成跨账号日志采集后，您可以通过日志服务控制台查看相关数据。

#### 通过Logtail跨账号采集ECS日志

1. 登录。
2. 进入目标project，在日志库列表中，单击目标logstore。
3. 单击![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1527417861/p684493.png)进入查询分析界面，单击**查询/分析**查看日志信息。

![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0318299861/p696374.png)

#### 通过日志审计服务跨账号采集云产品日志

1. 登录。
2. 在**日志应用**区域的**审计与安全**页签下，单击**日志审计服务**。
3. 单击**审计配置** > **云产品接入** > **全局数据**，查看日志审计全局数据视图或单击**审计报表** > **中心化** > **OSS**，查看云产品全局数据视图。

![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4157299861/p696365.png)

### 清理资源

在本方案中，您为两个账号分别创建了1台云服务器ECS实例、1个日志服务project和1个对象存储OSS Bucket。测试完方案后，您可以参考以下规则处理对应产品的实例，避免继续产生费用：

1. 释放2台云服务器ECS实例：
   
   登录[ECS控制台](https://ecs.console.aliyun.com)，在**实例**页面，找到目标实例，然后在**操作**列选择**![216更多-竖向..png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6054474861/p673247.png)>释放设置**，根据界面提示释放实例。
2. 释放2个日志服务project：
   
   登录[日志服务控制台](https://sls.console.aliyun.com/)，进入目标Project，然后在左侧日志库列表中单击目标日志库，进入**数据接入 > Logtail配置**，删除Logtail。单击![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5620432861/p637510.png) **> 删除**，删除日志库。最后在日志服务控制台首页，删除目标Project。
3. 释放2个对象存储OSS Bucket：
   
   登录[对象存储OSS控制台](https://oss.console.aliyun.com)，在**文件列表**页面，找到文件，然后在文件右侧**操作**列，选择**![more](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3872617761/p572765.png)****>彻底删除**，根据界面提示删除文件。然后在左侧导航栏，选择**删除Bucket**，在**删除Bucket**页面，单击**删除Bucket**，然后根据界面提示删除Bucket。
