## 场景说明
### 基础版
* ecs-deploy 单机部署
* ecs-rds 部署ecs和rds，同时传入rds的连接配置安装ecs中的应用
* ecs-polardb 部署ecs和polardb, 同时传入polardb的连接配置安装ecs中的应用
* ecs-sqlserver 部署ecs和sqlserver, 从oss中导入sql, 同时传入sqlserver的连接配置到安装ecs的应用中
* master-slave-ecs ecs部署master-slave架构
* ack-nginx ack容器部署场景

### 进阶版
* scaling-ecs ecs部署带有弹性伸缩
* ecs-mysql-deploy ecs单机部署MySQL

## 模版规范和注意事项
* 资源付费类型需要统一参数名用 PayType, PayPeriodUnit, PayPeriod
* ALIYUN::ECS::RunCommand代替用ALIYUN::ECS::Command和ALIYUN::ECS::Invocation 
* 对于ecs的密码请配置 AssociationProperty: ALIYUN::ECS::Instance::Password，否则会导致校验不完全
* 如果是指定可用区的场景，可用区, VSwitch, VpcId放到最后让用户选择
* 安全组请新建，不要让用户配置，isv对自己的安全组配置是更了解的
