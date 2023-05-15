## 场景说明
本文介绍了在计算巢上rds+ecs的部署架构

部署预览
![deploy.jpg](deploy.jpg)

部署结果
![result.jpg](result.jpg)

## 架构图
![architecture.jpg](architecture.jpg)

## 部署

创建ecs和rds实例并通过runcommand到ecs中安装命令，并把rds对应的数据库账号密码和地址传入到脚本中执行完成安装过程

## 运维
通过计算巢的代运维登录到机器上完成运维

## 附录
参考文档
* [云服务器ecs](https://ros.console.aliyun.com/resourceType/ALIYUN::ECS::InstanceGroup)
* [云数据库rds](https://ros.console.aliyun.com/resourceType/ALIYUN::RDS::DBInstance)
* [到云服务器执行命令](https://ros.console.aliyun.com/resourceType/ALIYUN::ECS::RunCommand)