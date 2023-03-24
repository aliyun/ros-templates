# 计算巢模板编写和测试最佳实践

<!-- TOC -->

* [总体过程](#)
* [分析您的应用](#)
* [提高模板编写效率](#)
* [安全](#)
* [编写ROS模板](#ros)
  * [参数](#)
  * [资源](#)
  * [输出](#)
  * [Metadata](#metadata)
* [编写Terraform模板](#terraform)
* [测试部署模板](#)
  
  <!-- TOC -->

接入计算巢服务的过程中，模板的编写和测试占用了一半以上的时间。按照最佳实践编写和测试模板，能够大大减少工作量，避免常见错误，同时让最终用户使用起来更方便。

## 总体过程

分析您的应用 => 从计算巢模板库中复制模板进行修改 => 测试模板中的脚本 => 在ROS控制台测试部署资源栈

## 分析您的应用

在开始接入之前，您应该对应用进行分析，以设计最优的云上部署方案。

1. 确定您的服务类型，了解计算巢的[服务类型](https://help.aliyun.com/document_detail/426465.html)。
2. 梳理应用部署的网络架构。如新建VPC还是部署到已有VPC，子网的划分（VSwitch），安全组设置，是否要跨多可用区等等。
3. 梳理出应用部署包含的资源类型，并在阿里云找到合适的云产品。比如线下服务器对应到ECS云服务器，关系数据库对应到RDS云数据库，K8S集群对应到容器服务K8S集群等等。
4. 梳理部署过程包含的步骤以及依赖关系。
5. 梳理为您的用户提供的配置选项。确定哪些参数用户可以调整，哪些不允许调整。
6. 梳理为您的用户提供的输出。用户部署完服务后最终拿到的是模板的输出。

## 提高模板编写效率

1. 如果您是第一次使用ROS，请阅读ROS文档，尤其推荐阅读[模板快速入门](https://help.aliyun.com/document_detail/370710.html)和[模板结构说明](https://help.aliyun.com/document_detail/28858.html)。

2. 请阅读计算巢模板的[最佳实践文档](https://github.com/aliyun/ros-templates/blob/master/ComputeNestBestPractice/README.md)。

3. **强烈推荐**从[计算巢最佳实践模板库](https://github.com/aliyun/ros-templates/tree/master/ComputeNestBestPractice)里寻找和您的应用最接近的场景模板，并复制此场景模板的内容做为编写模板的起点。这将大大减少您的工作量，避免常见错误。在后续的编写过程中，可以在模板库中搜索您需要的参数或资源，从模板库复制代码片段。不要从一个空文档开始。

4. 推荐您使用ROS控制台的[在线编辑器](https://ros.console.aliyun.com/editor)或者[使用IntelliJ IDEA加上Alibaba Cloud Toolkit插件](https://help.aliyun.com/document_detail/171807.html)（您可以下载免费的IntelliJ IDEA社区版）来编写模板。这两者的提供了代码补全和语法高亮、语法校验。

5. 推荐使用yaml格式编写，yaml格式更简洁，尤其模板中包含脚本时，可读性好。

6. 在编写模板的同时打开最常见的参考文档，随时查阅：
   
   - [ROS资源类型列表](https://ros.console.aliyun.com/resourceType)，可以查询资源类型的属性和输出，和ROS功能及时同步。同时也有支持中文的文档：[资源类型索引](https://help.aliyun.com/document_detail/127039.html)。
   - [模板语法](https://help.aliyun.com/document_detail/28857.html)，尤其是其中[函数（Functions）](https://help.aliyun.com/document_detail/28865.html)部分。

## 安全

1. 计算巢安全审核最佳实践参考[发布审核标准](https://help.aliyun.com/document_detail/406760.html)。
2. 如果您的软件在系统盘或数据盘保存了重要的业务数据，建议使用[自动快照策略](https://help.aliyun.com/document_detail/127811.html)提供备份功能。

## 编写ROS模板

### 参数

- 尽量减少用户需要输入的参数个数，尽量按最佳实践为参数设置默认值。
- 参数应配置好中英文的Label和Description。在计算巢控制台，Label是参数的名称，Description是填写参数的说明。
- 存在校验规则的参数应配置AllowedValues/AllowedPattern/MinLength/MaxLength/MinValue/MaxValue属性，可以提高部署成功率。
- 密码类参数必须将NoEcho属性设置为true，为了安全性一般不应设置默认值。
- 资源付费类型需要统一参数名用 PayType, PayPeriodUnit, PayPeriod，并且配置上AssociationProperty。
- 对于需要客户选择的参数使用AssociationProperty和AssociationPropertyMetadata，除了增加易用性和保证值的正确性外，计算巢会利用此信息来判断参数值是否可用，比如无库存的实例规格无法选择。参考[AssociationProperty和AssociationPropertyMetadata](https://help.aliyun.com/document_detail/315578.html)。
- 参数的顺序影响用户体验，用户选定前面的参数后，后续参数只会展示可用值，比如选定可用区后，后续的实例规格列表只会展示该可用区有库存的规格。建议使用参数分组进行排序。

### 参数分组

1. 建议配置参数分组，参考[使用Metadata为参数分组](https://help.aliyun.com/document_detail/211198.html)。参数分组会提升用户的部署体验，让部署参数看起来更有条理。
2. ParameterGroup支持两种样式，指定GroupType为Table时使用表格样式，不指定时使用普通平铺表单样式，可以根据喜好选择。
3. 如果配置了套餐，套餐所在参数分组一般应该排在最前面，因为套餐中的参数值比如实例规格可以配置多个值。将套餐参数放在后面时，输入前面参数后无法准确判断套餐参数的可用值。如果将可用区等参数放在套餐参数后，选完套餐后可判断出哪些可用区有库存。


### 资源

- #### 公共
  
  - 可以在模版中引用ALIYUN::StackName作为名称，ALIYUN::StackName对应计算巢服务实例名。
  - 不要模板中嵌入您的密钥（如阿里云AK）或密码信息。
  - 如果资源间存在依赖关系但无法通过引用关系推导出来（如资源A的属性使用了资源B的返回值，则ROS可以推导出资源A依赖资源B），需要通过DependsOn属性显示指定依赖关系。

- #### 云服务器ECS
  
  - ECS::InstanceGroup里的ZoneId要求必填，否则可能导致创建失败。
  - 使用ALIYUN::ECS::RunCommand代替ALIYUN::ECS::Command和ALIYUN::ECS::Invocation，从而简化命令调用，且不额外创建命令。
  - 对于ECS实例的密码请配置 AssociationProperty: ALIYUN::ECS::Instance::Password，否则会导致校验不完全。
  - 请新建安全组，不应让用户配置，因为服务商对自身软件的安全要求更了解。

- #### 弹性伸缩ESS
  
  - 如果伸缩组资源（ALIYUN::ESS::ScalingGroup）中只定义了一个伸缩规则资源（ALIYUN::ESS::ScalingConfiguration），则伸缩组资源中要显式定义对伸缩规则资源依赖的资源的依赖关系。
    比如伸缩规则资源依赖了安全组资源，则需要在伸缩组资源中显式DependsOn安全组资源，这样在服务实例删除时，安全组才能够被正确删除。

- #### 专有网络VPC
  
  - 同时创建VPC和VSwitch时，需要保证VSwitch的CIDR Block包含在VPC的CIDR Block下。为了防止用户输入错误的CIDR Block参数，需要在VpcCidrBlock和VSwitchCidrBlock入参下指定AssociationProperty和AssociationPropertyMetadata，具体配置方法请参照[场景模板ack-nginx](./ack-nginx/template.yaml)。

- #### 云数据库RDS
  
  - 数据库密码建议加上AssociationProperty: ALIYUN::RDS::Instance::AccountPassword。
  - 对于RDS数据库实例资源（ALIYUN::RDS::DBInstance），必须指定DBInstanceStorageType和Category属性，否则会导致校验不完全，用户部署后可能出现资源无库存的错误。具体配置方法请参照[场景模板ecs-rds](./ecs-rds/template.yaml)。

- #### 容器服务CS
  
  - 对于容器集群资源（ALIYUN::CS::ManagedKubernetesCluster），必须指定ZoneIds属性，否则会导致校验不完全，用户部署后可能出现资源无库存的错误。具体配置方法请参照[场景模板ack-nginx](./ack-nginx/template.yaml)。

- #### 执行初始化脚本
  
  - 不建议使用UserData的方式执行初始化脚本，推荐使用RunCommand的方式（ROS资源类型为ALIYUN::ECS::RunCommand）执行初始化脚本，尤其是对于在脚本中引用了模板入参的情况。因为在资源编排资源栈里UserData脚本执行失败后，无法重新执行，只有重新创建ECS实例才能修复；而使用云助手Command的方式用户可以通过重新执行Command来修复，计算巢的继续部署功能支持修复Command执行失败。
  - 如果服务仅面向中文用户，模板中的命令、脚本可以输出中文错误信息，对用户友好。
  - 如果模板存在执行脚本的部分，建议脚本步骤里打印日志并保存到本地，以便于在出现错误时进行debug。建议对脚本执行失败进行捕获并打印用户友好的错误信息，并通过[ROS的WaitConditionHandle通信机制](https://help.aliyun.com/document_detail/438170.html)返回错误信息给用户。
  - 启用bash的-e选项，在脚本出错时退出。
  - 以云助手命令形式执行的脚本中可以echo信息到stdout、stderr，打印到stdout、stderr的信息可以通过云助手控制台或OpenAPI查询到。
  - 如果脚本对资源、网络或者进程的状态有隐式的依赖，比如等待应用服务可用后才可以进行登录配置，请在脚本中进行循环检测，等待条件满足后再进行下一步；等待超时时报错。
  - Here document中的变量如$x，如果希望原样写入字符串不进行变量替换，第一行可以使用cat << "EOF"的写法，在分隔符上加双引号。

- #### 从应用中访问云服务
  
    如果应用需要访问云服务，比如应用需要将文件保存到对象存储OSS上。在应用配置文件里写上AK信息是不安全的。可以通过在ROS模板里创建一个RAM角色，并将这个角色Attach到应用所在的ECS实例上。这样应用就可以在实例内部获取到临时AK来访问云服务。请参照[实例RAM角色](https://help.aliyun.com/document_detail/54235.html)。

### 输出

Outputs中的变量名要规范、易读。请配置输出变量的中英文描述。输出会展示在服务实例的详情页上，增加描述会提升用户的体验。


## 编写Terraform模板

1. 请阅读[Terraform代码开发方式和建议](https://help.aliyun.com/document_detail/322216.html)。

2. 请参考[Terraform最佳实践](https://www.terraform-best-practices.com/)。

3. 为了给用户提供更好的体验，Terraform模板需要利用ROS原生功能来扩展参数定义和参数分组。请参照[Terraform示例模板](https://github.com/aliyun/ros-templates/blob/master/ComputeNestBestPractice/terraform-ecs-nginx/template.yaml)。步骤如下：
   
   - 打开ROS控制台[模板编辑器](https://ros.console.aliyun.com/editor)，切换到Terraform模式，使用“打开文件”功能将本地Terraform模板导入。
   
   - 在编辑器里切换到ROS模式，配置Parameters和Metadata。
   
   - 请参考[Terraform类型模板结构](https://help.aliyun.com/document_detail/184397.html)。

## 测试部署模板

1. 使用ROS控制台测试部署模板。推荐先在ROS控制台测试部署模板，测试通过后再录入计算巢服务中进行集成测试。因为在计算巢配置服务还需要配置其他内容，并且计算巢服务实例的部署在ROS资源栈之外增加了很多其他步骤，仅就测试模板来说，在ROS控制台测试效率更高。

2. 使用非回滚模式部署资源栈。创建测试资源栈时，应禁用”失败时回滚“。保留部署失败的现场，便于排查问题。

3. 单独测试命令行脚本。如果模板中包含命令行脚本，建议将脚本摘出在相同的运行环境（同样的操作系统版本、同样的shell版本）中单独测试，这样可以排除掉模板中变量替换、转义引发的问题。脚本测试通过后再放入模板中集成测试。

4. 确认执行的脚本的内容。如果使用了ALIYUN::ECS::RunCommand且命令执行失败，可以先查看ROS部署日志查看在哪台ECS实例上执行，再登录ECS控制台查看[命令执行记录](https://ecs.console.aliyun.com/#/cloudAssistant/region/cn-hangzhou/) ，确认实际下发的脚本内容。

5. 调试阶段可以启用bash的-x选项，启用调试输出。

6. 确认ECS userdata命令执行结果
   
   - 在/var/log/cloud-init.log可以看到cloudinit执行日志。
   - 在/var/log/cloud-init-output.log查看userdata脚本执行的输出。
   - /var/lib/cloud/instance/scripts/part-001为具体的脚本，可以执行来排查问题。
