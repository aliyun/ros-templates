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
| [acm/configuration.yml](./resources/acm/configuration.yml)                                   | ACM Namespace/Configuration 资源示例。                                                                                                   |
| [actiontrail/trail-logging.yml](./resources/actiontrail/trail-logging.yml)                   | ACTIONTRAIL Trail/TrailLogging 资源示例。                                                                                                |
| [apigateway/api.yml](./resources/apigateway/api.yml)                                         | ApiGateway Api/Group/App/Deployment/Authorization/Signature/SignatureBinding/TrafficControl/TrafficControlBinding/ 资源示例。            |
| [apigateway/custom-domain.yml](./resources/apigateway/custom-domain.yml)                     | ApiGateway CustomDomain 资源示例。                                                                                                       |
| [apigateway/instance.yml](./resources/apigateway/instance.yml)                               | ApiGateway Instance 资源示例。                                                                                                           |
| [apigateway/stage-config.yml](./resources/apigateway/stage-config.yml)                       | ApiGateway StageConfig 资源示例。                                                                                                        |
| [apigateway/vpc-access-config.yml](./resources/apigateway/vpc-access-config.yml)             | ApiGateway VpcAccessConfig 资源示例。                                                                                                    |
| [arms/alert-contact-group.yml](./resources/arms/alert-contact-group.yml)                     | ARMS AlertContact/AlertContactGroup 资源示例。                                                                                           |
| [arms/retcode-app.yml](./resources/arms/retcode-app.yml)                                     | ARMS RetcodeApp 资源示例。                                                                                                               |
| [asm/service-mesh.yml](./resources/asm/service-mesh.yml)                                     | ASM ServiceMesh 资源示例。                                                                                                               |
| [bss/wait-order.yml](./resources/bss/wait-order.yml)                                         | BSS WaitOrder 资源示例。                                                                                                                 |
| [cas/certificate.yml](./resources/cas/certificate.yml)                                       | CAS Certificate 资源示例。                                                                                                               |
| [cdn/domain.yml](./resources/cdn/domain.yml)                                                 | CDN Domain/DomainConfig 资源示例。                                                                                                       |
| [cen/cen.yml](./resources/cen/cen.yml)                                                       | CEN 资源示例。                                                                                                                           |
| [cms/contact.yml](./resources/cms/contact.yml)                                               | CMS Contact/ContactGroup/DynamicTagGroup 资源示例。                                                                                      |
| [cms/event-rule-targets.yml](./resources/cms/event-rule-targets.yml)                         | CMS EventRuleTargets 资源示例。                                                                                                          |
| [cms/event-rule.yml](./resources/cms/event-rule.yml)                                         | CMS EventRule 资源示例。                                                                                                                 |
| [cms/group-metric-rule.yml](./resources/cms/group-metric-rule.yml)                           | CMS GroupMetricRule/MetricRuleTargets 资源示例。                                                                                         |
| [cms/metric-rule-template.yml](./resources/cms/metric-rule-template.yml)                     | CMS MetricRuleTemplate 资源示例。                                                                                                        |
| [cms/monitor-group.yml](./resources/cms/monitor-group.yml)                                   | CMS MonitorGroup/MonitorGroupInstances 资源示例。                                                                                        |
| [cms/monitoring-agent-process.yml](./resources/cms/monitoring-agent-process.yml)             | CMS MonitoringAgentProcess 资源示例。                                                                                                    |
| [cms/site-monitor.yml](./resources/cms/site-monitor.yml)                                     | CMS SiteMonitor 资源示例。                                                                                                               |
| [config/config.yml](./resources/config/config.yml)                                           | Config Rule 资源示例。                                                                                                                   |
| [cr/instance-endpoint-acl-policy.yml](./resources/cr/instance-endpoint-acl-policy.yml)       | CR InstanceEndpointAclPolicy 资源示例。                                                                                                  |
| [cr/namespace.yml](./resources/cr/namespace.yml)                                             | CR NameSpace 资源示例。                                                                                                                  |
| [cr/repository.yml](./resources/cr/repository.yml)                                           | CR Repository 资源示例。                                                                                                                 |
| [cs/any-cluster.yml](./resources/cs/any-cluster.yml)                                         | CS AnyCluster 资源示例。                                                                                                                 |
| [cs/kubernetes-cluster.yml](./resources/cs/kubernetes-cluster.yml)                           | CS KubernetesCluster 资源示例。                                                                                                          |
| [cs/managed-edge-kubernetes-cluster.yml](./resources/cs/managed-edge-kubernetes-cluster.yml) | CS ManagedEdgeKubernetesCluster 资源示例。                                                                                               |
| [cs/managed-kubernetes-cluster.yml](./resources/cs/managed-kubernetes-cluster.yml)           | CS ManagedKubernetesCluster 资源示例。                                                                                                   |
| [cs/serverless-kubernetes-cluster.yml](./resources/cs/serverless-kubernetes-cluster.yml)     | CS ServerlessKubernetesCluster 资源示例。                                                                                                |
| [datahub/topic.yml](./resources/datahub/topic.yml)                                           | DataHub Project/Topic 资源示例。                                                                                                         |
| [dns/domain-record.yml](./resources/dns/domain-record.yml)                                   | DNS DomainRecord 资源示例。                                                                                                              |
| [dns/domain.yml](./resources/dns/domain.yml)                                                 | DNS Domain/DomainGroup 资源示例。                                                                                                        |
| [drds/drds-instance.yml](./resources/drds/drds-instance.yml)                                 | DrdsInstance 资源示例。                                                                                                                  |
| [dts/consumer-group.yml](./resources/dts/consumer-group.yml)                                 | DTS SubscriptionInstance 资源示例。                                                                                                      |
| [dts/dts.yml](./resources/dts/dts.yml)                                                       | DTS MigrationJob/SynchronizationJob 资源示例。                                                                                           |
| [dts/subscription-instance.yml](./resources/dts/subscription-instance.yml)                   | DTS SubscriptionInstance/ConsumerGroup 资源示例。                                                                                        |
| [eci/container-group.yml](./resources/eci/container-group.yml)                               | ECI ContainerGroup 资源示例。                                                                                                            |
| [eci/image-cache.yml](./resources/eci/image-cache.yml)                                       | ECI ImageCache 资源示例。                                                                                                                |
| [ecs/assign-private-ip-addresses.yml](./resources/ecs/assign-private-ip-addresses.yml)       | ECS AssignPrivateIpAddresses 资源示例。                                                                                                  |
| [ecs/auto-snapshot-policy.yml](./resources/ecs/auto-snapshot-policy.yml)                     | ECS AutoSnapshotPolicy 资源示例。                                                                                                        |
| [ecs/custom-image.yml](./resources/ecs/custom-image.yml)                                     | ECS CustomImage/CopyImage 资源示例。                                                                                                     |
| [ecs/dedicated-host.yml](./resources/ecs/dedicated-host.yml)                                 | ECS DedicatedHost 资源示例。                                                                                                             |
| [ecs/deployment-set.yml](./resources/ecs/deployment-set.yml)                                 | ECS DeploymentSet 资源示例。                                                                                                             |
| [ecs/disk-attachment.yml](./resources/ecs/disk-attachment.yml)                               | ECS DiskAttachment/Snapshot 资源示例。                                                                                                   |
| [ecs/disk.yml](./resources/ecs/disk.yml)                                                     | ECS Disk 资源示例。                                                                                                                      |
| [ecs/forward-entry.yml](./resources/ecs/forward-entry.yml)                                   | ECS ForwardEntry 资源示例。                                                                                                              |
| [ecs/hpc-cluster.yml](./resources/ecs/hpc-cluster.yml)                                       | ECS HpcCluster 资源示例。                                                                                                                |
| [ecs/instance-clone.yml](./resources/ecs/instance-clone.yml)                                 | ECS Instance Clone 资源示例。                                                                                                            |
| [ecs/instance-group.yml](./resources/ecs/instance-group.yml)                                 | ECS InstanceGroup/InstanceGroupClone/Command/Invocation 资源示例。                                                                       |
| [ecs/instance.yml](./resources/ecs/instance.yml)                                             | ECS instance/EIP/NatGateway/SSHKeyPair 资源示例。                                                                                        |
| [ecs/join-security-group.yml](./resources/ecs/join-security-group.yml)                       | ECS JoinSecurityGroup 资源示例。                                                                                                         |
| [ecs/launch-template.yml](./resources/ecs/launch-template.yml)                               | ECS LaunchTemplate/AutoProvisioningGroup 资源示例。                                                                                      |
| [ecs/nat-gateway.yml](./resources/ecs/nat-gateway.yml)                                       | ECS NatGateway/BandwidthPackage 资源示例。                                                                                               |
| [ecs/network-interface-attachment.yml](./resources/ecs/network-interface-attachment.yml)     | ECS NetworkInterface/NetworkInterfaceAttachment 资源示例。                                                                               |
| [ecs/prepay-instance.yml](./resources/ecs/prepay-instance.yml)                               | ECS PrepayInstance 资源示例。                                                                                                            |
| [ecs/route.yml](./resources/ecs/route.yml)                                                   | ECS Route/AssignIpv6Addresses 资源示例。                                                                                                 |
| [ecs/run-command.yml](./resources/ecs/run-command.yml)                                       | ECS RunCommand 资源示例。                                                                                                                |
| [ecs/snat-entry.yml](./resources/ecs/snat-entry.yml)                                         | ECS SecurityGroupIngress 资源示例。                                                                                                      |
| [ecs/security-group-clone.yml](./resources/ecs/security-group-clone.yml)                     | ECS SecurityGroupClone 资源示例。                                                                                                        |
| [ecs/security-group-egress.yml](./resources/ecs/security-group-egress.yml)                   | ECS SecurityGroupEgress 资源示例。                                                                                                       |
| [ecs/security-group-ingress.yml](./resources/ecs/security-group-ingress.yml)                 | ECS SecurityGroupIngress 资源示例。                                                                                                      |
| [edas/cluster-member.yml](./resources/edas/cluster-member.yml)                               | EDAS ClusterMember 资源示例。                                                                                                            |
| [edas/cluster.yml](./resources/edas/cluster.yml)                                             | EDAS Cluster/App/DeployGroup 资源示例。                                                                                                  |
| [ehpc/cluster.yml](./resources/ehpc/cluster.yml)                                             | EHPC Cluster 资源示例。                                                                                                                  |
| [elasticsearch/instance.yml](./resources/elasticsearch/instance.yml)                         | ElasticSearch Instance 资源示例。                                                                                                        |
| [emr/cluster.yml](./resources/emr/cluster.yml)                                               | EMR Cluster 资源示例。                                                                                                                   |
| [ess/scaling-group-enable.yml](./resources/ess/scaling-group-enable.yml)                     | ESS ScalingConfiguration/ScalingGroupEnable 资源示例。                                                                                   |
| [ess/scaling-group.yml](./resources/ess/scaling-group.yml)                                   | ESS ScalingGroup/ScalingRule/AlarmTask/AlarmTaskEnable/LifecycleHook/ScheduledTask 资源示例。                                            |
| [fc/custom-domain.yml](./resources/fc/custom-domain.yml)                                     | FC CustomDomain 资源示例。                                                                                                               |
| [fc/function-invoker.yml](./resources/fc/function-invoker.yml)                               | FC FunctionInvoker/Trigger/Version/Alias/ProvisionConfig 资源示例。                                                                      |
| [fnf/flow.yml](./resources/fnf/flow.yml)                                                     | FNF Flow/Schedule 资源示例。                                                                                                             |
| [ga/ga-ipv6.yml](./resources/ga/ga-ipv6.yml)                                                 | GA Accelerator/ BandwidthPackage/IpSets/Listener/EndpointGroup/BandwidthPackageAcceleratorAddition 资源示例。                            |
| [gws/cluster.yml](./resources/gws/cluster.yml)                                               | GWS Cluster/Instance 资源示例。                                                                                                          |
| [iot/device-group.yml](./resources/iot/device-group.yml)                                     | IOT DeviceGroup 资源示例。                                                                                                               |
| [iot/device.yml](./resources/iot/device.yml)                                                 | IOT Product/Device 资源示例。                                                                                                            |
| [iot/rule.yml](./resources/iot/rule.yml)                                                     | IOT Rule/RuleAction 资源示例。                                                                                                           |
| [kafka/instance.yml](./resources/kafka/instance.yml)                                         | Kafka Instance/Topic 资源示例。                                                                                                          |
| [kms/key.yml](./resources/kms/key.yml)                                                       | KMS Key/Alias 资源示例。                                                                                                                 |
| [kms/secret.yml](./resources/kms/secret.yml)                                                 | KMS Secret 资源示例。                                                                                                                    |
| [marketplace/order.yml](./resources/marketplace/order.yml)                                   | MarketPlace Order 资源示例。                                                                                                             |
| [memcache/instance.yml](./resources/memcache/instance.yml)                                   | Memcache Instance/WhiteList 资源示例。                                                                                                   |
| [mns/subscription.yml](./resources/mns/subscription.yml)                                     | MNS Queue/Topic/Subscription 资源示例。                                                                                                  |
| [mongodb/mongodb-instance.yml](./resources/mongodb/mongodb-instance.yml)                     | MONGODB Instance 资源示例。                                                                                                              |
| [mongodb/serverless-instance.yml](./resources/mongodb/serverless-instance.yml)               | MONGODB ServerlessInstance 资源示例。                                                                                                    |
| [mongodb/sharding-instance.yml](./resources/mongodb/sharding-instance.yml)                   | MONGODB ShardingInstance 资源示例。                                                                                                      |
| [mse/cluster.yml](./resources/mse/cluster.yml)                                               | MSE Cluster 资源示例。                                                                                                                   |
| [nas/nas.yml](./resources/nas/nas.yml)                                                       | NAS AccessGroupName/AccessRule/FileSystem/MountTarget 资源示例。                                                                         |
| [oos/oos.yml](./resources/oos/oos.yml)                                                       | OOS Template/Execution 资源示例。                                                                                                        |
| [oos/parameter.yml](./resources/oos/parameter.yml)                                           | OOS Parameter 资源示例。                                                                                                                 |
| [oss/bucket.yml](./resources/oss/bucket.yml)                                                 | OSS Bucket 资源示例。                                                                                                                    |
| [ots/ots.yml](./resources/ots/ots.yml)                                                       | OTS Table/Instance/VpcBinder 资源示例。                                                                                                  |
| [polardb/polardb.yml](./resources/polardb/polardb.yml)                                       | POLARDB DBCluster/Account/DBInstance/DBNodes/AccountPrivilege/DBClusterAccessWhiteList/DBClusterEndpointAddress 资源示例。               |
| [privatelink/vpc-endpoint.yml](./resources/privatelink/vpc-endpoint.yml)                     | PrivateLink VpcEndpointService/VpcEndpoint 资源示例。                                                                                    |
| [pvtz/pvtz.yml](./resources/pvtz/pvtz.yml)                                                   | PVTZ Zone/ZoneRecord/ZoneVpcBinder 资源示例。                                                                                            |
| [ram/access-key.yml](./resources/ram/access-key.yml)                                         | RAM User/AccessKey 资源示例。                                                                                                            |
| [ram/attach-policy-to-role.yml](./resources/ram/attach-policy-to-role.yml)                   | RAM Role/AttachPolicyToRole 资源示例。                                                                                                   |
| [ram/managed-policy.yml](./resources/ram/managed-policy.yml)                                 | RAM ManagedPolicy 资源示例。                                                                                                             |
| [ram/role.yml](./resources/ram/role.yml)                                                     | RAM Role 资源示例。                                                                                                                      |
| [ram/saml-provider.yml](./resources/ram/saml-provider.yml)                                   | RAM SAMLProvider 资源示例。                                                                                                              |
| [ram/user.yml](./resources/ram/user.yml)                                                     | RAM User/Group/AttachPolicyToUser/UserToGroupAddition 资源示例。                                                                         |
| [rds/db-instance.yml](./resources/rds/db-instance.yml)                                       | RDS DBInstance/Account/AccountPrivilege 资源示例。                                                                                       |
| [rds/prepay-db-instance.yml](./resources/rds/prepay-db-instance.yml)                         | RDS PrepayDBInstance 资源示例。                                                                                                          |
| [redis/instance.yml](./resources/redis/instance.yml)                                         | Redis Instance/Whitelist and Account 资源示例。                                                                                          |
| [redis/prepay-instance.yml](./resources/redis/prepay-instance.yml)                           | Redis PrepayInstance 资源示例。                                                                                                          |
| [resourcemaneger/handshake.yml](./resources/resourcemaneger/handshake.yml)                   | ResourceManager Handshake 资源示例。                                                                                                     |
| [resourcemaneger/resource-group.yml](./resources/resourcemaneger/resource-group.yml)         | ResourceManager ResourceGroup 资源示例。                                                                                                 |
| [rocketmq/rocketmq.yml](./resources/rocketmq/rocketmq.yml)                                   | ROCKETMQ Instance/Topic 资源示例。                                                                                                       |
| [ros/auto-enable-service.yml](./resources/ros/auto-enable-service.yml)                       | ROS AutoEnableService 资源示例。                                                                                                         |
| [ros/custom-resource.yml](./resources/ros/custom-resource.yml)                               | ROS Custom 资源示例。                                                                                                                    |
| [ros/stack.yml](./resources/ros/stack.yml)                                                   | ROS Nested Stack 资源示例。                                                                                                              |
| [ros/wait-condition-handle.yml](./resources/ros/wait-condition-handle.yml)                   | ROS WaitConditionHandle 资源示例。                                                                                                       |
| [ros/wait-condition.yml](./resources/ros/wait-condition.yml)                                 | ROS WaitCondition/WaitConditionHandle 资源示例。                                                                                         |
| [sae/sae.yml](./resources/sae/sae.yml)                                                       | SAE Application/Namespace/SlbBinding 资源示例。                                                                                          |
| [sag/acl.yml](./resources/sag/acl.yml)                                                       | SAG ACL/ACLRule/ACLAssociation 资源示例。                                                                                                |
| [slb/access-control.yml](./resources/slb/access-control.yml)                                 | SLB AccessControl 资源示例。                                                                                                             |
| [slb/backend-server-attachment.yml](./resources/slb/backend-server-attachment.yml)           | SLB LoadBalancer/MasterSlaveServerGroup/BackendServerAttachment 资源示例。                                                               |
| [slb/listener.yml](./resources/slb/listener.yml)                                             | SLB LoadBalancer/Listener/LoadBalancerClone/Certificate/DomainExtension/VServerGroup/Rule 资源示例。                                     |
| [sls/sls.yml](./resources/sls/sls.yml)                                                       | SLS Project/Logstore/Alert/Index/SavedSearch/LogtailConfig/MachineGroup/ApplyConfigToMachineGroup/ApiGatewayLogConfig 资源示例。         |
| [tsdb/hi-tsdb-instance.yml](./resources/tsdb/hi-tsdb-instance.yml)                           | TSDB HiTSDBInstance 资源示例。                                                                                                           |
| [vpc/anycast-eip.yml](./resources/vpc/anycast-eip.yml)                                       | VPC AnycastEIP/AnycastEIPAssociation 资源示例。                                                                                          |
| [vpc/eip-association.yml](./resources/vpc/eip-association.yml)                               | VPC EIP/EIPAssociation 资源示例。                                                                                                        |
| [vpc/eip-segment.yml](./resources/vpc/eip-segment.yml)                                       | VPC EIPSegment 资源示例。                                                                                                                |
| [vpc/eip.yml](./resources/vpc/eip.yml)                                                       | VPC EIP 资源示例。                                                                                                                       |
| [vpc/nat-gateway.yml](./resources/vpc/nat-gateway.yml)                                       | VPC NatGateway 资源示例。                                                                                                                |
| [vpc/network-acl.yml](./resources/vpc/network-acl.yml)                                       | VPC NetworkAcl/NetworkAclAssociation 资源示例。                                                                                          |
| [vpc/route-table.yml](./resources/vpc/route-table.yml)                                       | Vpc RouteTable 资源示例。                                                                                                                |
| [vpc/router-interface-update.yml](./resources/vpc/router-interface-update.yml)               | Vpc RouterInterface 资源示例。                                                                                                           |
| [vpc/router-interface.yml](./resources/vpc/router-interface.yml)                             | Vpc RouterInterface 资源示例。                                                                                                           |
| [vpc/snat-entry.yml](./resources/vpc/snat-entry.yml)                                         | VPC NatGateway/Ipv6Gateway/Ipv6InternetBandwidth/EIP/EIPAssociation/SnatEntry/CommonBandwidthPackage/CommonBandwidthPackageIp 资源示例。 |
| [waf/domain-config.yml](./resources/waf/domain-config.yml)                                   | Waf DomainConfig/AclRule/WafSwitch 资源示例。                                                                                            |
| [waf/domain.yml](./resources/waf/domain.yml)                                                 | Waf Domain 资源示例。                                                                                                                    |
| [waf/instance.yml](./resources/waf/instance.yml)                                             | WAF Instance 资源示例。                                                                                                                  |

