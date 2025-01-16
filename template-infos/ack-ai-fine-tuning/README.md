## 方案概览

大模型训练和推理是机器学习和深度学习领域的重要应用，但企业和个人往往面临着 GPU 管理复杂、资源利用率低，以及 AI 作业全生命周期管理中工程效率低下等挑战。本方案通过创建ACK集群Pro版，使用云原生AI套件提交模型微调训练任务与部署GPU 共享推理服务。适用于机器学习和深度学习任务中的以下场景：

* 模型训练：基于 Kubernetes 集群微调开源模型，可以屏蔽底层资源和环境的复杂度，快速配置训练数据、提交训练任务，并自动运行和保存训练结果。
* 模型推理：基于 Kubernetes 集群部署推理服务，可以屏蔽底层资源和环境的复杂度，快速将微调后的模型部署成推理服务，将模型应用到实际业务场景中。
* AI 作业生命周期管理：命令行工具 Arena 实现 AI 作业生命周期管理，包括模型训练、模型评测、模型推理等环节。Arena 可以完全屏蔽底层资源和环境管理、任务调度、GPU 分配和监控的复杂性，兼容主流AI框架和工具，例如 TensorFlow ，还提供多种语言 SDK ，便于您二次开发。
* GPU 共享推理：支持 GPU 共享调度能力和显存隔离能力，可将多个推理服务部署在同一块GPU 卡上，提高 GPU 的利用率的同时也能保证推理服务的稳定运行。

### 方案架构

方案提供的默认设置完成部署后在阿里云上搭建的网站运行环境如架构图所示。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与架构图相似。


本方案的技术架构包括以下基础设施和云服务：

* 1 个地域：ACK 集群、云原生AI套件、文件存储 NAS 均部署在同一地域下。
* 1 个专有网络 VPC ：为 ACK 、NAS 、云原生 AI 套件等云资源形成云上私有网络。
* 1 个ACK集群Pro版：简单、低成本、高可用的 Kubernetes 集群，支持应用管理，无需您管理控制面板。
* 云原生AI套件：容器服务 Kubernetes 版提供的云原生AI 技术和产品方案，以 Kubernetes 容器服务为底座，支持大模型训练及 GPU 共享推理服务部署。
* 1 个 NAS 实例：可共享访问，弹性扩展，高可靠，高性能的分布式文件系统，支持共享访问。

## 方案部署
### 部署准备


开始部署前，请按以下指引完成账号申请、账号充值、RAM 用户创建和授权。

#### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。请确保您的账户余额大于等于 100 元。
3. 阿里云账号拥有操作资源的最高权限，从云资源安全角度考虑，建议您创建 RAM 用户。RAM 用户需要获得相关云服务的访问权限才能完成方案部署，详情如下：
   
   1. 访问 [RAM 控制台-用户页面](https://ram.console.aliyun.com/users)，单击**创建用户**，填写相关信息，勾选**控制台访问**和 **OpenAPI 调用访问**，自定义密码并选择无需重置密码，创建一个 RAM 用户。
   2. 在 RAM 用户列表的操作列，单击目标RAM用户对应的**添加权限**。在**添加权限**面板，在**选择权限**策略的**系统策略**区域，搜索并新增如下权限，然后单击**确定**。
      
      涉及的云服务：资源编排 ROS 、容器服务 Kubernetes 版、专有网络 VPC、云服务器 ECS、访问控制 RAM、费用中心 BSS、文件存储 NAS、弹性公网 IP、NAT 网关、Cloud Shell 。
      
      每次支持最多绑定5条策略，请分多次操作添加如下权限。
      
      | **云服务** | **需要的权限** | **描述** |
      | --- | --- | --- |
      | 资源编排 ROS | AliyunROSFullAccess | 管理资源编排服务 ROS 的权限。 |
      | 容器服务 Kubernetes 版 | AliyunCSFullAccess | 首次登录容器服务 Kubernetes 版时，需要为服务账号授予的系统默认角色。 |
      | 专有网络 VPC | AliyunVPCFullAccess | 管理专有网络 VPC 的权限。 |
      | 云服务器 ECS | AliyunECSFullAccess | 管理云服务器服务 ECS 的权限。 |
      | 访问控制 RAM | AliyunRAMFullAccess | 管理访问控制 RAM 的权限，即管理用户以及授权的权限。 |
      | 费用中心 BSS | AliyunBSSReadOnlyAccess | 只读访问费用中心 BSS 的权限。 |
      | 文件存储 NAS | AliyunNASFullAccess | 管理文件存储 NAS 的权限。 |
      | 弹性公网 IP | AliyunEIPFullAccess | 管理弹性公网 IP（EIP）的权限。 |
      | NAT 网关 | AliyunNATGatewayFullAccess | 管理 NAT 网关（NAT Gateway）的权限。 |
      | 弹性伸缩服务 ESS | AliyunESSFullAccess | 管理弹性伸缩服务（ESS）的权限 |
      | Cloud Shell | AliyunCloudShellFullAccess | 管理云命令行（Cloud Shell）的权限。 |
      
      创建 RAM 用户后，您可以使用 RAM 用户登录阿里云控制台，开始本方案的部署和体验。
      
      RAM 用户的使用请参见[创建 RAM 用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)、[创建自定义权限策略](https://help.aliyun.com/zh/ram/user-guide/create-a-custom-policy)和[为 RAM 用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。
   3. 单击[云资源访问权限](https://ram.console.aliyun.com/role/authorization?request=%7B%22Services%22%3A%5B%7B%22Service%22%3A%22CS%22%2C%22Roles%22%3A%5B%7B%22RoleName%22%3A%22AliyunCSManagedLogRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedLogRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedCmsRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedCmsRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedCsiRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedCsiRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedVKRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedVKRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSClusterRole%22%2C%22TemplateId%22%3A%22Cluster%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSServerlessKubernetesRole%22%2C%22TemplateId%22%3A%22ServerlessKubernetes%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSKubernetesAuditRole%22%2C%22TemplateId%22%3A%22KubernetesAudit%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedNetworkRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedNetworkRole%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSDefaultRole%22%2C%22TemplateId%22%3A%22Default%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedKubernetesRole%22%2C%22TemplateId%22%3A%22ManagedKubernetes%22%7D%2C%7B%22RoleName%22%3A%22AliyunCSManagedArmsRole%22%2C%22TemplateId%22%3A%22AliyunCSManagedArmsRole%22%7D%5D%7D%5D%2C%22ReturnUrl%22%3A%22https%3A%2F%2Fcs.console.aliyun.com%2F%22%7D)，然后单击**同意授权**。
      
      此页权限为可供容器服务 ACK 使用的角色。授权后，ACK 拥有对您云资源相应的访问权限。
### 一键部署


您可以通过下方提供的 ROS 一键部署链接，来自动化地完成以下资源的创建和配置。部署完成后，您可以参见教程实现并体验如何训练大模型以及部署 GPU 共享推理服务。

* 创建一个名为 ai-test 的ACK集群Pro版
* 创建一个容量型 NAS 实例

#### ROS 部署前置资源

1. 单击[一键部署](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/ack-ai-fine-tuning.yml&pageTitle=一键训练大模型及部署GPU共享推理服务&disableRollback=true&hideStepRow=true&hideStackConfig=true&isSimplified=true&disabltion=true&productNavBar=disabled&balanceIntercept=true&disableNavigation=true)前往 ROS 控制台，系统自动打开使用新资源创建资源栈的面板。在页面最上方选择部署地域，例如华东 1（杭州），然后设置配置项，单击**创建**。
   
   **说明** 
   
   因资源量有限，可能会出现所选地域下无可选可用区的情况，您可以切换部署地域如华北 2（北京）、西南 1（成都）继续尝试。
   
   | **配置项** | **说明** | **示例** |
   | --- | --- | --- |
   | **资源栈名称** | 支持自定义。 | stack\_2023-06-12\_cBesTX8FB |
   | **集群名称** | 支持自定义。不能与现有 ACK集群重名。 | ai-test |
   | **可用区** | 选择集群可用区。本方案使用一台指定规格的 ECS 实例作为节点，备选实例规格包括ecs.gn6i-c24g1.12xlarge 、  ecs.gn6v-c8g1.4xlarge 或  ecs.gn6i-c24g1.24xlarge 。如果当前可用区为空，请切换地域重新选择。 | 可用区 K |
   | **设置节点登录密码** | 设置节点登录密码。 | 自行设置 |
   | **NAS 可用区** | 选择 NAS 可用区。 | 可选任意可用区 |
2. 在页面右上角，打开**自动刷新**开关，每隔 5 秒自动刷新一次，观察资源创建情况。
   
   在**资源栈信息**页签，显示**状态**为**创建成功**，表示快速创建成功。
   
   若在**资源栈信息**页签，显示**状态**不为**创建成功**，表示快速创建不成功。可以根据界面提示单击**创建一键诊断**，查看详细信息。
   
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1318802961/p706344.png)
### 安装云原生AI套件


1. 登录，在左侧导航栏选择**集群**。
2. 在**集群列表**页面，单击目标集群ai-test，然后在左侧导航栏，选择**应用****>****云原生 AI 套件****。**
   
   **说明** 
   
   如果首次使用云原生AI套件，需要先单击**开通服务**。
3. 在**云原生 AI 套件**页面，单击**一键部署**。
4. 在部署页面，参考下图所示完成设置。然后单击**部署云原生 AI 套件**。
   
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3441429271/p857186.png)
### 配置NAS共享存储并下载数据


1. 查找 NAS 实例的挂载点
   ----------------
   1. 登录[文件存储 NAS 控制台](https://nasnext.console.aliyun.com/overview)，在左侧导航栏选择**文件系统 >** **文件系统列表**，在页面顶部选择创建的 NAS 实例所在区域。
   2. 在**文件系统列表**页面，找到系统自动 ROS 自动创建的NAS实例，即在**文件系统 ID** 列包含 ack-ai-nas 的 NAS 文件系统。
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4691512961/p706435.png)
   3. 单击目标文件系统 ID 进入文件详情页面，单击**挂载使用**，在**挂载点地址**和**挂载命令**列，复制并记录此处的值供后续步骤使用。
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8020992071/p746665.png)

