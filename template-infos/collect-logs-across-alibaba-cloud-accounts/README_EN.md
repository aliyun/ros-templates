Please translate the following Chinese text into English, retaining the original format:
## Overview

When you want to collect multiple account application logs in a unified location or need to merge different account cloud product logs for data analysis, you need to collect logs across Alibaba Cloud accounts.

This technical solution uses the example of collecting ECS server logs across Alibaba Cloud accounts to demonstrate:

* How to collect ECS server logs across accounts using Logtail.
* How to collect OSS object storage logs across accounts using the log audit service.

## Architecture

![Cross-account log collection.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5329403961/p711572.png)

The technical architecture of this solution includes the following infrastructure and cloud services:

**Note**

Alibaba Cloud products such as OSS, RDS, SLB, etc. can all complete cross-account log collection through the log audit service. This article uses the example of collecting OSS logs across accounts.

* 2 Alibaba Cloud accounts: implement cross-account data collection.
* 2 cloud servers ECS: 2 Alibaba Cloud accounts deploy 1 cloud server ECS each, used to generate relevant log data for collection.
* 2 log services SLS: 2 Alibaba Cloud accounts open 1 log service SLS each, used to collect data for analysis.
* 2 OSS: 2 Alibaba Cloud accounts open 1 OSS each, used to generate relevant log data for collection.
## Deployment
### Preparation


Before deployment, please follow the instructions below to complete account application, account recharge, RAM user creation and authorization.

### Prepare accounts

1. If you do not have an Alibaba Cloud account, please visit the [AliCloud account registration page](https://account.aliyun.com/register/qr_register.htm) and follow the prompts to register. An Alibaba Cloud account is the entity that you use to pay for cloud resources. This solution requires you to apply for two Alibaba Cloud accounts.
2. [Recharge your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html).

   * The cloud resources in this solution support pay-as-you-go, and the default settings are guided operations for pay-as-you-go. Please ensure that your account balance is greater than or equal to 100 yuan.
   * To complete the deployment and experience of this solution, it is estimated that the cost will be about 1 yuan (assuming that you choose the lowest specification resources, and the resource running time does not exceed 1 hour. In actual situations, some instances may not be able to purchase, so you need to adjust the resource specifications according to actual situations, and at the same time, due to the difference in the actual traffic used during your operation process, the cost may vary, please refer to the actual quotation and final bill, as shown in the table below for reference only).

     The following table is for reference only, and the actual situation shall prevail.

     | **No.** | **Product** | **Source of Fees** | **Specification** | **Region** | **Estimated Cost Reference** | **Description** |
     | --- | --- | --- | --- | --- | --- | --- |
     | 1 | Cloud Server ECS | ECS configuration fee | Instance: ecs.t5-lc2m1.nano (t5 instance with peak performance, 1 vCPU, 0.5 GiB) System disk: cloud\_efficiency 40GiB | East China 1 (Hangzhou) | 0.083 yuan/hour | - |
     | 2 | Log Service SLS | Read/write traffic fee | / | East China 1 (Hangzhou) | + 500 MB within: 0 yuan + Exceeding part: 0.180 yuan/GB | This solution involves read/write traffic related to the amount of cross-account collected logs, and this article charges 500 MB within the quota, and the actual price is based on the actual data volume. |
     | Pay-as-you-go fees: 0.083 yuan/hour | | | | | | |
3. Alibaba Cloud accounts have the highest operating permissions for resources. From the perspective of cloud resource security, it is recommended that you create a RAM user. The RAM user needs to obtain access permissions for relevant cloud services to complete the solution deployment.
   
   | **Cloud Service** | **Required Permissions** | **Description** |
   | --- | --- | --- |
   | Cloud Server ECS | AliyunECSFullAccess | Permission to manage cloud server ECS |
   | Log Service SLS | AliyunLogFullAccess | Permission to manage log service SLS |
   | Object Storage OSS | AliyunOSSFullAccess | Permission to manage object storage OSS |

   For instructions on creating a RAM user and authorizing it, see [Create a RAM User and Authorize the RAM User to Access the Log Service](https://help.aliyun.com/zh/sls/create-a-ram-user-and-authorize-the-ram-user-to-access-log-service).
### One-click deployment


One-click deployment is realized by ROS (Resource Orchestration Service). The ROS template has defined scripts, which can automate the creation and configuration of cloud resources, improving the efficiency of resource creation and deployment. The content completed by the ROS template includes:

#### Operation Steps

#### Collect ECS logs across accounts