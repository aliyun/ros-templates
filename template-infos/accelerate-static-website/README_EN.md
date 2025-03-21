Please translate the following content into English, and retain the original format:
## Overview

In the current era of rapid development of the Internet, websites have become an important bridge for enterprises to communicate with users. When users in different regions access websites, some users may experience slow access due to their geographical distance, which affects user experience. At the same time, as the website traffic continues to increase, the response speed of the site will also decrease. Among them, static resources on the website, such as JS files, CSS files, images, large files or audio and video files, etc., the loading speed of these contents directly determines the overall experience of users browsing the website.

To ensure that users in different regions can access the website smoothly, you can use Alibaba Cloud CDN products to distribute OSS files. This not only reduces the load pressure on the source station but also improves the access performance of the website. At the same time, under high concurrency scenarios, by using CDN, static resources can be cached on various nodes, reducing direct requests to the source station, which not only reduces bandwidth costs but also reduces the traffic costs of the source station. For example, if you purchase a 1-month and a 6-month 100GB downstream traffic package, using CDN to accelerate static resources, ignoring the back-source cost, compared with directly using OSS downstream traffic, the costs are reduced by 75.5% and 97.5%, respectively. Please refer to the official resource package price for details.

## Architecture

The static resources (JS files, CSS files, images, audio and video files, etc.) of the website are stored in OSS. CDN will cache the OSS source files in advance to the global acceleration nodes of CDN. When users request to access or download resources, they can obtain the cached resources from the CDN node nearby, thereby achieving resource access acceleration. The overall scheme architecture is shown in the architecture diagram.


The technical structure of this scheme includes the following infrastructure and cloud services:

* Object Storage OSS: Store the static resource files of the website.
* Content Delivery Network CDN: Accelerate the access to the resources stored in OSS.

## Deployment
### Preparation


1. If you do not have an Alibaba Cloud account, please visit the [Alibaba Cloud Account Registration Page](https://account.aliyun.com/register/qr_register.htm) and complete the registration and personal real-name authentication according to the prompts on the page. An Alibaba Cloud account is the entity that you use to pay for cloud resources, so it is a prerequisite for deploying the scheme.
2. [Top up your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html). To save costs, this scheme defaults to using pay-as-you-go. To use pay-as-you-go resources, you need to ensure that your account balance is not less than 100 yuan. After completing the deployment and experience of this scheme, the estimated cost is about 5 yuan.
3. You already have at least one domain name, and the domain name has been filed. If it has not been filed, you can log in to the [AliCloud ICP Filing Management System](https://beian.aliyun.com/pcContainer/myorder) to complete the filing.
4. Open [Object Storage OSS](https://common-buy.aliyun.com/?spm=5176.7933691.J_5253785160.2.41252c47B1n6So&commodityCode=oss_rc_dp_cn) and [Content Delivery Network CDN](https://common-buy.aliyun.com/?spm=5176.7933777.J_3537169050.3.c285496eAAPwa9&commodityCode=cdn#/open).
### One-click Deployment


One-click deployment is realized based on Alibaba Cloud Resource Orchestration Service ROS (Resource Orchestration Service). The ROS template has defined scripts, which can automatically complete the creation and configuration of cloud resources, improving the creation and deployment efficiency of resources. The content completed by the ROS template includes:

#### Operation Steps

You can automatically complete the creation and configuration of these resources through the ROS one-click deployment link provided below:

* Create 1 OSS Bucket.
* Bind 1 custom domain name.
  
  **Note** 
  
  If this is the first time you add this domain name to CDN, you need to verify the ownership of the domain name before adding it. Follow the prompts on the console to perform DNS resolution verification or file verification to verify the ownership of the domain name. For details, see [Verify Domain Name Ownership](https://help.aliyun.com/zh/cdn/verify-domain-name-ownership).
* Configure 1 CDN acceleration service.
* Add 1 CNAME record.

1. One-click deployment of resources.
   
   1. Click [One-click Deployment](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/accelerate-static-website.yml&hideStepRow=true&hideStackConfig=true&pageTitle=Website Static Resources Access Acceleration&disableRollback=false&isSimplified=true&disa=true&productNavBar=disabled), and select the region.
   2. In the configuration page, modify the **Resource Stack Name**, configure the **Acceleration Region**, **Acceleration Domain Name**, and **Storage Space Name**, click **Next**, and then click **Create** to start the one-click configuration. The acceleration domain name cannot be set as a top-level domain.
   3. When the **Resource Stack Information** page shows the status as **Created Successfully**, the one-click configuration is completed.
2. Enable CDN cache auto-refresh.
   
   1. Log in to the [OSS Management Console](https://oss.console.aliyun.com/).
   2. Enter the target Bucket, and select **Bucket Configuration** > **Domain Name Management**.
   3. In the target domain, click **OSS Domain Binding** under the **Not Bound** column in the target domain name, enter the domain name information in the pop-up panel, and click **Submit**.
   4. In the target domain, select all supported operations in the **CDN Cache Auto Refresh** column, and then click **OK**.
      
      When you modify the files in OSS, you can trigger the automatic refresh of CDN cache.
### Completion and Cleanup


#### Scheme Verification

**1. Verify the CDN acceleration effect through Real-Time Monitoring Service ARMS**

You can verify the cache strategy and acceleration effect by uploading files to OSS's Bucket through the OSS console or Alibaba Cloud SDK, and then accessing the corresponding CDN resource address through the browser.

1. View the static resource cache strategy through file access.
   
   Take accessing a picture file as an example. When you access the corresponding URL in the browser, you can get the following response information, indicating that the file is downloaded from the CDN node, and the cache time is also set to 30 days as expected.
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8144212171/p788816.png)
2. Verify the static resource acceleration effect through the website containing pictures.

Use the instant dial test function of Alibaba Cloud Application Real-Time Monitoring Service ARMS, which covers major cities across the country, to test the size of the picture file as 2 MB, and verify the static resource acceleration effect through CDN. Initially, when the static resource is not cached to the CDN acceleration node, the access performance will be relatively slow. When the static resource is cached to the CDN acceleration node, the acceleration node responds directly, and the access performance after setting CDN acceleration will be better. See the data below for details.

The left side of the figure is the access