Please translate the following content into English, and retain the original format:
## Overview of the Solution

When a new business is launched in an enterprise, it is generally considered to be deployed in a new account. If you register a new account through the console and complete the configuration of security compliance baseline within the account, the process will often take a long time and is easy to make mistakes. Using the account factory solution can efficiently build a new account with security compliance. In this solution, we will introduce how to use the open-source IaC tool (Terraform) to quickly create a new account with security compliance. Through this solution, you can unify the baseline of different accounts within the enterprise and flexibly adapt to the personalized needs of different enterprises for account initialization.

### Solution Architecture

The default settings provided by the solution after deployment on Alibaba Cloud are shown in the architecture diagram as the website running environment. When actually deploying, you can modify some settings according to the resource planning, but the final running environment will be similar to the architecture diagram.


The technical architecture of this solution includes the following infrastructure and cloud services:

* Resource Management: You can quickly create a corporate real-name authenticated resource account using the resource catalog in resource management.
* Access Control: By assigning AssumeRole and resource catalog permissions to the RAM user, you can use this RAM user to assume a temporary identity role in a new account and complete the configuration of the baseline in the new account using this temporary identity.
* Virtual Private Cloud: Create a VPC in the account to prepare the network environment for subsequent application deployment.
## Solution Deployment
### Deployment Preparation


Before starting the deployment, please follow the instructions below to complete the account application, real-name authentication, RAM user creation, and authorization.

#### Account Preparation

1. If you do not have an Alibaba Cloud account, please visit the [Alibaba Cloud account registration page](https://account.aliyun.com/register/qr_register.htm) and complete the registration according to the prompts on the page. An Alibaba Cloud account is the entity that uses cloud resources and is therefore a prerequisite for deploying the solution.
2. Complete the [Enterprise Real-name Authentication](https://help.aliyun.com/zh/account/user-guide/enterprise-real-name-verification/) for your Alibaba Cloud account. Only Alibaba Cloud accounts that have passed enterprise real-name authentication can open a resource directory.
3. Create a RAM user for the deployment of the solution.
   
   1. Create 1 RAM user. For specific operations, see [Create a RAM User](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user).
   2. Grant the following cloud services access permissions to complete the solution deployment. For specific operations, see [Grant Permissions to the RAM User](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user).
   3. | Cloud Service | Required Permission | Description |
      | --- | --- | --- |
      | Resource Directory RD | AliyunResourceDirectoryFullAccess | Permission to manage the Resource Directory RD |
      | Access Control RAM | AliyunSTSAssumeRoleAccess | Permission to call the STS service AssumeRole interface |

#### Environment Preparation

In order to efficiently create a new cloud account, you need to first open the resource directory.

1. Log in to the [Resource Manager Console](https://resourcemanager.console.aliyun.com/).
2. In the left navigation bar, select **Resource Directory** > **Overview**.
3. Click **Open Resource Directory**.
4. Select **Use the current account to open**.
5. Click **Open**.
6. In the **Security Verification** dialog box, complete the security verification through a mobile phone number or email, and then click **OK**.
7. Create two resource folders (Core and Application).

1. Log in to the [Resource Manager Console](https://resourcemanager.console.aliyun.com/).
2. In the left navigation bar, select **Resource Directory>Overview**.
3. Click the **Resource Organization** tab.
4. Under the **Root** resource folder on the left, select the target resource folder, and then click **Create Resource Folder** on the right side of the page in the resource folder.
   
   You will create a sub-resource folder under the target resource folder.
5. In the **Create Resource Folder** panel, fill in the **Resource Folder Name**.
6. Click **OK**.
### One-click Deployment


One-click deployment is based on Alibaba Cloud Resource Orchestration Service ROS (Resource Orchestration Service). ROS hosts the Terraform template, which defines scripts and automates the creation and configuration of cloud resources to improve the efficiency of resource creation and deployment. The ROS template completes the following tasks:

* Create a new real-name authenticated account under the resource directory
  
  **Note** 
  
  Only Alibaba Cloud accounts that have passed enterprise real-name authentication can open a resource directory.
* Configure the security compliance baseline for the newly created account

**Operation Steps**
--------

1. Open the [template link for one-click configuration](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/documents/solution/efficiently-build-a-new-account-with-security-and-compliance.yml&isSimplified=true) to go to the ROS console, and the system automatically opens the panel for creating a resource stack using the new account, and displays the detailed information of the YAML file in the **Template Content** area.
   
   **Note** 
   
   The ROS console defaults to the region you last visited when you accessed the console. Please modify the region to the region where the resources are located before proceeding to the next step.
2. After confirming the region, select the resource directory resource folder where the new account needs to be created, and click Create.
3. When the **Resource Stack Information** page shows the **Status** as **Creation Successful**, the one-click configuration is completed.

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3986359761/p606086.png)

### Completion and Cleanup


#### Solution Verification

**Verify the security compliance of the new account through the Resource Directory Console by logging in to the new account**

1. Log in to the [Resource Manager Console](https://resourcemanager.console.aliyun.com/).
2. In the left navigation bar, select **Resource Directory** > **Overview**.
3. Click **Resource Organization** or **Member List** tab.![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2852609271/p859860.png)
4. In the member list, click the **Login Account** column of the target member **Operations**.
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2852609271/p859865.png)

After logging in, the RAM user managed by the account will play the RAM role in the new account and can view the relevant compliance baselines configured in the account. In this demonstration scheme, the baselines involved include:

* RAM account, you can log in to [Access Control - Identity Management](https://ram.console.aliyun.com/users) to view the RAM users created by the account factory.![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2852609271/p859882.png)
* SSO configuration, you can log in to [Access Control - Integration Management](https://ram.console.aliyun.com/providers) to view the SSO configurations created by the account factory.![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2852609271/p859884.png)
* VPC configuration, you can log in to [Virtual Private Cloud](https://vpc.console.aliyun.com/) to view the VPC resources created by the account factory.![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2852609271/p859872.png)
#### Resource Cleanup

In this scheme, you created resource folders, 1 RAM account, and VPC and vSwitch created by the ROS template. After testing the scheme, you can handle the corresponding accounts and resources according to the following rules.

1. Log in to the [ROS Management Console](https://ros.console.aliyun.com/cn-beijing/stacks).
   
   1. In the left navigation bar, select **Resource Stack**.
   2. Find the target resource stack, and click the **Operations** column of **Delete**.
2. Log in to the [Resource Directory Console](https://resourcemanager.console.aliyun.com/resource-directory/folders/r-creKjI).
   
   1. Click **Resource Organization** or **Member List** tab.
   2. In the member list