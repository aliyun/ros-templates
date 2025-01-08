## **方案概览**

视频、图文类多媒体数据量快速增长，内容不断丰富，多媒体数据存储与分发解决方案融合对象存储OSS、内容分发CDN 、智能媒体管理IMM等产品能力，解决客户多媒体数据存储、处理、加速、分发等业务问题，进而实现低成本、高稳定性的业务目标。本技术解决方案以搭建一个多媒体数据存储与分发服务为例，为您演示：

* 如何搭建一个多媒体数据存储与分发服务
* 模拟多媒体数据处理和加速分发

## **方案架构**

方案提供的默认设置完成部署后在阿里云上搭建的网站运行环境如下图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与下图相似。

![多媒体数据存储与分发.jpg](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9669798961/p720009.jpg)

本方案以多媒体内容加速分发的场景为例。本方案的技术架构包括以下基础设施和云服务：

* 1个对象存储OSS：提供海量存储空间和高吞吐带宽。
* 1个内容分发网络CDN：用于加速访问对象存储OSS中存储的资源。
* 1个智能媒体管理IMM：提供图像和视频存储、处理、分析、搜索等多种功能，帮助用户更好地管理和利用海量的多媒体数据。
* 1个域名：已经完成备案的域名。
## **方案部署**
### **部署准备**


开始部署前，请按以下指引完成账号申请、账号充值、服务开通。

