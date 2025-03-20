Please translate the following content into English, retaining the original format:
## Overview of the Solution

On December 8, 2020, CentOS officially announced its plan to stop maintaining CentOS Linux and launched the CentOS Stream project. Ali Cloud CentOS Linux public images come from the official CentOS. After CentOS Linux stops maintenance, Ali Cloud will also stop supporting this operating system. The discontinuation of an operating system will bring a series of security impacts. Operating system migration solutions are mainly applicable to the following scenarios:

* The operating system has reached its end of life cycle and needs to be maintained and supported.
  CentOS officially announced its plan to stop maintaining CentOS Linux. If you want to maintain and support your operating system in the future, you need to change CentOS to other Linux LTS distributions.
* Architecture optimization
  The current operating system cannot meet business needs and requires re-architecture to improve the reliability and performance of the system. For example: the current operating system may not be compatible with some software, hardware or other devices.

This solution uses a cloud server that has deployed WordPress as an example to demonstrate how to migrate the operating system for ECS through Server Migration Center SMC while keeping the application running normally.

### Solution Architecture

The default settings provided by the solution will build a website running environment on Alibaba Cloud after deployment, as shown in the architecture diagram. When deploying, you can modify some settings according to resource planning, but the final running environment is similar to the architecture diagram.


The technical architecture of this solution includes the following infrastructure and cloud services:

* 1 VPC: forms a private network on Alibaba Cloud for the cloud server ECS.
* 1 ECS: used to install the migrated operating system.
* Server Migration Center SMC: used to create and manage migration tasks.
* Cloud Disk Snapshot Service: used to back up the ECS before migration.

## Solution Deployment
### Preparation


Before deployment, please complete the following steps according to the instructions to apply for an account, recharge the account, open related services, create RAM users, and authorize them.

1. If you do not have an Alibaba Cloud account, please visit the [Alibaba Cloud Account Registration Page](https://account.aliyun.com/register/qr_register.htm) and follow the prompts to register.
2. [Recharge your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html).
   
   1. To save costs, this solution defaults to using all Pay-As-You-Go resources. Using Pay-As-You-Go resources requires ensuring that your account balance is not less than 100 yuan.
   2. The estimated cost of completing the deployment and experience of this solution is no more than 1 yuan (assuming that you choose an ECS with 1 vCPU and 2 GB of memory, and the resource runs for no more than 1 hour, and delete the ECS snapshot after the experience. The actual cost may vary due to the specifications and traffic of the resources used during the operation process. Please refer to the actual quotation and final bill displayed on the console.)
3. Open services
   
   If you are using SMC for the first time, please log in to the [SMC console](https://smc.console.aliyun.com/) and follow the prompts on the page:
   
   1. **Open RAM service and authorization**
   2. **Open Snapshot service**
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9030009071/p769594.png)
### Source Migration Preparation


You can create an ECS instance running WordPress with a CentOS 7 image through the following steps.

1. Click the [One-click Deployment Link](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?productNavBar=disabled&templateUrl=https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20230704/kunb/wordpress-centos7.yml&isSimplified=true) to enter the ROS console, and select the region according to your needs.
2. Follow the guidance in the ROS console to select a new ECS and deploy WordPress (or deploy WordPress on an existing ECS instance).
3. Confirm that the information is correct and click **Create**. Then wait for the stack status to show **Create Success**. (If you deploy on an existing ECS instance, it takes about 10 minutes. You can turn on the **Auto Refresh** switch in the upper right corner of the page to follow the progress of the creation in real time.)
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1744054961/p718827.png)
4. After the resource stack is created successfully, click the **Output** tab and find the value of the **ECSWordPressUrl** parameter in the list of output keywords, click to enter the WordPress webpage, and follow the instructions to initialize the WordPress website.
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2268416071/p762253.png)
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1744054961/p718830.png)
5. After completing the registration and installation prompts, fill in the email and password registered in the previous step to log in to the WordPress management backend.![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868258.png)
6. Click the site icon in the upper left corner of the management page to enter the website and browse.![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p868274.png)![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9908580371/p8