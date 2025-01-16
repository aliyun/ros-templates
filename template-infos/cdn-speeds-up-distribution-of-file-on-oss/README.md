## 方案概述

运营电商网站时，网站会产生海量的商品详情数据（例如：图片、视频等），在源站使用阿里云OSS产品来存储静态文件的情况下，要保障所有用户都能够流畅地访问网站，可以使用阿里云CDN产品来分发OSS上的文件，以提高网站的访问性能，并且降低流量费用。业务价值和优势如下：

* 用户访问网站资源，全部通过CDN来分发流量，以降低源站压力。
* CDN提供了低流量成本的文件内容分发服务，并且采用阶梯定价方式，用量越大，流量单价越低。
* 用户从距离客户端最近的CDN节点获取资源，减少网络传输距离，保证静态资源传输质量。

## 方案架构

电商网站的将静态资源存储在OSS上，CDN会将OSS源站的静态资源（图片文件、音频文件、视频文件等）提前缓存到CDN全球加速节点，用户请求访问或下载资源时，可以就近获取CDN节点上已缓存的资源，实现资源加速。默认设置完成部署后的网站运行环境如架构图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与架构图相似。


本方案的技术架构包括以下基础设施和云服务：

* 对象存储 OSS：用于存储电商网站产生的商品详情介绍材料。
* 内容分发网络 CDN：用于加速电商网站的静态文件资源。

## 方案部署
### 部署准备


开始部署前，请按以下指引完成账号申请、账号充值、RAM用户创建和授权。

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册并完成个人实名认证。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。为节省成本，本方案默认选择使用按量付费，使用按量付费资源需要确保账户余额不小于100元。完成本方案的部署及体验，预计费用约为5元（假设您配置CDN产品和OSS产品时均选择采用按量付费方式，且方案验证过程中产生的流量在10GB以内。实际情况可能会因您操作过程中使用的流量大小差异，导致费用有所变化，请以控制台显示的实际报价以及最终账单为准）。
3. 您已经拥有了至少一个域名，且域名已经备案。如果未备案，可登录[阿里云ICP代备案管理系统](https://beian.aliyun.com/pcContainer/myorder)完成备案。
4. 阿里云账号拥有操作资源的最高权限，从云资源安全角度考虑，建议您创建RAM用户。RAM用户需要获得相关云服务的访问权限才能完成方案部署，详情如下：
   
   | **云服务** | **需要的权限** | **描述** |
   | --- | --- | --- |
   | 内容分发网络 CDN | AliyunCDNFullAccess | 管理内容分发网络CDN的权限 |
   | 对象存储 OSS | AliyunOSSFullAccess | 管理云服务器OSS的权限 |
   
   创建RAM用户并进行授权的操作指引请参见[创建RAM用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)及[为RAM用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。
### 一键部署


#### ROS一键部署

资源编排（ROS）可以让您通过YAML或JSON文件清晰简洁地描述所需的云资源及其依赖关系，然后自动化地创建和配置这些资源。您可以通过下方提供的 ROS 一键部署链接，来自动化地完成这些资源的创建和配置：

* 创建1个对象存储OSS Bucket。
* 创建1个CDN加速域名，并设置前面创建的OSS Bucket为源站。

1. 打开[一键配置模板链接](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/cdn-speeds-up-distribution-of-file-on-oss.yml&pageTitle=文件下载加速及成本优化&disableRollback=false&isSimplified=true&productNavBar=disabled)前往ROS控制台，系统自动打开使用新资源创建资源栈的面板，并在**模板内容**区域展示YAML文件的详细信息。
   
   **说明** 
   * ROS控制台默认处于您上一次访问控制台时的地域，请根据您创建的资源所在地域修改地域后再执行下一步。
   * 这里的ROS一键部署模板中，不包含配置CDN加速域名的CNAME解析记录，如需配置CDN加速域名的CNAME解析记录，请参考手动部署的部署步骤。
2. 确认好地域后，保持页面所有选项不变，单击**下一步**进入**配置模板参数**页面。
3. 在**配置模板参数**页面修改资源栈名称，配置加速域名、加速区域、存储空间名称等。填写完所有必选信息并确认后单击**创建**开始一键配置。
4. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
### 验证及清理


#### 方案验证

**一、通过浏览器URL地址并查看请求头，验证静态资源缓存策略**

1. 登录[OSS控制台](https://oss.console.aliyun.com/)，在左侧导航栏中的历史访问路径， 点击之前创建的Bucket名称，进入文件列表，点击上一步所创建的文件目录。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2770679271/p863042.png)
2. 点击上传文件按钮，其他配置保持不变，在**待上传文件**，拖拽图片上传，本示例以 \_MG\_0090.jpg为准。
3. 打开浏览器，访问CDN资源URL地址。示例：http://image.example.com/image\_data/\_MG\_0090.jpg
   
   **说明** 
   
   CDN资源URL地址构：http://由CDN配置的域名/创建的OSS目录名/文件名
4. 待浏览器显示上传的图片时，打开浏览器开发者工具，找到请求头如下。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1780713961/p711665.png)可以看到请求头中含有缓存机制中的Last-Modified和X-swift-cachetime，以及CDN特定字段Via、X-Cache等，可验证静态资源缓存策略生效。
   
   **说明** 
   
   X-swift-cachetime是一个响应头，通常用于标识缓存时间或缓存相关的信息；
   
   Last-Modified：这是服务器在响应中提供的头信息，指出服务器上资源的最后修改时间

**二、通过网络拨测工具对比优化前后访问，验证静态资源加速效果**

1. 访问[一次性拨测工具](https://cloudmonitor.console.aliyun.com/disposableTest)，设置区域为境外。
2. 下面第一张截图是优化之前（直接访问源站）的数据，第二张截图是优化以后（经过CDN加速）的数据，可以看到经过CDN加速以后，数据传输速度更快、耗时更短。
![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5532093961/p711906.png)![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5532093961/p711904.png)
#### 清理资源

在本方案中，您在对象存储 OSS中上传文件、在CDN中创建加速域名，测试完方案后，您可以在ROS控制台直接删除资源栈并删除相关资源；也可以参考以下方式，手动处理对应产品的资源，避免继续产生费用：

* 删除对象存储 OSS中文件资源和Bucket：
  
  1. 登录[OSS控制台](https://oss.console.aliyun.com/)，单击**Bucket列表**，然后单击目标Bucket名称。
  2. 在左侧导航栏，选择**文件管理** > **文件列表**。
  3. 选中一个或多个Object，单击下方的**彻底删除**。
  4. 在弹出的对话框中，单击**确定**删除文件。
  5. 单击**删除Bucket**，然后按照页面指引完成删除操作。
* 删除CDN加速域名：
  
  1. 登录[CDN控制台](https://cdn.console.aliyun.com/overview)。
  2. 在左侧导航栏，单击**域名管理**。
  3. 在域名管理页面，定位目标域名，在操作列中，选择...图标单击 **删除**。
  4. 在确认删除域名对话框中，单击**确定**。