</details>

<details>
  <summary>examples</summary>

| 模板 | 说明 |
| ---- | ---- |
| [application/ecs-clone-join-sls.yml](./examples/application/ecs-clone-join-sls.yml) | 克隆ECS实例，将IP指向日志服务中新建的机器组，应用指定的规则。 |
| [application/ecs-group-join-sls.yml](./examples/application/ecs-group-join-sls.yml) | 创建一组ECS实例，将其作为日志服务中相关项目logtail的机器组。 |
| [application/ecs-instance-group-join-sls.yml](./examples/application/ecs-instance-group-join-sls.yml) | 创建一组ECS并将其作为指定的SLS中相关project的logtail的机器组。 |
| [csapps/existing-vpc-docker-cluster-etcd.yml](./examples/csapps/existing-vpc-docker-cluster-etcd.yml) | 在Centos7下安装部署集群版Etcd服务（静态发现从节点模式），Etcd是一个用于服务注册与发现的键值存储组件, 其内部采用raft协议作为一致性算法保证数据统一性，集群安装完成后请使用etcdctl命令在云服务器中操作管理集群。 |
| [csapps/existing-vpc-docker-cluster-harbor.yml](./examples/csapps/existing-vpc-docker-cluster-harbor.yml) | 使用Docker容器安装部署Harbor(1.9.3)集群服务，Harbor是一个企业级私有的容器镜像管理服务，Harbor提供了用户管理，访问控制，活动审计等的特性, 本次部署以NFS作为共享存储（/data目录）存放Harbor相关镜像数据，并分离PostgreSQL与Redis为多个Harbor共同连接使用，使用SLB令集群达到负载均衡高可用的模式，对SLB绑定公网IP对外提供服务。 |
| [csapps/existing-vpc-docker-cluster-rancher.yml](./examples/csapps/existing-vpc-docker-cluster-rancher.yml) | 使用三台阿里云服务器ECS实现Rancher高可用集群安装，在Kubernetes集群中安装Rancher并使用DNS域名解析绑定SLB四层负载均衡对外提供服务，外部访问时请在安全组中添加80,443入方向的访问规则，Rancher是一个开源的企业级多集群Kubernetes管理平台，实现了Kubernetes集群在混合云+本地数据中心的集中部署与管理，以确保集群的安全性，加速企业数字化转型。 |
| [csapps/existing-vpc-docker-single-etcd.yml](./examples/csapps/existing-vpc-docker-single-etcd.yml) | 单节点在centos7下安装部署Etcd服务，Etcd是一个用于服务注册与发现的键值存储组件, 其内部采用raft协议作为一致性算法保证数据统一性，服务安装完成后请使用etcdctl命令在云服务器中操作管理服务。 |
| [csapps/existing-vpc-docker-single-harbor.yml](./examples/csapps/existing-vpc-docker-single-harbor.yml) | 单节点使用Docker容器安装部署Harbor(2.1.0)服务，Harbor是一个企业级私有的容器镜像管理服务，Harbor提供了用户管理，访问控制，活动审计等的特性, 如需外网访问Harbor Web界面请在安全组添加入方向80访问规则。 |
| [csapps/existing-vpc-docker-single-rancher.yml](./examples/csapps/existing-vpc-docker-single-rancher.yml) | 单节点使用Docker容器安装部署Rancher服务，Rancher是一个开源的企业级多集群Kubernetes管理平台，实现了Kubernetes集群在混合云+本地数据中心的集中部署与管理，以确保集群的安全性，加速企业数字化转型, 如需外网访问Rancher Web界面请在安全组添加入方向80访问规则。 |
| [csapps/j-storm.yml](./examples/csapps/j-storm.yml) | 创建一个容器服务集群并部署JStorm及其依赖Zookeeper。 |
| [csapps/jenkins.yml](./examples/csapps/jenkins.yml) | 创建容器服务集群部署不同语言的Jenkins主从。 |
| [db/memcache-instance.yml](./examples/db/memcache-instance.yml) | 阿里云资源编排示例模板： 创建一个 VPC类型 memcache 实例。 |
| [db/mongodb-instance.yml](./examples/db/mongodb-instance.yml) | 创建一个经典网络MongDB实例。 |
| [db/rds-instance.yml](./examples/db/rds-instance.yml) | 创建一个RDS实例。 |
| [db/redis-instance.yml](./examples/db/redis-instance.yml) | 阿里云资源编排示例模板：创建一台VPC网络类型的Redis实例。 |
| [elastic/aliyun-kafka-instance.yml](./examples/elastic/aliyun-kafka-instance.yml) | 使用此模板创建一台阿里云消息队列Kafka实例。 |
| [elastic/anycasteip-attach-slb-bind-ecs.yml](./examples/elastic/anycasteip-attach-slb-bind-ecs.yml) | 创建Anycast EIP，绑定新建的SLB，并将新建的ECS挂载到SLB上。 |
| [elastic/batch-of-ecs-instances.yml](./examples/elastic/batch-of-ecs-instances.yml) | 此模板支持批量创建按量付费或包年包月的ECS实例，并且支持选择已有VPC，VSW，SG或新建VPC，VSW，SG的场景。 |
| [elastic/data-disk-snapshot.yml](./examples/elastic/data-disk-snapshot.yml) | 基于快照创建新数据盘并自动挂载创建的数据盘到ECS实例。 |
| [elastic/ecs-a-record.yml](./examples/elastic/ecs-a-record.yml) | 阿里云资源编排示例模板： 创建一台ECS并将公网Ip绑定域名（记录）。 |
| [elastic/ecs-group-attach-multiple-slb.yml](./examples/elastic/ecs-group-attach-multiple-slb.yml) | 创建ECS实例组绑定SLB。 |
| [elastic/ecs-group-vpc.yml](./examples/elastic/ecs-group-vpc.yml) | 创建一个VPC、VSwitch、安全组和ECS实例。 |
| [elastic/ecs-image-disk-snapshot.yml](./examples/elastic/ecs-image-disk-snapshot.yml) | 指定镜像ID和快照创建ECS实例。 |
| [elastic/ecs-instance-group-clone.yml](./examples/elastic/ecs-instance-group-clone.yml) | 根据已有的ECS实例，克隆出一组相同配置（InstanceType、ImageId、InternetChargeType、InternetMaxBandwidthIn、InternetMaxBandwidthOut、系统盘、数据盘配置、VPC属性）的ECS实例。 用户只需指定 SourceInstanceId。 |
| [elastic/ecs-instance-group-vpc-bind-eip-by-count.yml](./examples/elastic/ecs-instance-group-vpc-bind-eip-by-count.yml) | 使用Count创建VPC类型ECS，并依次绑定EIP(新建VPC)。 |
| [elastic/ecs-instance-group-vpc.yml](./examples/elastic/ecs-instance-group-vpc.yml) | 在新创建的VPC、VSwitch和安全组下，创建一组相同配置的ECS实例。 |
| [elastic/ecs-ipv6-instance.yml](./examples/elastic/ecs-ipv6-instance.yml) | 创建一台具备IPV4/IPV6双栈的云服务器，并为云主机自动分配IPv6公网地址。 |
| [elastic/ecs-json-data-transmission.yml](./examples/elastic/ecs-json-data-transmission.yml) | 创建ECS并配置SSH key。 |
| [elastic/ecs-kubernetes-cluster.yml](./examples/elastic/ecs-kubernetes-cluster.yml) | 阿里巴巴 Cloud ROS 示例方案模板：使用ECS搭建Kubernetes集群，两个EIP分别作用于Master实例 ssh服务、6443端口服务和交换机下ECS的外网访问。此模板创建的k8s集群仅供参考，生产环境下推荐使用容器服务。 |
| [elastic/ecs-mount-multiple-uninitialized-data-disks.yml](./examples/elastic/ecs-mount-multiple-uninitialized-data-disks.yml) | 创建一个ECS，挂载多个数据盘。 |
| [elastic/ecs-multi-dynamic-ip.yml](./examples/elastic/ecs-multi-dynamic-ip.yml) | ALIYUN ROS示例模板：显示如何创建具有网络接口和多个IP地址的实例。 |
| [elastic/ecs-vpc-instance.yml](./examples/elastic/ecs-vpc-instance.yml) | 创建一个VPC网络的ECS实例。 |
| [elastic/ecs-with-2-data-disk.yml](./examples/elastic/ecs-with-2-data-disk.yml) | 创建一个ECS示例，挂载两块快照创建的数据盘。 |
| [elastic/ecs-with-java-web-enviroment.yml](./examples/elastic/ecs-with-java-web-enviroment.yml) | 创建一个ECS实例并安装JDK和Tomcat。 |
| [elastic/ecs-with-nodejs-enviroment.yml](./examples/elastic/ecs-with-nodejs-enviroment.yml) | 创建一个ECS实例，安装Node.js环境并测试。 ***警告*** 此模板仅支持 CentOS。 |
| [elastic/ecs-with-ruby-enviroment.yml](./examples/elastic/ecs-with-ruby-enviroment.yml) | 创建一个ECS实例，部署Ruby on Rails环境，并使用本地MySQL数据库进行存储。此示例从模板创建一个简单的 hello world 应用程序。 ***警告*** 此模板仅支持 CentOS-7。 当"rvm install 2.3.1"可能需要很长时间。 |
| [elastic/ecs-with-ssh-key.yml](./examples/elastic/ecs-with-ssh-key.yml) | 创建一个ECS实例，并配置SSH Key。 |
| [elastic/entire-ecs-clone.yml](./examples/elastic/entire-ecs-clone.yml) | 克隆一台ECS实例。 |
| [elastic/ess-1-slb-2-rds-2-ecs.yml](./examples/elastic/ess-1-slb-2-rds-2-ecs.yml) | 创建1个SLB、1个ESS和1个RDS，通过ESS创建2个ECS实例。将ECS实例和ESS绑定到SLB上。 |
| [elastic/existing-vpc-anycasteip-attach-slb-bind-ecs.yml](./examples/elastic/existing-vpc-anycasteip-attach-slb-bind-ecs.yml) | 创建Anycast EIP，绑定新建的SLB，并将新建的ECS挂载到SLB上。 |
| [elastic/existing-vpc-ecs-bind-eip-by-count.yml](./examples/elastic/existing-vpc-ecs-bind-eip-by-count.yml) | 使用Count创建VPC类型ECS，并依次绑定EIP(已有VPC)。 |
| [elastic/existing-vpc-kubernetes-cluster.yml](./examples/elastic/existing-vpc-kubernetes-cluster.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，使用容器服务Kubernetes版创建一个标准的 Kubernetes 专有版集群。您可以完整地创建集群管理节点和工作节点，对整个集群享有完全控制能力。 |
| [elastic/existing-vpc-one-ecs-bind-eip.yml](./examples/elastic/existing-vpc-one-ecs-bind-eip.yml) | 创建VPC类型ECS，并绑定EIP(已有VPC)。 |
| [elastic/existing-vpc-single-flink.yml](./examples/elastic/existing-vpc-single-flink.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Flink)并绑定弹性IP；Java jdk版本是1.8.0，Flink版本是1.10.2，访问UI界面需要安全组配置8081端口入规则。 |
| [elastic/existing-vpc-single-hdfs.yml](./examples/elastic/existing-vpc-single-hdfs.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Hadoop HDFS)并绑定弹性IP；Java jdk版本是1.8.0，Hadoop版本是2.7.7， 如需外网访问HDFS web界面请在安全组添加入方向50070访问规则。 |
| [elastic/existing-vpc-single-hive.yml](./examples/elastic/existing-vpc-single-hive.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Hive)并绑定弹性IP；Java jdk版本是1.8.0，Hadoop版本是2.7.7，Hive版本是2.3.7，MySQL驱动版本5.1.48。 |
| [elastic/existing-vpc-single-jenkins.yml](./examples/elastic/existing-vpc-single-jenkins.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Jenkins)并绑定弹性IP；Java jdk版本是11.0.17，Jenkins版本是2.384-1.1；需要访问Jenkins Web界面，请在已存在的安全组入方向规则添加8080端口。 |
| [elastic/existing-vpc-single-kafka.yml](./examples/elastic/existing-vpc-single-kafka.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Kafka Middleware)并绑定弹性IP；Java jdk版本是1.8.0，Scala版本是2.12，Kafka版本是0.10.2.2，数据盘路径是/home/software/，用于存储Kafka数据；默认Kafka bin目录位于/home/software/kafka/bin。 |
| [elastic/existing-vpc-single-map-reduce.yml](./examples/elastic/existing-vpc-single-map-reduce.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Hadoop MapReduce)并绑定弹性IP；Java jdk版本是1.8.0，Hadoop版本是2.7.7，如需外网访问MapReduce web界面请在安全组添加入方向8088访问规则。 |
| [elastic/existing-vpc-single-rabbitmq.yml](./examples/elastic/existing-vpc-single-rabbitmq.yml) | 在ECS主机上部署RabbitMQ（3.8.4）服务，RabbitMQ是一个开源AMQP实现的消息中间件服务，支持多种客户端连接，具备健壮、稳定、易用、跨平台、支持多种语言的特性。 |
| [elastic/existing-vpc-single-spark.yml](./examples/elastic/existing-vpc-single-spark.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Spark)并绑定弹性IP；Java jdk版本是1.8.0，Hadoop版本是2.7.7，Scala版本是2.12.1，Spark版本是2.1.0，如需外网访问管理web界面请在安全组添加入方向8088和8080访问规则。 |
| [elastic/existing-vpc-single-storm.yml](./examples/elastic/existing-vpc-single-storm.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Storm)并绑定弹性IP；Java jdk版本是1.8.0，Storm版本是2.2.0，Zookeeper版本3.6.2，访问UI界面需要安全组配置允许入方向8081端口。 |
| [elastic/existing-vpc-single-yarn.yml](./examples/elastic/existing-vpc-single-yarn.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在已有虚拟专有网络、交换机和安全组基础资源上，创建一台ECS(Hadoop YARN)并绑定弹性IP；Java jdk版本是1.8.0，Hadoop版本是2.7.7，如需外网访问YARN web界面请在安全组添加入方向8088访问规则。 |
| [elastic/existing-vpc-single-zookeeper.yml](./examples/elastic/existing-vpc-single-zookeeper.yml) | 阿里巴巴 Cloud ROS 示例方案模板：在ECS单节点主机上部署Zookeeper（3.6.2）服务，Zookeeper是一个分布式应用的协调服务，用于对分布式系统进行节点管理、leader选举、配置管理等，如需外网访问Zookeeper web界面请在安全组添加入方向9090访问规则。 |
| [elastic/hadoop-distributed-ecs-instance-group.yml](./examples/elastic/hadoop-distributed-ecs-instance-group.yml) | 部署Hadoop环境。 一台ECS实例扮演master角色，一组ECS实例扮演worker角色。 ***警告***仅在CentOS-7中进行测试。 也许需要停止防火墙。 部署时间主要取决于jdk和hadoop软件包的下载速度。 |
| [elastic/hadoop-distributed-env-3-ecs.yml](./examples/elastic/hadoop-distributed-env-3-ecs.yml) | 在3个ECS实例上部署Hadoop环境。 一个ECS实例扮演master节点的角色，另外两个实例扮演worker节点的角色。 ***警告***仅在CentOS-7中进行测试。 也许需要停止防火墙。 部署时间主要取决于jdk和hadoop软件包的下载速度。 |
| [elastic/hadoop-pseudo-distributed-env.yml](./examples/elastic/hadoop-pseudo-distributed-env.yml) | 在1个ECS实例上部署Hadoop伪分布式环境。 ECS实例扮演主从角色。 ***警告***仅在CentOS-7中进行测试。 也许需要关闭防火墙。 部署时间主要取决于JDK和hadoop软件包的下载速度。 |
| [elastic/instance-image-disk-snapshot.yml](./examples/elastic/instance-image-disk-snapshot.yml) | 指定镜像ID和磁盘快照创建ECS实例。 |
| [elastic/java-web-single-instance.yml](./examples/elastic/java-web-single-instance.yml) | 创建一台ECS实例并安装jdk和tomcat。 |
| [elastic/jdk-dns-ssh-without-password-3-ecs.yml](./examples/elastic/jdk-dns-ssh-without-password-3-ecs.yml) | 此模板创建3台ECS实例，并安装和配置Java jdk，域名解析和ssh登录而无需密码环境。该模板可以用作其他复杂模板（例如hadoop和spark）的开始。 |
| [elastic/kong-single-instance.yml](./examples/elastic/kong-single-instance.yml) | 在一个ECS实例上部署Kong栈，请默认使用国外地区，因为Kong的下载源是国外源。 ***警告*** 只支持 CentOS-7。 |
| [elastic/lamp-basic.yml](./examples/elastic/lamp-basic.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，基于Centos7系统中一键部署LAMP(Linux+Apache+MySQL+PHP)开发环境。 |
| [elastic/lnmp-basic.yml](./examples/elastic/lnmp-basic.yml) | 在1个ECS实例上部署 LNMP（Linux+Nginx+MySQL+PHP）堆栈；模板仅支持 CentOS-7。 |
| [elastic/lnmpa-basic.yml](./examples/elastic/lnmpa-basic.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，基于Centos7系统中一键部署LNMPA(Linux+Nginx+MySQL+PHP+Apache)开发环境，其中Nginx主要用于存储静态文件，而Apache处理PHP动态请求。 |
| [elastic/lnmt-basic.yml](./examples/elastic/lnmt-basic.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，基于Centos7系统中一键部署LNMT(Linux+Nginx+MySQL+Tomcat)开发环境，其中Nginx主要用于存储静态文件，而Apache处理PHP动态请求。 |
| [elastic/mount-multiple-noninit-data-disks.yml](./examples/elastic/mount-multiple-noninit-data-disks.yml) | 创建ECS和弹性IP并挂载多个数据盘。 |
| [elastic/new-vpc-ask.yml](./examples/elastic/new-vpc-ask.yml) | 创建Serverless Kubernetes集群。 |
| [elastic/new-vpc-single-kafka.yml](./examples/elastic/new-vpc-single-kafka.yml) | 阿里巴巴 Cloud ROS 示例方案模板：新建虚拟专有网络、交换机和安全组基础资源后，创建一台ECS(Kafka Middleware)并绑定弹性IP；Java jdk版本是1.8.0，Scala版本是2.12，Kafka版本是0.10.2.2，数据盘路径是/home/software/，用于存储Kafka数据；默认Kafka bin目录位于/home/software/kafka/bin。 |
| [elastic/new-vpc-single-rabbitmq.yml](./examples/elastic/new-vpc-single-rabbitmq.yml) | 在ECS主机上部署RabbitMQ（3.8.4）服务，RabbitMQ是一个开源AMQP实现的消息中间件服务，支持多种客户端连接，具备健壮、稳定、易用、跨平台、支持多种语言的特性。 |
| [elastic/nodejs-single-instance.yml](./examples/elastic/nodejs-single-instance.yml) | 该模板用于部署Node.js环境并基于新的ECS实例进行测试。***警告***，此模板仅支持CentOS。 |
| [elastic/one-ecs-attach-multiple-slb.yml](./examples/elastic/one-ecs-attach-multiple-slb.yml) | 创建ECS，加入多个SLB并在/etc/hosts中绑定IP和机器名。 |
| [elastic/rds-with-ecs-in-iplist.yml](./examples/elastic/rds-with-ecs-in-iplist.yml) | 阿里云资源编排示例模板：RDS实例+ ECS实例+内联网访问。 |
| [elastic/ruby-on-rails-single-instance.yml](./examples/elastic/ruby-on-rails-single-instance.yml) | 阿里云资源编排示例模板:使用带有本地MySQL数据库的单个ECS实例创建Ruby on Rails堆栈进行存储。该示例从模板创建了一个简单的hello world应用程序。***警告***该模板仅支持CentOS-7。'rvm 安装2.3.1'可能需要很长时间。 |
| [elastic/scaling-simple-ha-infrastructure.yml](./examples/elastic/scaling-simple-ha-infrastructure.yml) | 根据已有的ECS实例，克隆出一组相同配置（InstanceType、ImageId、InternetChargeType、InternetMaxBandwidthIn、InternetMaxBandwidthOut、系统盘、数据盘配置、VPC属性）的ECS实例。 用户需要指定 SourceInstanceId。 |
| [elastic/simple-ecs-instance.yml](./examples/elastic/simple-ecs-instance.yml) | 阿里云资源编排示例模板：一个简单的ECS实例，在VPC中具有一个安全组和一个vSwitch。 用户只需要指定图像ID。 |
| [elastic/simple-high-available-infrastructure.yml](./examples/elastic/simple-high-available-infrastructure.yml) | 用户可以创建高可用性基础架构。将创建一些ECS和一个RDS。ECS将连接到一个SLB。RDS跨越多个可用区域。所有资源都在VPC环境下。客户可以通过SLB访问此基础架构。 |
| [elastic/slb-with-2-ecs.yml](./examples/elastic/slb-with-2-ecs.yml) | 阿里云资源编排示例模板：首先创建一个SLB，然后创建2个ECS实例，最后将2个实例附加到SLB。 |
| [elastic/spark-hadoop-distributed-env-3-ecs.yml](./examples/elastic/spark-hadoop-distributed-env-3-ecs.yml) | 阿里云资源编排示例模板：此模板显示了如何在3个ECS实例上部署Hadoop-Spark环境。一个ECS实例扮演主节点的角色，另外两个实例扮演工作节点的角色。步骤1配置不带密码的ssh登录。步骤2安装并 configs Java env。步骤3安装和配置hadoop env。步骤4安装和配置Spark env。***警告***仅支持CentOS-7，也许需要停止防火墙，部署时间主要取决于下载速度4 包。 |
| [elastic/spark-hadoop-ecs-instance-group.yml](./examples/elastic/spark-hadoop-ecs-instance-group.yml) | 此模板显示了如何部署Hadoop-Spark环境。一个ECS实例扮演主角色，一个实例组扮演工作角色。步骤1配置不带密码的ssh登录。步骤2安装和配置Java环境。步骤3安装 和配置 Hadoop 环境。步骤4安装并配置Spark 环境。***警告***仅在CentOS-7中进行测试。也许需要停止防火墙。部署时间主要取决于下载4个软件包的速度。 |
| [elastic/tensorflow-deployment.yml](./examples/elastic/tensorflow-deployment.yml) | 阿里云资源编排示例模板：创建ECS实例并安装TensorFlow。 |
| [elastic/wordpress-cluster-phpmyadmin.yml](./examples/elastic/wordpress-cluster-phpmyadmin.yml) | 部署WordPress网站和phpMyAdmin应用程序。 |
| [elastic/wordpress-cluster.yml](./examples/elastic/wordpress-cluster.yml) | 创建一个WordPress集群。 |
| [elastic/wordpress-instance.yml](./examples/elastic/wordpress-instance.yml) | 创建一台ECS实例并部署WordPress。 |
| [free/multi-zone-network.yml](./examples/free/multi-zone-network.yml) | 创建多可用区网络。 |
| [free/single-role-add-policy.yml](./examples/free/single-role-add-policy.yml) | 创建一个RAM角色并添加策略。 |
| [free/single-user-with-different-policies.yml](./examples/free/single-user-with-different-policies.yml) | 创建一个属于用户组和管理员组的子帐户，启用控制台登录并创建访问密钥。 |
| [free/vpc-type-of-slb.yml](./examples/free/vpc-type-of-slb.yml) | 创建Vpc类型的Slb。 |
| [gamesupport/ecs-bind-mult-eni-and-eip.yml](./examples/gamesupport/ecs-bind-mult-eni-and-eip.yml) | 此模板主要实现创建ECS并绑定多个弹性网卡，绑定弹性网卡的个数需要由ECS的规格具体决定，每个弹性网卡支持绑定多个弹性公网IP。 |
| [iot/existing-vpc-cluster-emq.yml](./examples/iot/existing-vpc-cluster-emq.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，基于Centos7部署EMQ X服务集群，在使用ESS弹性伸缩集群时会创建EssRamRole自动授权OOS执行任务将Slave加入/移除集群，EMQ X 是一款完全开源，高度可伸缩，高可用的分布式 MQTT 消息服务器，适用于 IoT、M2M 和移动应用程序，可处理千万级别的并发客户端。 |
| [iot/existing-vpc-clusteremq.yml](./examples/iot/existing-vpc-clusteremq.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，基于Centos7部署EMQ X服务集群，在使用ESS弹性伸缩集群时会创建EssRamRole自动授权OOS执行任务将Slave加入/移除集群，EMQ X 是一款完全开源，高度可伸缩，高可用的分布式 MQTT 消息服务器，适用于 IoT、M2M 和移动应用程序，可处理千万级别的并发客户端。 |
| [iot/existing-vpc-single-emq.yml](./examples/iot/existing-vpc-single-emq.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，基于Centos7单节点部署EMQ X服务，EMQ X 是一款完全开源，高度可伸缩，高可用的分布式 MQTT 消息服务器，适用于 IoT、M2M 和移动应用程序，可处理千万级别的并发客户端。 |
| [isv/custom-image-ecs-datadisk.yml](./examples/isv/custom-image-ecs-datadisk.yml) | 单实例自定义镜像部署，带数据盘，公网IP可选（支持创建新VPC和指定VPC）。 |
| [isv/custom-image-ecs.yml](./examples/isv/custom-image-ecs.yml) | 单实例自定义镜像部署，不带数据盘，带公网IP（支持创建新VPC和指定VPC）。 |
| [isv/existing-vpc-ack.yml](./examples/isv/existing-vpc-ack.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，创建一组Kubernetes专有版集群。 |
| [isv/existing-vpc-slb-ecs-isv.yml](./examples/isv/existing-vpc-slb-ecs-isv.yml) | 使用已有VPC、VSWitch，创建1个SLB、2个ECS实例，并将所有ECS实例绑定到SLB上。 |
| [isv/existing-vpc-slb-ecs-rds-isv.yml](./examples/isv/existing-vpc-slb-ecs-rds-isv.yml) | 使用已有VPC、VSWitch，创建1个RDS、1个SLB、2个ECS实例，并将所有ECS实例绑定到SLB上。 |
| [isv/new-vpc-ack-and-jump-server.yml](./examples/isv/new-vpc-ack-and-jump-server.yml) | 新建虚拟专有网络、交换机和安全组，并创建一组Kubernetes托管版集群，并创建一台跳板机使用kubectl部署应用。 |
| [network/cen-open-isolated-networks.yml](./examples/network/cen-open-isolated-networks.yml) | 隔离VPC使用共享服务。 |
| [network/micro-vpc-architecture.yml](./examples/network/micro-vpc-architecture.yml) | 阿里云资源编排示例模板： 微业务VPC网络体系结构。创建一个VPC网络和一个子网。子网中的ECS通过公共IP访问国际网络。 |
| [network/middle-vpc-architecture.yml](./examples/network/middle-vpc-architecture.yml) | 阿里云资源编排示例模板： 中型企业VPC网络体系结构。在VPC下创建了三个子网。Front子网中的ECS和SLB处理公共网络请求。后端子网中的ECS，SLB，RDS，Redis，OSS等提供核心业务逻辑。网络访问公众 通过NatGateway的SNAT建立网络。 |
| [network/private-link-access-service.yml](./examples/network/private-link-access-service.yml) | 用私网连接（PrivateLink）服务将一个专有网络（VPC）内部署的私网SLB服务共享给同账号下的另外一个VPC访问。 |
| [network/security-vpc.yml](./examples/network/security-vpc.yml) | 安全VPC场景。 |
| [network/slb-clone.yml](./examples/network/slb-clone.yml) | 克隆一个负载均衡，并将其ECS实例挂载到新的负载均衡上。用户只需要指定源SLB ID。 |
| [network/small-vpc-architecture.yml](./examples/network/small-vpc-architecture.yml) | 阿里云资源编排示例模板: 小型业务VPC网络架构，在VPC网络部署两个子网，所有子网都通过NatGateway对外网提供服务和访问外网。 |
| [network/vpc-nat-gateway.yml](./examples/network/vpc-nat-gateway.yml) | 阿里云资源编排示例模板: 在VPC网络下创建ECS并配置NatGateway使VPC网络中的ECS可访问外网和提供服务。 |
| [network/vpc-snat-gateway.yml](./examples/network/vpc-snat-gateway.yml) | 搭建VPC环境，配置SNat Gateway，保证ECS访问公网和提供公网服务。 |
| [network/vpc-snat.yml](./examples/network/vpc-snat.yml) | 阿里云资源编排示例模板: 一键创建SNAT网关，VPC环境下创建一个绑定了EIP的ECS做为SNAT网关。 |
| [network/vpc-vswitch-route-sg-ecs.yml](./examples/network/vpc-vswitch-route-sg-ecs.yml) | 创建一个VPC、VSwitch、安全组、ECS实例、路由。用户需要指定图像 ID。 |
| [network/vpc.yml](./examples/network/vpc.yml) | 创建一个VPC实例。 |
| [network/vpcv-switch-route-sg-ecs.yml](./examples/network/vpcv-switch-route-sg-ecs.yml) | 创建一个VPC、VSwitch、安全组、ECS实例和路由。用户需要指定图像 ID。 |
| [security/centralized-logs.yml](./examples/security/centralized-logs.yml) | 创建管理操作审计、OSS、SLS的Ram角色，将审计数据保存到指定的OSS bucket中。 |
| [security/ecs-ram-role.yml](./examples/security/ecs-ram-role.yml) | 创建用于ECS实例的RAM角色。 |
| [security/existing-vpc-single-jump-server.yml](./examples/security/existing-vpc-single-jump-server.yml) | 在ECS单节点主机上部署JumpServer服务，JumpServer是一个运维安全审计系统，主要用于身份验证、账号管理、授权控制、安全审计等。如需外网访问JumpServer Web界面请在安全组添加入方向JumpServerWeb服务端口访问规则。 |
| [security/manage-vpc-vswitch-policy.yml](./examples/security/manage-vpc-vswitch-policy.yml) | 创建策略授权管理单个区域的交换机策略。 |
| [security/managed-policy.yml](./examples/security/managed-policy.yml) | 创建自定义策略。 |
| [security/ram-create-sub-account.yml](./examples/security/ram-create-sub-account.yml) | 创建子账户，启用控制台登录，并创建访问密钥。 |
| [security/stack-group-aliyun-ros-stack-group-administration-role.yml](./examples/security/stack-group-aliyun-ros-stack-group-administration-role.yml) | 配置AliyunROSStackGroupAdministrationRole以使用阿里云ROS资源栈组。 |
| [security/stack-group-aliyun-ros-stack-group-execution-role.yml](./examples/security/stack-group-aliyun-ros-stack-group-execution-role.yml) | 配置AliyunROSStackGroupExecutionRole以启用您的帐户作为阿里云ROS资源栈组中的目标帐户。 |
| [security/sub-account-pass-role.yml](./examples/security/sub-account-pass-role.yml) | 创建子账号并具备ram:PassRole权限。 |
| [stackgroup/aliyun-ros-stack-group-administration-role.yml](./examples/stackgroup/aliyun-ros-stack-group-administration-role.yml) | 配置AliyunROSStackGroupAdministrationRole以使用阿里云ROS资源栈组。 |
| [stackgroup/aliyun-ros-stack-group-execution-role.yml](./examples/stackgroup/aliyun-ros-stack-group-execution-role.yml) | 配置AliyunROSStackGroupExecutionRole以启用您的帐户作为阿里云ROS资源栈组中的目标帐户。 |
| [storage/simple-oss-bucket.yml](./examples/storage/simple-oss-bucket.yml) | 创建一个OSS Bucket。 |
| [windows/simple-windows-instance-with-exchange.yml](./examples/windows/simple-windows-instance-with-exchange.yml) | 创建一个ECS实例并安装Exchange Server 2013。 |
| [windows/simple-windows-instance-with-sharepoint.yml](./examples/windows/simple-windows-instance-with-sharepoint.yml) | 创建一个ECS实例并安装SharePoint Foundation 2013。 |
</details>

<details>
  <summary>solutions</summary>

| 模板 | 说明 |
| ---- | ---- |
| [backup-recovery/application-business-migration.yml](./solutions/backup-recovery/application-business-migration.yml) | 同地域跨可用区容灾的解决方案2.0，介绍单可用区到跨可用区的迁移及切换演练，以模拟wordpress应用服务为例，帮助客户更清晰地了解方案架构；切换演练需要手动到对应产品的控制台操作，此模版配合单可用区应用搭建完成应用业务迁移。 |
| [backup-recovery/cross-the-available-zone-disaster.yml](./solutions/backup-recovery/cross-the-available-zone-disaster.yml) | 本文介绍同城跨区域容灾演练的基本操作步骤，以云市场镜像Magento电子商务系统镜像搭建电商网站环境。 |
| [backup-recovery/cross-the-available-zone-epidemic-control.yml](./solutions/backup-recovery/cross-the-available-zone-epidemic-control.yml) | 本文介绍同城跨区域容灾演练的基本操作步骤，以快速搭建疫情护航应用基础服务为例。在建立云上稳定性保障的基础上实现了疫情护航项目部署方案。 |
| [backup-recovery/deploy-the-rds-environment.yml](./solutions/backup-recovery/deploy-the-rds-environment.yml) | 在以往的数据库异地备份方案中，往往采用本地备份压缩后上传异地的方式来做，不便于整个备份集的管理，对于历史备份数据，随着时间间隔的增大，被查询的可能性越来越低，一视同仁会浪费一定的存储资源。目标：追求经济的数据库的备份方案，低时间成本查询数据集需求。 |
| [backup-recovery/self-built-elastic-search-snapshot-saved-to-oss.yml](./solutions/backup-recovery/self-built-elastic-search-snapshot-saved-to-oss.yml) | 本文介绍如何通过快照的方式，将快照数据安全备份到阿里云OSS存储空间及如何将备份在OSS的快照仓库恢复到阿里云ElasticSearch实例。 |
| [backup-recovery/single-available-zone-building-application.yml](./solutions/backup-recovery/single-available-zone-building-application.yml) | 同地域跨可用区容灾的解决方案2.0，介绍单可用区到跨可用区的迁移及切换演练，以模拟wordpress应用服务为例，帮助客户更清晰地了解方案架构；切换演练需要手动到对应产品的控制台操作，此模版完成单可用区应用搭建。 |
| [backup-recovery/zero-loss-of-trading-system-data.yml](./solutions/backup-recovery/zero-loss-of-trading-system-data.yml) | 中小型公司交易系统数据零丢失最佳实践 - 云上环境部署。 |
| [bioscience/bcs-3rd-generation-gene-sequence-data-assembly.yml](./solutions/bioscience/bcs-3rd-generation-gene-sequence-data-assembly.yml) | 本文介绍如何基于批量计算服务提供的WDL-Canu解决方案，进行三代基因组组装的最佳实践。 |
| [cloud-market/deploy-high-availability-architecture-to-the-cloud.yml](./solutions/cloud-market/deploy-high-availability-architecture-to-the-cloud.yml) | 在两个可用区下创建多种资源并组合使用，达到高可用的通用产品上云部署的架构效果。 |
| [cloud-market/deploy-small-architecture-to-the-cloud.yml](./solutions/cloud-market/deploy-small-architecture-to-the-cloud.yml) | 在单个可用区下创建多种资源并组合使用，达到小型的通用产品上云部署的架构效果。 |
| [cloud-market/elastic-ha-architecture-to-the-cloud.yml](./solutions/cloud-market/elastic-ha-architecture-to-the-cloud.yml) | 利用弹性伸缩组和阿里自研云数据库POLARDB，在两个可用区下创建多种资源并组合使用，达到高可用并具备弹性的通用产品上云部署的架构效果。 |
| [compute-nest/compute-nest-on-premises-solution-sag.yml](./solutions/compute-nest/compute-nest-on-premises-solution-sag.yml) | 计算巢的云下服务上云能力实现，可以保证云服务商的云下服务能力上云，通过集成SAG、CCN、CEN、VPC、ECS等云产品，自动化实现云下网络同云上VPC互联，天然跟计算巢当前的虚拟互联网融合，通过终端节点的方式提供给跨VPC、跨用户访问云下服务的能力。 |
| [container-micro-service/spring-cloud-cloud-native-migration.yml](./solutions/container-micro-service/spring-cloud-cloud-native-migration.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，使用ECS和ACK托管版等资源搭建Spring Cloud的架构参考示例，方便用户在阿里云上部署和迁移Spring Cloud应用。 |
| [container-micro-service/spring-cloud-hostingack-service.yml](./solutions/container-micro-service/spring-cloud-hostingack-service.yml) | 无需改造即可迁移，应用间的调用都是原来的方式；平滑迁移，迁移成本小；kubernetes天然适合微服务框架；充分利用kubernetes的弹性，满足应用弹性扩容需求；容器化后，资源利用率获得极大提升。 |
| [data-analysis/existing-vpc-cluster-flink.yml](./solutions/data-analysis/existing-vpc-cluster-flink.yml) | 本文介绍了在已有虚拟专有网络、交换机和安全组基础资源上，创建多台ECS（Flink），其中一台绑定弹性IP作为管理节点，其他节点使用弹性伸缩进行管理；Java jdk版本是1.8.0，Flink版本是1.10.2，访问UI界面需要安全组配置8081端口入规则。 |
| [data-analysis/existing-vpc-cluster-hdfs.yml](./solutions/data-analysis/existing-vpc-cluster-hdfs.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，创建多台ECS（Hadoop HDFS），其中一台绑定弹性IP作为管理节点，其他节点使用弹性伸缩进行管理；Java jdk版本是1.8.0，Hadoop版本是2.7.7，访问管理界面需要安全组配置50070端口入规则。 |
| [data-analysis/existing-vpc-cluster-hive.yml](./solutions/data-analysis/existing-vpc-cluster-hive.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，创建多台ECS（Hive），其中一台绑定弹性IP作为管理节点，其他节点使用弹性伸缩进行管理；Java jdk版本是1.8.0，Hadoop版本是2.7.7，Scala版本是2.12.1，Spark版本是2.1.0，Hive版本是2.3.7，访问Spark管理界面需要安全组配置8080端口入规则，访问Hive管理界面需要安全组配置10001端口入规则。 |
| [data-analysis/existing-vpc-cluster-map-reduce.yml](./solutions/data-analysis/existing-vpc-cluster-map-reduce.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，创建多台ECS（Hadoop MapReduce），其中一台绑定弹性IP作为管理节点，其他节点使用弹性伸缩进行管理；Java jdk版本是1.8.0，Hadoop版本是2.7.7，访问YARN管理界面需要安全组配置8088端口入规则，访问HDFS管理界面需要安全组配置50070端口入规则。 |
| [data-analysis/existing-vpc-cluster-spark.yml](./solutions/data-analysis/existing-vpc-cluster-spark.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，创建多台ECS（Spark），其中一台绑定弹性IP作为管理节点，其他节点使用弹性伸缩进行管理；Java jdk版本是1.8.0，Hadoop版本是2.7.7，Scala版本是2.12.1，Spark版本是2.1.0，访问管理界面需要安全组配置8080端口入规则。 |
| [data-analysis/existing-vpc-cluster-storm.yml](./solutions/data-analysis/existing-vpc-cluster-storm.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，创建多台ECS（Storm），其中一台绑定弹性IP作为管理节点，其他节点使用弹性伸缩进行管理；Java jdk版本是1.8.0，Storm版本是2.2.0，Zookeeper版本3.6.2，访问UI界面需要安全组配置允许入方向8081端口。 |
| [data-analysis/existing-vpc-cluster-yarn.yml](./solutions/data-analysis/existing-vpc-cluster-yarn.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，创建多台ECS（Hadoop YARN），其中一台绑定弹性IP作为管理节点，其他节点使用弹性伸缩进行管理；Java jdk版本是1.8.0，Hadoop版本是2.7.7，访问YARN管理界面需要安全组配置8088端口入规则，访问HDFS管理界面需要安全组配置50070端口入规则。 |
| [data-analysis/low-cost-offline-big-data-analysis-emr.yml](./solutions/data-analysis/low-cost-offline-big-data-analysis-emr.yml) | 本方案利用ROS创建EMR以及日志服务LOG、对象存储OSS等产品资源，结合手动操作电商网站日志埋点采集存储投递并利用EMR进行日志消费分析，来展示构建弹性低成本的离线海量日志大数据分析的最佳实践。 |
| [data-analysis/low-cost-offline-big-data-analysis.yml](./solutions/data-analysis/low-cost-offline-big-data-analysis.yml) | 本模板可以帮助用户搭建以抢占式ECS实例及对象存储为基础的云上离线大数据分析系统平台，并提供完整的demo演示，可供客户以及一线业务架构师进行PoC测试验证。 |
| [data-analysis/sls-multi-cloud-log-processing-analysis.yml](./solutions/data-analysis/sls-multi-cloud-log-processing-analysis.yml) | 从第三方云平台或线下IDC服务器上采集日志写入到阿里云日志服务，通过日志服务进行数据分析，帮助提升运维、运营效率，建立 DT 时代海量日志处理能力。 |
| [data-migration/low-cost-link-to-business-data.yml](./solutions/data-migration/low-cost-link-to-business-data.yml) | 本实践适用于提供业务数据搬迁上云服务。业务数据量一般都比较大，迁移上云需要大量的网络带宽，BGP费用比较高。 阿里云对用户开放所需地域购买静态单线共享带宽包的权限（移动/联通/电信均可），可用为迁移数据有效降低成本。 |
| [data-migration/self-built-hive-data-warehouse-migrated-to-emr.yml](./solutions/data-migration/self-built-hive-data-warehouse-migrated-to-emr.yml) | 本方案利用ROS创建自建Hadoop集群的数据迁移到阿里云自建Hadoop或者EMR。 |
| [database/polardb-migration-from-rds.yml](./solutions/database/polardb-migration-from-rds.yml) | 解决RDS MySQL或自建MySQL遇到的性能或容量瓶颈，迁移上下PolarDB链路打通。 |
| [devops/container-application-devops-for-ack-cluster.yml](./solutions/devops/container-application-devops-for-ack-cluster.yml) | DevOps的目的是构建一种文化和环境，使构建，测试，发布软件更加快捷，频繁和可靠。而到了容器时代，需要部署的机器不但量更大，变化更剧烈，有的甚至需要根据条件自动升缩，为了满足企业敏捷的需求，持续部署也成了必须，本方案使用云效完成容器应用（小程序后端服务）的自动化构建和持续部署。 |
| [enterprise-on-cloud/create-ddh-and-deploy-cloud-server.yml](./solutions/enterprise-on-cloud/create-ddh-and-deploy-cloud-server.yml) | 介绍本地部署或托管在IDC环境的 VMware系统迁移上云至独立宿主机（DDH）的最佳实践。使用DDH在云端构建由独享物理服务器组成的资源池，同时配合ECS成熟稳定的虚拟化技术体系，充分利用云上资源弹性、按使用付费的优势，快速构建高性能、高可靠和可快速动态伸缩的虚拟化系统，满足安全、合规、自定义部署、自带许可证（BYOL）等企业级需求；此模板完成创建DDH并部署云服务器。 |
| [enterprise-on-cloud/e-commerce-business-and-db-on-the-cloud.yml](./solutions/enterprise-on-cloud/e-commerce-business-and-db-on-the-cloud.yml) | 此模板可创建出电商资源建站和数据库迁移方案所需资源，属于企业上云的最佳实践之一。 |
| [enterprise-on-cloud/games-or-retail-single-db-single-service.yml](./solutions/enterprise-on-cloud/games-or-retail-single-db-single-service.yml) | 在创业型公司或阿米巴模式经营的公司，新项目发布初期存在较大的不确定性，既要考虑项目未来的扩展性，又要衡量项目的运营成本。本解决方案为客户提供低成本，敏捷快捷的最佳实践。适用典型行业：游戏、零售等行业。 |
| [enterprise-on-cloud/image-storage-and-tool-env.yml](./solutions/enterprise-on-cloud/image-storage-and-tool-env.yml) | 介绍本地部署或托管在IDC环境的 VMware系统迁移上云至独立宿主机（DDH）的最佳实践。使用DDH在云端构建由独享物理服务器组成的资源池，同时配合ECS成熟稳定的虚拟化技术体系，充分利用云上资源弹性、按使用付费的优势，快速构建高性能、高可靠和可快速动态伸缩的虚拟化系统，满足安全、合规、自定义部署、自带许可证（BYOL）等企业级需求；此模板完成镜像存储及工具环境的搭建。 |
| [enterprise-on-cloud/internet-industry-high-elastic-system-construction.yml](./solutions/enterprise-on-cloud/internet-industry-high-elastic-system-construction.yml) | 本方案通过ESS和POLARDB实现应用和数据库两个层面的弹性，通过REDIS和SLB实现跨可用区的自动容灾，构建出可用性高，弹性收缩用户感知小的互联网行业高可用系统。 |
| [enterprise-on-cloud/kingdee-windows-server-on-cloud.yml](./solutions/enterprise-on-cloud/kingdee-windows-server-on-cloud.yml) | 单节点实例在新建专有网络模式下部署金蝶云星空7.5企业版应用，使用者需要单独提供金蝶云星空许可、SQLServer许可。 |
| [enterprise-on-cloud/move-server-using-custom-mirror.yml](./solutions/enterprise-on-cloud/move-server-using-custom-mirror.yml) | 适用需要迁移服务器到阿里云ECS，支持迁移主流Windows和Linux操作系统。包括P2V（Physical to Virtual）代表从物理 IDC 环境迁移到ECS，和V2V（Virtual to Virtual）代表从虚拟机环境或者云平台主机迁移到ECS；此模板配合搭建带有迁云工具的服务器模板完成服务器搬迁。 |
| [enterprise-on-cloud/move-server-with-migration-tool.yml](./solutions/enterprise-on-cloud/move-server-with-migration-tool.yml) | 适用需要迁移服务器到阿里云ECS，支持迁移主流Windows和Linux操作系统。包括P2V（Physical to Virtual）代表从物理 IDC 环境迁移到ECS，和V2V（Virtual to Virtual）代表从虚拟机环境或者云平台主机迁移到ECS；此模板搭建带有迁云工具的服务器。 |
| [enterprise-on-cloud/single-website-on-cloud-cloud-architecture.yml](./solutions/enterprise-on-cloud/single-website-on-cloud-cloud-architecture.yml) | 对于云上大量中小客户，上云后，由原来的单机服务进行基本的云化部署架构升级，解决弹性伸缩需求的场景。此模板配合单机服务器部署完成单机网站上云架构云化。 |
| [enterprise-on-cloud/single-website-on-cloud-stand-alone-server.yml](./solutions/enterprise-on-cloud/single-website-on-cloud-stand-alone-server.yml) | 对于云上大量中小客户，上云后，由原来的单机服务进行基本的云化部署架构升级，解决弹性伸缩需求的场景。此模板完成单机服务器部署。 |
| [enterprise-on-cloud/single-website-on-cloud-stand-one-click.yml](./solutions/enterprise-on-cloud/single-website-on-cloud-stand-one-click.yml) | 自动创建一个互联网云化架构的资源栈，包括VPC/私网SLB/EIP/2台ECS/RDS，ECS上部署免费WordPress镜像。部署完后，可以直接使用输出的EIP地址来访问WordPress网站。 |
| [enterprise-on-cloud/vmware-on-elastic-bare-metal-server.yml](./solutions/enterprise-on-cloud/vmware-on-elastic-bare-metal-server.yml) | 本文介绍将传统企业VMware迁移到阿里云弹性裸金属，利用云计算平台提供的弹性基础设施，实现线下业务平滑迁移上云。 |
| [high-performance-computing/ehpc-industrial-simulation.yml](./solutions/high-performance-computing/ehpc-industrial-simulation.yml) | 本实践适用于使用弹性高性能计算EHPC+对象存储OSS运行仿真软件进行模型仿真的场景中，这里运行的是LAMMPS这款开源的仿真软件，数据通过OSS上传。 |
| [internet-network/enterprise-app-hotel-network.yml](./solutions/internet-network/enterprise-app-hotel-network.yml) | 酒店上云是分阶段实施，线下和云上的混合云是长期状态，需要保证线下多地域多分支、云上多地域之间互相访问，且需要满足不同类型的企业节点的服务要求，比如总部IDC要求带宽大，对安全可靠性要求高等。 |
| [internet-network/global-deployment-network-build-global-network.yml](./solutions/internet-network/global-deployment-network-build-global-network.yml) | 在线教育的教师大部分和学员不在相同区域，设置不在同一个国家。例如场景的英语类在线教育，教师在北美，学员分布在国内各地区；此模板配合搭建单个地域的资源环境模板完成全球部署网络规划。 |
| [internet-network/global-deployment-network-deploy-single-env.yml](./solutions/internet-network/global-deployment-network-deploy-single-env.yml) | 在线教育的教师大部分和学员不在相同区域，设置不在同一个国家。例如场景的英语类在线教育，教师在北美，学员分布在国内各地区；此模板完成搭建单个地域的资源环境。 |
| [internet-network/landing-zone-cen-ack.yml](./solutions/internet-network/landing-zone-cen-ack.yml) | 进行跨账号同地域容器集群通过转发路由器组网，验证两个集群内Pod连通性。 |
| [internet-network/landing-zone-cen-privatelink.yml](./solutions/internet-network/landing-zone-cen-privatelink.yml) | 在账号1与在账号2之间通过创建终端节点服务并建立终端节点连接实现账号1与在账号2之间网络访问。 |
| [internet-network/landing-zone-cen-tr-peer.yml](./solutions/internet-network/landing-zone-cen-tr-peer.yml) | 在账号1内创建VPC1、VPC2，在账号2内创建VPC3、VPC4，其中VPC2和VPC4之间配置对等连接，从而降低跨VPC互联的流量费用，而其他VPC间借助转发路由器进行组网，能够降低网络管理的复杂度。 |
| [internet-network/landing-zone-cen-tr.yml](./solutions/internet-network/landing-zone-cen-tr.yml) | 在账号1及账号2内使用CEN及TR进行跨地域网络互通，账号2数据互通VPC加入两个账号CEN实现双网络互通。 |
| [internet-network/multi-avaiable-areas-building-services.yml](./solutions/internet-network/multi-avaiable-areas-building-services.yml) | 适用于有本地IDC，需要搭建具有高稳定性业务架构的多地域多可用区混合云的用户。物理专线是打通IDC到云上内网通道的最高效稳定的方式。此模板完成多可用区单地域搭建服务。 |
| [internet-network/multi-region-multi-area-network-interworking.yml](./solutions/internet-network/multi-region-multi-area-network-interworking.yml) | 适用于有本地IDC，需要搭建具有高稳定性业务架构的多地域多可用区混合云的用户。物理专线是打通IDC到云上内网通道的最高效稳定的方式。此模板可配合多可用区单地域搭建服务完成组建多可用区多地域的混合云。 |
| [machine-learning-ai/hybrid-cloud-uses-ali-ai-acceleration-tools.yml](./solutions/machine-learning-ai/hybrid-cloud-uses-ali-ai-acceleration-tools.yml) | 本文介绍了混合云场景中，自建Kubernetes服务，线下集群+云上弹性扩展阿里云GPU服务实例+飞天AI加速工具，并采用阿里云CPFS存储，运行AI训练+AI推理作业的操作步骤。 |
| [media-service/fpga-cloud-servers.yml](./solutions/media-service/fpga-cloud-servers.yml) | 解决提供高画质低码率的实施转码技术方案、提高图片和视频转码效率及降低传输带宽、转码和存储成本。 |
| [middleware/existing-vpc-cluster-kafka.yml](./solutions/middleware/existing-vpc-cluster-kafka.yml) | 在现有的VPC、VSwitch和安全组下,创建多台ECS（Kafka Middleware），其中一台绑定弹性IP作为管理节点，其他节点使用弹性伸缩进行管理，其中Java jdk版本采用1.8.0，Scala版本采用2.12，Kafka版本采用0.10.2.2；应用数据存放至挂载的数据盘（数据盘挂载目录：/home/software，Kafka bin目录：/home/software/kafka/bin）；如需访问Kafka Manager管理界面，在已有的安全组下添加访问规则入方向TCP 9000端口。 |
| [middleware/existing-vpc-cluster-rabbitmq.yml](./solutions/middleware/existing-vpc-cluster-rabbitmq.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，利用ECS主机组部署RabbitMQ（3.8.4）镜像集群，并使用SLB令集群达到负载均衡高可用的模式，在使用ESS弹性伸缩集群时会创建EssRamRole自动授权OOS执行任务将Slave加入/移除集群，RabbitMQ是一个开源AMQP实现的消息中间件服务，支持多种客户端连接，具备健壮、稳定、易用、跨平台、支持多种语言的特性，如需访问RabbitMQ管理界面，在已有的安全组下添加访问规则入方向TCP 15672端口；如客户端需使用RabbitMQ中间件时，在已有的安全组下添加访问规则入方向TCP 5672端口。 |
| [middleware/existing-vpc-cluster-zookeeper.yml](./solutions/middleware/existing-vpc-cluster-zookeeper.yml) | 在已有虚拟专有网络、交换机和安全组基础资源上，利用ECS主机组部署Zookeeper（3.6.2）集群，使用ESS弹性伸缩集群会创建EssRamRole自动授权OOS执行任务将弹性组节点加入/移除集群, Zookeeper是一个分布式应用的协调服务，用于对分布式系统进行节点管理、leader选举、配置管理等。 |
| [middleware/spring-cloud-netflix-migrate-edas.yml](./solutions/middleware/spring-cloud-netflix-migrate-edas.yml) | 无需改造即可迁移，应用间的调用都是原来的方式；平滑迁移，迁移成本小；kubernetes天然适合微服务框架；充分利用kubernetes的弹性，满足应用弹性扩容需求；容器化后，资源利用率获得极大提升。 |
| [mini-program/fc-mini-program-backend-service.yml](./solutions/mini-program/fc-mini-program-backend-service.yml) | 使用Severless无服务器架构搭建移动App、小程序和Web应用的后端服务，静态资源（如图片）存在OSS上通过CDN加速访问，动态数据通过API网关加函数计算访问RDS数据库，无需管理服务器和运行环境，弹性伸缩使用云资源。 |
| [security-rule/business-security-for-e-commerce-sites.yml](./solutions/security-rule/business-security-for-e-commerce-sites.yml) | 本实践为云上客户提供完整的电商网站运营期间的防护方案，包括用户注册、业务运营活动等场景。保障业务运维活动系统稳定运行、防止“薅羊毛”、运营优惠给到真实的客户。 |
| [security-rule/ram-account-rights-management.yml](./solutions/security-rule/ram-account-rights-management.yml) | 单账号体系下用户管理、资源分组、权限配置、访问控制的治理方法及原则。以某电商网站项目为例，根据研发、测试、生产环境划分及业务流程，使用阿里云RAM访问控制服务规划实现资源分组、账号用户体系、权限分配、安全加固、定期安全检查等措施的最佳实践。 |
| [serviceless-compute/fc-web-file-backend-service.yml](./solutions/serviceless-compute/fc-web-file-backend-service.yml) | 使用Severless无服务器架构搭建Web网站文件处理服务，用户通过API、SDK或阿里云控制台上传或更新文件到指定OSS存储空间后，可自动实现文件压缩、文件解压、获取文件md5、获取文件元信息等功能。 |
| [studio-entertainment/game-business-zone-service-env.yml](./solutions/studio-entertainment/game-business-zone-service-env.yml) | 为了提升玩家游戏体验，并提高留存率、增强付费率，除了游戏本身的内容趣味性，改善用户访问加速体验，并对游戏数据分区合服是很常见的业务运营模式。 |
| [studio-entertainment/light-weight-gpu-deployed-cloud-games.yml](./solutions/studio-entertainment/light-weight-gpu-deployed-cloud-games.yml) | 随着AI深度学习，视频处理，科学计算以及图形可视化等应用场景的普及，GPU的市场需求越来越大。但单颗物理GPU起步至超大规模弹性计算带来的计算能力过剩成本上升问题也越来越明显。轻量级GPU的诞生打破了传统直通模式的局限，可以提供比单颗物理GPU更细粒度的服务，从而让客户以更低成本、更高弹性开展业务。 |
</details>

<details>
  <summary>documents</summary>
  <details>
    <summary>help</summary>

- ecs

| 模板                                                 | 说明                                                                                     |
| ---------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| [lnmp-centos7.yml](./documents/help/ecs/lnmp-centos7.yml) | 在 ECS 实例（CentOS 7）上搭建 LNMP 环境，其中 LNMP 分别代表 Linux、Nginx、MySQL 和 PHP。 |
| [ftp-centos7.yml](./documents/help/ecs/ftp-centos7.yml) | 使用Centos7系统创建ECS实例安装部署FTP服务。 |

- ack
  
| 模板                                                  | 说明                                                                     |
|------------------------------------------------------|----------------------------------------------------------------------|
| [ack-cube-game.yml](./documents/help/ack/ack-cube-game.yml) | 使用ACK部署魔方游戏。 |


- alb

| 模板                                                                                                                 | 说明                 |
|--------------------------------------------------------------------------------------------------------------------|--------------------|
| [alb-create-ipv4-load-balancer-and-dnsrecord.yml](./documents/help/alb/alb-create-ipv4-load-balancer-and-dnsrecord.yml) | 快速实现IPv4服务的负载均衡。 |

- rds

| 模板                                                                                                                 | 说明                      |
|--------------------------------------------------------------------------------------------------------------------|-------------------------|
| [rds-create-instance-database-and-connection.yml](./documents/help/rds/rds-create-instance-database-and-connection.yml) | 快速创建RDS MySQL实例并进行基本设置。|

- oss

| 模板                                                                                                                                                               | 说明                          |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------| --------------- |
| [add-signatures-on-server-configure-upload-callback.yml](./documents/help/oss/add-signatures-on-server-configure-upload-callback.yml)                                 | 在服务端通过Java代码完成签名，并且设置上传回调，然后通过表单直传数据到OSS。 |
| [add-signatures-on-the-client-by-using-JS-and-upload-data.yml](./documents/help/oss/add-signatures-on-the-client-by-using-JS-and-upload-data.yml)                     | 基于POST Policy的使用规则在客户端通过JavaScript代码完成签名，然后通过表单直传数据到OSS。 |
| [obtain-signature-information-from-the-server-and-upload-data-to-oss.yml](documents/help/oss/obtain-signature-information-from-the-server-and-upload-data-to-oss.yml) | 从服务器获取签名信息并上传数据到OSS。|
| [mobile-application-direct-transmission-service.yaml](./documents/help/oss/mobile-application-direct-transmission-service.yaml)                                       | 开通STS服务并配置应用服务器，通过输出的服务器地址可以获取临时的Token。|
| [cdn-speeds-up-oss-access.yaml](./documents/help/oss/cdn-speeds-up-oss-access.yaml)                                                                                   | 使用CDN添加域名并解析域名，实现加速OSS的访问。 |

   </details>

- trial

| 模板                                                                                                                               | 说明                                                                                         |
| ---------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| [alb-7-layer-load-balancing.yml](./documents/trial/alb-7-layer-load-balancing.yml)                                                 | 实现 IPv4 服务的七层负载均衡。 \| [教程](https://help.aliyun.com/document_detail/612746.htm) |
| [clb-4-layer-load-balancing.yml](./documents/trial/clb-4-layer-load-balancing.yml)                                                 | 四层 CLB 负载均衡。 \| [教程](https://help.aliyun.com/document_detail/612746.htm)            |
| [clb-7-layer-load-balancing.yml](./documents/trial/clb-7-layer-load-balancing.yml)                                                 | 七层 CLB 负载均衡。 \| [教程](https://help.aliyun.com/document_detail/611014.htm)            |
| [nlb-4-layer-load-balancing.yml](./documents/trial/nlb-4-layer-load-balancing.yml)                                                 | 实现 IPv4 服务的四层负载均衡。 \| [教程](https://help.aliyun.com/document_detail/611685.htm) |
| [ecs-blog.yml](./documents/trial/ecs-blog.yml)                                                                                     | 搭建云上博客。                                                                               |
| [ecs-lamp.yml](./documents/trial/ecs-lamp.yml)                                                                                     | 部署 LAMP 环境。                                                                             |
| [ecs-lnmp.yml](./documents/trial/ecs-lnmp.yml)                                                                                     | 部署 LNMP 环境。 \| [教程](https://help.aliyun.com/document_detail/611922.htm)               |
| [ecs-mount-nas-file-system.yml](./documents/trial/ecs-mount-nas-file-system.yml)                                                   | NAS 挂载到 ECS。                                                                             |
| [ecs-online-education-video-course-sharing-website.yml](./documents/trial/ecs-online-education-video-course-sharing-website.yml)   | 搭建在线教育视频课程分享网站。                                                               |
| [ecs-website.yml](./documents/trial/ecs-website.yml)                                                                               | 快速搭建网站。 \| [教程](https://help.aliyun.com/document_detail/611918.htm)                 |
| [edas-deploy-Java-application-based-on-ecs-cluster.yml](./documents/trial/edas-deploy-Java-application-based-on-ecs-cluster.yml)                                                                               | 在EDAS中基于ECS集群部署Java微服务应用。 \| [教程](https://help.aliyun.com/document_detail/615356.html)                 |
| [ga-accelerated-access-to-specified-ip.yml](./documents/trial/ga-accelerated-access-to-specified-ip.yml)                           | 加速访问指定 IP 的后端服务。                                                                 |
| [nlpautoml-create-and-train-sentiment-analysis-model.yml](./documents/trial/nlpautoml-create-and-train-sentiment-analysis-model.yml)                           | 基于NLP自学习平台创建并训练情感分析模型。                                                                 |
| [oos-timing-management-of-ecs.yml](./documents/trial/oos-timing-management-of-ecs.yml)                                             | OOS 实现 ECS 的定时管理。                                                                    |
| [polardb-mysql-htap-real-time-data-analysis.yml](./documents/trial/polardb-mysql-htap-real-time-data-analysis.yml)                 | PolarDB MySQL HTAP 实时数据分析。                                                            |
| [polardb-postgresql-compatible-with-PG.yml](./documents/trial/polardb-postgresql-compatible-with-PG.yml)                                             | 云原生数据库PolarDB PostgreSQL版试用教程。                                                                  |
| [polardb-postgresql-compatible-with-oracle.yml](./documents/trial/polardb-postgresql-compatible-with-oracle.yml)                                             | 云原生数据库PolarDB PostgreSQL（兼容Oracle）版试用教程。                                                                  |
| [polardb-postgresql-enterprise-performance-practice.yml](./documents/trial/polardb-postgresql-enterprise-performance-practice.yml) | PolarDB PostgreSQL 企业级性能实践。                                                          |
| [polardb-x-best-practice.yml](./documents/trial/polardb-x-best-practice.yml)                                             | 云原生数据库PolarDB分布式版企业版试用教程 |
| [ram-create-user-and-authorize.yml](./documents/trial/ram-create-user-and-authorize.yml)                                           | 创建 RAM 用户并授权。                                                                        |
| [rds-create-account-database-and-connection.yml](./documents/trial/rds-create-account-database-and-connection.yml)                 | 创建连接 RDS 数据库并进行读写操作。                                                          |
| [rds-quickly-use-rds-mysql-serverless-instance.yml](./documents/trial/rds-quickly-use-rds-mysql-serverless-instance.yml)           | 快速使用RDS MySQL Serverless实例 。                                                       |
| [redis-game-player-leaderboard.yml](./documents/trial/redis-game-player-leaderboard.yml)                                           | Redis 游戏玩家排行榜。                                                                       |
| [sls-collect-logs-in-nginx-mode.yml](./documents/trial/sls-collect-logs-in-nginx-mode.yml)                                         | 通过日志服务SLS快速采集Nginx日志。                                                           |
| [tair-restores-data-through-data-flashback.yml](./documents/trial/tair-restores-data-through-data-flashback.yml)                   | Tair 通过数据闪回恢复数据。                                                                  |

</details>

<details>
  <summary>compute-nest-best-practice</summary>

| 模板                                                                                                    | 说明                            |
| ------------------------------------------------------------------------------------------------------- |-------------------------------|
| [ack-app-rds](./compute-nest-best-practice/ack-app-rds/README.md)                                       | 创建容器应用和 RDS。                   |
| [ack-nginx](./compute-nest-best-practice/ack-nginx/README.md)                                           | 创建 ACK 并部署 Nginx。              |
| [ecs-adbpg](./compute-nest-best-practice/ecs-adbpg/README.md)                                           | 创建 ECS 和 ADBPG 实例。             |
| [ecs-deploy](./compute-nest-best-practice/ecs-deploy/README.md)                                         | 基于 ECS 实例的部署。                  |
| [ecs-mongodb](./compute-nest-best-practice/ecs-mongodb/README.md)                                       | 创建 ECS 和 MongoDB 实例。           |
| [ecs-mysql-deploy](./compute-nest-best-practice/ecs-mysql-deploy/README.md)                             | 新建 ECS 实例并创建 MySQL。            |
| [ecs-polardb](./compute-nest-best-practice/ecs-polardb/README.md)                                       | 创建 ECS 和 PolarDB 实例。           |
| [ecs-postgresql](./compute-nest-best-practice/ecs-postgresql/README.md)                                 | 创建 ECS 和 PostgreSQL 实例。        |
| [ecs-ramrole-oss](./compute-nest-best-practice/ecs-ramrole-oss/README.md)                               | 创建 ECS 实例、RAM Role 和 OSS。      |
| [ecs-rds](./compute-nest-best-practice/ecs-rds/README.md)                                               | 创建 ECS 和 RDS 实例。               |
| [ecs-redis](./compute-nest-best-practice/ecs-redis/README.md)                                           | 创建 ECS 和 Redis 实例。             |
| [ecs-slb](./compute-nest-best-practice/ecs-slb/README.md)                                               | 创建 ECS 和 SLB 实例。               |
| [ecs-sqlserver](./compute-nest-best-practice/ecs-sqlserver/README.md)                                   | 创建 ECS 和 SQL Server 实例。        |
| [ehpc-demo](./compute-nest-best-practice/ehpc-demo/README.md)                                           | 创建弹性高性能计算集群。                   |
| [existing-ecs-nginx](./compute-nest-best-practice/existing-ecs-nginx/README.md)                         | 在已有 ECS 实例上部署 Nginx。           |
| [fc](./compute-nest-best-practice/fc/README.md)                                                         | 部署一个NAS+OSS UI文件管理系统(Kodbox)到阿里云函数计算。 |
| [managed-reverse-vpc-connection](./compute-nest-best-practice/managed-reverse-vpc-connection/README.md) | 全托管服务私网反向访问的最佳实践。              |
| [master-slave-ecs](./compute-nest-best-practice/master-slave-ecs/README.md)                             | 创建 Master-Slave 架构的 ECS 实例。    |
| [opensource](./compute-nest-best-practice/opensource)                                                   | 部署各类开源软件的最佳实践。                 |
| [pai/pai-dsw.yml](./compute-nest-best-practice/pai/pai-dsw.yml)                                         | 创建 PAI。                        |
| [scaling-ecs](./compute-nest-best-practice/scaling-ecs/README.md)                                       | 创建一组带有伸缩组的 ECS 架构。             |
| [terraform-ecs-nginx](./compute-nest-best-practice/terraform-ecs-nginx/README.md)                       | [Terraform] 创建 ECS 实例并部署 Nginx。 |

</details>
