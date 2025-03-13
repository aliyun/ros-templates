Please translate the following content into English, and retain the original format:
## Overview of the Solution

The characteristics of distributed system calls are to execute a core business logic while calling multiple downstream businesses for processing. Therefore, how to ensure the consistency of the core business and multiple downstream business execution results is the main problem that distributed transactions need to solve. Through this tutorial, you will learn how to use the transaction message function of Cloud Message Queue RocketMQ Edition to ensure the final consistency of local main branch transactions and downstream message sending transactions in distributed scenarios. Downstream businesses can ensure the correct processing of messages through means such as retrying consumption, and achieve the final consistency of core business and multiple downstream business execution results.

## Solution Architecture

This solution aims to use Cloud Message Queue RocketMQ Edition to realize an efficient and reliable distributed transaction processing system. Distributed transactions are particularly important in microservice architecture, ensuring that operations across multiple services or databases maintain consistency and integrity. The transaction message function of RocketMQ provides an elegant solution to this requirement, guaranteeing the final consistency of messages and business operations through a two-phase commit model of pre-commit, commit/rollback. At the same time, the architecture also uses proprietary network VPC, switches, and security groups, etc., to achieve system communication under private networks.

The default settings provided by the solution complete the deployment of a highly available architecture on Alibaba Cloud after deployment. You can modify some settings according to resource planning during actual deployment, but the resulting operating environment should be similar to the architecture diagram. 


The technical architecture of this solution includes the following infrastructure and cloud services:

* 1 VPC: builds a private cloud network for cloud resources such as ECS, RDS, and RocketMQ.
* 4 switches: deployed in the same availability zone.
* 2 ECS servers: used to deploy the business system, with producers and consumers deployed on different servers to achieve a distributed business scenario and provide application services.
* 1 RDS MySQL basic edition: provides data services for the business system.
* 1 standard edition of RocketMQ: ensures data consistency and reliable message delivery in a distributed system through transaction messages.

The overall process of implementing distributed transactions in this solution is as follows:

1. The user submits a transaction request, triggering the execution of a distributed transaction.
2. The producer sends a half-transaction message to the RocketMQ service end, at which point the message is in a pre-commit state and has not yet been truly delivered to the consumer end.
3. The producer executes the local business logic, completing operations on the RDS database.
4. Based on the result of the local transaction, the producer sends a transaction confirmation message to the RocketMQ service end. The confirmation message can be Commit (commit) or Rollback (rollback).
5. The server processes the secondary confirmation result of the transaction:
   
   5.1 If the confirmation result is Rollback, the RocketMQ service end will roll back the message, i.e., it will not be delivered to the consumer end, ensuring that the message will not be consumed.
   
   5.2 If the confirmation result is Commit, the RocketMQ service end will officially deliver the message to the consumer end, ensuring that the message can be correctly processed.
6. If the service end does not receive the secondary confirmation result submitted by the message producer, it will initiate a message query to the message producer. The producer needs to check the final result of the local transaction and again submit the secondary confirmation to the service end.
7. The consumer end processes the message, performing operations on the RDS, completing the entire distributed transaction process.

## Solution Deployment
### Deployment Preparation


Before deploying, please follow the instructions below to apply for an account and top up your account balance.

### Account Preparation

1. If you do not have an Alibaba Cloud account, please visit the [Alibaba Cloud account registration page](https://account.aliyun.com/register/qr_register.htm) and follow the prompts to complete the registration. An Alibaba Cloud account is the entity that pays for cloud resources, so it is a prerequisite for deploying the solution.
2. [Top up your Alibaba Cloud account](https://help.aliyun.com/document_detail/324650.html). This solution supports pay-as-you-go for cloud resources, and the default settings all guide operations using pay-as-you-go. If you determine that any cloud resource will be deployed using pay-as-you-go, the account balance must be greater than or equal to 100 yuan.
### One-click Deployment


One-click deployment is realized based on Alibaba Cloud Resource Orchestration Service ROS (Resource Orchestration Service), and the ROS template has defined scripts that can automatically complete the creation and configuration of cloud resources, improving the efficiency of resource creation and deployment. The ROS template completes the following content:

#### Operation Steps

You can automatically complete the creation and configuration of these resources through the one-click deployment link provided below:

* Create 2 ECS instances.
* Create 1 VPC.
* Create 4 switches.
* Create 1 security group.
* Create 1 RDS MySQL basic edition.
* Create 1 standard edition of RocketMQ.

One-click deployment of resources.

1. Click [One-click Deployment](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/through-RocketMQ-transaction-messages.yml&hideStepRow=true&hideStackConfig=true&pageTitle=通过RocketMQ事务消息实现分布式事务&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled), select the region in the top navigation bar.
2. Modify **Resource Stack Name** in the configuration page, and select and configure parameters as needed.
3. When the **Resource Stack Information** page's **Status** displays as **Creation Successful**, the one-click configuration is completed.
### Verification and Cleanup


#### Solution Verification

**1. Verify the consistency of distributed transactions through simulated order and logistics information creation**

1. Click the **Output** tab of the resource stack, and then click the URL corresponding to the experience address for access. ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9712055271/p840510.png)
2. System login: Enter the username and password configured before creating the ROS resource stack in the login page, and then log in and experience (if you forget the username, you can find your settings information in the AppDemoAccountName parameter of the ROS resource stack creation). ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9712055271/p837683.png)
3. Simulated payment: After successful login, the system will automatically jump to the "Simulated Order Payment" page. On this page, enter the user ID and order number in integer form, and click the "Simulated Payment" button. If the operation is correct, the system will display the message "Payment order created successfully!" indicating that the payment process has been successfully simulated. ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9712055271/p837687.png)![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9712055271/p837690.png)
4. Verify the creation of logistics information: To verify the integrity of the distributed transaction, we will next verify whether the logistics information is created along with the order. Enter the `http://<ECS Public IP>/logistic` in the browser address bar to enter the "Logistics Query Simulation" page. Here, use the same user ID and order number for query. If everything goes according to the expected design, the system will feedback "Logistics information query result is created", directly proving that at the same time as the order is created, the corresponding logistics record is also successfully established through the transaction message mechanism of RocketMQ. ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9712055271/p837698.png)
5. Summary: When creating an order, first send a half-transaction message to RocketMQ, marking the start of the process. Then, execute the order initialization logic, considered as pre-commit. According to the order result, RocketMQ confirms or rolls back the transaction through specific interfaces, ensuring the consistency of operations. Once the