### **准备账号**

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   1. 为节省成本，本方案默认全部选择使用按量付费资源，使用按量付费资源需要确保账户余额不小于100元。
   2. 完成本方案的部署及体验，预计产生费用不超过1元（假设您选择最低规格资源，且资源运行时间不超过30分钟。实际情况中可能部分实例无法购买，需要根据实际情况调整资源规格，同时因您操作过程中实际使用的流量差异，会导致费用有所变化，请以控制台显示的实际报价以及最终账单为准）。以下预估费用不包含域名和加密证书费用。
      
      | **序号** | **产品** | **费用来源** | **规格** | **地域** | **预估费用参考** | **说明** |
      | --- | --- | --- | --- | --- | --- | --- |
      | 1 | 对象存储OSS | 标准存储（本地冗余）容量（Storage）费 | - | 华东1（杭州） | 0.12元/GB/月 | - |
      | PUT类或GET类请求费 | - | 华东1（杭州） | 0.01元/万次 | - |
      | CDN回源流出流量 | - | 华东1（杭州） | 0.15元/GB | - |
      | 2 | CDN | CDN下行流量费 | - | 华东1（杭州） | 0.24元/GB | 0GB-10TB(含） |
      | 3 | 智能媒体管理IMM | 媒体处理费 | - | 华东1（杭州） | 0.00500元/次 | VideoCompress265HD  * 视频转码265 HD：输出的视频使用H.265编码器 |
      | 按量费用：0.525元/时 | | | | | | |
3. 开通[对象存储OSS](https://common-buy.aliyun.com/?commodityCode=oss)、[内容分发网络CDN](https://common-buy.aliyun.com/?spm=5176.7933777.J_3537169050.3.c285496eAAPwa9&commodityCode=cdn#/open)、[智能媒体管理IMM](https://common-buy.aliyun.com/?spm=5176.166693.J_5253785160.2.79cb31a6rLGbiD&commodityCode=imm#/open)。并准备好已经完成备案的域名。
### **一键部署**


一键部署基于阿里云资源编排服务ROS（Resource Orchestration Service）实现，ROS模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。

#### 操作步骤

您可以通过下方提供的ROS一键部署链接，来自动化地完成这些资源的创建和配置：

* 创建1个对象存储OSS Bucket。
* 绑定1个自定义域名。
* 配置1个CDN加速服务。
* 添加1个CNAME记录。

1. 一键部署资源。
   
   1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/dcdn-speeds-up-data-storage-on-oss.yml&hideStepRow=true&pageTitle=多媒体数据存储与分发&isSimplified=true&disableNavigation=true&productNavBar=disabled)，并选择地域。
   2. 在**配置模板参数**页面修改资源栈名称，配置OSS Bucket和Domain，然后单击**创建**开始一键配置。
   3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
2. 开启CDN缓存自动刷新。
   
   在[OSS管理控制台](https://oss.console.aliyun.com/)的**域名管理**页签，打开目标域名右侧的**CDN缓存自动刷新**开关，（在全屏模式下）选择所有支持的操作，然后单击**确定**。
3. 绑定IMM项目。
   
   1. 登录[OSS管理控制台](https://oss.console.aliyun.com/overview)。
   2. 在左侧导航栏，单击**Bucket列表**，然后单击创建的examplebucket。
   3. 在左侧导航栏，选择**数据处理**。
   4. 单击**媒体处理**，然后在弹出绑定页面单击**Bucket绑定IMM project**按钮。
   5. 在**绑定智能媒体项目**对话框的**IMM配置**区域，选择**创建新的Project**，输入Project的名称，然后单击**确定**。
4. 配置证书加密访问（可选）
   
   如果您需要实现全网数据加密传输，您可以上传自定义证书或将已经托管在阿里云SSL证书服务的证书部署至CDN平台，从而启用HTTPS加速服务。本教程以托管在阿里云SSL证书服务的证书为例。在执行以下步骤前，您需要购买SSL证书，详情请参见[购买SSL证书](https://help.aliyun.com/zh/ssl-certificate/user-guide/purchase-an-ssl-certificate)。
   
   1. 登录[CDN控制台](https://cdn.console.aliyun.com/overview)。
   2. 在左侧导航栏，单击**域名管理**。
   3. 在**域名管理**页面，单击目标域名**操作**列的**管理**。
   4. 在指定域名的左侧导航栏，单击**HTTPS配置**。
   5. 在**HTTPS证书**区域，单击**修改配置**。
   6. 在**HTTPS设置**对话框，打开**HTTPS安全加速**开关。
      
      当您打开**HTTPS安全加速**开关时，系统弹出确认开启HTTPS界面，该操作单独计费，您可以根据所需选择是否开启。HTTPS计费标准请参考[HTTPS请求数/动态HTTP请求数](https://help.aliyun.com/zh/edge-security-acceleration/dcdn/product-overview/billing-of-https-and-http-requests#concept-2071526)。
   7. 配置证书相关参数。
      
      | **项目** | **说明** | **示例值** |
      | --- | --- | --- |
      | **证书来源** | 证书来源包含以下两种，两种证书之间可以相互切换。  * **云盾（SSL）证书中心** * **自定义上传（证书+私钥）** | 云盾（SSL）证书中心 |
      | **证书名称** | 选择证书的名称。 | cert-9687672 |
   8. 单击**确定**，完成配置。
### **验证及清理**


#### **方案验证**

**一、通过媒体处理功能,完成视频转码。**

1. 向OSS上传视频。
   
   1. 登录[OSS管理控制台](https://oss.console.aliyun.com/)
   2. 单击**Bucket列表**，然后单击目标Bucket名称。
   3. 在左侧导航栏，选择**文件管理 > 文件列表**。
   4. 在**文件列表**页面，单击**上传文件**，根据页面提示上传[srcexample.mp4](https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20241121/qwkhdx/srcexamlpe.mp4)。
2. 通过媒体处理进行转码。
   
   1. 在目标Bucket详情页的左侧导航栏中点击**数据处理 > 媒体处理**。
   2. 单击右侧视频转码中的**任务页签。**![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6126704371/p885870.png)
   3. 点击**创建任务**按钮。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6126704371/p885872.png)
   4. 再弹出的任务创建窗口，如上图所示，依次选择刚上传的视频，选择需要的样式，填写输出路径，最后点击确定，即刻启动视频转码任务。
      
      1. 输入路径：点击选择按钮，在弹出的选项框中选择上一步上传的视频。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6126704371/p887268.png)
      2. 样式选择：点击下拉菜单可选择系统内置样式如下。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6126704371/p887267.png)
      3. 输出路径：点击选择，在下拉菜单中点击自己创建的Bucket名称，进入到目录选择中，若无建立目录继续点击确定即可，随后输入自定义文件名(即转码后视频文件名)，示例：oss://<OSS Bucket名称>/demo/test.mp4。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6126704371/p887282.png)
   5. 由于视频转码需要一定的时间，等待几分钟后，当任务状态为成功时，返回文件列表，查看转码后的视频文件。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6126704371/p885882.png)![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6126704371/p885883.png)
   6. 点击下载转码后的视频文件，点击文件属性，查看文件视频格式如下：![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6126704371/p887305.png)可看到与我们转码任务设置的编码格式和分辨率一致，转码成功。

**二、通过拨测工具，验证CDN加速效果。**

1. 访问[网络拨测工具](https://boce.aliyun.com/detect/http)页面，单击**立即检测**按钮下方的**对比检测**，在两个输入框中分别输入以下链接。更多使用详情可参见[使用网络拨测工具测试加速效果](https://help.aliyun.com/zh/ga/use-cases/use-the-network-dial-test-tool-to-test-the-acceleration)。
   
   * 左侧输入框：加速视频链接。点击转码后的视频文件名，在详情页中的**自有域名**选项中，选择之前配置的加速域名，点击复制文件URL，即可得使用CDN加速的视频链接。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6126704371/p887337.png)
   * 右侧输入框：未加速视频链接。点击转码后的视频文件名，在详情页中的**自有域名**选项中，选择不使用自由域名，点击复制文件URL，即可得到未加速视频链接。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6126704371/p887409.png)
2. 多次单击右侧**立即检测**按钮（每次等待5~10秒） ，即可看到拨测后使用CDN加速访问和未使用CDN加速访问时的详细对比结果，查看**总响应时间**列，可以看到使用CDN加速后，总响应时间明显降低，部分地区下降高达`50%`以上。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9148152371/p876955.png)

#### 清理资源

在本方案中，您创建了1个CDN加速、1个OSS Bucket、智能媒体存储服务IMM项目。测试完方案后，您可以参考以下规则处理对应产品的实例，避免继续产生费用：

1. 一键删除OSS Bucket和CDN加速。
   
   1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
   2. 在左侧导航栏，选择**资源栈**。
   3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
   4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
2. 手动删除智能媒体管理IMM项目。
   
   登录[智能媒体管理IMM控制台](https://imm.console.aliyun.com/v2/cn-beijing/projects)，在项目列表页面，单击创建的IMM项目。在左侧导航栏，选择**删除项目**，然后单击**删除项目**，根据页面提示删除IMM项目。
