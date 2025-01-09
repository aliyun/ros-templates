## **方案概览**

在当前互联网快速发展的时代，网站已成为企业与用户沟通的重要桥梁。不同地域的用户访问网站时，部分用户会因为地域较远导致访问速度较慢，影响用户体验，同时随着网站流量的不断增加，站点的响应速度也会出现下降的问题。其中网站的静态资源，如JS文件、CSS文件、图片、大文件或音视频等，这些内容的加载速度直接决定用户浏览网站的整体体验。

为了确保不同地域的用户能够流畅地访问网站，您可以使用阿里云CDN产品来分发OSS上的文件，不仅可以降低源站的负载压力，还能够提升网站的访问性能。同时，在高并发的场景下，通过CDN能够将静态资源缓存在各个节点上，减少对源站的直接请求，不仅降低了带宽费用，还降低了源站的流量费用。以购买1个月和6个月有效期的100GB下行流量包费用为例，使用CDN加速静态资源，在忽略回源费用的情况下，相对于直接使用OSS下行流量，费用分别降低了75.5%和97.5%。具体请以官方资源包价格为准。

## **方案架构**

将网站的静态资源（JS文件、CSS文件、图片、音视频文件等）存储在OSS上，CDN会将OSS源站的文件提前缓存到CDN全球加速节点，用户请求访问或下载资源时，可以就近获取到CDN节点上已缓存的资源，从而实现资源访问加速。整体的方案架构如下图所示。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8505864371/CAEQOxiBgMDBx_r08BgiIDZmYmNiYTc4MTAxOTQxNTFhYmFkMmZkODE5ZjQ5Yjlm4243220_20240308162036.721.svg)

本方案的技术结构包括以下基础设施和云服务：

* 对象存储 OSS：存储网站静态资源文件。
* 内容分发网络 CDN：加速访问对象存储 OSS中存储的资源。

## **方案部署**
### **部署准备**


