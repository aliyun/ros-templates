Please translate the following content into English, and retain the original format:
## Overview of the Solution

The continuous and stable service is the basis for enterprise development. The high availability architecture of application deployment plays a crucial role in the stability and development of business. This solution starts from the most basic needs of enterprises moving to the cloud, and introduces the design of the "high availability architecture of business moving to the cloud" solution to face the single point failure risk that may be encountered. It demonstrates how to:

* Build a high availability architecture system across availability zones
* After completion, observe the availability of the website through fault simulation

## Solution Architecture

This architecture adopts a single region and dual availability zone deployment, deploys the business system and database in two different availability zones, realizes availability zone-level disaster recovery capability, and thus ensures the continuity of the business. At the same time, this architecture also uses proprietary network VPC, switches, and cross-availability zone security groups to realize private network communication under the system.

After the default settings provided by the solution are completed, the high availability architecture built on Alibaba Cloud is shown in the architecture diagram. When actually deployed, you can modify some settings according to resource planning, but the final operating environment will be similar to the architecture diagram.


The technical architecture of this solution includes the following infrastructure and cloud services:

* 1 proprietary network VPC: builds a private network on Alibaba Cloud for application load balancing ALB, cloud servers ECS, cloud databases RDS, etc.
* 6 switches: designs 3 subnet planes (public plane, business plane, data plane) according to the classic architecture design, deploys them in two availability zones respectively, providing basic network segmentation and isolation functions. ALB is deployed across two availability zones in the public plane, two ECSs are deployed in the business plane of two availability zones respectively, and a pair of cloud databases RDS MySQL high availability edition master-slave nodes are deployed in the data plane of two availability zones respectively.
* 1 public application load balancing ALB: distributes public access traffic to different cloud servers ECS, supports configuring the automatic elastic scaling of backend server groups. Public ALB provides public network service capabilities through EIP.
* 2 cloud servers ECS: used to deploy the business system, provide application services.
* 1 cloud database RDS MySQL high availability edition: provides data services for the business system.
## Deployment of the Solution
### Deployment Preparation


Before starting the deployment, please complete the account application and account recharge according to the following instructions.

### Prepare the Account

1. If you do not have an Alibaba Cloud account, please visit the [Alibaba Cloud account registration page](https://account.aliyun.com/register/qr_register.htm), and complete the registration according to the prompts on the page. An Alibaba Cloud account is the entity that pays for your use of cloud resources, so it is a prerequisite for deploying the solution.
2. [Recharge your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html). The cloud resources in this solution support pay-as-you-go, and the default settings all guide operations using pay-as-you-go. If you determine that any cloud resource will be deployed using pay-as-you-go, the account balance must be greater than or equal to 100 yuan.


One-click deployment is realized based on Alibaba Cloud Resource Orchestration Service ROS (Resource Orchestration Service). The template is a blueprint describing the infrastructure and architecture. Through ROS templates, you can automatically create and configure cloud resources, improving the creation and deployment efficiency of resources. The ROS template provided by this solution includes the following content for creating and configuring resources:

* Create 2 cloud servers ECS instances to achieve high availability across availability zones.
* Create 1 proprietary network VPC.
* Create 6 switches, to achieve high availability, you need to distribute cloud server and other resources as much as possible across multiple availability zones to avoid service unavailability caused by single availability zone failures.
* Create 1 high availability cloud database RDS MySQL.
* Create 1 application-type load balancing ALB and configure server groups and listeners, thereby achieving public access and traffic distribution for the 2 cloud servers ECS under this proprietary network VPC.

### One-click Deployment

1. Open the [one-click deployment template link](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/basic-highly-available-architecture.yml&hideStepRow=true&hideStackConfig=true&pageTitle=Cloud High Availability Architecture&disableRollback=false&isSimplified=true&disabltion=true&productNavBar=disabled&balanceIntercept=true) to go to the ROS console, the system automatically opens the panel for creating resources using new resources.
   
   **Note** 
   
   The ROS console defaults to the region you last visited when accessing the console, so please modify the region according to the region where the created resources are located before proceeding with the next step.
2. Complete the following configuration on the **Parameter Configuration** page (this tutorial uses **East China 1 (Hangzhou)** as an example) and then click **Next: Check and Confirm**.
   
   | Configuration Item | Parameter | Description | Example Value |
   | --- | --- | --- | --- |
   | ECS Configuration | Availability Zone | Select an availability zone for each ECS instance, and ensure that the two ECS instances are located in different availability zones. | Availability Zone J, Availability Zone K |
   | Instance Specification | Select the corresponding specification configuration according to the architecture and classification of the ECS instance. | `ecs.e-c1m2.large` |
   | Instance Password | Password for the ECS instance account. | |
   | RDS Database Configuration | RDS instance specification | The specification of the cloud database RDS instance. | `mysql.x2.medium.2c` |
   | RDS Database Account | Database account and password for PolarDB MySQL instance. | |
   | RDS Database Password |
   | Other Configuration | Enable CDT | After enabling, you need to continue to upgrade the cloud product to CDT billing, and be granted 200 GB/month of public network traffic, of which 20 GB/month can be used for global regions (including mainland China), and 180 GB/month is only available for non-mainland China regions, which can offset the public network traffic generated by pay-as-you-go instances such as cloud servers ECS and Elastic Public IP, and the excess part is charged according to the tiered billing. | Custom. |
3. On the resource preview page, confirm the template parameters and costs, and then click **Create**.
4. When the status of the **Resource Stack Information** page shows **Creation Successful**, the one-click configuration is completed.
### Verification and Cleanup


#### Solution Verification

**1. Verify service availability by accessing the DNS name of the ALB**

1. Log in to the [ALB console](https://slb.console.aliyun.com/alb), get the DNS name of the ALB instance from the instance list. ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1375047271/p854661.png)
2. Access the DNS name through the browser to check if the sample application can be normally accessed. If the page displays the content shown in the following figure, it indicates that the service has been successfully started and is running normally. ![image (1)](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1375047271/p854663.png)

**2. Verify service high availability by simulating server failure through stopping any server after completing multi-server configuration**

After multi-server configuration is completed, you can simulate server failures to verify the availability of the service when some servers are unavailable.

1