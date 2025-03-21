Please translate the following Chinese text into English, and retain the original format:
## Solution Overview

This solution demonstrates how to use the Tongyi Wanxiang AIGC technology developed in-house to implement advanced image generation in Web services. It includes functions such as text-to-image, doodle conversion, portrait style reshaping, and character photo creation. These capabilities can accelerate the creative process of artists and designers and improve creative efficiency. At the same time, they can also be applied in various fields such as advertising marketing, education, and game development to enhance the visual presentation of content and user experience. Through Tongyi Wanxiang, users can easily convert text descriptions or simple sketches into high-quality images, achieving personalized visual content customization to meet the needs of social media, e-commerce, and electronic entertainment industries. This marks the infinite possibilities of artistic creation, personalized expression, and digital content development.

## Solution Architecture

The default settings provided by the solution will build a website operating environment on Alibaba Cloud after deployment, as shown in the architecture diagram.

### The technical architecture of this solution includes the following infrastructure and cloud services:

- 1 Virtual Private Cloud (VPC): Cloud servers ECS are created under this VPC.
- 1 Switch: Cloud servers ECS are created under this switch.
- 1 Cloud Server ECS: Used to deploy the sample application.
- 1 Object Storage OSS Bucket: Stores user-uploaded pictures and generates signed URLs for download by the large model. It is recommended to use an OSS Bucket in the same region as the ECS.
- Bailei Model Service: Used by the sample application to call Tongyi Wanxiang.

## Deployment Preparation

Before starting the deployment, please complete account application, account recharge, service activation, and authorization according to the following instructions.

### Prepare Account

1. If you do not have an Alibaba Cloud account, please visit the [Alibaba Cloud account registration page](https://account.aliyun.com/register/qr_register.htm) and follow the prompts to register. An Alibaba Cloud account is the entity that pays for your use of cloud resources, so it is a prerequisite for deploying the solution.
2. Recharge your Alibaba Cloud account

   * To save costs, this solution defaults to using all pay-as-you-go resources. Using pay-as-you-go resources requires ensuring that your account balance is not less than 100 yuan.
   * Completing the deployment and experience of this solution is expected to incur costs of no more than 10 yuan.

### Activate Bailei Services and Obtain API-KEY

1. Go to [Model Square](https://bailian.console.aliyun.com/#/model-market) to activate the model service.
2. Obtain the API Key: In order to be able to call the large model through the API, you also need to create an API Key in the [API Key Management interface](https://bailian.console.aliyun.com/?apiKey=1).
   
**Note: Please keep the API Key safe and avoid writing it in plain text in the code to prevent leakage.**

## One-Click Deployment

1. Click [One-Click Deployment](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/drawing_with_tongyi_wanxiang_new.yml&hideStepRow=true&hideStackConfig=true&pageTitle=Creative Accelerator: AI Painting Creation&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled) to go to the ROS console.
2. Select the Bailei API-KEY, ECS instance specifications (2-core 8-gigabyte), availability zone, and input the instance password, and configure the application login information. We recommend that you manually record the configured username and password, which can be directly logged into the sample application next time. The actual cost incurred depends on the ECS specification you choose, as displayed in the console.

**Note: Be sure to save the username and password for configuring the application login information, which is the only password for logging into the sample application.**

![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3356686171/p804562.png)

After starting the creation, wait for about 5 minutes until the creation is successful.
If the following situation occurs: click **Open Link** to open the OSS service, and then continue creating.
![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4922044271/p839477.png)
![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3356686171/p804563.png)

## Completion and Cleanup

### Solution Verification

* Click the **Output** tab of the resource stack, and then click the URL corresponding to the experience address to access it.

![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3356686171/p804565.png)

* After opening the experience address in the browser, enter the username and password you configured earlier on the login page, and then log in.

**Note**

If you forget the username, you can find your setting information in the DemoUserName parameter of the ROS resource stack.

* Now you can start experiencing the Tongyi Wanxiang API.

![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5246427271/p852713.png)

### Resource Cleanup

In this solution, you created 1 cloud server ECS instance, 1 switch, 1 virtual private network VPC, and 1 object storage OSS bucket. If you no longer need to use them, delete the resources as soon as possible to avoid continuing to incur costs.

1. Log in to the [ROS console](https://ros.console.aliyun.com/overview).
2. In the left navigation bar, select **Resource Stack**.
3. On the **Resource Stack** page at the top, select the region where the deployed resource stack is located, find the resource stack, and then in the **Operation** column on its right, click **Delete**.
4. In the **Delete Resource Stack** dialog box, select **Deletion Method** as **Release Resources**, and then click **OK** to complete the resource release according to the prompt.
5. Delete the Bailei **API-KEY** :
   In the [API-KEY Management](https://bailian.console.aliyun.com/?apiKey=1) page, find the target API-KEY, click **Operation** in the **Operation** column, and then click **Delete** according to the prompts on the page to delete it. 