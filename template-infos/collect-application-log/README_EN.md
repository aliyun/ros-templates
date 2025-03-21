## Overview

Application business log monitoring and alert refers to meeting user data collection needs based on Alibaba Cloud Log Service. This technical solution uses the simulated education application service log as a sample log library, and will demonstrate:

* How to implement a monitoring dashboard
* How to trigger email alerts based on business logs

## Architecture

The default settings provided by the scheme are shown in the architecture diagram after the deployment is completed on Alibaba Cloud. When deploying, you can modify some settings according to resource planning, but the final running environment and architecture diagram are similar.


This scheme includes the following infrastructure and cloud services:

* Region and Availability Zone: ECS instances and SLS projects are recommended to be in the same region, with no restrictions on availability zones.
* 1 VPC: An ECS instance will use a VPC network.
* Core system:
  
  + 2 ECS instances, used to deploy simulated business clients, which write business logs
  + 1 log library: query and analyze collected logs to produce a monitoring dashboard, and configure alert rules


## Deployment
### Deployment Preparation

10

Before deploying, please follow the instructions below to complete account registration and account recharge.

### Account Preparation

* If you do not have an Alibaba Cloud account, please visit [Alibaba Cloud Account Registration Page](https://account.aliyun.com/register/qr_register.htm) to complete registration. The Alibaba Cloud account is the entity that pays for cloud resources, so it is a necessary prerequisite for deploying the scheme.
* [Recharge your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html).
  
  1. The cloud resources of this scheme support pay-as-you-go, and all default settings guide operations. If any cloud resource is set to be deployed using pay-as-you-go, the account balance must be greater than or equal to 100 yuan.
  2. To complete the deployment and experience of this scheme, the estimated cost is less than 10 yuan (assuming that the relevant specifications of the resources are selected in the table below, and the actual quotation and final bill are displayed when the control panel is displayed). If the resource specifications are adjusted, please refer to the actual quotation and final bill displayed on the control panel.
| **Cloud Service** | **Specification Configuration** | **Region** | **Estimated Cost Reference** |
| --- | --- | --- | --- |
| Log Service SLS | Billing Mode: Pay-as-you-go  Logstore Type: Standard  Raw Data Volume (GB / Daily Write)：1  Retention Days (Days)：30  Intelligent Storage Tiering: Disabled  Index Field Ratio: 100% | East China 1 (Hangzhou) | 0.76 yuan/day |
| Cloud Server ECS | Specification: ecs.e-c1m1.large  Storage Space: 40 GB (Efficient Cloud Disk) | East China 1 (Hangzhou) | Configuration Cost: 0.27 yuan/hour  Public Network Traffic Cost: 