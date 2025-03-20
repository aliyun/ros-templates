## Overview

Video and graphic multimedia data is growing rapidly, and the content is continuously enriched. The multimedia data storage and distribution solution integrates object storage OSS, content delivery network CDN, intelligent media management IMM products, solves customer multimedia data storage, processing, acceleration, distribution and other business problems, and realizes low-cost and stable business goals. This technical solution takes building a multimedia data storage and distribution service as an example to demonstrate:

* How to build a multimedia data storage and distribution service
* Simulate multimedia data processing and acceleration distribution

## Architecture

The default settings of the scheme are deployed on Alibaba Cloud. The website running environment shown in the architecture diagram is built after deployment. When deploying, you can modify some settings according to resource planning, but the final running environment is similar to the architecture diagram.


This scheme takes the scenario of multimedia content acceleration distribution as an example. The technical architecture of this scheme includes the following infrastructure and cloud services:

* 1 Object Storage OSS: provides massive storage space and high throughput bandwidth.
* 1 Content Delivery Network CDN: used to accelerate access to resources stored in Object Storage OSS.
* 1 Intelligent Media Management IMM: provides image and video storage, processing, analysis, search and other functions, helping users better manage and utilize massive multimedia data.
* 1 Domain Name: already registered domain name.
## Deployment
### Preparation


Before deployment, please follow the instructions below to complete account application, account recharge, and service activation.

### Prepare Account

1. If you do not have an Alibaba Cloud account, please visit [Alibaba Cloud Account Registration Page](https://account.aliyun.com/register/qr_register.htm) and follow the prompts to register. An Alibaba Cloud account is the payment entity for using cloud resources, so it is a necessary prerequisite for deploying the scheme.
2. [Recharge your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html).

   1. To save costs, this scheme defaults to all using pay-as-you-go resources. Pay-as-you-go resources require that the account balance is not less than 100 yuan.
   2. The estimated cost for completing the deployment and experience does not exceed 1 yuan (assuming that you choose the lowest specification resources, and the resource runtime does not exceed 30 minutes. In actual operation, if some instances cannot be purchased, you need to adjust the resource specifications according to actual situations, and the actual traffic may vary, so the actual quotation and final bill shall prevail). The estimated cost does not include domain name and encryption certificate fees.
      
      | **No.** | **Product** | **Source** | **Specification** | **Region** | **Estimated Cost Reference** | **Remarks** |
      | --- | --- | --- | --- | --- | --- | --- |
      | 1 | Object Storage OSS | Standard Storage (Local Redundancy) Capacity (Storage) Fee | - | East China 1 (Hangzhou) | 0.12 yuan/GB/month | - |
      | PUT or