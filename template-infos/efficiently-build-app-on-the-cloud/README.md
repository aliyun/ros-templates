## **方案概览**

在移动设备占主导地位的今天，企业开发移动应用App可以帮助企业更好地适应数字时代的挑战，企业可以通过App为用户提供更便捷、更具互动性和更个性化的服务，帮助企业扩宽市场渠道、获得数据反馈，从而增加收入和竞争优势。使用阿里云移动研发平台开发您的App，可以帮您减轻技术负担，让您能更专注于业务核心，快速构建高可靠、高性能的移动应用，并且可以高效迭代您的移动应用。

## **方案架构**

方案提供的默认设置完成部署后在阿里云上搭建的移动应用架构如下图所示。![APP搭建架构图优化@2x](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7447757171/p808216.png)

本方案的技术架构包括以下基础设施和云服务：

* 应用
  
  + App服务端应用
  + iOS App
  + Android App
* 基础设施和云服务
  
  + 1个专有网络VPC：为云服务器ECS、云数据库 RDS MySQL 等云资源形成云上私有网络。
  + 1台交换机：将1台云服务器ECS和1台云数据库RDS连接在同一网络上，实现它们之间的通信，并提供基本的网络分段和隔离功能。
  + 1台云服务器ECS：用于部署App后端服务。
  + 1个云数据库RDS MySQL：为App后端服务提供数据服务。
  + 云解析DNS：将用户的请求解析到ECS。
  + 1个域名：用于为App后端程序提供访问域名。
  + 移动研发平台EMAS：提供一站式的App客户端应用研发运营管理服务，涵盖开发、测试、运维、运营等应用全生命周期。
  + 云效：一站式 DevOps 平台，支持通过流水线构建持续交付的研发流程。用于持续构建和部署App服务端。
## **方案部署**
### **部署准备**


开始部署前，请按以下指引完成账号申请、账号充值。

### **准备账号**

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册并进行个人实名认证。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。如果确定任何一个云资源采用按量付费方式部署，账户余额都必须大于等于100元。
### **一键部署**


一键部署基于阿里云资源编排服务ROS（Resource Orchestration Service）实现，ROS模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。ROS模板完成的内容包括：

#### 操作步骤

您可以通过下方提供的ROS一键部署链接，来自动化地完成这些资源的创建和配置：

* 创建1台云服务器ECS实例。
* 创建1个专有网络VPC。
* 创建1台交换机。
* 创建1个云数据库RDS MySQL。

1. 一键部署资源。
   
   1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/efficiently-build-app-on-the-cloud.yml&hideStepRow=true&hideStackConfig=true&pageTitle=移动开发秘籍：云上高效构建APP&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled)，在顶部导航栏选择地域。
   2. 在配置页面修改**资源栈名称**，按需选择和配置参数。
   3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
### **部署服务端**


#### **创建流水线**

1. 进入[云效控制台](https://devops.console.aliyun.com/organizations?channel=yy_fangan)，单击**立即使用**，按操作步骤创建您的企业、选择您的角色之后，点击开始工作。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0756675171/p783938.png)
2. 进入[流水线Flow](https://flow.aliyun.com/my?page=1&channel=yy_fangan)，点击**流水线**->**我的流水线**。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0756675171/p793300.png)
3. 点击右上角**新建流水线**。在弹出面板中选择**Java**，顶部选择**可视化编排**，找到**Java构建、部署到阿里云ECS/自有主机**流水线。![云效流水线.jpg](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p799513.jpg)
4. 点击**创建流水线**，进入流水线配置界面。

**配置流水线**
---------

云效支持多种**流水线源**，如多种代码仓库、已经编译好的代码包、对接Jenkins及另一个流水线的产出物。

1. 进入流水线后，在左侧选择**添加流水线源**。本文使用Codeup，更多流水线源配置请参考[配置流水线源](https://help.aliyun.com/document_detail/606514.html)。
   
   1. 单击**添加流水线源**。
   2. 选择流水线源为**代码源**，选择**Codeup**。
   3. 点击**新建代码仓库**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8075040271/p818258.png)
   4. 在代码管理页面右上角，单击**导入库**。
   5. 在**导入代码库**弹出框，选中**URL导入**，在源代码仓库地址填入`https://atomgit.com/aliyun_solution/app-demo-auto.git`，单击**确定**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8075040271/p818259.png)
   6. 回到流水线源配置页面，**代码仓库**选择刚刚创建的代码仓库，**默认分支**选择master。并点击**添加**，完成流水线源的配置。
2. 配置**Java构建上传**。更多构建相关信息可以参考[持续集成（CI）](https://help.aliyun.com/document_detail/153701.html)。
   
   1. 单击**Java构建上传**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p799558.png)
   2. 在右侧配置弹窗内，单击**构建物上传**，在打包路径下新增一个deploy.sh。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p798601.png)
   3. 在页面右上角，单击**仅保存**。
