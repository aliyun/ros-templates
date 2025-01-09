## **方案概览**

本方案旨在通过基于阿里云容器服务Kubernetes版（ACK）实现微服务的部署，借助容器技术和Kubernetes的强大功能，实现资源的高效利用、更高扩展性和弹性、快速迭代部署及DevOps流程优化，从而全面提升业务灵活性与竞争力。通过本方案，企业能够实现应用部署的容器化转型，提升运维效率、优化资源利用，并加速业务创新步伐，为企业的数字化升级奠定坚实基础。

## **方案架构**

本方案介绍如何基于ACK，实现微服务应用部署，提升运维效率、优化资源利用，加速业务创新和市场响应速度。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与下图相似。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0993189171/p816170.png)

模拟应用服务对外提供 API`a`和API`b`，API`a`依赖API`b`。API`b`返回服务名称以及一个UUID；API`a`返回服务名称和一个UUID以及通过HTTP请求的API`b`的返回值。

本方案的技术架构包括以下基础设施和云服务：

* 1个专有网络VPC：为应用型负载均衡ALB、云服务器ECS、阿里云容器服务Kubernetes版ACK集群等云资源构建云上私有网络
* 2台交换机：使多可用区的3台云服务器ECS、阿里云容器服务Kubernetes版ACK集群和应用型负载均衡ALB能够在同一网络上进行通信，并提供基本的网络分段和隔离功能。
* 1个公网应用型负载均衡ALB：对外提供访问，作为ACK集群的Ingress实现。
* 1个阿里云容器服务Kubernetes版ACK集群
* 3台云服务器ECS：用于部署模拟应用服务，为ACK使用。
## **方案部署**
### **部署准备**


开始部署前，请按以下指引完成账号申请、账号充值。

#### **准备账号**

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。如果确定任何一个云资源采用按量付费方式部署，账户余额都必须大于等于100元。
### **一键部署**


**ROS一键部署**
-----------

1. 打开[一键配置模板链接](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/build-microservices-on-ack.yml&hideStepRow=true&hideStackConfig=true&pageTitle=灵活调度，高效编排，容器化管理云上应用&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled&balanceIntercept=true)前往ROS控制台，系统自动打开使用新资源创建资源栈的面板，并在**模板内容**区域展示YAML文件的详细信息。
   
   **说明** 
   
   ROS控制台默认处于您上次访问控制台时所在的地域，请根据您创建的新资源所在地域修改对应地域后再执行下一步。
2. 确认好地域后，系统自动刷新出配置模板参数页面。
3. 在**配置模板参数**页面修改资源栈名称，可用区，配置ECS实例（推荐使用**通用算力型**，**ecs.u1-c1m2.xlarge**）。填写完所有必选信息并确认后单击**创建**开始一键配置。
   
   **说明** 
   
   防止可用区资源不足情况导致ALB无法访问，这里建议选择可用区J和可用区K。
4. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。说明：
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2206829171/p813882.png)
### 验证与资源清理


#### 方案验证

**一、通过访问ALB Ingress，验证服务可用性**

完成了一键部署之后，登录ACK控制台，通过创建的ALB Ingress发起访问验证服务是否成功部署。

1. 登录[容器服务ACK管理控制台](https://cs.console.aliyun.com/#/k8s/cluster/list)。
2. 在左侧导航栏，选择**集群**，点击创建的集群，点击名称开始操作。
3. 在左侧导航栏，选择**网络**，在展开的菜单中选择**路由**，找到创建的ALB Ingress的**端点**一列，获取`端点域名`，在浏览器中访问`端点域名/a`，查看返回值，例如：

```
[
    {
        "serviceName": "a",
        "uuid": "f1b99e7a-e731-4a3b-aa22-5e8a3abd577c"
    },
    {
        "serviceName": "b",
        "uuid": "d1eee41e-3259-4eb2-a018-43b7df64589b"
    }
]
```

说明模拟应用服务正常运行。

**二、通过配置手动和自动弹性伸缩，验证服务扩缩容**

1. 手动弹性伸缩

在[容器服务ACK管理控制台](https://cs.console.aliyun.com/?spm=a2c4g.2808202.0.0.5fb6a985o1vHY7#/k8s/cluster/list)选择目标集群，在左侧导航栏中，选择**节点管理 > 节点池**，点击**去配置**。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0376216271/p848100.png)

为了快速看到扩缩容现象，修改如下参数。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0376216271/p848101.png)完成后，点击当前节点池操作栏中的**编辑**按钮，在弹出的窗口中，找到并勾选**开启自动弹性伸缩**。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0376216271/p848097.png)

在左侧导航栏中，选择**工作负载**>**无状态**。点击“ecs-ack-test-service-a”应用操作栏中的**伸缩**按钮。将所需容器组数量设置为 8。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0376216271/p848102.png)

等待集群完成扩容，在“容器组”列表中可以看到当前无状态工作负载的容器组数量变为8。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0376216271/p848103.png)

在左侧导航栏中，选择**工作负载**>**无状态**。点击“ecs-ack-test-service-a”应用操作栏中的**伸缩**按钮。将所需容器组数量设置为 2。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0376216271/p848104.png)在“容器组”列表中可以看到当前无状态工作负载的容器组数量变为2。![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5462237271/p854058.png)

2. 基于 Ingress 的弹性伸缩

在左侧导航栏中，选择**工作负载**>**无状态**。点击“ecs-ack-test-service-a”名称进入详情页。点击**容器伸缩**标签，点击创建指标伸缩（HPA）。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0376216271/p848106.png)

参考下图完成HPA配置。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0376216271/p848109.png)

我们使用负载测试工具 [Locust](https://locust.io/)（参考[官方文档](https://docs.locust.io/en/stable/installation.html)安装） 进行测试。以下是详细的操作步骤和测试结果分析。

创建文件locustfile.py，完整代码如下：

```
from locust import HttpUser, TaskSet, task, between

class UserBehavior(TaskSet):
    @task(1)
    def query_department_with_cache(self):
        self.client.get("/a")

class WebsiteUser(HttpUser):
    tasks = [UserBehavior]
    wait_time = between(1, 5)

if __name__ == "__main__":
    import os
    os.system("locust -f <this_script_name>.py")
```

在命令行中运行`locust`启动 Locust。打开浏览器，访问 Locust Web 界面 `http://localhost:8089`，如图所示填写测试参数。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0376216271/p848111.png)

可以观察到当前CPU的使用率和容器组数量的增加。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0376216271/p848112.png)

节点池中的节点数也有变化，自动触发了扩容。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0376216271/p848113.png)

通过上述步骤，成功验证了服务的部署，并演示了手动弹性伸缩和基于 Ingress 的自动弹性伸缩功能。在负载增加时，HPA自动扩展 Pod 数量，而 ALB作为 Ingress 控制器，将外部流量均匀分配到这些新增的 Pod 上，实现流量管理和负载均衡。

#### 清理资源

在本方案中，您创建了3台云服务器ECS实例、1个应用型负载均衡ALB实例、2个交换机、1个专有网络VPC、1个阿里云容器服务Kubernetes版ACK集群。测试完方案后，您可以参考以下规则处理对应产品的实例，避免继续产生费用：

1. 释放资源栈下的资源，即3台云服务器ECS实例、1个应用型负载均衡ALB实例、2个交换机、1个专有网络VPC、1个阿里云容器服务Kubernetes版ACK集群。
   
   1. 登录[ROS控制台](https://ros.console.aliyun.com/overview)。
   2. 在左侧导航栏，选择**资源栈**
   3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
   4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
