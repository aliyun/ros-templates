Please translate the following content into English, and retain the original format:
## Overview

Multi-account configuration for unified compliance audit provides a multi-account compliance management solution for enterprise center management teams. It implements a unified compliance baseline from top to bottom and enforces resource management. It can continuously detect the compliance status of all business in a centralized manner. It improves the visibility and controllability of center management team work, and effectively plays a regulatory role and avoids potential risks.

### Architecture

After adopting the multi-account architecture, you can create account groups based on the organization structure in the Resource Directory in the configuration audit to define the scope of compliance management, and then create compliance rules for the account group to achieve cross-account resource compliance audit. The architecture of multi-account resource compliance audit is shown in the architecture diagram.


The advantages of this scheme are as follows:

* Continuous compliance audit
  
  Configuration audit enables you to monitor resource configuration changes continuously and trigger compliance evaluation automatically when changes occur, enabling you to achieve autonomous supervision of compliance.
* Rich pre-set templates
  
  You can start corresponding compliance items according to your requirements. Configuration audit will continuously detect target resources and correct non-compliant resources through correction templates.
* Integration across regions
  
  Configuration audit integrates resources from different regions into a complete list, and quickly integrates cloud resource configurations into the enterprise CMDB through resource lists and resource details APIs, achieving unified management of resources by the enterprise.

## Deployment
### Preparation


Before deployment, please complete the account application, account recharge, and Resource Directory activation according to the following guidelines.

#### Prepare accounts

1. If you do not have an Alibaba Cloud account, please visit the [Alibaba Cloud account registration page](https://account.aliyun.com/register/qr_register.htm) and follow the prompts to register an account.
2. [Recharge your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html).

The cloud resources in this scheme support pay-as-you-go, and the default settings are guided operations for pay-as-you-go. If you determine that any cloud resource uses the pay-as-you-go method for deployment, the account balance must be greater than or equal to 100 yuan.
**Note**

Configuration audit and Resource Management are free of charge. This scheme involves the OSS object storage used to store audit results, which will generate a small amount of fees.
3. Complete enterprise real-name authentication.
  
  For details, see [Enterprise Real-name Authentication](https://help.aliyun.com/zh/account/user-guide/enterprise-real-name-verification/).
#### Activate the Resource Directory and build the enterprise multi-account resource structure

The account that activates the Resource Directory is the management account of the Resource Directory.

1. In the [Resource Management console](https://resourcemanager.console.aliyun.com/), activate the Resource Directory.
  
  For details, see [Activate the Resource Directory](https://help.aliyun.com/zh/resource-management/resource-directory/user-guide/enable-a-resource-directory#task-2152699).
2. In the [Resource Management console](https://resourcemanager.console.aliyun.com/), build the enterprise organization structure. You can create new members or invite existing Alibaba Cloud accounts to join the organization.
  
  The management account should prepare at least two members in the Resource Directory. For details, see [Create a folder](https://help.aliyun.com/zh/resource-management/resource-directory/user-guide/create-a-folder#task-hjk-vq1-dhb), [Create a member](https://help.aliyun.com/zh/resource-management/resource-directory/user-guide/create-a-member#task-tzh-bs1-dhb), and [Invite an Alibaba Cloud account to join the Resource Directory](https://help.aliyun.com/zh/resource-management/resource-directory/user-guide/invite-an-alibaba-cloud-account-to-join-a-resource-directory#task-2039327).
### Plan resources


**Note**

If your account already has related cloud resources (for example, ECS instances, RDS instances, etc.), you do not need to perform this operation.

Refer to the instructions in the table and plan cloud resources in the scheme.

| **Planning item** | Quantity | **Description** |
| --- | --- | --- |
| Object Storage OSS | 2 | This scheme requires creating one storage space for each of the two members to detect whether the storage space is compliant. By default, the read-write permission of the created storage space is private. |

### Deploy resources


After planning the resources, deploy all resources in the scheme according to the following steps.

#### One-click deployment

Click [One-click deployment](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/multiple-accounts-support-configuration-auditing.yml&hideStepRow=true&pageTitle=%E4%BC%81%E4%B8%9A%E5%A4%9A%E8%B4%A6%E5%8F%B7%E9%85%8D%E7%BD%AF%E7%BB%9F%E4%B8%80%E5%90%88%E8%A7%84%E5%AE%A1%E8%AE%A1&disableRollback=false&isSimplified=true&dion=true&productNavBar=disabled) to go to the ROS console. On the ROS console resource stack page, configure the template parameters and complete the creation according to the prompts.

This template completes the following operations for you:

√Opens the configuration audit

√Creates an account group

√Creates a compliance package (this scheme uses the rules **OSS storage space ACL prohibits public read** and **OSS storage space ACL prohibits public read and write** in the Level 3 Security Compliance Pre-check Compliance Package to detect the compliance of resources (storage spaces) under the two members)

You can click the created resource stack to view the resource name, type, and ID in the resource.

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5220940171/p779691.png)

#### Manual deployment

1. **Open the configuration audit**
   Before using the configuration audit, the management account must first open the configuration audit service to obtain a cross-region resource list and perform compliance audits on the resources.
   
   1. Log on to the [configuration audit console](https://config.console.aliyun.com).
   2. Click **Enable Now**.
      
      The configuration audit automatically creates a configuration audit service associated role, which is used to obtain access permissions for other cloud services. For more information, see [Configuration Audit Service Associated Role](https://help.aliyun.com/document_detail/162994.html).
   
   **Note**

   It takes 2~10 minutes for the configuration audit to scan your current account's resources and build a resource list. Please wait patiently.

2. **Create an account group**
   To realize customized management of the resources and their compliance within a certain account group, you need to create an account group. This scheme uses the creation of a custom account group as an example.
   
   1. Log on to the [configuration audit console](https://config.console.aliyun.com).
   2. In the left navigation bar, click **Account Group**.
   3. In the **Account Group** page, click **Create Account Group**.
   4. In the **Create Account Group** page, set the account group name and description, and then click **Add Member**.
   5.