2. 配置目标 ai-test 集群的存储卷 PV 和存储声明 PVC
    -----------------------------------

   1. 登录，在左侧导航栏选择**集群**。
   2. 在**集群列表**页面，单击目标集群 ai-test ，然后在左侧导航栏，选择**存储 > 存储卷**。
   3. 在**存储卷**页面右上方，单击**创建**。
   4. 在**创建存储卷**对话框中，参考如下图示进行参数配置，选择**挂载点域名**为您上一步查询的挂载点地址，然后单击**创建**，创建名为 **training-data** 的存储卷。
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3441429271/p857194.png)
   5. 在左侧导航栏，选择**存储 > 存储声明**，在**存储声明**页面，单击**创建**，在**创建存储声明**对话框中，参考如下图示进行参数配置，然后单击**创建**，创建名为 **training-data** 的存储声明。
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/3441429271/p857350.png)

**3. 下载数据到 NAS 中**

    ------------------

  1. 登录 [ECS 管理控制台](https://ecs.console.aliyun.com/)。
  2. 在顶部菜单栏，选择**华东 1（杭州**）地域。
  3. 在左侧导航栏，选择**实例与镜像>实例**。
  4. 登录 ECS 控制台。
     1. 在**实例**页面，找到创建的一台 ECS 实例，在其右侧**操作**列，单击**远程连接**。
     2. 在**远程连接**对话框的**通过 Workbench 远程连接**区域，单击**立即登录**，然后根据页面提示登录。
  5. 使用前面记录复制的 NAS 文件的挂载命令，挂载 NAS 。
       ```
       sudo mount -t nfs -o vers=3,nolock,proto=tcp,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 0bbfb4915a-sdm14.cn-hangzhou.nas.aliyuncs.com:/ /mnt
       ```

  6. 执行以下命令，下载 bloom 模型和训练数据。
       ```
       cd /mnt/
       wget http://ai-training-data.oss-cn-hangzhou.aliyuncs.com/bloom-560m-sft-data.tar
       ```
   
       出现如下提示，表明数据下载完成。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/9590915961/p706465.png)
   
       然后执行以下命令，解压下载文件。
       
       ```
       tar -xvf bloom-560m-sft-data.tar
       ```

**4. 在 GPU 节点上配置集群证书**

    ----------------------

    1. 登录，在左侧导航栏选择**集群**。
    2. 在**集群列表**页面，单击目标集群 ai-test 进入集群信息页面，单击**连接信息**，在**内网访问**页签下，复制内网访问凭证。
    3. 执行以下命令，将集群的内网访问的证书内容复制到节点的 config 文件中。
   
      ```
      mkdir -p ~/.kube
      vi ~/.kube/config
      ```

