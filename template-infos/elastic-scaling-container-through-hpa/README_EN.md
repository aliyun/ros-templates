Please translate the following content into English, retaining the original format:
## Overview

Through this tutorial, you will learn how to deploy applications on Alibaba Cloud Container Service, use Application Load Balancer (ALB) for Layer 7 load balancing service to distribute client requests to backend container pods, and use Horizontal Pod Autoscaler (HPA) for elastic scaling to quickly scale up multiple pods when business loads surge, and scale down when business loads decrease to save resources without manual intervention. HPA is suitable for services with large fluctuations, many services, and frequent scaling up and down, such as e-commerce services, online education, financial services, etc.

## Architecture

This architecture adopts a single region and dual availability zone deployment, deploys the system in two different availability zones, realizes availability zone-level disaster recovery capabilities, and enables elastic scaling at both node and pod dimensions to ensure business continuity.

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7033829171/p813621.png)

The technical architecture of this solution includes the following infrastructure and cloud services:

* 1 VPC and 2 switches: build cloud private network.
* 1 ALB: load balancing service.
* 1 Kubernetes cluster: container platform, provide container application management service.
* 1 SLS Project and 1 SLS Logstore: provide access record storage service.
* 2-3 ECS servers: created by Kubernetes cluster and deployed Nginx service as web site.

Application Load Balancer (ALB): specifically for Layer 7 applications, provides powerful application layer processing capabilities and rich advanced forwarding rules. The maximum performance of a single ALB instance can reach 1 million QPS. For more information, see [What is Application Load Balancer ALB](https://help.aliyun.com/document_detail/197202.html).

Pod horizontal auto-scaling HPA: Kubernetes built-in component, provides pod horizontal scaling capabilities.

In addition, Ali Cloud Container Service provides various workload scaling (scheduling layer elasticity) and node scaling (resource layer elasticity) solutions. For more information, see [Elastic Scaling Overview](https://help.aliyun.com/document_detail/176660.html), understand the applicable scenarios, usage restrictions, etc. of different solutions.

The default HPA only supports CPU and memory-based automatic scaling, which cannot meet all business scenario operation and maintenance needs. For example, CPU and memory are not the only bottlenecks of IO-intensive systems. This tutorial will introduce how to implement application elastic scaling based on QPS data. For more application elastic scaling scenarios, see [Container Horizontal Scaling](https://help.aliyun.com/document_detail/2746980.html).

## Deployment
### Preparation


1. If you do not have an Alibaba Cloud account, please visit the [Alibaba Cloud Account Registration Page](https://account.aliyun.com/register/qr_register.htm) and complete registration according to the prompts. An Alibaba Cloud account is the entity that uses cloud resources, so it is a prerequisite for deploying the solution.
2. [Top up your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html)
   
   1. To save costs, this solution defaults to using pay-as-you-go resources. Using pay-as-you-go resources requires ensuring that your account balance is not less than 100 yuan.
   2. To complete the deployment and experience of this solution, the estimated cost is no more than 10 yuan (assuming that you choose the sample specifications in this article and the resources run for no more than 60 minutes. In actual operations, the actual cost may vary due to the actual traffic used, so the actual quotation and final bill should be taken as the reference, as shown in the table below for reference only).
      
      | **No.** | **Product** | **Specification** | **Region** |
      | --- | --- | --- | --- |
      | 1 | ECS | Instance specification and kernel, vCPU number. For best practices on ECS selection, please refer to [Best Practices for ECS Selection](https://help.aliyun.com/document_detail/58291.html). This tutorial uses ecs.c6.xlarge and ecs.c7.xlarge as examples. If you find that there is no recommended specification instance in the target availability zone, you can select other availability zones or other specification instances. | East China 1 (Hangzhou) |
      | 2 | ALB | Function version: Standard Edition. | East China 1 (Hangzhou) |
      | 3 | Kubernetes cluster | Cluster version: ACK Managed Cluster Pro Edition. | East China 1 (Hangzhou) |
      | 4 | SLS | No specification requirements. | East China 1 (Hangzhou) |
### One-click deployment


Click [One-click deployment](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/elastic-scaling-container-through-hpa.yml&hideStepRow=true&hideStackConfig=true&pageTitle=%E6%99%BA%E8%83%BD%E5%BA%94%E5%AF%B9%E6%B5%81%E9%87%8F%E5%8F%98%E5%8C%96%EF%BC%8C%E5%AE%B9%E5%99%A8%E5%8C%96%E9%9B%86%E7%BE%A4%E7%9A%84%E5%BC%B9%E6%80%A7%E6%94%BB%E7%95%A5&disableRollback=false&isSdisableNavigation=true&productNavBar=disabled&balanceIntercept=true&isSimplified=true) to go to the ROS console, select the ECS instance specification and availability zone (note that you need to select two different availability zones), and fill in the ACK Managed Edition cluster name and other additional information. The actual cost depends on the selected ECS specification, as shown in the console.
**Note** 

This tutorial uses ecs.c6.xlarge and ecs.c