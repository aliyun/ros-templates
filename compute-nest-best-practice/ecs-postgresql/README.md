## 场景说明
本文介绍了在计算巢上ecs+postgresql的部署架构

部署预览
![deploy.jpg](deploy.jpg)

部署结果
![result.jpg](result.jpg)

## 架构图
![architecture.jpg](architecture.jpg)

## 部署

部署ecs和postgresql,同时传入postgresql的连接配置到安装ecs的应用中

## 运维
通过计算巢的代运维登录到机器上完成运维

## 附录
参考文档
* [云服务器ecs](https://ros.console.aliyun.com/resourceType/ALIYUN::ECS::InstanceGroup)
* [云数据库rds](https://ros.console.aliyun.com/resourceType/ALIYUN::RDS::DBInstance)
* [AnalyticDB MySQL版集群 DBCluster](https://www.alibabacloud.com/help/zh/resource-orchestration-service/latest/aliyun-adb-dbcluster)