3. 配置环境变量，您需要将数据库连接地址和账号密码配置到流水线环境变量中。
   
   1. 在页面顶部导航选中**变量和缓存**，在页面中的**字符变量**模块单击**新增变量**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0756675171/p799597.png)
   2. 填入数据库相关信息，并设置成私密模式。相关数据可在[数据库控制台](https://rdsnext.console.aliyun.com/rdsList/cn-hangzhou)，进入数据实例详情页面查看。
      
      | **变量名称** | **默认值** |
      | --- | --- |
      | APPLETS\_RDS\_ENDPOINT | 数据库连接地址 |
      | APPLETS\_RDS\_USER | 数据库用户名 |
      | APPLETS\_RDS\_PASSWORD | 数据库密码 |
      | APPLETS\_RDS\_DB\_NAME | 数据库名称 |
4. 配置部署任务。
   
   1. 单击**主机部署**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p799560.png)
   2. 制品：下拉选择上游构建阶段的产物，如**制品名称.Artfacts\_xxx**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p799564.png)
   3. 配置主机组：
      
      1. 单击**新建主机组**，在新开的**全局设置 > 主机组管理**页面中再次单击**新建主机组**。
         
         ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p799569.png)
      2. 在**新建主机组**弹窗中，填入自定义的**主机组名称**，然后单击**确定**。
         
         ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p799570.png)
      3. 在主机组详情页面，单击**添加新主机**，**添加方式**选择**阿里云ECS**，单击**添加服务连接**。
         
         ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p799571.png)
      4. 在**新建服务连接**面板单击**+新建**，完成RAM授权后，创建服务连接。
         
         ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p799573.png)
      5. 回到**接入新主机**面板，**地域**下拉框选择**华东1（杭州）**，勾选您在该地域下创建的ECS实例，单击**保存**。
         
         ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p799578.png)
      6. 回到流水线**主机部署**的**编辑**面板，在**主机组**下拉框选中刚刚创建的主机组。
         
         ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p799579.png)
   4. 部署脚本填入如下脚本
      
      ```
      tar zxvf /home/admin/app/package.tgz -C /home/admin
      sh /home/admin/deploy.sh restart /home/admin/target/app-demo-0.0.1-SNAPSHOT.jar
      ```
   5. 单击流水线页面右上角**保存并运行**，在弹出的**运行配置**弹窗中单击**运行**。
#### 验证服务

1. 登录[ECS控制台](https://ecs.console.aliyun.com/server/region/cn-hangzhou)，在实例列表中找到之前创建的ECS实例，在**IP地址**列，复制公网IP。
2. 粘贴到浏览器地址栏访问，看到如下页面表示服务已经正常启动。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0756675171/p799452.png)
### **通过EMAS构建和发布移动App**


#### Android App

##### **云构建配置**

##### **1.1 创建代码仓库**

1. 打开[云效codeup](https://codeup.aliyun.com/)，在代码管理页面右上角，单击**导入库**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819287.png)
2. 在**导入代码库**弹出框，选中**URL导入**，在源代码仓库地址填入`https://atomgit.com/aliyun_solution/emas-android-demo.git`，单击**确定**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8075040271/p818259.png)
3. 导入成功后，在页面右上角单击**克隆/下载**，复制HTTPS地址。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3423950271/p819290.png)
4. 将代码克隆下载到本地。具体操作可参考[快速入门](https://help.aliyun.com/document_detail/153707.html)。

##### **1.2 创建项目**

1. 登录[EMAS控制台](https://emas.console.aliyun.com/)。
2. 如果是第一次使用EMAS，单击**立即创建项目**，如果已有项目，单击左侧**添加项目**。在右侧弹出框中，输入**项目名称**和**项目描述**，单击**创建并进入**。

##### **1.3 创建应用**

1. 进入项目详情页后，单击**立即添加应用**，输入**应用名称**、**应用类型**选择**Native**、**平台**选择**Android**，**PackageName**填入`com.example.emas_android_demo`，然后单击**创建应用**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819300.png)
2. 下载配置文件，按照提示添加到本地项目中。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819330.png)
3. 添加SDK，示例代码中已完成项目配置修改，无需在修改项目配置代码。
4. 修改代码中配置
   
   1. 在项目概览页面，单击应用列表中的应用管理按钮![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7447757171/p805344.png)。获取应用名称、AppKey、AppSecret。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819314.png)
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3423950271/p819318.png)
5. 打开本地项目，找到项目目录下app/src/main/assets下的appConfig.properties文件，填入appName、appKey和appSecret。serverUrl填入`http://[云服务器公网IP]`。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7447757171/p805347.png)
6. 提交代码到远程仓库。具体操作可以参考[快速入门](https://help.aliyun.com/document_detail/153707.html)。

##### **1.4 创建云构建**

1. 在项目概览页面，在右侧单击**云构建**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819320.png)
2. 在云构建页面，单击**配置应用**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819334.png)
3. 配置代码仓库
   
   1. 在右侧弹出框代码仓库页签下，选择代码源**云效codeup**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819336.png)
   2. 在指定代码仓库输入框中，粘贴之前创建的代码仓库地址。
   3. 单击**新建代码访问权限**。
      
      1. 在添加仓库权限页面，访问协议选择**HTTPS**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819338.png)
      2. 打开[云效codeup](https://codeup.aliyun.com/)，单击导航栏右上角头像图标，在弹出菜单中单击**个人设置**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819343.png)
      3. 在左侧菜单栏，单击**个人信息**，复制账号名称。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819344.png)
      4. 在添加仓库权限页面，在**账号**输入框填入刚刚复制的账号名称。
      5. 在个人设置页面左侧菜单栏，单击**个人访问令牌**，然后单击**创建访问令牌**。创建完成后，复制令牌信息。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819341.png)
      6. 回到添加仓库权限页面，**Token**输入框粘贴令牌信息。
      7. 单击**联通测试**，若显示测试成功则表示操作成功。
      8. 单击**保存**。
   4. 在配置代码仓库页签下，单击**联通测试**，若显示测试成功则表示配置成功。
   5. 单击**下一步**。
4. 配置证书
   
   1. 在**证书配置**页签下，上传Keystore证书，并按照表单输入如下信息。如果没有证书，可以访问[地址](https://www.applicationloader.net/keystore.html)在线生成。
      
      | 选项 | 说明 |
      | --- | --- |
      | Keystore密码 | 用于输入Keystore文件的密码。 |
      | Key 别名 | 用于指定证书的名称。 |
      | Key 密码 | 用于输入证书的密码。 |
   2. 单击**下一步**。
5. 人员配置，默认包含主账号，单击**确认**。
6. 在云构建流水线列表页面，找到刚刚创建的流水线，在右侧相关操作列，单击**详情**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819349.png)
7. 在右上角单击**编辑**，在编辑页面，单击**构建应用模块**。在左侧菜单选中**JDK版本替换**，将**JDK版本**修改为17。单击**确定**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819351.png)![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7447757171/p803546.png)
8. 单击**保存并运行**。
9. 运行成功后，可以在页面左侧产物，扫码或手动下载安装包到手机。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819353.png)

