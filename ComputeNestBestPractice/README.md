## 场景说明

### 基础版

* ecs-deploy ecs单机部署nginx
* ecs-rds 部署ecs和rds，同时传入rds的连接配置安装ecs中的应用
* ecs-polardb 部署ecs和polardb, 同时传入polardb的连接配置安装ecs中的应用
* ecs-sqlserver 部署ecs和sqlserver, 同时使用powershell初始化数据库
* ecs-redis 部署ecs和redis
* master-slave-ecs ecs部署master-slave架构
* ack-nginx ack容器部署场景
* ack-app-rds 已有ack中部署应用，应用使用RDS数据库
* ecs-postgresql 部署ecs和postgresql,同时传入postgresql的连接配置到安装ecs的应用中
* terraform-ecs-nginx terraform版ecs单机部署nginx
* vpc-natgateway-eip nat网关绑定eip部署场景
* ecs-slb ecs+slb+eip的部署架构
* ecs-ramrole-oss ecs+ramrole免密访问oss场景
* ecs-jenkins 部署ecs创建jenkins
* existing-ecs-nginx 现存ecs部署nginx
* ecs-adbpg 创建ecs和云原生数据仓库 AnalyticDB PostgreSQL版
### 进阶版

* scaling-ecs ecs部署带有弹性伸缩
* ecs-mysql-deploy ecs单机部署MySQL
* ehpc-demo 部署ecs和ehpc,使用cluster弹性高性能计算集群，nas新建文件系统和挂载点
* managed-reverse-vpc-connection 托管版vpc私网反向访问
* ecs-mongoDB 部署ecs和mongoDB，并使用mongodb shell连接到mongoDB数据库

## [模版规范和注意事项](./TemplateBestPractice.md)
