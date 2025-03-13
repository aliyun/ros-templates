Please translate the following content into English, and retain the original format:
## Overview

With the continuous development of network technology, if your Web application does not have a traffic entry protection, it will face the following risks:

* The webpage is maliciously tampered with, causing inaccurate information.
* The site response suddenly slows down or suddenly encounters a large number of access requests, affecting normal user access.
* Sensitive data such as account numbers and mobile phone numbers are leaked or database data is tampered with, resulting in business affected.
* In the face of new security vulnerabilities, modifying the code to fix it takes time, and there are phased safety hazards.
* To meet the security compliance requirements of various industries, a large amount of development costs need to be spent to reach the security protection level of the website.

How to avoid these problems efficiently and flexibly, and protect your Web application, we recommend you use [Ali Cloud Web Application Firewall](https://www.aliyun.com/product/waf) (Web Application Firewall, abbreviated as WAF). WAF protects your Web application by identifying and protecting malicious features of website or App traffic. After cleaning and filtering the traffic, it returns normal and safe traffic to the server, avoiding performance abnormalities caused by malicious intrusion of the website server, thus ensuring the business security and data security of the website.

## Architecture

WAF supports enabling security protection for ECS instances. After an ECS instance is connected to WAF, all Web business traffic of the instance will be directed to WAF for detection. After WAF filters Web application attacks, normal business traffic will be forwarded back to the ECS server. The specific network architecture is shown in the architecture diagram.


The technical architecture of this solution includes the following infrastructure and cloud services:

* Cloud Server ECS: Deployed Web application.
* WAF 3.0 Pay-As-You-Go Edition: Used to protect Web applications.

## Deployment
### Preparation

1. If you do not have an Alibaba Cloud account, please visit the [Alibaba Cloud Account Registration Page](https://account.aliyun.com/register/qr_register.htm), follow the prompts on the page to complete registration and personal real-name authentication. An Alibaba Cloud account is the payment entity for using cloud resources, so it is a necessary prerequisite for deploying the solution.
2. [Recharge your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html). To save costs, this solution defaults to using pay-as-you-go. You need to ensure that the account balance is not less than 100 yuan when using pay-as-you-go resources. Select the lowest specification pay-as-you-go ECS instance, and release the resource after the experience ends. The cost incurred will not exceed 5 yuan. The actual cost is based on the control ledger.
### One-click deployment


One-click deployment is realized through Alibaba Cloud Resource Orchestration Service ROS (Resource Orchestration Service). The ROS template has defined scripts, which can automatically complete the creation and configuration of cloud resources, improving the efficiency of resource creation and deployment.

You can automatically complete the creation and configuration of these resources through the ROS one-click deployment link provided below:

* Create an ECS instance
* Install a Web site
* Enable WAF 3.0 Pay-As-You-Go Edition.

#### Operation steps

1. Click [One-click deployment](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/protect-web-applications-with-WAF.yml&hideStepRow=true&hideStackConfig=true&pageTitle=Efficiently Protect Web Applications&disableRollback=false&isSimplified=true&disaigation=true&productNavBar=disabled), and select the region.
2. In the configuration page, select the availability zone, ECS specification, set the password, and confirm the price. Then click Next.
3. In **Price Preview**, confirm the price, and then click Create.
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8535523171/p792027.png)
   
   In this solution, both ECS and WAF are pay-as-you-go. For WAF Pay-As-You-Go instances, the hourly traffic processing fee and function fee will be calculated based on the number of business requests processed in each full hour and the enabled protection functions. This generates a per-hour bill, and a daily bill is generated in each settlement cycle. The actual cost is based on the bill.
4. When the status of the **Resource Stack Information** page is **Create Success**, the configuration is completed.
### Connect ECS instance to WAF

**Important** 

* When the instance is connected to WAF, the Web business may experience second-level flash disconnection. If the client can automatically reconnect, the disconnection will be automatically recovered, and will not affect your business. Please pay attention to your business and evaluate your business system to prepare for disaster recovery mechanisms such as reconnection or return source.
* **ECS** instances are automatically disconnected from the引流 port after being connected to WAF. You need to add the port again, otherwise, the business traffic will not pass through WAF protection.
  
  + Change the public IP bound to the instance.
  + Create a migration task for ECS and change the availability zone.
  + Release the instance.
* **ECS**引流 is the引流 of EIP or public IP.
* **ECS** unbinding of EIP will automatically delete the引流.
#### Operation steps

1. Log in to [Web Application Firewall 3.0 console](https://yundunnext.console.aliyun.com/?p=wafnew).
2. In the left navigation bar, click Access Management.
3. In the **Cloud Product Access** tab, in the cloud product type list on the left, select **ECS**.
4. Follow the prompts on the page to click Authorize Now to complete the authorization of the cloud product (if you have already authorized the cloud product, this page will not appear, and you can directly perform the subsequent steps).
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6094701171/p782034.png)
5. Click Sync Latest Assets, wait for about 60 seconds, and then select the instance created through one-click deployment. Click Add Port.
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8535523171/p792054.png)
6. In the Add Port dialog box, enter the port number **80**.
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6094701171/p782069.png)
7. After the connection is completed, WAF will automatically generate a protection object named "Instance ID-Port-Asset Type", and enable the default basic protection rules for the protection object. You can view the automatically added protection objects in the Protection Objects page.
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6094701171/p782089.png)
   
   If you want to continue using more protection functions of WAF 3.0, see [Protection Configuration Diagram](https://help.aliyun.com/zh/waf/web-application-firewall-3-0/user-guide/protection-configuration).
### Verification and cleanup


**Solution verification**

**1. Verify SQL injection protection through malicious SQL injection code**

1. Log in to [ROS console](https://ros.console.aliyun.com/overview), in the left navigation bar, choose Resource Stack, and find the resource stack deployed in this solution.
2. In the Resource Stack Details page, in the Output page, click the website address URL to open the deployed website. At this point, it can be accessed normally.
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7010623171/p792079.png)
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7010623171/p792080.png)
3. Input SQL malicious attack code in the IP to verify the protection effect, for example, `http://127.xxx.xxx?id=1 and 1=1`. If the 405 interception prompt page is returned, it indicates that the attack