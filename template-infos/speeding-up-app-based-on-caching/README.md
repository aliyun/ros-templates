## 方案概览

本方案旨在基于云数据库Redis版（ApsaraDB for Redis）构建缓存以提速应用，提升业务系统的性能，降低响应时间，使应用能够承担更高的负载。

## 方案架构

方案提供的默认设置完成部署后在阿里云上搭建的运行环境如架构图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与架构图相似。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9537613271/p832288.png)

方案示例模拟了员工与部门关联的场景，通过HTTP API以部门ID为参数，获取部门下的员工ID以及姓名。数据优先从数据库中查询，选择使用Redis作为缓存后，首次加载仍然通过数据库查询，之后的查询将会优先从Redis中取出结果。在清理掉数据库数据之后，由于缓存在有效期，仍然可以查询到结果。

本方案的技术架构包括以下基础设施和云服务：

* 1个专有网络VPC：为应用型负载均衡ALB、云服务器ECS、云数据库 RDS MySQL 版、云数据库Redis版等云资源形成云上私有网络。
* 1台交换机：将1台云服务器ECS连接在同一网络上，实现它们之间的通信，并提供基本的网络分段和隔离功能。
* 1台云服务器ECS：用于部署模拟服务。
* 1个云数据库RDS MySQL版实例：为模拟服务提供数据服务。
* 1个云数据库Redis版实例：提供缓存服务

## 方案部署
### 部署准备


开始部署前，请按以下指引完成账号申请、账号充值、RAM用户创建和授权。

#### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。如果确定任何一个云资源采用按量付费方式部署，账户余额都必须大于等于100元。
### 一键部署


**ROS一键部署**
-----------

1. 打开[一键配置模板链接](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/speeding-up-app-based-on-caching.yml&hideStepRow=true&hideStackConfig=true&pageTitle=%E5%BA%94%E5%AF%B9%E9%AB%98%E5%B9%B6%E5%8F%91%EF%BC%8C%E5%88%A9%E7%94%A8Redis%E7%89%88%E7%BC%93%E5%AD%98%E5%AE%9E%E7%8E%B0%E6%9E%81%E9%80%9F%E5%93%8D%E5%BA%94&disableRollback=false&isSimplified=true&disabltion=true&productNavBar=disabled&balanceIntercept=true)前往ROS控制台，系统自动打开使用新资源创建资源栈的面板，并在**模板内容**区域展示YAML文件的详细信息。
   
   **说明** 
   
   ROS控制台默认处于您上次访问控制台时所在的地域，请根据您创建的资源所在地域修改地域后再执行下一步。（本次实验地域选择的是**杭州**）
2. 确认好地域后，保持页面所有选项不变，单击**下一步**进入**配置模板参数**页面。
3. 在**配置模板参数**页面修改资源栈名称，可用区，配置ECS实例（推荐使用**计算型c6，ecs.c6.large**）。填写完所有必选信息并确认后单击**创建**开始一键配置。
4. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
   
