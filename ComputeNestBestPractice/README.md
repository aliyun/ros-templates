## 场景说明

### 基础版

* ecs-deploy ecs单机部署nginx
* ecs-rds 部署ecs和rds，同时传入rds的连接配置安装ecs中的应用
* ecs-polardb 部署ecs和polardb, 同时传入polardb的连接配置安装ecs中的应用
* ecs-sqlserver 部署ecs和sqlserver, 同时使用powershell初始化数据库
* ecs-redis 部署ecs和redis
* master-slave-ecs ecs部署master-slave架构
* ack-nginx ack容器部署场景
* ecs-postgresql 部署ecs和postgresql,同时传入postgresql的连接配置到安装ecs的应用中
* terraform-ecs-nginx terraform版ecs单机部署nginx
* vpc-natgateway-eip nat网关绑定eip部署场景
### 进阶版

* scaling-ecs ecs部署带有弹性伸缩
* ecs-mysql-deploy ecs单机部署MySQL
* ehpc-demo ehpc部署
* managed-reverse-vpc-connection 托管版vpc私网反向访问

## 模版规范和注意事项

### 通用

* 资源付费类型需要统一参数名用 PayType, PayPeriodUnit, PayPeriod，并且配置上AssociationProperty
* 如果是指定可用区的场景，可用区, VSwitch, VpcId放到最后让用户选择
* 模版中引用ALIYUN::StackName存放名字，对应计算巢服务实例名
* 建议配置参数分组，参考[使用Metadata为参数分组](https://help.aliyun.com/document_detail/211198.html).
* 对于需要客户下拉框选的参数使用AssociationProperty和AssociationPropertyMetadata,参考[AssociationProperty和AssociationPropertyMetadata](https://help.aliyun.com/document_detail/315578.html).

### ECS
* ECS::InstanceGroup里的ZoneId需要必添否则会导致有时开不出对应的资源
* ALIYUN::ECS::RunCommand代替用ALIYUN::ECS::Command和ALIYUN::ECS::Invocation
* 对于ecs的密码请配置 AssociationProperty: ALIYUN::ECS::Instance::Password，否则会导致校验不完全
* 安全组请新建，不要让用户配置，isv对自己的安全组配置是更了解的
* 如果产品面向中文用户，模板中的命令、脚本可以输出中文错误信息，对用户友好
* 如果模板存在执行脚本的部分，建议脚本步骤里打印日志并保存到本地，以便于在出现错误时进行debug。建议对脚本执行失败进行捕获并打印用户友好的错误信息，并通过[ROS的WaitConditionHandle通信机制](https://help.aliyun.com/document_detail/438170.html)返回错误信息给用户。

### VPC

* 同时创建VPC和VSwitch时，需要保证VSwitch的CIDR Block包含在VPC的CIDR Block下。为了防止用户输入错误的CIDR Block参数，需要在VpcCidrBlock和VSwitchCidrBlock入参下指定AssociationProperty和AssociationPropertyMetadata，具体配置方法请参照[场景模板ack-nginx](./ack-nginx/template.yaml)
* 数据库密码建议加上AssociationProperty: ALIYUN::RDS::Instance::AccountPassword

### RDS

* 对于RDS数据库实例资源（ALIYUN::RDS::DBInstance），必须指定DBInstanceStorageType和Category属性，否则会导致校验不完全，用户部署后可能出现资源无库存的错误。具体配置方法请参照[场景模板ecs-rds](./ecs-rds/template.yaml)

### CS

* 对于容器集群资源（ALIYUN::CS::ManagedKubernetesCluster），必须指定ZoneIds属性，否则会导致校验不完全，用户部署后可能出现资源无库存的错误。具体配置方法请参照[场景模板ack-nginx](./ack-nginx/template.yaml)

### 安全
* 计算巢安全审核最佳实践参考 [发布审核标准](https://help.aliyun.com/document_detail/406760.html)
