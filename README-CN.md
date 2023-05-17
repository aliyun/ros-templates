[English](./README.md) | 简体中文

<h1 align="center">ROS Templates</h1>

> 如果您不了解资源编排服务 ROS，请阅读[什么是资源编排服务](https://www.alibabacloud.com/help/resource-orchestration-service/latest/what-is-ros)。如果您不熟悉 ROS 模板语法，请阅读[模板快速入门](https://www.alibabacloud.com/help/resource-orchestration-service/latest/get-started-with-templates)。

> 欢迎通过 ROS [控制台](https://ros.console.aliyun.com/cn-beijing/stacks/create)、[API](https://api.aliyun.com/product/ROS)、[SDK](https://api.aliyun.com/api-tools/sdk/ROS)、[CDK](https://www.alibabacloud.com/help/resource-orchestration-service/latest/ros-cdk-overview) 体验 ROS。

## 简介
ROS 模板的示例和最佳实践。模板分类如下：

- `resources`：资源级模板示例，提供单服务或单资源的模板。
- `examples`：综合模板示例，提供面向简单场景的模板。模板内容同 ROS 控制台[模板示例](https://ros.console.aliyun.com/cn-beijing/samples)。
- `solutions`：解决方案，提供面向复杂场景的模板最佳实践。模板同 ROS 控制台[解决方案中心](https://ros.console.aliyun.com/cn-beijing/solutions)。
- `transform`：基于 [Transform 语法](https://www.alibabacloud.com/help/resource-orchestration-service/latest/template-syntax-transform)的模板，提供面向特定场景的简化模板。
- `documents`：阿里云文档中涉及的模板。
- `compute-nest-best-practice`：[计算巢](https://www.alibabacloud.com/help/computing-nest)最佳实践模板，提供面向计算巢基础和进阶场景的模板。


## 详细说明
<details>
  <summary>resources</summary>

| 模板                                                                                         | 说明                                                                                                                                 |
| -------------------------------------------------------------------------------------------- |------------------------------------------------------------------------------------------------------------------------------------|
| [acm/configuration.yml](./resources/acm/configuration.yml)                                   | ACM Namespace/Configuration 资源示例                                                                                                   |
| [actiontrail/trail-logging.yml](./resources/actiontrail/trail-logging.yml)                   | ACTIONTRAIL Trail/TrailLogging 资源示例                                                                                                |
| [apigateway/api.yml](./resources/apigateway/api.yml)                                         | ApiGateway Api/Group/App/Deployment/Authorization/Signature/SignatureBinding/TrafficControl/TrafficControlBinding/ 资源示例            |
| [apigateway/custom-domain.yml](./resources/apigateway/custom-domain.yml)                     | ApiGateway CustomDomain 资源示例                                                                                                       |
| [apigateway/instance.yml](./resources/apigateway/instance.yml)                               | ApiGateway Instance 资源示例                                                                                                           |
| [apigateway/stage-config.yml](./resources/apigateway/stage-config.yml)                       | ApiGateway StageConfig 资源示例                                                                                                        |
| [apigateway/vpc-access-config.yml](./resources/apigateway/vpc-access-config.yml)             | ApiGateway VpcAccessConfig 资源示例                                                                                                    |
| [arms/alert-contact-group.yml](./resources/arms/alert-contact-group.yml)                     | ARMS AlertContact/AlertContactGroup 资源示例                                                                                           |
| [arms/retcode-app.yml](./resources/arms/retcode-app.yml)                                     | ARMS RetcodeApp 资源示例                                                                                                               |
| [asm/service-mesh.yml](./resources/asm/service-mesh.yml)                                     | ASM ServiceMesh 资源示例                                                                                                               |
| [bss/wait-order.yml](./resources/bss/wait-order.yml)                                         | BSS WaitOrder 资源示例                                                                                                                 |
| [cas/certificate.yml](./resources/cas/certificate.yml)                                       | CAS Certificate 资源示例                                                                                                               |
| [cdn/domain.yml](./resources/cdn/domain.yml)                                                 | CDN Domain/DomainConfig 资源示例                                                                                                       |
| [cen/cen.yml](./resources/cen/cen.yml)                                                       | CEN 资源示例                                                                                                                           |
| [cms/contact.yml](./resources/cms/contact.yml)                                               | CMS Contact/ContactGroup/DynamicTagGroup 资源示例                                                                                      |
| [cms/event-rule-targets.yml](./resources/cms/event-rule-targets.yml)                         | CMS EventRuleTargets 资源示例                                                                                                          |
| [cms/event-rule.yml](./resources/cms/event-rule.yml)                                         | CMS EventRule 资源示例                                                                                                                 |
| [cms/group-metric-rule.yml](./resources/cms/group-metric-rule.yml)                           | CMS GroupMetricRule/MetricRuleTargets 资源示例                                                                                         |
| [cms/metric-rule-template.yml](./resources/cms/metric-rule-template.yml)                     | CMS MetricRuleTemplate 资源示例                                                                                                        |
| [cms/monitor-group.yml](./resources/cms/monitor-group.yml)                                   | CMS MonitorGroup/MonitorGroupInstances 资源示例                                                                                        |
| [cms/monitoring-agent-process.yml](./resources/cms/monitoring-agent-process.yml)             | CMS MonitoringAgentProcess 资源示例                                                                                                    |
| [cms/site-monitor.yml](./resources/cms/site-monitor.yml)                                     | CMS SiteMonitor 资源示例                                                                                                               |
| [config/config.yml](./resources/config/config.yml)                                           | Config Rule 资源示例                                                                                                                   |
| [cr/instance-endpoint-acl-policy.yml](./resources/cr/instance-endpoint-acl-policy.yml)       | CR InstanceEndpointAclPolicy 资源示例                                                                                                  |
| [cr/namespace.yml](./resources/cr/namespace.yml)                                             | CR NameSpace 资源示例                                                                                                                  |
| [cr/repository.yml](./resources/cr/repository.yml)                                           | CR Repository 资源示例                                                                                                                 |
| [cs/any-cluster.yml](./resources/cs/any-cluster.yml)                                         | CS AnyCluster 资源示例                                                                                                                 |
| [cs/kubernetes-cluster.yml](./resources/cs/kubernetes-cluster.yml)                           | CS KubernetesCluster 资源示例                                                                                                          |
| [cs/managed-edge-kubernetes-cluster.yml](./resources/cs/managed-edge-kubernetes-cluster.yml) | CS ManagedEdgeKubernetesCluster 资源示例                                                                                               |
| [cs/managed-kubernetes-cluster.yml](./resources/cs/managed-kubernetes-cluster.yml)           | CS ManagedKubernetesCluster 资源示例                                                                                                   |
| [cs/serverless-kubernetes-cluster.yml](./resources/cs/serverless-kubernetes-cluster.yml)     | CS ServerlessKubernetesCluster 资源示例                                                                                                |
| [datahub/topic.yml](./resources/datahub/topic.yml)                                           | DataHub Project/Topic 资源示例                                                                                                         |
| [dns/domain-record.yml](./resources/dns/domain-record.yml)                                   | DNS DomainRecord 资源示例                                                                                                              |
| [dns/domain.yml](./resources/dns/domain.yml)                                                 | DNS Domain/DomainGroup 资源示例                                                                                                        |
| [drds/drds-instance.yml](./resources/drds/drds-instance.yml)                                 | DrdsInstance 资源示例                                                                                                                  |
| [dts/consumer-group.yml](./resources/dts/consumer-group.yml)                                 | DTS SubscriptionInstance 资源示例                                                                                                      |
| [dts/dts.yml](./resources/dts/dts.yml)                                                       | DTS MigrationJob/SynchronizationJob 资源示例                                                                                           |
| [dts/subscription-instance.yml](./resources/dts/subscription-instance.yml)                   | DTS SubscriptionInstance/ConsumerGroup 资源示例                                                                                        |
| [eci/container-group.yml](./resources/eci/container-group.yml)                               | ECI ContainerGroup 资源示例                                                                                                            |
| [eci/image-cache.yml](./resources/eci/image-cache.yml)                                       | ECI ImageCache 资源示例                                                                                                                |
| [ecs/assign-private-ip-addresses.yml](./resources/ecs/assign-private-ip-addresses.yml)       | ECS AssignPrivateIpAddresses 资源示例                                                                                                  |
| [ecs/auto-snapshot-policy.yml](./resources/ecs/auto-snapshot-policy.yml)                     | ECS AutoSnapshotPolicy 资源示例                                                                                                        |
| [ecs/custom-image.yml](./resources/ecs/custom-image.yml)                                     | ECS CustomImage/CopyImage 资源示例                                                                                                     |
| [ecs/dedicated-host.yml](./resources/ecs/dedicated-host.yml)                                 | ECS DedicatedHost 资源示例                                                                                                             |
| [ecs/deployment-set.yml](./resources/ecs/deployment-set.yml)                                 | ECS DeploymentSet 资源示例                                                                                                             |
| [ecs/disk-attachment.yml](./resources/ecs/disk-attachment.yml)                               | ECS DiskAttachment/Snapshot 资源示例                                                                                                   |
| [ecs/disk.yml](./resources/ecs/disk.yml)                                                     | ECS Disk 资源示例                                                                                                                      |
| [ecs/forward-entry.yml](./resources/ecs/forward-entry.yml)                                   | ECS ForwardEntry 资源示例                                                                                                              |
| [ecs/hpc-cluster.yml](./resources/ecs/hpc-cluster.yml)                                       | ECS HpcCluster 资源示例                                                                                                                |
| [ecs/instance-clone.yml](./resources/ecs/instance-clone.yml)                                 | ECS Instance Clone 资源示例                                                                                                            |
| [ecs/instance-group.yml](./resources/ecs/instance-group.yml)                                 | ECS InstanceGroup/InstanceGroupClone/Command/Invocation 资源示例                                                                       |
| [ecs/instance.yml](./resources/ecs/instance.yml)                                             | ECS instance/EIP/NatGateway/SSHKeyPair 资源示例                                                                                        |
| [ecs/join-security-group.yml](./resources/ecs/join-security-group.yml)                       | ECS JoinSecurityGroup 资源示例                                                                                                         |
| [ecs/launch-template.yml](./resources/ecs/launch-template.yml)                               | ECS LaunchTemplate/AutoProvisioningGroup 资源示例                                                                                      |
| [ecs/nat-gateway.yml](./resources/ecs/nat-gateway.yml)                                       | ECS NatGateway/BandwidthPackage 资源示例                                                                                               |
| [ecs/network-interface-attachment.yml](./resources/ecs/network-interface-attachment.yml)     | ECS NetworkInterface/NetworkInterfaceAttachment 资源示例                                                                               |
| [ecs/prepay-instance.yml](./resources/ecs/prepay-instance.yml)                               | ECS PrepayInstance 资源示例                                                                                                            |
| [ecs/route.yml](./resources/ecs/route.yml)                                                   | ECS Route/AssignIpv6Addresses 资源示例                                                                                                 |
| [ecs/run-command.yml](./resources/ecs/run-command.yml)                                       | ECS RunCommand 资源示例                                                                                                                |
| [ecs/s-nat-entry.yml](./resources/ecs/snat-entry.yml)                                       | ECS SecurityGroupIngress 资源示例                                                                                                      |
| [ecs/security-group-clone.yml](./resources/ecs/security-group-clone.yml)                     | ECS SecurityGroupClone 资源示例                                                                                                        |
| [ecs/security-group-egress.yml](./resources/ecs/security-group-egress.yml)                   | ECS SecurityGroupEgress 资源示例                                                                                                       |
| [ecs/security-group-ingress.yml](./resources/ecs/security-group-ingress.yml)                 | ECS SecurityGroupIngress 资源示例                                                                                                      |
| [edas/cluster-member.yml](./resources/edas/cluster-member.yml)                               | EDAS ClusterMember 资源示例                                                                                                            |
| [edas/cluster.yml](./resources/edas/cluster.yml)                                             | EDAS Cluster/App/DeployGroup 资源示例                                                                                                  |
| [ehpc/cluster.yml](./resources/ehpc/cluster.yml)                                             | EHPC Cluster 资源示例                                                                                                                  |
| [elasticsearch/instance.yml](./resources/elasticsearch/instance.yml)                         | ElasticSearch Instance 资源示例                                                                                                        |
| [emr/cluster.yml](./resources/emr/cluster.yml)                                               | EMR Cluster 资源示例                                                                                                                   |
| [ess/scaling-group-enable.yml](./resources/ess/scaling-group-enable.yml)                     | ESS ScalingConfiguration/ScalingGroupEnable 资源示例                                                                                   |
| [ess/scaling-group.yml](./resources/ess/scaling-group.yml)                                   | ESS ScalingGroup/ScalingRule/AlarmTask/AlarmTaskEnable/LifecycleHook/ScheduledTask 资源示例                                            |
| [fc/custom-domain.yml](./resources/fc/custom-domain.yml)                                     | FC CustomDomain 资源示例                                                                                                               |
| [fc/function-invoker.yml](./resources/fc/function-invoker.yml)                               | FC FunctionInvoker/Trigger/Version/Alias/ProvisionConfig 资源示例                                                                      |
| [fnf/flow.yml](./resources/fnf/flow.yml)                                                     | FNF Flow/Schedule 资源示例                                                                                                             |
| [ga/ga-ip-v6.yml](./resources/ga/ga-ipv6.yml)                                               | GA Accelerator/ BandwidthPackage/IpSets/Listener/EndpointGroup/BandwidthPackageAcceleratorAddition 资源示例                            |
| [gws/cluster.yml](./resources/gws/cluster.yml)                                               | GWS Cluster/Instance 资源示例                                                                                                          |
| [iot/device-group.yml](./resources/iot/device-group.yml)                                     | IOT DeviceGroup 资源示例                                                                                                               |
| [iot/device.yml](./resources/iot/device.yml)                                                 | IOT Product/Device 资源示例                                                                                                            |
| [iot/rule.yml](./resources/iot/rule.yml)                                                     | IOT Rule/RuleAction 资源示例                                                                                                           |
| [kafka/instance.yml](./resources/kafka/instance.yml)                                         | Kafka Instance/Topic 资源示例                                                                                                          |
| [kms/key.yml](./resources/kms/key.yml)                                                       | KMS Key/Alias 资源示例                                                                                                                 |
| [kms/secret.yml](./resources/kms/secret.yml)                                                 | KMS Secret 资源示例                                                                                                                    |
| [marketplace/order.yml](./resources/marketplace/order.yml)                                   | MarketPlace Order 资源示例                                                                                                             |
| [memcache/instance.yml](./resources/memcache/instance.yml)                                   | Memcache Instance/WhiteList 资源示例                                                                                                   |
| [mns/subscription.yml](./resources/mns/subscription.yml)                                     | MNS Queue/Topic/Subscription 资源示例                                                                                                  |
| [mongodb/mongo-db-instance.yml](./resources/mongodb/mongodb-instance.yml)                   | MONGODB Instance 资源示例                                                                                                              |
| [mongodb/serverless-instance.yml](./resources/mongodb/serverless-instance.yml)               | MONGODB ServerlessInstance 资源示例                                                                                                    |
| [mongodb/sharding-instance.yml](./resources/mongodb/sharding-instance.yml)                   | MONGODB ShardingInstance 资源示例                                                                                                      |
| [mse/cluster.yml](./resources/mse/cluster.yml)                                               | MSE Cluster 资源示例                                                                                                                   |
| [nas/nas.yml](./resources/nas/nas.yml)                                                       | NAS AccessGroupName/AccessRule/FileSystem/MountTarget 资源示例                                                                         |
| [oos/oos.yml](./resources/oos/oos.yml)                                                       | OOS Template/Execution 资源示例                                                                                                        |
| [oos/parameter.yml](./resources/oos/parameter.yml)                                           | OOS Parameter 资源示例                                                                                                                 |
| [oss/bucket.yml](./resources/oss/bucket.yml)                                                 | OSS Bucket 资源示例                                                                                                                    |
| [ots/ots.yml](./resources/ots/ots.yml)                                                       | OTS Table/Instance/VpcBinder 资源示例                                                                                                  |
| [polardb/polardb.yml](./resources/polardb/polardb.yml)                                       | POLARDB DBCluster/Account/DBInstance/DBNodes/AccountPrivilege/DBClusterAccessWhiteList/DBClusterEndpointAddress 资源示例               |
| [privatelink/vpc-endpoint.yml](./resources/privatelink/vpc-endpoint.yml)                     | PrivateLink VpcEndpointService/VpcEndpoint 资源示例                                                                                    |
| [pvtz/pvtz.yml](./resources/pvtz/pvtz.yml)                                                   | PVTZ Zone/ZoneRecord/ZoneVpcBinder 资源示例                                                                                            |
| [ram/access-key.yml](./resources/ram/access-key.yml)                                         | RAM User/AccessKey 资源示例                                                                                                            |
| [ram/attach-policy-to-role.yml](./resources/ram/attach-policy-to-role.yml)                   | RAM Role/AttachPolicyToRole 资源示例                                                                                                   |
| [ram/managed-policy.yml](./resources/ram/managed-policy.yml)                                 | RAM ManagedPolicy 资源示例                                                                                                             |
| [ram/role.yml](./resources/ram/role.yml)                                                     | RAM Role 资源示例                                                                                                                      |
| [ram/saml-provider.yml](./resources/ram/saml-provider.yml)                                   | RAM SAMLProvider 资源示例                                                                                                              |
| [ram/user.yml](./resources/ram/user.yml)                                                     | RAM User/Group/AttachPolicyToUser/UserToGroupAddition 资源示例                                                                         |
| [rds/db-instance.yml](./resources/rds/db-instance.yml)                                       | RDS DBInstance/Account/AccountPrivilege 资源示例                                                                                       |
| [rds/prepay-db-instance.yml](./resources/rds/prepay-db-instance.yml)                         | RDS PrepayDBInstance 资源示例                                                                                                          |
| [redis/instance.yml](./resources/redis/instance.yml)                                         | Redis Instance/Whitelist and Account 资源示例                                                                                          |
| [redis/prepay-instance.yml](./resources/redis/prepay-instance.yml)                           | Redis PrepayInstance 资源示例                                                                                                          |
| [resourcemaneger/handshake.yml](./resources/resourcemaneger/handshake.yml)                   | ResourceManager Handshake 资源示例                                                                                                     |
| [resourcemaneger/resource-group.yml](./resources/resourcemaneger/resource-group.yml)         | ResourceManager ResourceGroup 资源示例                                                                                                 |
| [rocketmq/rocketmq.yml](./resources/rocketmq/rocketmq.yml)                                   | ROCKETMQ Instance/Topic 资源示例                                                                                                       |
| [ros/auto-enable-service.yml](./resources/ros/auto-enable-service.yml)                       | ROS AutoEnableService 资源示例                                                                                                         |
| [ros/custom-resource.yml](./resources/ros/custom-resource.yml)                               | ROS Custom 资源示例                                                                                                                    |
| [ros/stack.yml](./resources/ros/stack.yml)                                                   | ROS Nested Stack 资源示例                                                                                                              |
| [ros/wait-condition-handle.yml](./resources/ros/wait-condition-handle.yml)                   | ROS WaitConditionHandle 资源示例                                                                                                       |
| [ros/wait-condition.yml](./resources/ros/wait-condition.yml)                                 | ROS WaitCondition/WaitConditionHandle 资源示例                                                                                         |
| [sae/sae.yml](./resources/sae/sae.yml)                                                       | SAE Application/Namespace/SlbBinding 资源示例                                                                                          |
| [sag/acl.yml](./resources/sag/acl.yml)                                                       | SAG ACL/ACLRule/ACLAssociation 资源示例                                                                                                |
| [slb/access-control.yml](./resources/slb/access-control.yml)                                 | SLB AccessControl 资源示例                                                                                                             |
| [slb/backend-server-attachment.yml](./resources/slb/backend-server-attachment.yml)           | SLB LoadBalancer/MasterSlaveServerGroup/BackendServerAttachment 资源示例                                                               |
| [slb/listener.yml](./resources/slb/listener.yml)                                             | SLB LoadBalancer/Listener/LoadBalancerClone/Certificate/DomainExtension/VServerGroup/Rule 资源示例                                     |
| [sls/sls.yml](./resources/sls/sls.yml)                                                       | SLS Project/Logstore/Alert/Index/SavedSearch/LogtailConfig/MachineGroup/ApplyConfigToMachineGroup/ApiGatewayLogConfig 资源示例         |
| [tsdb/hi-tsdb-instance.yml](./resources/tsdb/hi-tsdb-instance.yml)                           | TSDB HiTSDBInstance 资源示例                                                                                                           |
| [vpc/anycast-eip.yml](./resources/vpc/anycast-eip.yml)                                       | VPC AnycastEIP/AnycastEIPAssociation 资源示例                                                                                          |
| [vpc/eip-association.yml](./resources/vpc/eip-association.yml)                               | VPC EIP/EIPAssociation 资源示例                                                                                                        |
| [vpc/eip-segment.yml](./resources/vpc/eip-segment.yml)                                       | VPC EIPSegment 资源示例                                                                                                                |
| [vpc/eip.yml](./resources/vpc/eip.yml)                                                       | VPC EIP 资源示例                                                                                                                       |
| [vpc/nat-gateway.yml](./resources/vpc/nat-gateway.yml)                                       | VPC NatGateway 资源示例                                                                                                                |
| [vpc/network-acl.yml](./resources/vpc/network-acl.yml)                                       | VPC NetworkAcl/NetworkAclAssociation 资源示例                                                                                          |
| [vpc/route-table.yml](./resources/vpc/route-table.yml)                                       | Vpc RouteTable 资源示例                                                                                                                |
| [vpc/router-interface-update.yml](./resources/vpc/router-interface-update.yml)               | Vpc RouterInterface 资源示例                                                                                                           |
| [vpc/router-interface.yml](./resources/vpc/router-interface.yml)                             | Vpc RouterInterface 资源示例                                                                                                           |
| [vpc/snat-entry.yml](./resources/vpc/snat-entry.yml)                                         | VPC NatGateway/Ipv6Gateway/Ipv6InternetBandwidth/EIP/EIPAssociation/SnatEntry/CommonBandwidthPackage/CommonBandwidthPackageIp 资源示例 |
| [waf/domain-config.yml](./resources/waf/domain-config.yml)                                   | Waf DomainConfig/AclRule/WafSwitch 资源示例                                                                                            |
| [waf/domain.yml](./resources/waf/domain.yml)                                                 | Waf Domain 资源示例                                                                                                                    |
| [waf/instance.yml](./resources/waf/instance.yml)                                             | WAF Instance 资源示例                                                                                                                  |
</details>

<details>
  <summary>documents</summary>

- trail

| 模板                                                                                                                                 | 说明                                                                                       |
|------------------------------------------------------------------------------------------------------------------------------------| ------------------------------------------------------------------------------------------ |
| [alb-7-layer-load-balancing.yml](./documents/trail/alb-7-layer-load-balancing.yml)                                                 | 实现 IPv4 服务的七层负载均衡 \| [教程](https://help.aliyun.com/document_detail/612746.htm) |
| [clb-4-layer-load-balancing.yml](./documents/trail/clb-4-layer-load-balancing.yml)                                                 | 四层 CLB 负载均衡 \| [教程](https://help.aliyun.com/document_detail/612746.htm)            |
| [clb-7-layer-load-balancing.yml](./documents/trail/clb-7-layer-load-balancing.yml)                                                 | 七层 CLB 负载均衡 \| [教程](https://help.aliyun.com/document_detail/611014.htm)            |
| [nlb-4-layer-load-balancing.yml](./documents/trail/nlb-4-layer-load-balancing.yml)                                                 | 实现 IPv4 服务的四层负载均衡 \| [教程](https://help.aliyun.com/document_detail/611685.htm) |
| [ecs-blog.yml](./documents/trail/ecs-blog.yml)                                                                                     | 搭建云上博客                                                                               |
| [ecs-lamp.yml](./documents/trail/ecs-lamp.yml)                                                                                     | 部署 LAMP 环境                                                                             |
| [ecs-lnmp.yml](./documents/trail/ecs-lnmp.yml)                                                                                     | 部署 LNMP 环境 \| [教程](https://help.aliyun.com/document_detail/611922.htm)               |
| [ecs-mount-nas-file-system.yml](./documents/trail/ecs-mount-nas-file-system.yml)                                                   | NAS 挂载到 ECS                                                                             |
| [ecs-online-education-video-course-sharing-website.yml](./documents/trail/ecs-online-education-video-course-sharing-website.yml)   | 搭建在线教育视频课程分享网站                                                               |
| [ecs-website.yml](./documents/trail/ecs-website.yml)                                                                               | 快速搭建网站 \| [教程](https://help.aliyun.com/document_detail/611918.htm)                 |
| [ga-accelerated-access-to-specified-ip.yml](./documents/trail/ga-accelerated-access-to-specified-ip.yml)                           | 加速访问指定 IP 的后端服务                                                                 |
| [oos-timing-management-of-ecs.yml](./documents/trail/oos-timing-management-of-ecs.yml)                                             | OOS 实现 ECS 的定时管理                                                                    |
| [polardb-mysql-htap-real-time-data-analysis.yml](./documents/trail/polardb-mysql-htap-real-time-data-analysis.yml)                 | PolarDB MySQL HTAP 实时数据分析                                                            |
| [polardb-postgresql-enterprise-performance-practice.yml](./documents/trail/polardb-postgresql-enterprise-performance-practice.yml) | PolarDB PostgreSQL 企业级性能实践                                                          |
| [ram-create-user-and-authorize.yml](./documents/trail/ram-create-user-and-authorize.yml)                                           | 创建 RAM 用户并授权                                                                        |
| [rds-create-account-database-and-connection.yml](./documents/trail/rds-create-account-database-and-connection.yml)                 | 创建连接 RDS 数据库并进行读写操作                                                          |
| [redis-game-player-leaderboard.yml](./documents/trail/redis-game-player-leaderboard.yml)                                           | Redis 游戏玩家排行榜                                                                       |
| [tair-restores-data-through-data-flashback.yml](./documents/trail/tair-restores-data-through-data-flashback.yml)                   | Tair 通过数据闪回恢复数据                                                                  |
</details>