##### **云发布配置**

1. 新建发布包流水线
   
   1. 在左侧菜单，选择**云构建** > **流水线列表**，单击**新建流水线**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3423950271/p819378.png)
   2. 在**新建流水线**滑框内容，输入**流水线名称**，**流水线类型**选择**发布包流水线**，单击**新建**。
      
      | 选项 | 说明 | 示例 |
      | --- | --- | --- |
      | 流水线名称 | 用于设置流水线的名称。  【数据类型】字符串  【取值范围】2～20个任意字符  【是否必选】是 | 发布流水线 |
      | 流水线类型 | 选择**构建包流水线**或**发布包流水线**，发布包流水线用于与云发布服务的发布单关联。 | 发布包流水线 |
      | 版本号 | 用于自定义该发布流水线生成的应用版本。  【数据类型】字符串  【取值范围】2-4位数字  【是否必选】是  【示例】1.0、1.0.0、1.0.0.0 | 1.0.1 |
      | VersionCode | 自定义Android系统中应用的实际版本，比如APK安装时会判断版本，确定是否需要升级安装等。  【数据类型】字符串  【取值范围】正整数  【是否必选】是  【示例】1、2、3 | 1 |
      | 说明 | 用于添加流水线的说明。  【数据类型】字符串  【取值范围】0～200个任意字符  【是否必选】否 | 测试包更新 |
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819380.png)
   3. 在流水线列表页面，单击刚刚创建的流水线的**相关操作**列**详情**，进入详情页面。
   4. 在右上角单击**编辑**，在编辑页面，单击**构建应用模块**。在左侧菜单中选中**JDK版本替换**，修改J**DK版本**为17。单击**确定**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7447757171/p803546.png)
   5. 单击**保存并运行**。
2. 新建发布单
   
   1. 在左侧菜单，选择**云发布** > **发布单列表**，单击**新建发布单**。
   2. 在新建发布单滑框内，待发布产品来源选择**云构建发布**，关联流水线选择刚刚创建的发布包流水线。
   3. 单击**新建**。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3423950271/p819382.png)
3. 推送更新
   
   1. 在发布单列表页，单击发布状态列**更新推送**。按照表单填写后，单击**下一步**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819386.png)
      
      | 选项 | 说明 | 示例 |
      | --- | --- | --- |
      | 版本号 | 默认设置为当前发布流水线的版本号。 | 1.0.1 |
      | 发布类型 | 设置本轮更新推送的发布类型，包括**灰度发布**和**全量发布**2种发布类型。 | 全量发布 |
      | 最低API Level | 用于设置Android系统版本对应的编号。鼠标移动至帮助按钮，从快捷菜单中单击**查看API Level列表**链接，根据Android平台版本，查看对应的API Level编码。 | 1 |
      | 更新文案 | 用于设置当前更新推送在客户端显示的提醒文案，字符长度为10-200。 | 测试更新发布，请立即更新。 |
   2. 在基本策略页面，填入表单信息。
      
      | 选项 | 说明 | 示例 |
      | --- | --- | --- |
      | 提醒更新版本 | 用于设置提示更新的App版本。  【是否必选】否  【配置说明】  * 如设置多个版本，用“,”分隔。 * 支持设置版本区间，用“-”连接。 * 如未设置该参数，则在推送范围内，所有版本低于当前发布版本的App，提示版本更新。 【示例】1.0.0,1.0.2-1.0.8，表示设置以下版本提示版本更新：1.0.0/1.0.2/1.0.3/1.0.4/1.0.5/1.0.6/1.0.7/1.0.8。 | 可不填 |
      | 提醒更新次数 | 用于设置同一版本的更新推送，在同一设备的提示次数。 | 1 |
      | 提醒更新策略 | 用于基于手机端交互方式和网络环境，选择相应的更新策略。  【取值范围】  * **提示更新**：在App启动时，提示版本更新，且提示次数不大于**提醒更新次数**。 * **强制更新**：在App启动时，强制进行版本更新。 * **强制更新，非WiFi模式提示**：在App启动时，强制进行版本更新。如果当前网络非WiFi模式，则提示用户确认是否立即更新。 * **勿扰模式A：不主动提醒，可手动检测**：不主动提示版本更新，用户可手动检测更新。 * **勿扰模式B：仅WiFi下提醒，非WiFi下勿扰，可检测**：如当前网络为Wifi模式，则提醒版本更新；否则，不提醒版本更新，但可手动检测更新。 | 提示更新 |
      | 任务开始时间 | 用于设置本次更新推送任务的开始时间。 | 使用默认 |
   3. 单击**确定**。
4. 查看手机上安装的App，可以看到更新提示。![android](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3687757171/p808238.png)
#### iOS App

#### **前提条件**

