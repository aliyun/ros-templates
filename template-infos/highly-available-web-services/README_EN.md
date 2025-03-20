## Overview

With the growth of business scale, data request and concurrent access volume increase, and static files are frequently changed, enterprises need to build a highly available and shared storage website architecture to ensure that the website service can run 24/7 while ensuring data consistency and sharing, and reduce the cost of repeated storage.

## Architecture

The default settings provided by the solution will deploy a highly available and shared storage Web service environment on Alibaba Cloud after deployment. In actual deployment, you can modify some settings according to resource planning, but the final running environment is similar to the architecture diagram.


The technical architecture of this solution includes the following infrastructure and cloud services:

* 1 Virtual Private Network (VPC): To form a cloud-based private network for load balancing CLB, cloud servers ECS, and file storage NAS.
* 2 Switches: To connect 2 cloud servers ECS in the same region and availability zone, enable communication between them, and provide basic network segmentation and isolation functions.
* 2 Cloud Servers ECS: 2 high-performance and highly available backend services in different regions of the same region.
* 1 Public Load Balancing CLB: Based on the ability to distribute traffic on demand, it can distribute traffic to different backend servers, eliminate single points of failure in the system, and when a server fails, CLB automatically distributes requests to other normal servers, thus ensuring the continuity and stability of the service.
* 2 File Storage NAS: To achieve data sharing and synchronization among multiple Web servers and ensure data consistency. At the same time, through automated scripts, inotify-tools, and sync tools, automatic incremental backup of master NAS and automatic switching of standby NAS are achieved.

## Deployment
### Preparation

Before deploying, please follow the instructions below to complete account application, account recharge, RAM user creation, and authorization.

### Account Preparation

1. If you do not have an Alibaba Cloud account, visit [the Alibaba Cloud account registration page](https://account.aliyun.com/register/qr_register.htm) to complete registration. The Alibaba Cloud account is the entity that pays for cloud resources, so it is a prerequisite for deploying the solution.
2. [Recharge your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html).
   
   1. To save costs, this solution defaults to using all-on-demand resources. Using on-demand resources requires that the account balance is not less than 100 yuan.
   2. The estimated cost for deploying and experiencing this solution is no more than 5 yuan (assuming that you choose the sample specifications in this article, and the resource usage time does not exceed 60 minutes. The actual cost may vary due to your operation process, so this table is for reference only).
      
      | Scope | Authorization Policy | Description |
      | --- | --- | --- |
      | Entire Cloud Account | AliyunECSFullAccess | Permission to manage cloud servers ECS |
      | AliyunSLBFullAccess | Permission to manage load balancing service |
      | AliyunVPCFullAccess | Permission to manage virtual private network VPC |
      | AliyunECSWorkbenchFullAccess | Complete permission to use ECS-Workbench