5. 完成资源栈部署后，您需要调用模拟服务的初始化接口导入模拟数据。
   
   1. 登录[ECS管理控制台](https://ecs.console.aliyun.com/)。
   2. 在左侧导航栏，选择实例与镜像>实例。
   3. 在顶部菜单栏，选择**华东1（杭州**）地域。
   4. 部署模拟应用服务。
      
      1. 在**实例**页面，找到创建的一台ECS实例，在其右侧**操作**列，单击**远程连接**。
      2. 在**远程连接**对话框的**通过Workbench远程连接**区域，单击**立即登录**，然后根据页面提示登录。
      3. 在终端中执行指令
         
         ```
         curl http://localhost:8080/initData?token=AppWithRedis
         ```
         
         如返回值为
         
         ```
         {"success":true,"message":"success","data":""}
         ```
         
         则说明测试数据准备完成。
      4. 登录[云数据库RDS控制台](https://rdsnext.console.aliyun.com/)，在**实例列表**页面，找到目标实例，点击实例名称；
      5. 在新页面点击**登录数据库**，如遇到提示**欢迎使用极简模式**，可以选择**跳过，直接使用**。如遇到提示**创建DMS服务关联角色**，点击**确认**。如遇到提示**实例自动接入开关**，默认选择为**开**，可根据需要选择，可以在界面右上角点击**实例自动接入：**进行配置。
      6. 如出现了**登录实例**对话框，输入数据库账号（此处为`rds`）密码（此处为用户设置的密码），管控模式选择**自由操作**，点击**登录**。
      7. 在SQLConsole窗口中输入
         
         ```
         SELECT * FROM `employee_department` 
         ```
         
         可以看到当前数据库中存在的数据。
### 完成及清理


#### 方案验证

**一、通过对比访问带缓存与不带缓存的接口，验证缓存功能**

完成了一键部署之后，通过ECS实例的公网IP可以访问应用接口，通过不同参数验证方案。

1. 验证不带缓存的接口
通过浏览器访问`http://<ECS公网IP>/getAllEmployeesInDepartment?departmentId=1&cacheFirst=false`接口，返回值为：

   ```
   {
     "success": true,
     "message": "success",
     "data": [
       {
         "id": 1,
         "name": "Alice"
       },
       {
         "id": 2,
         "name": "Ben"
       },
       {
         "id": 3,
         "name": "Charlotte"
       },
       {
         "id": 4,
         "name": "David"
       }
     ]
   }
   ```

2. 通过浏览器访问`http://<ECS公网IP>/getAllEmployeesInDepartment?departmentId=1&cacheFirst=true`接口，此时再次访问此接口，返回值为：
   ```
   {
     "success": true,
     "message": "success from cache",
     "data": [
       {
         "id": 1,
         "name": "Alice"
       },
       {
         "id": 2,
         "name": "Ben"
       },
       {
         "id": 3,
         "name": "Charlotte"
       },
       {
         "id": 4,
         "name": "David"
       }
     ]
   }
   ```
   
   可见`message`字段中提示当前数据从缓存中读取。

3. 验证缓存数据：
   1. 登录[云数据库Redis版控制台](https://kvstore.console.aliyun.com/Redis/)，在**实例列表**页面，找到目标实例，点击实例名称；
   2. 在新页面点击**登录数据库**，如出现了**登录实例**对话框，输入数据库账号（此处为`redis`）密码（此处为用户设置的密码），**安全托管**可以选择**不开启**，管控模式选择**自由操作**，点击**登录**。
   3. 在SQLConsole中输入：`GET department:1`![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3696417271/p852604.png)可以看到执行历史中返回值为接口数据：
      
      ```
      [{"id":1,"name":"Alice"},{"id":2,"name":"Ben"},{"id":3,"name":"Charlotte"},{"id":4,"name":"David"}]
      ```

**二、通过Locust性能测试，验证缓存减轻数据库压力**

为了进一步验证方案在高并发场景下数据库的压力情况，我们使用负载测试工具 [Locust](https://locust.io/)（参考[官方文档](https://docs.locust.io/en/stable/installation.html)安装） 进行测试。

1. 性能测试：无缓存接口
   
   1. 创建文件locustfile.py，完整代码如下：
      
      ```
      from locust import HttpUser, task, between
      
      class UserBehaviorWithoutCache(HttpUser):
          wait_time = between(1, 5)
      
          @task
          def query_department_without_cache(self):
              self.client.get("/getAllEmployeesInDepartment?departmentId=1&cacheFirst=false")
      
      if __name__ == "__main__":
          import os
          os.system("locust -f <this_script_name>.py")
      ```
   2. 在命令行中运行`locust`启动 Locust。打开浏览器，访问 Locust Web 界面 `http://localhost:8089`，如图所示填写新的测试参数。![image (1)](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3696417271/p852608.png)参数说明：
      
      * Number of users：并发用户数量。
      * Ramp up：即每秒钟增加的用户数量。
      * Host：目标系统的基地址，例如：http://<ECS公网IP>。
   3. 启动测试并执行一段时间后，点击 **Stop** 停止测试。
   4. 登录[云数据库RDS控制台](https://rdsnext.console.aliyun.com/)，在**实例列表**页面，找到目标实例，点击**监控。**![image (2)](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3696417271/p852610.png)
2. 性能测试：缓存接口
   
   1. 修改locustfile.py代码如下：
      
      ```
      from locust import HttpUser, task, between
      
      class UserBehaviorWithCache(HttpUser):
          wait_time = between(1, 5)
      
          @task
          def query_department_with_cache(self):
              self.client.get("/getAllEmployeesInDepartment?departmentId=1&cacheFirst=true")
      
      if __name__ == "__main__":
          import os
          os.system("locust -f <this_script_name>.py")
      ```
   2. 在命令行中运行`locust`启动 Locust，参考上一步的操作，完成测试，并查看RDS监控。![image (3)](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3696417271/p852617.png)
3. 对比分析：
   
   对比前后两次的数据库监控数据，可以明显看出，在测试无缓存接口时，数据库的流量吞吐量、TPS/QPS、执行次数等指标发生了显著变化，出现了一个处理波峰。而在访问带缓存的接口时，这些指标则更为平滑。具体来看，无缓存访问时的执行次数峰值接近700，而带缓存的情况下则稳定在个位数。这表明缓存机制能够有效缓解数据库的压力。

**三、通过删除数据库中的数据，验证缓存命中**

1. 清理数据库中的数据记录：
   
   1. 登录[云数据库RDS控制台](https://rdsnext.console.aliyun.com/)，在**实例列表**页面，找到目标实例，点击实例名称；
   2. 在新页面点击**登录数据库**，如出现了**登录实例**对话框，输入数据库账号（此处为`rds`）密码（此处为用户设置的密码），管控模式选择**自由操作**，点击**登录**。
   3. 在SQLConsole窗口中输入

   ```
   DELETE FROM `employee_department` 
   ```
   
   当**执行历史**出现提示：
   
   ```
   ------[执行成功]------
   [语句1]:  DELETE FROM `employee_department`
   [耗时]: 11 (ms)
   [影响行数]: 6
   ```
   
   说明数据清理完成。

2. 访问缓存接口：
   
   通过浏览器访问`http://<公网IP>/getAllEmployeesInDepartment?departmentId=1&cacheFirst=true`接口，返回值为：

   ```
   {
     "success": true,
     "message": "success from cache",
     "data": [
       {
         "id": 1,
         "name": "Alice"
       },
       {
         "id": 2,
         "name": "Ben"
       },
       {
         "id": 3,
         "name": "Charlotte"
       },
       {
         "id": 4,
         "name": "David"
       }
     ]
   }
   ```
   
   可见 `message` 字段中提示当前数据从缓存中读取，说明缓存已被正确命中。

#### 清理资源

在本方案中，您创建了1台云服务器ECS实例、1个交换机、1个专有网络VPC、1个云数据库RDS MySQL版实例和1个云数据库Redis版实例。测试完方案后，您可以参考以下规则处理对应产品的实例，避免继续产生费用：

1. 释放资源栈下的资源，即1台云服务器ECS实例、1个交换机、1个专有网络VPC、1个云数据库RDS MySQL版实例和1个云数据库Redis版实例。
   
   1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
   2. 在左侧导航栏，选择**资源栈**
   3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
   4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