* 需要您已经注册成为apple开发者，并且导出了开发者p12证书。详细操作参考[apple文档](https://developer.apple.com/cn/support/account/)。

#### **云构建配置**

#### **1.1 创建代码仓库**

1. 打开[云效codeup](https://codeup.aliyun.com/)，在代码管理页面右上角，单击**导入库**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819287.png)
2. 在**导入代码库**弹出框，选中**URL导入**，在源代码仓库地址填入`https://atomgit.com/aliyun_solution/emas-ios-demo.git`，单击**确定**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8075040271/p818259.png)
3. 导入成功后，在页面右上角单击**克隆/下载**，复制HTTPS地址。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819302.png)
4. 将代码克隆下载到本地。具体操作可参考[快速入门](https://help.aliyun.com/document_detail/153707.html#23b3736063w86)。

#### **1.2 创建项目**

1. 登录[EMAS控制台](https://emas.console.aliyun.com/)。
2. 如果是第一次使用EMAS，单击**立即创建项目**，如果已有项目，单击左侧**添加项目**。在右侧弹出框中，输入**项目名称**和**项目描述**，然后单击**创建并进入**。

#### **1.3 创建应用**

1. 进入项目详情页后，单击左上角的**添加应用**，输入**应用名称**、**应用类型**选择**Native**、**平台**选择**iOS**，**PackageName**填入`com.aliyun.emasdemo`，然后单击**创建应用**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819300.png)
2. 下载配置文件，按照提示添加到本地项目中。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819390.png)
3. 修改`TodoViewModel.swift`，serverUrl填入`http://[公网IP]`。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7447757171/p807639.png)
4. 提交代码到远程仓库。具体操作可以参考[快速入门](https://help.aliyun.com/document_detail/153707.html#fbeec96063oss)。
5. 添加SDK，示例代码中已完成项目配置修改，无需在修改项目配置代码。

#### **1.4 创建云构建**

1. 在项目概览页面，在右侧单击**云构建**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819388.png)
2. 在云构建页面，单击**配置应用**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819391.png)
3. 配置代码仓库。
   
   1. 在右侧弹出框代码仓库页签下，选择代码源**云效codeup**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819336.png)
   2. 在指定代码仓库输入框，粘贴之前创建的代码仓库地址。
   3. 单击**新建代码访问权限**。
      
      1. 在添加仓库权限页面，访问协议选择**HTTPS**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819338.png)
      2. 打开[云效codeup](https://codeup.aliyun.com/)，单击导航栏右上角头像图标，在弹出菜单中单击**个人设置**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819343.png)
      3. 在左侧菜单栏，单击**个人信息**，复制账号名称。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819344.png)
      4. 在添加仓库权限页面，在账号输入框填入刚刚复制的账号名称。
      5. 在个人设置页面左侧菜单栏，单击**个人访问令牌**，然后单击**创建访问令牌**。创建完成后，复制令牌信息。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819341.png)
      6. 回到添加仓库权限页面，**Token**输入框粘贴令牌信息。
      7. 单击**联通测试**，若显示测试成功则表示成功。
      8. 单击**保存**。
   4. 在配置代码仓库页签下，单击**联通测试**，若显示测试成功则表示成功。
   5. 单击**下一步**。
4. 配置证书
   
   1. 在证书配置页签下。
      
      1. 上传p12证书。
      2. 输入证书密码。
      3. 针对示例应用emasdemo生成.mobileprovision文件，单击**上传文件**，完成上传。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819397.png)
   2. 单击**下一步**。
5. 人员配置，默认包含主账号，单击**确认**。
6. 在云构建流水线列表页面，找到刚刚创建的流水线，在右侧相关操作列，单击**详情**。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819399.png)
7. 在右上角单击**编辑**，在编辑页面，单击**构建应用**模块。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3423950271/p819402.png)
   
   1. 配置构建命令。
      
      1. 左侧选择**执行构建命令**。
      2. **scheme**填入emasdemo。
      3. **xcodeproj**填入./emasdemo.xcodeproj。
      4. **xcworkspace**填入./emasdemo.xcworkspace。
      5. **configuration**填入Debug。
      6. **export-method**选择**development**。
   2. 单击**确定**。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3423950271/p819403.png)
8. 单击**保存并运行**。
9. 运行成功后，可以在页面左侧产物，使用手机相机扫码或手动下载安装包到手机。
   
   **说明** 
   
   当前采用的打包模式是Development，需要您将您下载应用的手机设置为开发者模式。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2423950271/p819407.png)

#### **云发布配置**

对于iOS应用，因平台限制，云发布仅对应用版本及发布状态进行管理。

### **申请域名与证书（可选）**

20

#### **域名申请和备案**