**5. 在 GPU 节点上安装 arena 客户端**

    ----------------------------

    执行下列命令，在 GPU 节点上安装 arena 客户端。
    
    ```
    # 下载arena客户端并安装
    cd /root && wget https://aliacs-k8s-cn-hongkong.oss-cn-hongkong.aliyuncs.com/arena/arena-installer-0.9.9-ce4a78d-linux-amd64.tar.gz
    tar -xzvf arena-installer-0.9.9-ce4a78d-linux-amd64.tar.gz
    cd arena-installer
    bash install.sh  --only-binary
    ```

    出现如下提示，表明 arena 客户端安装成功。
    
    ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4691512961/p706469.png)

### 方案验证


**一、提交并监控训练任务，验证模型训练成功**

1. 执行以下命令，提交一个 Bloom 模型的微调训练任务。训练任务大概需要运行 8 分钟。
   
   ```
   arena submit pytorchjob \
     --name=bloom-sft \
     --gpus=2 \
     --image=registry.cn-hangzhou.aliyuncs.com/acs/deepspeed:v0.9.0-chat \
     --data=training-data:/model \
     --tensorboard \
     --logdir=/model/logs \
     "cd /model/DeepSpeedExamples/applications/DeepSpeed-Chat/training/step1_supervised_finetuning && bash training_scripts/other_language/run_chinese.sh /model/bloom-560m-sft"
   ```
   
   训练任务提交成功后，任务状态将显示 RUNNING 。
2. 执行以下命令，查看当前通过 Arena 提交的所有作业。
   
   ```
   arena list
   ```
   
   预期输出：
   
   ```
   NAME       STATUS   TRAINER     DURATION  GPU(Requested)  GPU(Allocated)  NODE
   bloom-sft  RUNNING  PYTORCHJOB  17m       2               2               192.168.XX.XX
   ```
3. 执行以下命令，获取作业详情。
   
   ```
   arena get bloom-sft
   ```
   
   预期输出：
   
   ```
   Name:        bloom-sft
   Status:      RUNNING
   Namespace:   default
   Priority:    N/A
   Trainer:     PYTORCHJOB
   Duration:    1m
   CreateTime:  2023-07-20 15:06:19
   EndTime:
   
   Instances:
     NAME                STATUS   AGE  IS_CHIEF  GPU(Requested)  NODE
     ----                ------   ---  --------  --------------  ----
     bloom-sft-master-0  Running  1m   true      2             cn-hangzhou.192.168.XX.XX
   
   Tensorboard:
     Your tensorboard will be available on:
     http://192.168.XX.XX:32560
   ```
   
   记录此处 GPU 节点名称 cn-hangzhou.192.168.XX.XX ，用于后续部署推理服务。同时，记录此处 Tensorboard 的 Web 服务地址 http://192.168.XX.XX:32560 ，此处端口号为32560 ，以您的输出显示为准。
4. 将上一步记录的端口号加入 GPU 实例的入方向安全组，例如 32560 。
![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7948189271/p862425.png)
5. 通过浏览器访问 Tensorboard 。在浏览器中输入 http://121.41.XX.XX:32560 ，此处将 IP地址替换为 GPU 节点公网 IP 。
![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7948189271/p862423.png)
6. 等待任务训练完成，大概需要 10 分钟，再次执行命令 arena get bloom-sft ，确认 status为 SUCCEEDED ，表明模型训练任务已经成功完成。
![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7948189271/p862424.png)
7. 执行以下命令，查看微调后的模型目录，确保模型文件正确生成。
   
   ```
   # 进入微调后的模型目录, training.log 为训练日志
   cd /mnt/bloom-560m-sft/
   # 目录内容如下
   .
   ├── config.json
   ├── merges.txt
   ├── pytorch_model.bin
   ├── training.log
   ├── tokenizer_config.json
   ├── tokenizer.json
   └── vocab.json
   ```

**二、配置和部署推理服务，验证 GPU 共享推理**

使用中文数据集对 bloom-560m 模型进行了监督微调，接下来可以通过 GPU 显存共享的能力，将多个推理服务部署在同一块 GPU 卡上以提高 GPU 的利用率。下文介绍如何使用 Arena ，将步骤一微调后的模型部署成推理服务。

1. 执行以下命令，开启 GPU 共享调度能力和显存隔离能力，替换下列节点为您的 GPU 节点名称。
   
   ```
   kubectl label node cn-hangzhou.192.168.XX.XX ack.node.gpu.schedule=cgpu
   ```
   
   如需关闭 GPU 共享调度能力，您可以将标签设置为 **ack.node.gpu.schedule=default** 。
