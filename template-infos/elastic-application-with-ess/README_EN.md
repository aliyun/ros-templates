Please translate the following content into English, and retain the original format:
## Overview of the Solution

Through this tutorial, you will learn how to deploy a seven-layer load balancing service on Alibaba Cloud Application Load Balancer (ALB) to distribute client requests to backend ECSs, while utilizing Alibaba Cloud Elastic Scaling (ESS) products to achieve dynamic adjustment of server resources. This not only improves the high availability and throughput of applications but also enhances resource utilization and reduces application response time.

Elastic Scaling (Elastic Scaling Service): Also known as Auto Scaling, it can automatically adjust the number of computing resources (i.e., the number of instances required by your business) according to the strategies you set, helping you cope with fluctuations in business traffic while improving resource utilization and effectively reducing costs. For more information, see [What is Elastic Scaling ESS](https://help.aliyun.com/document_detail/25857.html).

Application Load Balancer ALB (Application Load Balancer): Specifically designed for seven-layer applications, it provides powerful application layer processing capabilities and rich advanced forwarding rules. A single ALB instance can handle up to 1 million QPS. For more information, see [What is Application Load Balancer ALB](https://help.aliyun.com/document_detail/197202.html).

This tutorial will introduce the deployment process based on regular fluctuations in business volume. For example, a game company has a peak demand at 6:00 PM every day, and the demand decreases at 10:00 PM, ending the peak period. The business volume of the game company fluctuates regularly, but manually adjusting computing capacity every day wastes manpower and time. You can use the scheduled tasks of Elastic Scaling to automatically perform elastic scaling by Alibaba Cloud at scheduled times. You can set two scheduled tasks, one to automatically add 1 instance at 5:55 PM every day, and the other to automatically reduce 1 instance at 10:05 PM every day. This method can well meet the business volume during the peak period from 6:00 PM to 10:00 PM every day, and release instances in time after the peak period ends to avoid wasting excess instance resources and costs. For more business scenarios, see [Elastic Scaling Application Scenarios](https://help.aliyun.com/document_detail/324146.html).

## Solution Architecture

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9126652271/p829400.png)

The technical architecture of this solution includes the following infrastructure and cloud services:

* 1 VPC and 2 switches: Build a private network in the cloud.
* 1 Application Load Balancer ALB: Load balancing service.
* 1 Elastic Scaling ESS: Provide cloud server ECS elastic scaling service.
* 2-3 cloud servers ECS: Created and deployed Nginx services by Elastic Scaling ESS as Web sites. (In this tutorial, we use the minimum resource instance as an example, initializing one ECS instance in each of the two different availability zones, and configuring the scheduled elastic scaling task to expand and shrink the third ECS instance.)

## Solution Deployment
### Deployment Preparation


1. If you do not have an Alibaba Cloud account, please visit the [Alibaba Cloud Account Registration Page](https://account.aliyun.com/register/qr_register.htm) and follow the prompts to complete registration. An Alibaba Cloud account is the entity that pays for cloud resources, so it is a prerequisite for deploying the solution.
2. [Top up your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html)
   
   1. To save costs, this solution defaults to using pay-as-you-go resources. Using pay-as-you-go resources requires ensuring that your account balance is not less than 100 yuan.
   2. Completing the deployment and experience of this solution is expected to cost no more than 10 yuan (assuming you choose the specifications of resources shown in this article, and the resources run for no more than 60 minutes. In actual operation, due to differences in the actual traffic used, the actual costs may vary, please refer to the actual quotation and final bill displayed in the console, as shown in the table below for reference only).
      
      | **Number** | **Product** | **Specification** | **Region** |
      | --- | --- | --- | --- |
      | 1 | Cloud Server ECS | Instance specification and kernel, vCPU quantity of ECS. For best practices on selecting ECS instances, please refer to [Instance Specification Selection Guidance](https://help.aliyun.com/document_detail/58291.html). This tutorial uses ecs.e-c1m2.large as an example. | East China 1 (Hangzhou) |
      | 2 | Application Load Balancer ALB | Function version: Basic Board. | East China 1 (Hangzhou) |
3. Claim free benefits
   
   | **Resource Claim Entry** | **Configuration in This Tutorial** |
   | --- | --- |
   | [Open Cloud Data Transmission CDT](https://cdt.console.aliyun.com/overview) | CDT offers 200GB of free public network traffic per month (of which 20GB is available in all regions, and 180GB is only available in overseas regions), which can be used to offset the public network traffic of cloud servers ECS, Elastic Public IP, and Application Load Balancer ALB. The excess part adopts a tiered billing rule, details of which can be found in [CDT Public Network Traffic Billing Rules](https://help.aliyun.com/document_detail/410942.html). |
### One-Click Deployment


Click [One-Click Deployment](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/elastic-application-with-ess.yml&hideStepRow=true&hideStackConfig=true&pageTitle=随需而动：自动弹性，稳定交付&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled&balanceIntercept=true) to go to the ROS console, select two ECS instance specifications and availability zones (note that you need to select two different availability zones), and fill in the expected automatic expansion and shrinking time (the automatic expansion and shrinking time should not be later than the current time). The specific costs incurred will vary depending on the selected ECS specifications, and will be displayed in the console.

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3571395171/p801551.png)

After starting the creation, wait for about 5 minutes, and the creation will be successful.

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3571395171/p801370.png)

### Verification and Cleanup


#### Solution Verification

**1. Verify the service availability through accessing the DNS name of ALB**

1. Log in to the [ALB console](https://slb.console.aliyun.com/alb), get the DNS name of the ALB instance from the instance list, and enter the browser to access the Nginx service. ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2080078271/p858084.png)

**2. Verify the execution of the scheduled tasks through viewing the scaling activities**

1. Visit the [Elastic Scaling ESS console](https://ess.console.aliyun.com/?spm=a2c4g.2766666.0.0.c7055911QDAwXZ), select the target scaling group, view the scaling activities, and check the cloud server ECS scaling situation on the day. You can see that the scheduled tasks set in the previous step were executed as scheduled. ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2080078271/p858093.png)

**3. Verify the high availability through stopping ECS to simulate a fault**

1. Visit the [Elastic Scaling ESS console](https://ess.console.aliyun.com/?spm=a2c4g.2766666.0.0.c7055911QDAwXZ), select the target scaling group, click the **Modify** button in the operation column, modify the **Minimum number of instances in the group** to 2, and save the configuration. Then return to the scaling group management page, click the **Instance List** tab, and confirm that the current service instance number is 2. ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2080