1. 创建域名信息模板并实名认证
   
   1. 登录[阿里云域名控制台](https://dc.console.aliyun.com)。
   2. 在左侧导航栏单击**信息模板**，在**信息模板**页面单击**创建新信息模板**。
      
      ![1](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3124796761/p571548.png)
   3. 根据界面提示，完成域名持有者信息填写，单击**提交**。
      
      展开查看填写说明。
      
      | **参数** | **个人** | **企业/组织** |
      | --- | --- | --- |
      | 域名持有者类型 | 选择**个人**。 | 选择**企业/组织**。 |
      | 信息填写方式 | 选择是否自动关联您的阿里云账号信息。 **说明**  如果您使用子账号登录域名控制台，则页面中没有此参数，您需手动填写域名持有者信息。 | |
      | 域名联系人（中文） | 无 | 填写域名联系人名称，通常是公司的技术人员作为域名联系人。 |
      | 所属区域 | 选择真实有效的通讯地址。 | 选择与营业执照上一致的区域。 **说明**  如果无法选择省市信息，建议您更换浏览器或更换网络环境。 |
      | 通讯地址（中文） | 填写真实有效的通讯地址。 | 填写与营业执照上一致的通讯地址。 |
      | 邮编 | 填写通讯地址所在地的邮政编码。 | 填写企业所在地的邮政编码。 |
      | 电子邮箱 | 填写域名联系人的电子邮箱，填写完成后请单击输入框下方的**点击进行****邮箱验证**，进行验证。 **说明**  * 建议不要使用test@test.club等新顶级域名后缀邮箱，避免域名订单长时间处于处理中状态，错失域名抢注等机会。 | |
      
      实名认证上传材料填写样例请参见如下：
      
      * [填写样例（个人）填写样例](https://help.aliyun.com/document_detail/108547.html#concept-f1l-skf-xgb)
      * [填写样例（组织）](https://help.aliyun.com/document_detail/108214.html#concept-gxx-hf3-wgb)
   4. 在[阿里云域名控制台](https://dc.console.aliyun.com)的左侧导航栏的**信息模板**中找到待查看的信息模板，查看**实名认证状态**。
      
      **说明** 
      
      域名实名认证资料的审核通常在1个工作日内可以完成，部分可能需要3~5个工作日，请您耐心等待审核结果。
2. 购买域名
   
   1. 查询域名。
      
      1. 登录[阿里云域名注册](https://wanwang.aliyun.com)。
      2. 在阿里云域名注册页面的搜索框中，搜索您想要注册的域名以及域名后缀，单击**查询域名**。
         
         ![1](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4395653271/p686823.jpg)
   2. 加入域名清单。
      
      1. 对于查询结果为**未注册**的域名，单击**加入清单**。
         
         ![加入清单](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3906353271/p410819.jpg)
      2. 在**域名清单**中确认已添加的域名，单击**立即购买**。
   3. 确认订单信息。
      
      1. 在**确认订单**页面，选择域名的购买年限和域名所有者类型。
         
         ![确认订单](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4395653271/p410805.jpg)
         
         **说明** 
         
         若您注册的是“.gov.cn”后缀域名，域名持有者类型只能为**企业**。
      2. 选择已完成实名认证的域名持有者信息模板。
   4. 选择支付方式后，单击**立即支付**。
      
      完成支付后，域名注册订单会短暂的显示为**处理中**状态，待订单状态变为**成功**，域名即注册成功。
      
      * 域名注册过程中的常见问题，请参见[域名注册FAQ](https://help.aliyun.com/document_detail/57976.html#concept-k3f-c2d-b2b)。
      * 如果域名注册失败，请参见[域名注册失败原因](https://help.aliyun.com/document_detail/84870.html)进行排查处理。
3. ICP备案前准备
   
   1. **（可选）前置审批。**
      
      新闻类、出版类、药品和医疗器械类、文化类、广播电影电视节目类、教育类、医疗保健类、网络预约车、电子公告类等行业的互联网信息服务，需联系当地机关办理对应的前置审批手续。各类行业对应的办理机关及手续类型请参见[前置审批](https://help.aliyun.com/document_detail/113602.html#concept-lc5-m1z-3hb)。
   2. **管局规则。**
      
      了解ICP备案所在地域的管局规则，根据管局要求准备ICP备案的材料。详细信息请在[各地区管局备案规则](https://help.aliyun.com/document_detail/50270.html#undefined)中单击对应省份查看。
4. 提交ICP备案
   
   1. **填写信息进行校验。**
      
      在[阿里云ICP代备案管理系统](https://beian.aliyun.com/order/index.htm)，根据界面提示，按要求填写主办单位信息和网站/App信息等，系统将根据您所填信息，自动校验是否可以进行ICP备案。
   2. **阿里云初审。**
      
      提交ICP备案初审订单后，订单状态为**阿里云审核中**，阿里云将会在**1个工作日**左右进行审核，具体以实际审核时间为准。
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p783331.png)
   3. **（可选）邮寄资料。**
      
      **说明** 
      
      阿里云初审后如果需要您邮寄资料，审核人员会通知您。如果您在初审时未收到需要邮寄资料的相关通知，则无需邮寄资料，ICP备案流程将进入下一个阶段。
   4. **工信部短信核验。**
      
      当需要验证的手机号收到工信部发出的验证码短信后，您需在收到核验短信的24小时内，访问[工信部备案管理系统](https://beian.miit.gov.cn/)进行短信核验。
      
      **说明** 
      
      建议通过手机移动数据（关闭WiFi连接）进行短信核验。
      
      1. 进入[工信部备案管理系统](https://beian.miit.gov.cn)，单击**短信核验**。
      2. 填写短信核验信息。
         
         在**短信核验**页签下，根据下方要求填写短信验证码、手机号码、证件号码后6位等信息，填写完成后单击**提交**，系统将进行自动审核。
         
         ![短信核验项](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7110016061/p184448.png)
      3. 确认短信核验结果。
         
         * 如系统提示**您的短信核验已全部完成，该请求将提交管局审核**，说明您的ICP备案订单已完成短信核验操作。
           
           **说明** 
           
           短信核验成功后，您的ICP备案订单将直接进入管局审核，工信部不会下发短信通知。短信核验结果会在24小时内同步至阿里云，您可前往[阿里云ICP代备案管理系统](https://beian.aliyun.com/order/index.htm)在**我的备案**中查看。
           
           ![核验完成](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1289906061/p184442.png)
         * 如系统提示**您的短信核验完成，请等待其他核验人进行短信核验**，说明您的ICP备案订单中还有其他需要验证的手机号码，请联系其他负责人及时完成核验。
           
           ![还有一个人没有核验](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1289906061/p184443.png)
   5. **管局审核。**
      
      订提交管局后订单为**待提交管局**状态，阿里云审核专员将会在**1个工作日**左右将您的订单提交至管局审核，具体以实际提交时间为准
      
      各省管局审核时间不同，实际审核时长会根据ICP备案场景有所不同，一般为1~20个工作日，具体以实际审核时间为准。管局审核通过后表示您的ICP备案即已完成，审核结果会发送至您的手机和邮箱。
5. ICP备案后操作
   
   1. **添加ICP备案号及版本所有 。**
      
      ICP备案成功后，您需要在互联网信息服务底部添加备案号和跳转至工信部的链接，以便访问者查询确认ICP备案信息。部分省份管局要求，例如江苏省，需要在互联网信息服务下方添加版权所有。详情请参见[添加ICP备案号和版权处理](https://help.aliyun.com/document_detail/146190.html#concept-2356706)。
   2. **（可选）ICP许可证。** 
      
      如果您的互联网信息服务属于经营性网站或App（通过互联网向上网用户有偿提供信息或者网页制作等服务活动），则需在ICP备案后申请经营性ICP许可证。详情请参见[经营性备案](https://help.aliyun.com/document_detail/36978.html#concept-rhw-fsl-zdb)。
      
      **说明** 
      
      弹性Web托管服务器不支持经营性备案。
   3. **公安联网备案。**
      
      依据 **《计算机信息网络国际联网安全保护管理办法》**相关规定，各互联网信息服务在工信部备案成功后，需在开通之日起30日内登录[全国互联网安全管理服务平台](http://www.beian.gov.cn/portal/index?spm=a2c4g.11186623.2.1.SRC9LP)提交公安联网备案申请。详情请参见[公安联网备案及注销](https://help.aliyun.com/document_detail/43898.html#concept-dw1-2sl-zdb)中国站备案文档中的公安联网备案。
#### 配置域名解析

申请域名后，您需要配置域名解析到ECS实例的公网IP，实现App服务端可访问的服务。

1. 登录[云解析DNS控制台](https://dns.console.aliyun.com/#/dns/domainList)。
2. 在**域名解析**页面，权威域名页签下，点击目标域名处的**解析设置**按钮，进入解析设置页面。
3. 单击**添加记录**，填写域名解析信息，然后单击**确认**。
   
   | 配置项 | 说明 | 示例值 |
   | --- | --- | --- |
   | **记录类型** | 选择域名指向的类型。 此处选择**A**。 | A |
   | **主机记录** | 根据域名前缀填写主机记录。本方案以顶级域名为例，例如`example.com`，输入**@**。 | @ |
   | **记录值** | 填写ECS实例的公网ID。 | 10.0.x.x |
   | **TTL** | 域名的更新周期，保留默认值。 | 10分钟 |
#### **申请SSL证书**

1. 领取免费证书额度。
   
   1. 登录[数字证书管理服务控制台](https://yundunnext.console.aliyun.com/?p=cas)。
   2. 在左侧导航栏，选择**证书管理** > **SSL证书管理**。
   3. 在**个人测试证书（原免费证书）**页签，单击**立即购买**。
   4. 在**立即购买**面板，参考下表购买免费证书，仔细阅读并勾选**服务协议**，单击**立即购买**并完成支付。
      
      | **配置项** | **示例** |
      | --- | --- |
      | **产品** | **个人测试证书** |
      | **证书类型** | **个人测试证书（免费版）** |
      | **服务** | 保持默认 |
      | **购买数量** | 保持默认 |
      | **其他服务** | **不需要** |
2. 提交证书申请。
   
   1. 返回**个人测试证书（原免费证书）**页签，单击**创建证书**。
   2. 在**证书申请**面板，配置证书参数，选中**快捷签发**，单击**提交审核**。
      
      | **配置项** | | **说明** |
      | --- | --- | --- |
      | **证书类型** | | 选择**个人测试证书（免费版）**：证书签发后有效期3个月。 |
      | **证书剩余数量/总数** | | 表示**剩余可申请的证书个数/总共可申请的证书**个数。只有当剩余可申请的证书个数不为0时，您才可以创建证书。 |
      | **域名名称** | | 填写该证书用于保护的网站域名。  申请个人测试证书时，此处只可以填写一个单域名，例如，`aliyundoc.com`。 **重要**  * 不支持后缀为特殊词的域名申请个人测试证书。例如`.edu`、`.gov`、`.org`、`.jp`、`.pay`、`.bank`、`.live`、`.nuclear`和`.ru`等等。正式证书无此限制。如果您需要为后缀为特殊词的域名申请证书，您只能申请正式证书。 * 不支持为公网IP申请个人测试证书。仅Globalsign、GeoTrust、vTrus、CFCA品牌的OV单域名证书支持绑定IP。具体操作，请参见[购买SSL证书](https://help.aliyun.com/document_detail/28542.html#task-q3j-zfp-ydb)。 * 如需一次操作申请多个域名的证书，需购买正式证书。具体操作请参见[购买SSL证书](https://help.aliyun.com/document_detail/28542.html#task-q3j-zfp-ydb)。 |
      | **数量** | | 证书数量，默认为1，不支持增加。 |
      | **快捷签发** **说明**  快捷签发是指在当前步骤填写证书申请资料并提交审核。 | **域名验证方式** | * 如果您**当前的阿里云账号与域名的DNS云解析服务所在账号一致**，申请证书时，阿里云数字证书管理服务将会自动识别，并默认选择**自动DNS验证**方式，且不支持修改，提交审核后，系统会自动进行DNS验证。 * 如果您**当前的阿里云账号与域名的DNS云解析服务所在账号不一致**，您可以选择以下任意一种方式进行域名所有权验证。    + **手动DNS验证**：您需要手动修改域名的DNS解析记录，并在证书绑定域名的域名控制台，添加一条解析记录用于域名所有权验证。   + **域名授权自动化验证**：您需要手动在对应的DNS域名解析服务商，添加一条CNAME类型的解析记录用于域名所有权验证。添加成功后，后续申请对应域名的SSL证书时可以直接选择该方式，且无需再添加域名解析记录。具体操作，请参见[域名所有权验证](https://help.aliyun.com/document_detail/48016.html#task-2086114)。   + **文件验证**：您需要手动从数字证书管理服务控制台下载一个专用的证书验证文件，然后将该文件上传到站点服务器的指定验证目录。 |
      | **联系人** | 从下拉列表中选择本次证书申请的联系人（包含邮箱、手机号码等联系信息）。 **重要**  收到证书申请请求后，CA中心会向联系人邮箱发送证书申请验证邮件或者通过联系人手机号码沟通审核相关事宜。因此，请务必确保联系人信息准确且有效。  如果您未创建过联系人，可以单击**新建联系人**，新建一个联系人。您也可以单击目标联系人的**编辑**按键，修改现有联系人的信息。数字证书管理服务会保存新建的联系人信息，方便您下次使用。关于新建联系人的具体配置，请参见[管理联系人](https://help.aliyun.com/document_detail/198262.html#section-3ao-ncx-vkt)。 |
      | **所在地** | 选择申请人所在城市或地区。 |
      | **密钥算法** | 证书使用的密钥算法。  默认选择为**RSA**，且不支持修改。RSA算法是目前在全球应用广泛的非对称加密算法，兼容性好。 |
      | **CSR生成方式** | CSR（Certificate Signing Request）文件是您的证书请求文件。该文件包含您的SSL证书信息，例如，证书绑定的域名、证书持有主体的名称及地理位置信息等。  您向CA中心提交证书申请时，必须提供CSR。CA中心审核通过您的证书申请后，将使用其根CA私钥为您提供的CSR签名，生成SSL证书公钥（即签发给您的SSL证书）。SSL证书的私钥即您在生成CSR时同时生成的私钥。  您可以选择以下CSR生成方式：  * **系统生成**：表示由数字证书管理服务自动使用您在**密钥算法**指定的加密算法生成CSR文件（您可以在证书签发后下载证书和私钥）。推荐您使用该方式。 * **手动填写**：表示您是使用OpenSSL或Keytool等工具手动生成的CSR和私钥文件，并将CSR内容复制粘贴到**CSR文件内容**（私钥文件由您自行保管）。关于如何制作CSR和私钥文件，请参见[如何制作CSR文件](https://help.aliyun.com/document_detail/42218.html#0f0749505frnz)。 **重要**    + **CSR生成方式**选择**手动填写**后，您将无法在数字证书管理控制台将该证书部署到阿里云产品中。   + 申请国密算法证书且选择手动填写CSR时，由于私钥不在阿里云，获得的加密证书需要私钥配合完成解密，请您联系私钥生成方协助完成解密工作。   + 您提供的CSR内容正确与否直接关系到证书申请流程是否能顺利完成，建议您使用数字证书管理服务自动生成的CSR（即选择**系统生成**方式），避免因提供的CSR内容不正确导致证书审核失败。   + 请确保您手动填写的CSR使用的加密算法与**密钥算法**中选择的算法相同，否则您将无法顺利提交证书审核。 如果您不清楚CSR使用的加密算法，您可以通过**查看CSR**工具查看，具体操作，请参见[查看CSR详情](https://help.aliyun.com/document_detail/469153.html#section-2q5-suh-d6s)。   + 在制作CSR文件时请务必保存好您的私钥文件。私钥和SSL证书一一对应，一旦私钥丢失，您的SSL证书也将不可使用。阿里云不负责保管您的私钥，如果您的私钥丢失，您必须重新购买SSL证书。 * **选择已有的CSR**：表示从您在数字证书管理服务控制台创建的CSR或上传的CSR中，选择与**证书绑定域名**相匹配的CSR。  您必须先使用数字证书管理服务提供的CSR管理工具手动创建CSR或上传已有的CSR，才可以使用该方式。具体操作，请参见[创建CSR](https://help.aliyun.com/document_detail/313297.html#section-r2b-rdg-5ze)和[上传CSR](https://help.aliyun.com/document_detail/313297.html#section-c03-6jn-fdc)。 **重要**  您选择的CSR使用的加密算法需要和您在**密钥算法**中设置的算法相同，否则您将无法顺利提交证书审核。如果您不清楚CSR使用的加密算法或域名，您可以通过**查看CSR**工具查看，具体操作，请参见[查看CSR详情](https://help.aliyun.com/document_detail/469153.html#section-2q5-suh-d6s)。 |
      | **CSR文件内容** | 只有在**CSR生成方式**为**手动填写**或**选择已有的CSR**时，需要配置该参数。在此处填写您的CSR文件内容。 |
   3. 按照**验证信息**中的提示，完成域名所有权的验证。
      
      域名所有权验证成功后，证书通常会在1~2个工作日完成签发，最快10分钟内签发。证书签发后，证书**状态**将变更为**已签发**。如果SSL证书长时间未签发，请您检查DNS验证配置是否正确。域名所有权验证更多信息和常见报错，请参见[域名所有权验证](https://help.aliyun.com/document_detail/48016.html#task-2086114)。
      
      **说明** 
      
      如果您未选中**快捷签发**，创建证书申请后，您将获得一个证书（对应要申请的证书）。您需要在该证书**操作**列，单击**证书申请**，填写证书申请信息并提交审核后，再按照该步骤进行验证。
#### **安装SSL证书**

1. 下载SSL证书。
   
   1. 登录[数字证书管理服务控制台](https://yundunnext.console.aliyun.com/?p=cas)。
   2. 在左侧导航栏，选择**证书管理** > **SSL证书管理**。
   3. 在**SSL证书管理**页面，定位到目标证书，在**操作**列，单击**更多**，然后选择**下载**页签。
   4. 在**服务器类型**为Nginx的**操作**列，单击**下载**。
      
      ![image..png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1097065861/p677531.png)
   5. 解压缩已下载的SSL证书压缩包。
      
      根据您在提交证书申请时选择的CSR生成方式，解压缩获得的文件不同，具体如下表所示。![CSR](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2050165861/p677479.png)![in](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7669116861/p679645.png)
      
      | **CSR生成方式** | **证书压缩包包含的文件** |
      | --- | --- |
      | **系统生成**或**选择已有的CSR** | * 证书文件（PEM格式）：Nginx支持安装PEM格式的文件，PEM格式的证书文件是采用Base64编码的文本文件，且包含完整证书链。解压后，该文件以`证书ID_证书绑定域名`命名。 * 私钥文件（KEY格式）：默认以*证书绑定域名*命名。 |
      | **手动填写** | * 如果您填写的是通过数字证书管理服务控制台创建的CSR，下载后包含的证书文件与**系统生成**的一致。 * 如果您填写的不是通过数字证书管理服务控制台创建的CSR，下载后只包括证书文件（PEM格式），不包含证书密码或私钥文件。您可以通过证书工具，将证书文件和您持有的证书密码或私钥文件转换成所需格式。转换证书格式的具体操作，请参见[证书格式转换](https://help.aliyun.com/document_detail/469153.html#section-7pl-isf-owk)。 |
2. 在ECS实例上安装Nginx服务
   
   1. 登录[ECS控制台](https://ecs.console.aliyun.com/server/region/cn-hangzhou)，在列表操作列单击远程连接，在远程连接模态框，单击**通过Workbench远程连接**对应的**立即登录。**
   2. 安装nginx
      
      1. 修改uwsgi服务端口，避免端口占用造成nginx启动失败，将`http=0.0.0.0:80`改为`socket=127.0.0.1:5000`
         
         ```
         cd /data && sudo vim uwsgi.ini
         ```
      2. 重启uwsgi服务
         
         ```
         sudo /usr/local/bin/uwsgi --stop /data/uwsgi.pid
         sudo /usr/local/bin/uwsgi /data/uwsgi.ini
         ```
      3. 执行命令安装Nginx。
         
         ```
         sudo yum update && sudo yum -y install nginx
         ```
      4. 启动Nginx。
         
         ```
         sudo systemctl start nginx
         ```
      5. 执行以下命令，查看Nginx服务的运行状态。
         
         如果回显信息显示`Active：active（running）`时，表示Nginx已启动。
         
         ```
         systemctl status nginx
         ```
      6. 创建反向代理配置文件。
         
         ```
         sudo vim /etc/nginx/conf.d/app.conf
         ```
      7. 进入Vim编辑器后，按`i`键进入编辑模式。
         
         ```
         server {
             listen 80 default_server;
             
             server_name app.example.com;
         
             root /var/www/html;
         
             # Add index.php to the list if you are using PHP
             index index.html index.htm index.nginx-debian.html;
         
             location / {
                 # 转发端口
                 uwsgi_pass  127.0.0.1:5000;
                 include uwsgi_params;
             }
         }
         ```
      8. 粘贴后，按Esc键，输入`:x`保存并退出编辑。
      9. 重启Nginx。
         
         ```
         nginx -s reload
         ```
3. 在Nginx服务器安装证书。
   
   1. 执行以下命令，在Nginx的conf目录下创建一个用于存放证书的目录。
      
      ```
      cd /etc/nginx
      mkdir cert
      ```
   2. 在顶部导航栏，单击**文件**，单击**打开新文件树**。找到/etc/nginx/cert目录，右键打开菜单，单击**上传文件**。
   3. 将证书文件和私钥文件上传到Nginx服务器的证书目录（/etc/nginx/cert）。
   4. 编辑Nginx配置文件nginx.conf，修改与证书相关的配置。
      
      1. 执行以下命令，打开配置文件。
         
         ```
         vim /etc/nginx/nginx.conf
         ```
      2. 找到被注释的SSL配置，参考如下示例进行修改。
         
         ```
         #  Settings for a TLS enabled server.
         
             server {
                 listen       443 ssl http2;
                 listen       [::]:443 ssl http2;
                 server_name demo.doc-test.cn;
                 root         /usr/share/nginx/html;
                 ssl_certificate cert/<cert-file-name>.pem;
         
                 ssl_certificate_key cert/<cert-file-name>.key;
         
                 ssl_session_cache shared:SSL:1m;
                 ssl_session_timeout 5m;
         
                 #自定义设置使用的TLS协议的类型以及加密套件（以下为配置示例，请您自行评估是否需要配置）
                 #TLS协议版本越高，HTTPS通信的安全性越高，但是相较于低版本TLS协议，高版本TLS协议对浏览器的兼容性较差。
                 ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
                 ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
         
                 #表示优先使用服务端加密套件。默认开启
                 ssl_prefer_server_ciphers on;
                 # Load configuration files for the default server block.
                 include /etc/nginx/default.d/*.conf;
         
                 error_page 404 /404.html;
                     location = /40x.html {
                 }
         
                 error_page 500 502 503 504 /50x.html;
                     location = /50x.html {
                 }
             }
         ```
      3. 粘贴后，按Esc键，输入`:x`保存并退出编辑。
      4. 重启Nginx。
         
         ```
         nginx -s reload
         ```
4. 验证SSL证书是否配置成功
   
   1. 证书安装完成后，您可以通过访问证书的绑定域名验证该证书是否安装成功。
   2. 如果网页地址栏出现小锁标志，表示证书已经安装成功。
      
      ![image..png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0756675171/p784961.png)
### **清理和后续**

10

#### 清理资源

您可以使用ROS一键删除创建的云资源，避免继续产生费用。

1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
2. 在左侧导航栏，选择**资源栈**。
3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。

#### **删除流水线**

1. 删除云效的流水线。
   
   进入[我的流水线](https://swasnext.console.aliyun.com/)，点击流水线右侧![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p783981.png)->**删除**。
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8957855171/p793375.png)
2. 删除代码仓库。
   
   1. 打开[codeup](https://codeup.aliyun.com/)。
   2. 进入仓库主页，点击左下角的**设置**->**基本设置**->**删除代码库**。

#### **删除移动研发平台应用**

1. 登录[EMAS控制台](https://emas.console.aliyun.com/products)，在项目列表单击项目卡片右上角删除图标。

#### **后续**

* 应法规要求，App上线前需要完成App备案，您可以参考[链接](https://wanwang.aliyun.com/qualificationrec/bazszl)进行App备案。
* 为了您的服务安全，建议您使用Web应用防火墙保护您的App后端服务。
* 如果您的应用有静态资源需要存储，如图片、视频等，建议您使用对象存储 OSS 和内容分发网络 CDN存储静态资源并提升访问速度。