2. 执行以下命令，查看集群 GPU 资源。
   
   ```
   arena top node
   ```
   
   预期输出：
   
   ```
   NAME                       IPADDRESS      ROLE    STATUS  GPUs(Allocated/Total)  GPU_MEMORY(Allocated/Total)  GPU_CORE(Allocated/Total)
   cn-hangzhou.192.168.xx.xx  121.41.XX.XX  <none>  Ready   0/2                    0.0/30.0 GiB                 __
   -----------------------------------------------------------------------------------------------------------
   Allocated/Total GPUs of nodes which own resource aliyun.com/gpu-mem In Cluster:
   0/2 (0.0%)
   ```
3. 执行以下命令，提交一个 bloom 的推理服务，部署 2 个副本，每个副本使用 6G 显存。
   
   ```
   arena serve custom \
     --name=bloom-infernece \
     --gpumemory=6 \
     --version=alpha \
     --replicas=2 \
     --restful-port=8080 \
     --data=training-data:/model \
     --image=registry.cn-hangzhou.aliyuncs.com/acs/djl-serving:v0.23.0 \
     "djl-serving -m /model/bloom-inference"
   ```
4. 查看提交的任务的详细信息。
   
   * 执行以下命令，查看 GPU 使用情况。
     
     ```
     arena top node
     ```
     
     预期输出：
     
     ```
     NAME                       IPADDRESS      ROLE    STATUS  GPUs(Allocated/Total)  GPU_MEMORY(Allocated/Total)  GPU_CORE(Allocated/Total)
     cn-hangzhou.192.168.xx.xx  101.x.x.x  <none>  Ready   0.8/2                  12.0/30.0 GiB                __
     -----------------------------------------------------------------------------------------------------------
     Allocated/Total GPUs of nodes which own resource aliyun.com/gpu-mem In Cluster:
     0.8/2 (40.0%)
     Allocated/Total GPU Memory of nodes which own resource aliyun.com/gpu-mem In Cluster:
     12.0/30.0 GiB(40.0%)
     ```
   * 执行以下命令，查看提交任务的详细信息。
     
     ```
     arena serve get bloom-infernece
     ```
     
     Pod 成功部署后，状态将变为 Running 。
     
     预期输出：
   * ```
     Name:       bloom-infernece
     Namespace:  default
     Type:       Custom
     Version:    alpha
     Desired:    2
     Available:  0
     Age:        3m
     Address:    172.16.xx.xx
     Port:       RESTFUL:8080
     
     Instances:
       NAME                                                   STATUS   AGE  READY  RESTARTS  GPU  NODE
       ----                                                   ------   ---  -----  --------  ---  ----
       bloom-infernece-alpha-custom-serving-866cfccd5b-h56pr  Running  27m  1/1    0         0.4  cn-hangzhou.192.168.xx.xx
       bloom-infernece-alpha-custom-serving-866cfccd5b-whndw  Running  27m  1/1    0         0.4  cn-hangzhou.192.168.xx.xx
     ```
     
     预期输出表明，两个推理服务的副本成功运行在同一张 GPU 卡上，同时记录此处的Address 172.16.xx.xx 。

**三、通过调用服务和结果验证，确认推理服务的有效性**

等待推理服务启动后，在 GPU 节点上执行以下命令，在本地调用推理服务。将下列 IP 替换为上一步记录的 Address 地址。

```
curl -X POST http://172.16.xx.xx:8080/predictions/bloom_inference -H "Content-type: text/plain" -d "四川美食"
```

预期输出类似以下内容：

```
[
  {
    "generated_text":"四川美食有哪些？这届成都主会场包括开幕式、开幕式后主会场和主会场美食表演。开幕式期间，美食一条街会集中展示美食小吃。开幕式结束，成都国际会展中心将举办“"
  }
]
```
### 完成及清理

5

#### 清理资源

在本方案中，您使用了 ROS 资源栈和 NAS 文件存储系统。测试完方案后，您可以参考以下规则处理对应产品的实例，避免继续产生费用：

释放资源栈下的资源，释放创建的 ACK 集群、NAS 件存储系统等。

1. 登录 [ROS 控制台](https://ros.console.aliyun.com/overview)，在左侧导航栏，选择**资源栈**。
2. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
   
   本方案会自动创建两个资源栈，一个由您部署时创建，另一个以`k8s-`开头，由ACK创建集群时创建。请删除非`k8s-`开头的资源栈，删除此资源栈时将自动删除`k8s-`开头的资源栈。
3. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
