Please translate the following Chinese text into English, requiring the original format to be retained:
## Overview

As your business grows, the volume of your application access log data may increase dramatically. Therefore, you need to archive historical data to save storage costs and optimize disk space utilization, and facilitate subsequent management and analysis.

This technical solution uses Nginx access log data archiving as an example to demonstrate:

* How to build a Nginx access log data collection and archiving service
* Simulate Nginx access log data archiving, observe archived logs

### Solution Architecture

The default settings provided by the solution will build the website running environment on Alibaba Cloud after deployment. You can modify some settings according to resource planning when deploying in practice, but the final running environment is similar to the architecture diagram.


The technical architecture of this solution includes the following infrastructure and cloud services:

* Cloud Server ECS: Deploy Nginx service.
* Log Service SLS: Collect and analyze Nginx service generated log data.
* Object Storage OSS: Archive log data collected by Log Service SLS.

## Solution Deployment

### Deployment Preparation

Before starting the deployment, please complete the following steps according to the instructions to apply for an account, top up the account, create and authorize RAM users.

#### Account Preparation

1. If you do not have an Alibaba Cloud account, please visit the [Alibaba Cloud account registration page](https://account.aliyun.com/register/qr_register.htm) and follow the prompts to register. The Alibaba Cloud account is the entity that you use to pay for cloud resources, so it is a prerequisite for deploying the solution.
2. [Top up your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html).

   1. To save costs, this solution defaults to using On-Demand Pay and Spot Instances. Using On-Demand Pay requires ensuring that your account balance is not less than 100 yuan.
   2. It is expected that the cost of deploying and experiencing this solution will not exceed 1 yuan (assuming that you choose the lowest specification resources, and the resource runs for no more than 30 minutes. If you adjust the resource specifications, please refer to the actual quoted price and the final bill displayed in the console).

      ![2023-08-18_15-09-40.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8893062961/p707920.png)
3. Create a RAM user for the solution deployment.

   1. Create 1 RAM user. For details, see [Create a RAM user](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user).
   2. Grant the following cloud services access permissions to complete the solution deployment. For details, see [Grant permissions to the RAM user](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user).


      | **Cloud Services**            | **Required Permissions**         | **Description**                                        |
      | --------------------- | ---------------------- | ----------------------------------------------- |
      | Cloud Server ECS           | AliyunECSFullAccess    | Permission to manage Cloud Server ECS             |
      | Dedicated Network VPC       | AliyunVPCFullAccess    | Permission to manage Dedicated Network VPC        |
      | Log Service SLS           | AliyunLogFullAccess    | Permission to manage Log Service SLS              |
      | Object Storage OSS           | AliyunOSSFullAccess    | Permission to manage Object Storage OSS           |
      | Resource Orchestration Service ROS       | AliyunROSFullAccess    | Permission to manage Resource Orchestration Service ROS |
      | Lightweight Message Queue (formerly MNS) | AliyunMNSFullAccess    | Permission to manage Lightweight Message Queue (formerly MNS) |
      | Operations Orchestration Service OOS       | AliyunOOSFullAccess    | Permission to manage Operations Orchestration Service OOS |
      | Quotas Quotas            | AliyunQuotasFullAccess | Permission to manage Quotas Quotas               |
      | Access Control RAM           | AliyunRAMFullAccess    | Permission to manage Access Control RAM, that is, permission to manage users and grant permissions |
      | Tag Service TAG           | AliyunTagManagerAccess | Permission to manage Tag Service TAG              |

### One-Click Deployment

---

You can automatically complete these resource creation and configuration through the ROS one-click deployment link provided below:

* 1 Dedicated Network VPC.
* 1 Switch.
* 1 Cloud Server ECS.
* 1 Log Service SLS Project.
* 1 Object Storage OSS Bucket.

1. Open the [one-click configuration link](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/Nginx-access-log-data-archive.yml&pageTitle=Application Log Data Archiving&disableRollback=false&isSimplified=true&productNavBar=disabled), and select the region.
2. In the **