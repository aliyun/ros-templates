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

| 模板                                                                                         | 说明                                                                                                                                   |
| -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
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
| [ecs/snat-entry.yml](./resources/ecs/snat-entry.yml)                                         | ECS SecurityGroupIngress 资源示例                                                                                                      |
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
| [ga/ga-ipv6.yml](./resources/ga/ga-ipv6.yml)                                                 | GA Accelerator/ BandwidthPackage/IpSets/Listener/EndpointGroup/BandwidthPackageAcceleratorAddition 资源示例                            |
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
| [mongodb/mongodb-instance.yml](./resources/mongodb/mongodb-instance.yml)                     | MONGODB Instance 资源示例                                                                                                              |
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
<summary>examples</summary>

| 模板 | 说明 |
| ---- | ---- |
| [examples/application/ecs-clone-join-sls.yml](./examples/application/ecs-clone-join-sls.yml) | 克隆ECS实例，将IP指向日志服务中新建的机器组，应用指定的规则 |
| [examples/application/ecs-group-join-sls.yml](./examples/application/ecs-group-join-sls.yml) | 创建一组ECS实例，将其作为日志服务中相关项目logtail的机器组 |
| [examples/application/ecs-instance-group-join-sls.yml](./examples/application/ecs-instance-group-join-sls.yml) | 创建一组ECS并将其作为指定的SLS中相关project的logtail的机器组 |
| [examples/csapps/existing-vpc-docker-cluster-etcd.yml](./examples/csapps/existing-vpc-docker-cluster-etcd.yml) | 在Centos7下安装部署集群版Etcd服务（静态发现从节点模式），Etcd是一个用于服务注册与发现的键值存储组件, 其内部采用raft协议作为一致性算法保证数据统一性，集群安装完成后请使用etcdctl命令在云服务器中操作管理集群 |
| [examples/csapps/existing-vpc-docker-cluster-harbor.yml](./examples/csapps/existing-vpc-docker-cluster-harbor.yml) | 使用Docker容器安装部署Harbor(1.9.3)集群服务，Harbor是一个企业级私有的容器镜像管理服务，Harbor提供了用户管理，访问控制，活动审计等的特性, 本次部署以NFS作为共享存储（/data目录）存放Harbor相关镜像数据，并分离PostgreSQL与Redis为多个Harbor共同连接使用，使用SLB令集群达到负载均衡高可用的模式，对SLB绑定公网IP对外提供服务 |
| [examples/csapps/existing-vpc-docker-cluster-rancher.yml](./examples/csapps/existing-vpc-docker-cluster-rancher.yml) | 使用三台阿里云服务器ECS实现Rancher高可用集群安装，在Kubernetes集群中安装Rancher并使用DNS域名解析绑定SLB四层负载均衡对外提供服务，外部访问时请在安全组中添加80,443入方向的访问规则，Rancher是一个开源的企业级多集群Kubernetes管理平台，实现了Kubernetes集群在混合云+本地数据中心的集中部署与管理，以确保集群的安全性，加速企业数字化转型 |
| [examples/csapps/existing-vpc-docker-single-etcd.yml](./examples/csapps/existing-vpc-docker-single-etcd.yml) | 单节点在centos7下安装部署Etcd服务，Etcd是一个用于服务注册与发现的键值存储组件, 其内部采用raft协议作为一致性算法保证数据统一性，服务安装完成后请使用etcdctl命令在云服务器中操作管理服务 |
| [examples/csapps/existing-vpc-docker-single-harbor.yml](./examples/csapps/existing-vpc-docker-single-harbor.yml) | 单节点使用Docker容器安装部署Harbor(2.1.0)服务，Harbor是一个企业级私有的容器镜像管理服务，Harbor提供了用户管理，访问控制，活动审计等的特性, 如需外网访问Harbor Web界面请在安全组添加入方向80访问规则 |
| [examples/csapps/existing-vpc-docker-single-rancher.yml](./examples/csapps/existing-vpc-docker-single-rancher.yml) | 单节点使用Docker容器安装部署Rancher服务，Rancher是一个开源的企业级多集群Kubernetes管理平台，实现了Kubernetes集群在混合云+本地数据中心的集中部署与管理，以确保集群的安全性，加速企业数字化转型, 如需外网访问Rancher Web界面请在安全组添加入方向80访问规则 |
| [examples/csapps/j-storm.yml](./examples/csapps/j-storm.yml) | 创建一个容器服务集群并部署JStorm及其依赖Zookeeper |
| [examples/csapps/jenkins.yml](./examples/csapps/jenkins.yml) | 创建容器服务集群部署不同语言的Jenkins主从 |
| [examples/db/memcache-instance.yml](./examples/db/memcache-instance.yml) | 阿里云资源编排示例模板： 创建一个 VPC类型 memcache 实例 |
| [examples/db/mongodb-instance.yml](./examples/db/mongodb-instance.yml) | 创建一个经典网络MongDB实例 |
| [examples/db/rds-instance.yml](./examples/db/rds-instance.yml) | 创建一个RDS实例 |
| [examples/db/redis-instance.yml](./examples/db/redis-instance.yml) | 阿里云资源编排示例模板：创建一台VPC网络类型的Redis实例 |
| [examples/elastic/aliyun-kafka-instance.yml](./examples/elastic/aliyun-kafka-instance.yml) | 使用此模板创建一台阿里云消息队列Kafka实例 |
| [examples/elastic/anycasteip-attach-slb-bind-ecs.yml](./examples/elastic/anycasteip-attach-slb-bind-ecs.yml) | 创建Anycast EIP，绑定新建的SLB，并将新建的ECS挂载到SLB上 |
| [examples/elastic/batch-of-ecs-instances.yml](./examples/elastic/batch-of-ecs-instances.yml) | 此模板支持批量创建按量付费或包年包月的ECS实例，并且支持选择已有VPC，VSW，SG或新建VPC，VSW，SG的场景 |
| [examples/elastic/data-disk-snapshot.yml](./examples/elastic/data-disk-snapshot.yml) | 基于快照创建新数据盘并自动挂载创建的数据盘到ECS实例 |
| [examples/elastic/ecs-a-record.yml](./examples/elastic/ecs-a-record.yml) | 阿里云资源编排示例模板： 创建一台ECS并将公网Ip绑定域名（记录） |
| [examples/elastic/ecs-group-attach-multiple-slb.yml](./examples/elastic/ecs-group-attach-multiple-slb.yml) | 创建ECS实例组绑定SLB |
| [examples/elastic/ecs-group-vpc.yml](./examples/elastic/ecs-group-vpc.yml) | 创建一个VPC、VSwitch、安全组和ECS实例 |
| [examples/elastic/ecs-image-disk-snapshot.yml](./examples/elastic/ecs-image-disk-snapshot.yml) | 指定镜像ID和快照创建ECS实例 |
| [examples/elastic/ecs-instance-group-clone.yml](./examples/elastic/ecs-instance-group-clone.yml) | 根据已有的ECS实例，克隆出一组相同配置（InstanceType、ImageId、InternetChargeType、InternetMaxBandwidthIn、InternetMaxBandwidthOut、系统盘、数据盘配置、VPC属性）的ECS实例。 用户只需指定 SourceInstanceId |
| [examples/elastic/ecs-instance-group-vpc-bind-eip-by-count.yml](./examples/elastic/ecs-instance-group-vpc-bind-eip-by-count.yml) | 使用Count创建VPC类型ECS，并依次绑定EIP(新建VPC) |
| [examples/elastic/ecs-instance-group-vpc.yml](./examples/elastic/ecs-instance-group-vpc.yml) | 在新创建的VPC、VSwitch和安全组下，创建一组相同配置的ECS实例 |
| [examples/elastic/ecs-ipv6-instance.yml](./examples/elastic/ecs-ipv6-instance.yml) | 创建一台具备IPV4/IPV6双栈的云服务器，并为云主机自动分配IPv6公网地址 |
| [examples/elastic/ecs-json-data-transmission.yml](./examples/elastic/ecs-json-data-transmission.yml) | 创建ECS并配置SSH key |
| [examples/elastic/ecs-kubernetes-cluster.yml](./examples/elastic/ecs-kubernetes-cluster.yml) | 阿里巴巴 Cloud ROS 示例方案模板：使用ECS搭建Kubernetes集群，两个EIP分别作用于Master实例 ssh服务、6443端口服务和交换机下ECS的外网访问。此模板创建的k8s集群仅供参考，生产环境下推荐使用容器服务 |
| [examples/elastic/ecs-mount-multiple-uninitialized-data-disks.yml](./examples/elastic/ecs-mount-multiple-uninitialized-data-disks.yml) | 创建一个ECS，挂载多个数据盘 |
| [examples/elastic/ecs-multi-dynamic-ip.yml](./examples/elastic/ecs-multi-dynamic-ip.yml) | ALIYUN ROS示例模板：显示如何创建具有网络接口和多个IP地址的实例 |
| [examples/elastic/ecs-vpc-instance.yml](./examples/elastic/ecs-vpc-instance.yml) | 创建一个VPC网络的ECS实例 |
| [examples/elastic/ecs-with-2-data-disk.yml](./examples/elastic/ecs-with-2-data-disk.yml) | 创建一个ECS示例，挂载两块快照创建的数据盘 |
| [examples/elastic/ecs-with-java-web-enviroment.yml](./examples/elastic/ecs-with-java-web-enviroment.yml) | 创建一个ECS实例并安装JDK和Tomcat |
| [examples/elastic/ecs-with-nodejs-enviroment.yml](./examples/elastic/ecs-with-nodejs-enviroment.yml) | 创建一个ECS实例，安装Node.js环境并测试。 ***警告*** 此模板仅支持 CentOS |
| [examples/elastic/ecs-with-ruby-enviroment.yml](./examples/elastic/ecs-with-ruby-enviroment.yml) | 创建一个ECS实例，部署Ruby on Rails环境，并使用本地MySQL数据库进行存储。此示例从模板创建一个简单的 hello world 应用程序。 ***警告*** 此模板仅支持 CentOS-7。 当"rvm install 2.3.1"可能需要很长时间 |
| [examples/elastic/ecs-with-ssh-key.yml](./examples/elastic/ecs-with-ssh-key.yml) | 创建一个ECS实例，并配置SSH Key |
| [examples/elastic/entire-ecs-clone.yml](./examples/elastic/entire-ecs-clone.yml) | 克隆一台ECS实例 |
| [examples/elastic/ess-1-slb-2-rds-2-ecs.yml](./examples/elastic/ess-1-slb-2-rds-2-ecs.yml) | 创建1个SLB、1个ESS和1个RDS，通过ESS创建2个ECS实例。将ECS实例和ESS绑定到SLB上 |
| [examples/elastic/existing-vpc-anycasteip-attach-slb-bind-ecs.yml](./examples/elastic/existing-vpc-anycasteip-attach-slb-bind-ecs.yml) | 创建Anycast EIP，绑定新建的SLB，并将新建的ECS挂载到SLB上 |
| [examples/elastic/existing-vpc-ecs-bind-eip-by-count.yml](./examples/elastic/existing-vpc-ecs-bind-eip-by-count.yml) | 使用Count创建VPC类型ECS，并依次绑定EIP(已有VPC) |
| [examples/elastic/existing-vpc-kubernetes-cluster.yml](./examples/elastic/existing-vpc-kubernetes-cluster.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，使用容器服务Kubernetes版创建一个标准的 Kubernetes 专有版集群。您可以完整地创建集群管理节点和工作节点，对整个集群享有完全控制能力 |
| [examples/elastic/existing-vpc-one-ecs-bind-eip.yml](./examples/elastic/existing-vpc-one-ecs-bind-eip.yml) | 创建VPC类型ECS，并绑定EIP(已有VPC) |
| [examples/elastic/existing-vpc-single-flink.yml](./examples/elastic/existing-vpc-single-flink.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Flink)并绑定弹性IP；Java jdk版本是1.8.0，Flink版本是1.10.2，访问UI界面需要安全组配置8081端口入规则 |
| [examples/elastic/existing-vpc-single-hdfs.yml](./examples/elastic/existing-vpc-single-hdfs.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Hadoop HDFS)并绑定弹性IP；Java jdk版本是1.8.0，Hadoop版本是2.7.7， 如需外网访问HDFS web界面请在安全组添加入方向50070访问规则 |
| [examples/elastic/existing-vpc-single-hive.yml](./examples/elastic/existing-vpc-single-hive.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Hive)并绑定弹性IP；Java jdk版本是1.8.0，Hadoop版本是2.7.7，Hive版本是2.3.7，MySQL驱动版本5.1.48 |
| [examples/elastic/existing-vpc-single-jenkins.yml](./examples/elastic/existing-vpc-single-jenkins.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Jenkins)并绑定弹性IP；Java jdk版本是11.0.17，Jenkins版本是2.384-1.1；需要访问Jenkins Web界面，请在已存在的安全组入方向规则添加8080端口 |
| [examples/elastic/existing-vpc-single-kafka.yml](./examples/elastic/existing-vpc-single-kafka.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Kafka Middleware)并绑定弹性IP；Java jdk版本是1.8.0，Scala版本是2.12，Kafka版本是0.10.2.2，数据盘路径是/home/software/，用于存储Kafka数据；默认Kafka bin目录位于/home/software/kafka/bin |
| [examples/elastic/existing-vpc-single-map-reduce.yml](./examples/elastic/existing-vpc-single-map-reduce.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Hadoop MapReduce)并绑定弹性IP；Java jdk版本是1.8.0，Hadoop版本是2.7.7，如需外网访问MapReduce web界面请在安全组添加入方向8088访问规则 |
| [examples/elastic/existing-vpc-single-rabbitmq.yml](./examples/elastic/existing-vpc-single-rabbitmq.yml) | 在ECS主机上部署RabbitMQ（3.8.4）服务，RabbitMQ是一个开源AMQP实现的消息中间件服务，支持多种客户端连接，具备健壮、稳定、易用、跨平台、支持多种语言的特性 |
| [examples/elastic/existing-vpc-single-spark.yml](./examples/elastic/existing-vpc-single-spark.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Spark)并绑定弹性IP；Java jdk版本是1.8.0，Hadoop版本是2.7.7，Scala版本是2.12.1，Spark版本是2.1.0，如需外网访问管理web界面请在安全组添加入方向8088和8080访问规则 |
| [examples/elastic/existing-vpc-single-storm.yml](./examples/elastic/existing-vpc-single-storm.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Storm)并绑定弹性IP；Java jdk版本是1.8.0，Storm版本是2.2.0，Zookeeper版本3.6.2，访问UI界面需要安全组配置允许入方向8081端口 |
| [examples/elastic/existing-vpc-single-yarn.yml](./examples/elastic/existing-vpc-single-yarn.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Hadoop YARN)并绑定弹性IP；Java jdk版本是1.8.0，Hadoop版本是2.7.7，如需外网访问YARN web界面请在安全组添加入方向8088访问规则 |
| [examples/elastic/existing-vpc-single-zookeeper.yml](./examples/elastic/existing-vpc-single-zookeeper.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在ECS单节点主机上部署Zookeeper（3.6.2）服务，Zookeeper是一个分布式应用的协调服务，用于对分布式系统进行节点管理、leader选举、配置管理等，如需外网访问Zookeeper web界面请在安全组添加入方向9090访问规则 |
| [examples/elastic/hadoop-distributed-ecs-instance-group.yml](./examples/elastic/hadoop-distributed-ecs-instance-group.yml) | 部署Hadoop环境。 一台ECS实例扮演master角色，一组ECS实例扮演worker角色。 ***警告***仅在CentOS-7中进行测试。 也许需要停止防火墙。 部署时间主要取决于jdk和hadoop软件包的下载速度 |
| [examples/elastic/hadoop-distributed-env-3-ecs.yml](./examples/elastic/hadoop-distributed-env-3-ecs.yml) | 在3个ECS实例上部署Hadoop环境。 一个ECS实例扮演master节点的角色，另外两个实例扮演worker节点的角色。 ***警告***仅在CentOS-7中进行测试。 也许需要停止防火墙。 部署时间主要取决于jdk和hadoop软件包的下载速度 |
| [examples/elastic/hadoop-pseudo-distributed-env.yml](./examples/elastic/hadoop-pseudo-distributed-env.yml) | 在1个ECS实例上部署Hadoop伪分布式环境。 ECS实例扮演主从角色。 ***警告***仅在CentOS-7中进行测试。 也许需要关闭防火墙。 部署时间主要取决于JDK和hadoop软件包的下载速度 |
| [examples/elastic/instance-image-disk-snapshot.yml](./examples/elastic/instance-image-disk-snapshot.yml) | 指定镜像ID和磁盘快照创建ECS实例 |
| [examples/elastic/java-web-single-instance.yml](./examples/elastic/java-web-single-instance.yml) | 创建一台ECS实例并安装jdk和tomcat |
| [examples/elastic/jdk-dns-ssh-without-password-3-ecs.yml](./examples/elastic/jdk-dns-ssh-without-password-3-ecs.yml) | 此模板创建3台ECS实例，并安装和配置Java jdk，域名解析和ssh登录而无需密码环境。该模板可以用作其他复杂模板（例如hadoop和spark）的开始 |
| [examples/elastic/kong-single-instance.yml](./examples/elastic/kong-single-instance.yml) | 在一个ECS实例上部署Kong栈，请默认使用国外地区，因为Kong的下载源是国外源。 ***警告*** 只支持 CentOS-7 |
| [examples/elastic/lamp-basic.yml](./examples/elastic/lamp-basic.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，基于Centos7系统中一键部署LAMP(Linux+Apache+MySQL+PHP)开发环境 |
| [examples/elastic/lnmp-basic.yml](./examples/elastic/lnmp-basic.yml) | 在1个ECS实例上部署 LNMP（Linux+Nginx+MySQL+PHP）堆栈；模板仅支持 CentOS-7 |
| [examples/elastic/lnmpa-basic.yml](./examples/elastic/lnmpa-basic.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，基于Centos7系统中一键部署LNMPA(Linux+Nginx+MySQL+PHP+Apache)开发环境，其中Nginx主要用于存储静态文件，而Apache处理PHP动态请求 |
| [examples/elastic/lnmt-basic.yml](./examples/elastic/lnmt-basic.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，基于Centos7系统中一键部署LNMT(Linux+Nginx+MySQL+Tomcat)开发环境，其中Nginx主要用于存储静态文件，而Apache处理PHP动态请求 |
| [examples/elastic/mount-multiple-noninit-data-disks.yml](./examples/elastic/mount-multiple-noninit-data-disks.yml) | 创建ECS和弹性IP并挂载多个数据盘 |
| [examples/elastic/new-vpc-ask.yml](./examples/elastic/new-vpc-ask.yml) | 创建Serverless Kubernetes集群 |
| [examples/elastic/new-vpc-single-kafka.yml](./examples/elastic/new-vpc-single-kafka.yml) | 阿里巴巴 Cloud ROS 示例方案模板：新建虚拟专有网络、交换机和安全组基础资源后，创建一台ECS(Kafka Middleware)并绑定弹性IP；Java jdk版本是1.8.0，Scala版本是2.12，Kafka版本是0.10.2.2，数据盘路径是/home/software/，用于存储Kafka数据；默认Kafka bin目录位于/home/software/kafka/bin |
| [examples/elastic/new-vpc-single-rabbitmq.yml](./examples/elastic/new-vpc-single-rabbitmq.yml) | 在ECS主机上部署RabbitMQ（3.8.4）服务，RabbitMQ是一个开源AMQP实现的消息中间件服务，支持多种客户端连接，具备健壮、稳定、易用、跨平台、支持多种语言的特性 |
| [examples/elastic/nodejs-single-instance.yml](./examples/elastic/nodejs-single-instance.yml) | 该模板用于部署Node.js环境并基于新的ECS实例进行测试。***警告***，此模板仅支持CentOS |
| [examples/elastic/one-ecs-attach-multiple-slb.yml](./examples/elastic/one-ecs-attach-multiple-slb.yml) | 创建ECS，加入多个SLB并在/etc/hosts中绑定IP和机器名 |
| [examples/elastic/rds-with-ecs-in-iplist.yml](./examples/elastic/rds-with-ecs-in-iplist.yml) | 阿里云资源编排示例模板：RDS实例+ ECS实例+内联网访问 |
| [examples/elastic/ruby-on-rails-single-instance.yml](./examples/elastic/ruby-on-rails-single-instance.yml) | 阿里云资源编排示例模板:使用带有本地MySQL数据库的单个ECS实例创建Ruby on Rails堆栈进行存储。该示例从模板创建了一个简单的hello world应用程序。***警告***该模板仅支持CentOS-7。'rvm 安装2.3.1'可能需要很长时间 |
| [examples/elastic/scaling-simple-ha-infrastructure.yml](./examples/elastic/scaling-simple-ha-infrastructure.yml) | 根据已有的ECS实例，克隆出一组相同配置（InstanceType、ImageId、InternetChargeType、InternetMaxBandwidthIn、InternetMaxBandwidthOut、系统盘、数据盘配置、VPC属性）的ECS实例。 用户需要指定 SourceInstanceId |
| [examples/elastic/simple-ecs-instance.yml](./examples/elastic/simple-ecs-instance.yml) | 阿里云资源编排示例模板：一个简单的ECS实例，在VPC中具有一个安全组和一个vSwitch。 用户只需要指定图像ID |
| [examples/elastic/simple-high-available-infrastructure.yml](./examples/elastic/simple-high-available-infrastructure.yml) | 用户可以创建高可用性基础架构。将创建一些ECS和一个RDS。ECS将连接到一个SLB。RDS跨越多个可用区域。所有资源都在VPC环境下。客户可以通过SLB访问此基础架构 |
| [examples/elastic/slb-with-2-ecs.yml](./examples/elastic/slb-with-2-ecs.yml) | 阿里云资源编排示例模板：首先创建一个SLB，然后创建2个ECS实例，最后将2个实例附加到SLB |
| [examples/elastic/spark-hadoop-distributed-env-3-ecs.yml](./examples/elastic/spark-hadoop-distributed-env-3-ecs.yml) | 阿里云资源编排示例模板：此模板显示了如何在3个ECS实例上部署Hadoop-Spark环境。一个ECS实例扮演主节点的角色，另外两个实例扮演工作节点的角色。步骤1配置不带密码的ssh登录。步骤2安装并 configs Java env。步骤3安装和配置hadoop env。步骤4安装和配置Spark env。***警告***仅支持CentOS-7，也许需要停止防火墙，部署时间主要取决于下载速度4 包 |
| [examples/elastic/spark-hadoop-ecs-instance-group.yml](./examples/elastic/spark-hadoop-ecs-instance-group.yml) | 此模板显示了如何部署Hadoop-Spark环境。一个ECS实例扮演主角色，一个实例组扮演工作角色。步骤1配置不带密码的ssh登录。步骤2安装和配置Java环境。步骤3安装 和配置 Hadoop 环境。步骤4安装并配置Spark 环境。***警告***仅在CentOS-7中进行测试。也许需要停止防火墙。部署时间主要取决于下载4个软件包的速度 |
| [examples/elastic/tensorflow-deployment.yml](./examples/elastic/tensorflow-deployment.yml) | 阿里云资源编排示例模板：创建ECS实例并安装TensorFlow |
| [examples/elastic/wordpress-cluster-phpmyadmin.yml](./examples/elastic/wordpress-cluster-phpmyadmin.yml) | 部署WordPress网站和phpMyAdmin应用程序 |
| [examples/elastic/wordpress-cluster.yml](./examples/elastic/wordpress-cluster.yml) | 创建一个WordPress集群 |
| [examples/elastic/wordpress-instance.yml](./examples/elastic/wordpress-instance.yml) | 创建一台ECS实例并部署WordPress |
| [examples/free/multi-zone-network.yml](./examples/free/multi-zone-network.yml) | 创建多可用区网络 |
| [examples/free/single-role-add-policy.yml](./examples/free/single-role-add-policy.yml) | 创建一个RAM角色并添加策略 |
| [examples/free/single-user-with-different-policies.yml](./examples/free/single-user-with-different-policies.yml) | 创建一个属于用户组和管理员组的子帐户，启用控制台登录并创建访问密钥 |
| [examples/free/vpc-type-of-slb.yml](./examples/free/vpc-type-of-slb.yml) | 创建Vpc类型的Slb |
| [examples/gamesupport/ecs-bind-mult-eni-and-eip.yml](./examples/gamesupport/ecs-bind-mult-eni-and-eip.yml) | 此模板主要实现创建ECS并绑定多个弹性网卡，绑定弹性网卡的个数需要由ECS的规格具体决定，每个弹性网卡支持绑定多个弹性公网IP |
| [examples/iot/existing-vpc-cluster-emq.yml](./examples/iot/existing-vpc-cluster-emq.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，基于Centos7部署EMQ X服务集群，在使用ESS弹性伸缩集群时会创建EssRamRole自动授权OOS执行任务将Slave加入/移除集群，EMQ X 是一款完全开源，高度可伸缩，高可用的分布式 MQTT 消息服务器，适用于 IoT、M2M 和移动应用程序，可处理千万级别的并发客户端 |
| [examples/iot/existing-vpc-clusteremq.yml](./examples/iot/existing-vpc-clusteremq.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，基于Centos7部署EMQ X服务集群，在使用ESS弹性伸缩集群时会创建EssRamRole自动授权OOS执行任务将Slave加入/移除集群，EMQ X 是一款完全开源，高度可伸缩，高可用的分布式 MQTT 消息服务器，适用于 IoT、M2M 和移动应用程序，可处理千万级别的并发客户端 |
| [examples/iot/existing-vpc-single-emq.yml](./examples/iot/existing-vpc-single-emq.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，基于Centos7单节点部署EMQ X服务，EMQ X 是一款完全开源，高度可伸缩，高可用的分布式 MQTT 消息服务器，适用于 IoT、M2M 和移动应用程序，可处理千万级别的并发客户端 |
| [examples/isv/custom-image-ecs-datadisk.yml](./examples/isv/custom-image-ecs-datadisk.yml) | 单实例自定义镜像部署，带数据盘，公网IP可选（支持创建新VPC和指定VPC） |
| [examples/isv/custom-image-ecs.yml](./examples/isv/custom-image-ecs.yml) | 单实例自定义镜像部署，不带数据盘，带公网IP（支持创建新VPC和指定VPC） |
| [examples/isv/existing-vpc-ack.yml](./examples/isv/existing-vpc-ack.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，创建一组Kubernetes专有版集群 |
| [examples/isv/existing-vpc-slb-ecs-isv.yml](./examples/isv/existing-vpc-slb-ecs-isv.yml) | 使用已有VPC、VSWitch，创建1个SLB、2个ECS实例，并将所有ECS实例绑定到SLB上 |
| [examples/isv/existing-vpc-slb-ecs-rds-isv.yml](./examples/isv/existing-vpc-slb-ecs-rds-isv.yml) | 使用已有VPC、VSWitch，创建1个RDS、1个SLB、2个ECS实例，并将所有ECS实例绑定到SLB上 |
| [examples/isv/new-vpc-ack-and-jump-server.yml](./examples/isv/new-vpc-ack-and-jump-server.yml) | 新建虚拟专有网络、交换机和安全组，并创建一组Kubernetes托管版集群，并创建一台跳板机使用kubectl部署应用 |
| [examples/network/cen-open-isolated-networks.yml](./examples/network/cen-open-isolated-networks.yml) | 隔离VPC使用共享服务 |
| [examples/network/micro-vpc-architecture.yml](./examples/network/micro-vpc-architecture.yml) | 阿里云资源编排示例模板： 微业务VPC网络体系结构。创建一个VPC网络和一个子网。子网中的ECS通过公共IP访问国际网络 |
| [examples/network/middle-vpc-architecture.yml](./examples/network/middle-vpc-architecture.yml) | 阿里云资源编排示例模板： 中型企业VPC网络体系结构。在VPC下创建了三个子网。Front子网中的ECS和SLB处理公共网络请求。后端子网中的ECS，SLB，RDS，Redis，OSS等提供核心业务逻辑。网络访问公众 通过NatGateway的SNAT建立网络 |
| [examples/network/private-link-access-service.yml](./examples/network/private-link-access-service.yml) | 用私网连接（PrivateLink）服务将一个专有网络（VPC）内部署的私网SLB服务共享给同账号下的另外一个VPC访问 |
| [examples/network/security-vpc.yml](./examples/network/security-vpc.yml) | 安全VPC场景 |
| [examples/network/slb-clone.yml](./examples/network/slb-clone.yml) | 克隆一个负载均衡，并将其ECS实例挂载到新的负载均衡上。用户只需要指定源SLB ID |
| [examples/network/small-vpc-architecture.yml](./examples/network/small-vpc-architecture.yml) | 阿里云资源编排示例模板: 小型业务VPC网络架构，在VPC网络部署两个子网，所有子网都通过NatGateway对外网提供服务和访问外网 |
| [examples/network/vpc-nat-gateway.yml](./examples/network/vpc-nat-gateway.yml) | 阿里云资源编排示例模板: 在VPC网络下创建ECS并配置NatGateway使VPC网络中的ECS可访问外网和提供服务 |
| [examples/network/vpc-snat-gateway.yml](./examples/network/vpc-snat-gateway.yml) | 搭建VPC环境，配置SNat Gateway，保证ECS访问公网和提供公网服务 |
| [examples/network/vpc-snat.yml](./examples/network/vpc-snat.yml) | 阿里云资源编排示例模板: 一键创建SNAT网关，VPC环境下创建一个绑定了EIP的ECS做为SNAT网关 |
| [examples/network/vpc-vswitch-route-sg-ecs.yml](./examples/network/vpc-vswitch-route-sg-ecs.yml) | 创建一个VPC、VSwitch、安全组、ECS实例、路由。用户需要指定图像 ID |
| [examples/network/vpc.yml](./examples/network/vpc.yml) | 创建一个VPC实例 |
| [examples/network/vpcv-switch-route-sg-ecs.yml](./examples/network/vpcv-switch-route-sg-ecs.yml) | 创建一个VPC、VSwitch、安全组、ECS实例和路由。用户需要指定图像 ID |
| [examples/security/centralized-logs.yml](./examples/security/centralized-logs.yml) | 创建管理操作审计、OSS、SLS的Ram角色，将审计数据保存到指定的OSS bucket中 |
| [examples/security/ecs-ram-role.yml](./examples/security/ecs-ram-role.yml) | 创建用于ECS实例的RAM角色 |
| [examples/security/existing-vpc-single-jump-server.yml](./examples/security/existing-vpc-single-jump-server.yml) | 在ECS单节点主机上部署JumpServer服务，JumpServer是一个运维安全审计系统，主要用于身份验证、账号管理、授权控制、安全审计等。如需外网访问JumpServer Web界面请在安全组添加入方向JumpServerWeb服务端口访问规则 |
| [examples/security/manage-vpc-vswitch-policy.yml](./examples/security/manage-vpc-vswitch-policy.yml) | 创建策略授权管理单个区域的交换机策略 |
| [examples/security/managed-policy.yml](./examples/security/managed-policy.yml) | 创建自定义策略 |
| [examples/security/ram-create-sub-account.yml](./examples/security/ram-create-sub-account.yml) | 创建子账户，启用控制台登录，并创建访问密钥 |
| [examples/security/stack-group-aliyun-ros-stack-group-administration-role.yml](./examples/security/stack-group-aliyun-ros-stack-group-administration-role.yml) | 配置AliyunROSStackGroupAdministrationRole以使用阿里云ROS资源栈组 |
| [examples/security/stack-group-aliyun-ros-stack-group-execution-role.yml](./examples/security/stack-group-aliyun-ros-stack-group-execution-role.yml) | 配置AliyunROSStackGroupExecutionRole以启用您的帐户作为阿里云ROS资源栈组中的目标帐户 |
| [examples/security/sub-account-pass-role.yml](./examples/security/sub-account-pass-role.yml) | 创建子账号并具备ram:PassRole权限 |
| [examples/stackgroup/aliyun-ros-stack-group-administration-role.yml](./examples/stackgroup/aliyun-ros-stack-group-administration-role.yml) | 配置AliyunROSStackGroupAdministrationRole以使用阿里云ROS资源栈组 |
| [examples/stackgroup/aliyun-ros-stack-group-execution-role.yml](./examples/stackgroup/aliyun-ros-stack-group-execution-role.yml) | 配置AliyunROSStackGroupExecutionRole以启用您的帐户作为阿里云ROS资源栈组中的目标帐户 |
| [examples/storage/simple-oss-bucket.yml](./examples/storage/simple-oss-bucket.yml) | 创建一个OSS Bucket |
| [examples/windows/simple-windows-instance-with-exchange.yml](./examples/windows/simple-windows-instance-with-exchange.yml) | 创建一个ECS实例并安装Exchange Server 2013 |
| [examples/windows/simple-windows-instance-with-sharepoint.yml](./examples/windows/simple-windows-instance-with-sharepoint.yml) | 创建一个ECS实例并安装SharePoint Foundation 2013 |
</details>

<details>
  <summary>documents</summary>

- trail

| 模板                                                                                                                               | 说明                                                                                       |
| ---------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
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

<details>
  <summary>compute-nest-best-practice</summary>

| 模板                                                                                                    | 说明                                  |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------- |
| [ack-app-rds](./compute-nest-best-practice/ack-app-rds/README.md)                                       | 创建容器应用和 RDS                    |
| [ack-nginx](./compute-nest-best-practice/ack-nginx/README.md)                                           | 创建 ACK 并部署 Nginx                 |
| [ecs-adbpg](./compute-nest-best-practice/ecs-adbpg/README.md)                                           | 创建 ECS 和 ADBPG 实例                |
| [ecs-deploy](./compute-nest-best-practice/ecs-deploy/README.md)                                         | 基于 ECS 实例的部署                   |
| [ecs-mongodb](./compute-nest-best-practice/ecs-mongodb/README.md)                                       | 创建 ECS 和 MongoDB 实例              |
| [ecs-mysql-deploy](./compute-nest-best-practice/ecs-mysql-deploy/README.md)                             | 新建 ECS 实例并创建 MySQL             |
| [ecs-polardb](./compute-nest-best-practice/ecs-polardb/README.md)                                       | 创建 ECS 和 PolarDB 实例              |
| [ecs-postgresql](./compute-nest-best-practice/ecs-postgresql/README.md)                                 | 创建 ECS 和 PostgreSQL 实例           |
| [ecs-ramrole-oss](./compute-nest-best-practice/ecs-ramrole-oss/README.md)                               | 创建 ECS 实例、RAM Role 和 OSS        |
| [ecs-rds](./compute-nest-best-practice/ecs-rds/README.md)                                               | 创建 ECS 和 RDS 实例                  |
| [ecs-redis](./compute-nest-best-practice/ecs-redis/README.md)                                           | 创建 ECS 和 Redis 实例                |
| [ecs-slb](./compute-nest-best-practice/ecs-slb/README.md)                                               | 创建 ECS 和 SLB 实例                  |
| [ecs-sqlserver](./compute-nest-best-practice/ecs-sqlserver/README.md)                                   | 创建 ECS 和 SQL Server 实例           |
| [ehpc-demo](./compute-nest-best-practice/ehpc-demo/README.md)                                           | 创建弹性高性能计算集群                |
| [existing-ecs-nginx](./compute-nest-best-practice/existing-ecs-nginx/README.md)                         | 在已有 ECS 实例上部署 Nginx           |
| [managed-reverse-vpc-connection](./compute-nest-best-practice/managed-reverse-vpc-connection/README.md) | 全托管服务私网反向访问的最佳实践      |
| [master-slave-ecs](./compute-nest-best-practice/master-slave-ecs/README.md)                             | 创建 Master-Slave 架构的 ECS 实例     |
| [opensource](./compute-nest-best-practice/opensource)                                                   | 部署各类开源软件的最佳实践            |
| [pai/pai-dsw.yml](./compute-nest-best-practice/pai/pai-dsw.yml)                                         | 创建 PAI                              |
| [scaling-ecs](./compute-nest-best-practice/scaling-ecs/README.md)                                       | 创建一组带有伸缩组的 ECS 架构         |
| [terraform-ecs-nginx](./compute-nest-best-practice/terraform-ecs-nginx/README.md)                       | [Terraform] 创建 ECS 实例并部署 Nginx |

</details>