1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册并完成个人实名认证。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。为节省成本，本方案默认选择使用按量付费，使用按量付费资源需要确保账户余额不小于100元。完成本方案的部署及体验，预计费用约为5元。
3. 您已经拥有了至少一个域名，且域名已经备案。如果未备案，可登录[阿里云ICP代备案管理系统](https://beian.aliyun.com/pcContainer/myorder)完成备案。
4. 开通[对象存储OSS](https://common-buy.aliyun.com/?spm=5176.7933691.J_5253785160.2.41252c47B1n6So&commodityCode=oss_rc_dp_cn)、[内容分发网络CDN](https://common-buy.aliyun.com/?spm=5176.7933777.J_3537169050.3.c285496eAAPwa9&commodityCode=cdn#/open)。
### **一键部署**


一键部署基于阿里云资源编排服务ROS（Resource Orchestration Service）实现，ROS模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。ROS模板完成的内容包括：

#### 操作步骤

您可以通过下方提供的ROS一键部署链接，来自动化地完成这些资源的创建和配置：

* 创建1个对象存储OSS Bucket。
* 绑定1个自定义域名。
  
  **说明** 
  
  如果是首次在CDN添加该域名，需要验证该域名的归属权后才能添加。请按照控制台提示进行DNS解析验证或文件验证的方式进行域名验证。具体请参考[验证域名归属权](https://help.aliyun.com/zh/cdn/verify-domain-name-ownership)。
* 配置1个CDN加速服务。
* 添加1个CNAME记录。

1. 一键部署资源。
   
   1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/accelerate-static-website.yml&hideStepRow=true&hideStackConfig=true&pageTitle=网站静态资源访问加速&disableRollback=false&isSimplified=true&disa=true&productNavBar=disabled)，并选择地域。
   2. 在配置页面修改**资源栈名称**，配置**加速区域**、**加速域名**及**存储空间名称**，单击**下一步**，然后单击**创建**开始一键配置。其中加速域名不能设置为顶级域名。
   3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
2. 开启CDN缓存自动刷新。
   
   1. 登录[OSS管理控制台](https://oss.console.aliyun.com/)。
   2. 进入目标Bucket后，选择**Bucket 配置** > **域名管理**。
   3. 在目标域名中，单击**OSS 域名绑定**列下的**未绑定**，在弹出面板输入域名信息，单击**提交**。
   4. 在目标域名中，在**CDN 缓存自动刷新**列，选择所有支持的操作，然后单击**确定**。
      
      当您在OSS对文件进行修改后，可以触发CDN缓存的自动刷新。
### **完成及清理**


#### **方案验证**

**一、通过实时监控服务ARMS，验证CDN加速效果**

您可以通过OSS控制台或者阿里云SDK等形式将文件上传到OSS的Bucket，然后通过浏览器访问对应的CDN资源地址验证缓存策略及加速效果。

1. 访问文件查看静态资源缓存策略。
   
   以访问图片文件为例，在浏览器访问对应的URL，可以得到以下响应信息，说明文件是从CDN节点上下载到的，并且缓存时间也按预期设置为30天。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8144212171/p788816.png)
2. 访问包含图片的网站验证静态资源加速效果。

使用阿里云应用实时监控服务ARMS的即时拨测功能，监测点覆盖全国主要城市，测试文件大小为2 MB，验证通过CDN加速和不设置CDN加速的图片访问性能。最初静态资源没有缓存至CDN加速节点时，访问性能会相对较慢。当静态资源缓存至CDN加速节点后，则由加速节点直接响应，设置CDN加速后的访问性能会更好。具体见下面数据。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4507561371/p873197.png)

图中左侧为未设置CDN加速的访问性能，右侧为设置CDN加速后的访问性能。通过本次拨测数据可以看到，设置CDN加速后的完全加载用时提升了约74.7%。

**二、通过OSS存储JS和CSS文件，实现文件的版本控制与上传，验证这些文件通过CDN加速后的访问效果**

JS、CSS文件会根据业务的实际情况更新版本，与图片及音视频这类不常更新的静态文件不太相同。您可以通过以下操作完成文件的版本控制、文件上传及文件访问。

1. 文件版本控制。
   
   JS、CSS文件可以通过文件路径中的版本号（例如js/0.0.1/app.js）或者查询参数的方式（app.js?v=0.0.1）确保用户可以获取到当前版本的文件。在实际的开发流程中，使用非覆盖式发布的情况更为常见，通过文件路径中的版本号的方式可以有效地控制缓存并进行版本追踪，同时方便进行回滚操作。
   
   在OSS中，可以通过创建对应版本号的目录存放对应版本的文件，就可以完成文件的版本控制。
2. 文件上传到OSS。
   
   文件版本更新后，您可以根据具体场景选择使用OSS控制台、阿里云SDK、ossutil、ossbrowser或者API等方式将最新版本的文件上传到OSS Bucket。本文以使用命令行工具ossutil为例，介绍如何将文件夹内的文件上传到OSS Bucket。简单上传的示例命令如下，具体可参考[cp（上传文件）](https://help.aliyun.com/zh/oss/developer-reference/upload-objects-6)。
   
   ```
    ossutil cp -r localfolder/ oss://<oss-bucket>/<folder>
   ```
3. 在应用程序的代码中更新JS、CSS文件的版本号，使其指向OSS上最新版本的文件路径。
4. 访问文件。
   
   * 命中CDN节点缓存
     
     通过开发者工具检查可以看到，多次访问0.0.1版本的JS文件时，X-Cache字段返回值以HIT开头，表明源站的资源已缓存到CDN节点。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8144212171/p788817.png)
   * 未命中CDN节点缓存
     
     更新JS文件版本为0.1.0后，首次访问新版本的JS文件，X-Cache字段返回值以MISS开头，表明首次访问未命中CDN节点缓存。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8144212171/p788818.png)
#### 清理资源

在本方案中，您创建了1个OSS Bucket、1个CDN加速。测试完方案后，您可以参考以下规则处理对应产品的资源，避免继续产生费用。

一键删除OSS Bucket和CDN加速。

1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
2. 在左侧导航栏，选择**资源栈**。
3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
