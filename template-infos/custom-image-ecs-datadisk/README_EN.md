Please translate the following Chinese text into English, and keep the original format:
## Deployment Instructions
Modification instructions for template examples:
- This template is applicable to the scenario where ISV deploys software through custom images in a computing nest. You can use this example to configure image distribution when creating an ISV service to create ECS servers with different images in different regions.
How to create a resource stack using template examples:
- If you use a RAM user, make sure that you have enabled the ECS and VPC services and obtained authorization before using the template.
- Click "Create Resource Stack" to deploy, fill in or select parameters according to the description of the parameters.
- After the resource stack is created, query EcsInstanceId through the resource stack output page.

## Automated Deployment
1. Click [Deployment Link](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/ros-templates/examples/isv/custom-image-ecs-datadisk.yml&hideStepRow=true&hideStackConfig=true&pageTitle=自定义镜像创建单实例ECS云服务器(添加数据盘)&isSimplified=true&balanceIntercept=true) to enter the deployment page.
2. In the **Configure Template Parameters** step, input parameter information according to the prompts on the console, confirm the security information, and click **Next: Check and Confirm** to enter the parameter confirmation page.
3. On the resource allocation preview page, after confirming the template parameters and costs, click **Create**.
4. When the **Resource Stack Information** page shows the **Status** as **Creation Successful**, automated deployment is completed.

## Confirmation of Deployment Information
- Click the **Resources** tab to view the created resources.
- Click the **Parameters** tab to view the parameter information filled in when creating the resource stack.
- Click the **Outputs** tab to view the output information, which can be used for deployment verification.

## Clearing Resources
1. In the [Resource Stack List](https://ros.console.aliyun.com/region/stacks), select the resource stack created earlier.
2. Click **Delete** in the **Operations** column on the right side and confirm to delete all created resources at one click. 