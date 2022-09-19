## 场景说明
本文介绍了在计算巢上sqlserver+ecs的部署架构

## 架构图
暂无

## 部署

创建ecs和sqlserver实例并通过runcommand到ecs中安装命令，并把rds对应的数据库账号密码和地址传入到脚本中执行完成安装过程，同时使用ALIYUN::RDS::MigrateTask完成sqlserver数据库的初始化
## 运维
通过计算巢的代运维登录到机器上完成运维

## 附录
参考文档
* 云服务器ecs: https://ros.console.aliyun.com/resourceType/ALIYUN::ECS::InstanceGroup
* 云数据库rds: https://ros.console.aliyun.com/resourceType/ALIYUN::RDS::DBInstance
* 到云服务器执行命令: https://ros.console.aliyun.com/resourceType/ALIYUN::ECS::RunCommand
* sqlserver从oss导入sql: https://ros.console.aliyun.com/resourceType/ALIYUN::RDS::MigrateTask