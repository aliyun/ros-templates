# [Click here for English Version](#english)

# ROS Templates
本仓库包含了编写 ROS 模板的示例和最佳实践。

欢迎体验 [ROS控制台](https://ros.console.aliyun.com)，阅读 [ROS帮助文档](https://help.aliyun.com/product/28850.html) 以了解更多细节。

## Examples
### Application
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ECSCloneJoinSLS | 创建一组ECS，并将其作为指定的SLS中相关project的logtail的机器组。 | [YAML](Examples/Application/YAML/ECSCloneJoinSLS.yml) [JSON](Examples/Application/JSON/ECSCloneJoinSLS.json) |
| 2 | ECSGroupJoinSLS | 克隆ECS并将IP指向日志服务中新创建的机器组，并应用指定的规则。 | [YAML](Examples/Application/YAML/ECSGroupJoinSLS.yml) [JSON](Examples/Application/JSON/ECSGroupJoinSLS.json) |

### CsApps
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | DockerDatacneterEnterprise | 基于Docker EE一键部署 DDC。 | [YAML](Examples/CsApps/YAML/DockerDatacneterEnterprise.yml) [JSON](Examples/CsApps/JSON/DockerDatacneterEnterprise.json) |
| 2 | DockerSwarm | 一键创建Docker Swarm模式集群。 | [YAML](Examples/CsApps/YAML/DockerSwarm.yml) [JSON](Examples/CsApps/JSON/DockerSwarm.json) |
| 3 | JStorm | 创建JStorm容器服务集群。JStorm依赖的Zookeeper也会一并部署。 | [YAML](Examples/CsApps/YAML/JStorm.yml) [JSON](Examples/CsApps/JSON/JStorm.json) |
| 4 | Jenkins | 创建Jenkins容器服务集群。 | [YAML](Examples/CsApps/YAML/Jenkins.yml) [JSON](Examples/CsApps/JSON/Jenkins.json) |

### DB
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | MemcacheInstance | 创建一个云数据库Memcache版实例。 | [YAML](Examples/DB/YAML/MemcacheInstance.yml) [JSON](Examples/DB/JSON/MemcacheInstance.json) |
| 2 | MongoDBInstance | 创建一个云数据库MongoDB版实例。 | [YAML](Examples/DB/YAML/MongoDBInstance.yml) [JSON](Examples/DB/JSON/MongoDBInstance.json) |
| 3 | RDSInstance | 创建一个云数据库RDS版实例。 | [YAML](Examples/DB/YAML/RDSInstance.yml) [JSON](Examples/DB/JSON/RDSInstance.json) |
| 4 | RedisInstance | 创建一个云数据库Redis版实例。 | [YAML](Examples/DB/YAML/RedisInstance.yml) [JSON](Examples/DB/JSON/RedisInstance.json) |

### Elastic
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ECSGroupAttachMultipleSLB | 创建ECS，在/etc/hosts中绑定IP和机器名，并把ECS加入多个SLB。 | [YAML](Examples/Elastic/YAML/ECSGroupAttachMultipleSLB.yml) [JSON](Examples/Elastic/JSON/ECSGroupAttachMultipleSLB.json) |
| 2 | ECSGroupClassic | 创建一组相同配置的ECS实例，采用经典网络，同属一个安全组。 | [YAML](Examples/Elastic/YAML/ECSGroupClassic.yml) [JSON](Examples/Elastic/JSON/ECSGroupClassic.json) |
| 3 | ECSGroupClone | 根据已有的ECS实例，克隆出相同配置的一组ECS实例。 | [YAML](Examples/Elastic/YAML/ECSGroupClone.yml) [JSON](Examples/Elastic/JSON/ECSGroupClone.json) |
| 4 | ECSGroupVPC | 创建一组相同配置的ecs实例，同属一个VPC和安全组。 | [YAML](Examples/Elastic/YAML/ECSGroupVPC.yml) [JSON](Examples/Elastic/JSON/ECSGroupVPC.json) |
| 5 | ECSImageDiskSnapshot | 指定镜像、磁盘快照创建ECS实例。 | [YAML](Examples/Elastic/YAML/ECSImageDiskSnapshot.yml) [JSON](Examples/Elastic/JSON/ECSImageDiskSnapshot.json) |
| 6 | ECSMountMultipleUninitializedDataDisks | 在VPC环境中创建ECS，申请弹性IP，并分区，格式化，挂载多个数据盘。 | [YAML](Examples/Elastic/YAML/ECSMountMultipleUninitializedDataDisks.yml) [JSON](Examples/Elastic/JSON/ECSMountMultipleUninitializedDataDisks.json) |
| 7 | ECSVPCInstance | 创建VPC网络下的ECS实例。 | [YAML](Examples/Elastic/YAML/ECSVPCInstance.yml) [JSON](Examples/Elastic/JSON/ECSVPCInstance.json) |
| 8 | ECSWith2DataDisk | 创建一个ECS实例，挂载两个快照数据盘。 | [YAML](Examples/Elastic/YAML/ECSWith2DataDisk.yml) [JSON](Examples/Elastic/JSON/ECSWith2DataDisk.json) |
| 9 | ECSWithJavaWebEnviroment | 部署Java Web开发测试环境。 | [YAML](Examples/Elastic/YAML/ECSWithJavaWebEnviroment.yml) [JSON](Examples/Elastic/JSON/ECSWithJavaWebEnviroment.json) |
| 10 | ECSWithNodejsEnviroment | 部署Node.js开发测试环境。 | [YAML](Examples/Elastic/YAML/ECSWithNodejsEnviroment.yml) [JSON](Examples/Elastic/JSON/ECSWithNodejsEnviroment.json) |
| 11 | ECSWithRubyEnviroment | 基于一个ECS实例和本地MySQL部署Rails on Ruby。 | [YAML](Examples/Elastic/YAML/ECSWithRubyEnviroment.yml) [JSON](Examples/Elastic/JSON/ECSWithRubyEnviroment.json) |
| 12 | ECSWithSSHKey | 创建一个ECS实例，并配置SSH Key。 | [YAML](Examples/Elastic/YAML/ECSWithSSHKey.yml) [JSON](Examples/Elastic/JSON/ECSWithSSHKey.json) |
| 13 | ESS1SLB2RDS2ECS | 创建一个ESS实例，其下挂载一个SLB实例、两个RDS实例。SLB实例下挂两个ECS实例。 | [YAML](Examples/Elastic/YAML/ESS1SLB2RDS2ECS.yml) [JSON](Examples/Elastic/JSON/ESS1SLB2RDS2ECS.json) |
| 14 | EntireECSClone | 完全克隆一台ECS实例，包括源ECS中的数据。 | [YAML](Examples/Elastic/YAML/EntireECSClone.yml) [JSON](Examples/Elastic/JSON/EntireECSClone.json) |
| 15 | HadoopDistributedEnv3ECS | 部署Hadoop分布式开发环境。 | [YAML](Examples/Elastic/YAML/HadoopDistributedEnv3ECS.yml) [JSON](Examples/Elastic/JSON/HadoopDistributedEnv3ECS.json) |
| 16 | HadoopDistributedecsgroup | 基于ECS Group部署Hadoop分布式环境。 | [YAML](Examples/Elastic/YAML/HadoopDistributedecsgroup.yml) [JSON](Examples/Elastic/JSON/HadoopDistributedecsgroup.json) |
| 17 | HadoopPseudoDistributedEnv | 部署Hadoop伪分布式开发环境。 | [YAML](Examples/Elastic/YAML/HadoopPseudoDistributedEnv.yml) [JSON](Examples/Elastic/JSON/HadoopPseudoDistributedEnv.json) |
| 18 | JDKDNSSSHWithoutPassword3ECS | 创建3个ECS实例, 并安装配置JDK，域名解析和无密码ssh登录环境。基于该模板，我们可以编写其他的复杂模板（例如，Hadoop和Spark模板）。 | [YAML](Examples/Elastic/YAML/JDKDNSSSHWithoutPassword3ECS.yml) [JSON](Examples/Elastic/JSON/JDKDNSSSHWithoutPassword3ECS.json) |
| 19 | LNMPBasic | 一键部署LNMP(Linux+Nginx+MySQL+PHP)栈。 | [YAML](Examples/Elastic/YAML/LNMPBasic.yml) [JSON](Examples/Elastic/JSON/LNMPBasic.json) |
| 20 | RDSWithECSInIpList | 创建一个RDS实例和一个ECS实例，且内网可访问。 | [YAML](Examples/Elastic/YAML/RDSWithECSInIpList.yml) [JSON](Examples/Elastic/JSON/RDSWithECSInIpList.json) |
| 21 | SLBWith2ECS | 创建一个SLB实例和两个ECS实例，并进行挂载。 | [YAML](Examples/Elastic/YAML/SLBWith2ECS.yml) [JSON](Examples/Elastic/JSON/SLBWith2ECS.json) |
| 22 | ScalingSimpleHAInfrastructure | 根据指定的ECS实例，克隆指定数量的ECS，并加入到指定的SLB中。 | [YAML](Examples/Elastic/YAML/ScalingSimpleHAInfrastructure.yml) [JSON](Examples/Elastic/JSON/ScalingSimpleHAInfrastructure.json) |
| 23 | SimpleEcsInstance | 简单创建一个包含安全组和vSwitch的ECS实例。 | [YAML](Examples/Elastic/YAML/SimpleEcsInstance.yml) [JSON](Examples/Elastic/JSON/SimpleEcsInstance.json) |
| 24 | SimpleHighAvailableInfrastructure | 创建一个简单的高可用基础架构：在VPC网络下，创建ECS实例并加入到一个SLB，同时创建多可用区RDS。外部用户可通过SLB访问应用。 | [YAML](Examples/Elastic/YAML/SimpleHighAvailableInfrastructure.yml) [JSON](Examples/Elastic/JSON/SimpleHighAvailableInfrastructure.json) |
| 25 | SparkHadoopDistributedEnv3ECS | 基于3个ECS实例和NAT网关，部署Spark和Hadoop分布式环境。 | [YAML](Examples/Elastic/YAML/SparkHadoopDistributedEnv3ECS.yml) [JSON](Examples/Elastic/JSON/SparkHadoopDistributedEnv3ECS.json) |
| 26 | SparkHadoopEcsgroup | 基于ECS Group部署Spark和Hadoop分布式环境。 | [YAML](Examples/Elastic/YAML/SparkHadoopEcsgroup.yml) [JSON](Examples/Elastic/JSON/SparkHadoopEcsgroup.json) |
| 27 | TensorFlowDeployment | 创建ECS实例，并安装TensorFlow。 | [YAML](Examples/Elastic/YAML/TensorFlowDeployment.yml) [JSON](Examples/Elastic/JSON/TensorFlowDeployment.json) |
| 28 | WordPressCluster | 在VPC网络环境下创建WordPress集群，并配置VPC的SNAT功能访问网络。 | [YAML](Examples/Elastic/YAML/WordPressCluster.yml) [JSON](Examples/Elastic/JSON/WordPressCluster.json) |
| 29 | WordPressClusterPhpMyAdmin | 创建WordPress集群和phpMyAdmin应用。 | [YAML](Examples/Elastic/YAML/WordPressClusterPhpMyAdmin.yml) [JSON](Examples/Elastic/JSON/WordPressClusterPhpMyAdmin.json) |
| 30 | WordPressInstance | 基于ECS和RDS创建WordPress环境。 | [YAML](Examples/Elastic/YAML/WordPressInstance.yml) [JSON](Examples/Elastic/JSON/WordPressInstance.json) |

### Network
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | MicroVPCArchitecture | 微型VPC企业网络架构。在VPC下创建了一个子网。ECS实例通过公网IP访问外部网络。 | [YAML](Examples/Network/YAML/MicroVPCArchitecture.yml) [JSON](Examples/Network/JSON/MicroVPCArchitecture.json) |
| 2 | MiddleVPCArchitecture | 中型VPC企业网络架构。在VPC下创建了三个子网。前端子网中的ECS和SLB处理公共网络请求。后端子网中的ECS、SLB、RDS、Redis、OSS等提供核心业务逻辑。网络通过NatGateway的SNAT访问公共网络。 | [YAML](Examples/Network/YAML/MiddleVPCArchitecture.yml) [JSON](Examples/Network/JSON/MiddleVPCArchitecture.json) |
| 3 | SLBClone | 将源负载均衡挂载的实例挂载到一个新的负载均衡上。 | [YAML](Examples/Network/YAML/SLBClone.yml) [JSON](Examples/Network/JSON/SLBClone.json) |
| 4 | SmallVPCArchitecture | 小型企业VPC网络架构。在VPC中创建了两个子网。ECS通过NatGateway DNAT和SNAT访问外部网络。 | [YAML](Examples/Network/YAML/SmallVPCArchitecture.yml) [JSON](Examples/Network/JSON/SmallVPCArchitecture.json) |
| 5 | VPC | 创建一个VPC实例。 | [YAML](Examples/Network/YAML/VPC.yml) [JSON](Examples/Network/JSON/VPC.json) |
| 6 | VPCNatGateway | 在VPC网络下创建ECS实例并配置NatGateway使VPC网络中的ECS实例可访问外网和提供服务。 | [YAML](Examples/Network/YAML/VPCNatGateway.yml) [JSON](Examples/Network/JSON/VPCNatGateway.json) |
| 7 | VPCSnatGateway | 一键创建SNAT网关，VPC环境下创建一个绑定了EIP的ECS实例做为SNAT网关。 | [YAML](Examples/Network/YAML/VPCSnatGateway.yml) [JSON](Examples/Network/JSON/VPCSnatGateway.json) |
| 8 | VPCVSwitchRouteSGECS | 创建一个VPC、一个VSwitch、一个安全组、一个ECS实例和一条自定义路由。 | [YAML](Examples/Network/YAML/VPCVSwitchRouteSGECS.yml) [JSON](Examples/Network/JSON/VPCVSwitchRouteSGECS.json) |

### Security
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | RAMCreateSubAccount | 创建子帐号, 生成ak，并开启控制台登录。 | [YAML](Examples/Security/YAML/RAMCreateSubAccount.yml) [JSON](Examples/Security/JSON/RAMCreateSubAccount.json) |

### StackGroup
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | AliyunROSStackGroupAdministrationRole | 配置 AliyunROSStackGroupAdministrationRole 以使用阿里云资源编排服务（ROS）的资源栈组功能。 | [YAML](Examples/StackGroup/YAML/AliyunROSStackGroupAdministrationRole.yml) [JSON](Examples/StackGroup/JSON/AliyunROSStackGroupAdministrationRole.json) |
| 2 | AliyunROSStackGroupExecutionRole | 配置 AliyunROSStackGroupExecutionRole 以在阿里云资源编排服务（ROS）的资源栈组功能中使用您的账户作为目标账户。 | [YAML](Examples/StackGroup/YAML/AliyunROSStackGroupExecutionRole.yml) [JSON](Examples/StackGroup/JSON/AliyunROSStackGroupExecutionRole.json) |

### Storage
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SimpleOSSBucket | 创建一个OSS Bucket。 | [YAML](Examples/Storage/YAML/SimpleOSSBucket.yml) [JSON](Examples/Storage/JSON/SimpleOSSBucket.json) |

### Windows
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SimpleWindowsInstanceWithSharepoint | 创建一个Windows实例，并安装SharePoint。 | [YAML](Windows/YAML/SimpleWindowsInstanceWithSharepoint.yml) [JSON](Windows/JSON/SimpleWindowsInstanceWithSharepoint.json) |

## ResourceTemplates
### ACM
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Configuration | 创建 ACM Namespace、Configuration | [YAML](ResourceTemplates/ACM/YAML/Configuration.yml) [JSON](ResourceTemplates/ACM/JSON/Configuration.json)|
### ARMS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | AlertContactGroup | 创建 Arms AlertContact、AlertContactGroup | [YAML](ResourceTemplates/ARMS/YAML/AlertContactGroup.yml) [JSON](ResourceTemplates/ARMS/JSON/AlertContactGroup.json)|
| 2 | RetcodeApp | 创建 Arms RetcodeApp | [YAML](ResourceTemplates/ARMS/YAML/RetcodeApp.yml) [JSON](ResourceTemplates/ARMS/JSON/RetcodeApp.json)|
### ActionTrail
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | TrailLogging | 创建 ACTIONTRAIL Trail、TrailLogging | [YAML](ResourceTemplates/ActionTrail/YAML/TrailLogging.yml) [JSON](ResourceTemplates/ActionTrail/JSON/TrailLogging.json)|
### ApiGateway
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Api | 创建 ApiGateway Api、Group、App、Deployment、Authorization、Signature、SignatureBinding、TrafficControl、TrafficControlBinding、 | [YAML](ResourceTemplates/ApiGateway/YAML/Api.yml) [JSON](ResourceTemplates/ApiGateway/JSON/Api.json)|
| 2 | Instance | 创建 ApiGateway Instance | [YAML](ResourceTemplates/ApiGateway/YAML/Instance.yml) [JSON](ResourceTemplates/ApiGateway/JSON/Instance.json)|
| 3 | StageConfig | 创建 ApiGateway StageConfig | [YAML](ResourceTemplates/ApiGateway/YAML/StageConfig.yml) [JSON](ResourceTemplates/ApiGateway/JSON/StageConfig.json)|
| 4 | VpcAccessConfig | 创建 ApiGateway VpcAccessConfig | [YAML](ResourceTemplates/ApiGateway/YAML/VpcAccessConfig.yml) [JSON](ResourceTemplates/ApiGateway/JSON/VpcAccessConfig.json)|
| 5 | CustomDomain | 创建 ApiGateway CustomDomain | [YAML](ResourceTemplates/ApiGateway/YAML/CustomDomain.yml) [JSON](ResourceTemplates/ApiGateway/JSON/CustomDomain.json)|
### BSS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | WaitOrder | 创建 BSS WaitOrder | [YAML](ResourceTemplates/BSS/YAML/WaitOrder.yml) [JSON](ResourceTemplates/BSS/JSON/WaitOrder.json)|
### CAS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Certificate | 创建 CAS Certificate | [YAML](ResourceTemplates/CAS/YAML/Certificate.yml) [JSON](ResourceTemplates/CAS/JSON/Certificate.json)|
### CDN
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Domain | 创建 CDN Domain、DomainConfig | [YAML](ResourceTemplates/CDN/YAML/Domain.yml) [JSON](ResourceTemplates/CDN/JSON/Domain.json)|
### CEN
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Cen | 创建 Cen | [YAML](ResourceTemplates/CEN/YAML/Cen.yml) [JSON](ResourceTemplates/CEN/JSON/Cen.json)|
### CMS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Contact | 创建 CMS Contact、ContactGroup、DynamicTagGroup | [YAML](ResourceTemplates/CMS/YAML/Contact.yml) [JSON](ResourceTemplates/CMS/JSON/Contact.json)|
| 2 | MonitoringAgentProcess | 创建 CMS MonitoringAgentProcess | [YAML](ResourceTemplates/CMS/YAML/MonitoringAgentProcess.yml) [JSON](ResourceTemplates/CMS/JSON/MonitoringAgentProcess.json)|
| 3 | MonitorGroup | 创建 CMS MonitorGroup、MonitorGroupInstances | [YAML](ResourceTemplates/CMS/YAML/MonitorGroup.yml) [JSON](ResourceTemplates/CMS/JSON/MonitorGroup.json)|
| 4 | EventRule | 创建 CMS EventRule | [YAML](ResourceTemplates/CMS/YAML/EventRule.yml) [JSON](ResourceTemplates/CMS/JSON/EventRule.json)|
| 5 | EventRuleTargets | 创建 CMS EventRuleTargets | [YAML](ResourceTemplates/CMS/YAML/EventRuleTargets.yml) [JSON](ResourceTemplates/CMS/JSON/EventRuleTargets.json)|
### CR
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Repository | 创建 CR Repository | [YAML](ResourceTemplates/CR/YAML/Repository.yml) [JSON](ResourceTemplates/CR/JSON/Repository.json)|
| 2 | InstanceEndpointAclPolicy | 创建 创建 CR InstanceEndpointAclPolicy | [YAML](ResourceTemplates/CR/YAML/InstanceEndpointAclPolicy.yml) [JSON](ResourceTemplates/CR/JSON/InstanceEndpointAclPolicy.json)|
| 3 | Namespace | 创建 CR NameSpace | [YAML](ResourceTemplates/CR/YAML/Namespace.yml) [JSON](ResourceTemplates/CR/JSON/Namespace.json)|
### CS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | KubernetesCluster | 创建 创建 KubernetesCluster | [YAML](ResourceTemplates/CS/YAML/KubernetesCluster.yml) [JSON](ResourceTemplates/CS/JSON/KubernetesCluster.json)|
| 2 | AnyCluster | 创建 AnyCluster | [YAML](ResourceTemplates/CS/YAML/AnyCluster.yml) [JSON](ResourceTemplates/CS/JSON/AnyCluster.json)|
| 3 | ManagedEdgeKubernetesCluster | 创建 ManagedEdgeKubernetesCluster | [YAML](ResourceTemplates/CS/YAML/ManagedEdgeKubernetesCluster.yml) [JSON](ResourceTemplates/CS/JSON/ManagedEdgeKubernetesCluster.json)|
| 4 | ManagedKubernetesCluster | 创建 创建 ManagedKubernetesCluster | [YAML](ResourceTemplates/CS/YAML/ManagedKubernetesCluster.yml) [JSON](ResourceTemplates/CS/JSON/ManagedKubernetesCluster.json)|
| 5 | ServerlessKubernetesCluster | 创建 ServerlessKubernetesCluster | [YAML](ResourceTemplates/CS/YAML/ServerlessKubernetesCluster.yml) [JSON](ResourceTemplates/CS/JSON/ServerlessKubernetesCluster.json)|
### DNS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Domain | 创建 DNS Domain、DomainGroup | [YAML](ResourceTemplates/DNS/YAML/Domain.yml) [JSON](ResourceTemplates/DNS/JSON/Domain.json)|
| 2 | DomainRecord | 创建 DNS DomainRecord | [YAML](ResourceTemplates/DNS/YAML/DomainRecord.yml) [JSON](ResourceTemplates/DNS/JSON/DomainRecord.json)|
### DRDS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | DrdsInstance | 创建 DrdsInstance | [YAML](ResourceTemplates/DRDS/YAML/DrdsInstance.yml) [JSON](ResourceTemplates/DRDS/JSON/DrdsInstance.json)|
### DTS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | DTS | 创建 DTS MigrationJob、SynchronizationJob | [YAML](ResourceTemplates/DTS/YAML/DTS.yml) [JSON](ResourceTemplates/DTS/JSON/DTS.json)|
### DataHub
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Topic | 创建 DataHub Project、Topic | [YAML](ResourceTemplates/DataHub/YAML/Topic.yml) [JSON](ResourceTemplates/DataHub/JSON/Topic.json)|
### ECI
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ContainerGroup | 创建 ECI ContainerGroup | [YAML](ResourceTemplates/ECI/YAML/ContainerGroup.yml) [JSON](ResourceTemplates/ECI/JSON/ContainerGroup.json)|
| 2 | ImageCache | 创建 ECI ImageCache | [YAML](ResourceTemplates/ECI/YAML/ImageCache.yml) [JSON](ResourceTemplates/ECI/JSON/ImageCache.json)|
### ECS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SNatEntry | 创建 ECS SecurityGroupIngress | [YAML](ResourceTemplates/ECS/YAML/SNatEntry.yml) [JSON](ResourceTemplates/ECS/JSON/SNatEntry.json)|
| 2 | AutoSnapshotPolicy | 创建 ECS AutoSnapshotPolicy | [YAML](ResourceTemplates/ECS/YAML/AutoSnapshotPolicy.yml) [JSON](ResourceTemplates/ECS/JSON/AutoSnapshotPolicy.json)|
| 3 | SecurityGroupEgress | 创建 ECS SecurityGroupEgress | [YAML](ResourceTemplates/ECS/YAML/SecurityGroupEgress.yml) [JSON](ResourceTemplates/ECS/JSON/SecurityGroupEgress.json)|
| 4 | NetworkInterfaceAttachment | 创建 ECS NetworkInterface、NetworkInterfaceAttachment | [YAML](ResourceTemplates/ECS/YAML/NetworkInterfaceAttachment.yml) [JSON](ResourceTemplates/ECS/JSON/NetworkInterfaceAttachment.json)|
| 5 | InstanceClone | 创建 ECS Instance Clone | [YAML](ResourceTemplates/ECS/YAML/InstanceClone.yml) [JSON](ResourceTemplates/ECS/JSON/InstanceClone.json)|
| 6 | SecurityGroupIngress | 创建 ECS SecurityGroupIngress | [YAML](ResourceTemplates/ECS/YAML/SecurityGroupIngress.yml) [JSON](ResourceTemplates/ECS/JSON/SecurityGroupIngress.json)|
| 7 | DedicatedHost | 创建 ECS DedicatedHost | [YAML](ResourceTemplates/ECS/YAML/DedicatedHost.yml) [JSON](ResourceTemplates/ECS/JSON/DedicatedHost.json)|
| 8 | DeploymentSet | 创建 ECS DeploymentSet | [YAML](ResourceTemplates/ECS/YAML/DeploymentSet.yml) [JSON](ResourceTemplates/ECS/JSON/DeploymentSet.json)|
| 9 | Instance | 创建 Vpc ECS instance、EIP、NatGateway、SSHKeyPair | [YAML](ResourceTemplates/ECS/YAML/Instance.yml) [JSON](ResourceTemplates/ECS/JSON/Instance.json)|
| 10 | LaunchTemplate | 创建 ECS LaunchTemplate、AutoProvisioningGroup | [YAML](ResourceTemplates/ECS/YAML/LaunchTemplate.yml) [JSON](ResourceTemplates/ECS/JSON/LaunchTemplate.json)|
| 11 | HpcCluster | 创建 ECS HpcCluster | [YAML](ResourceTemplates/ECS/YAML/HpcCluster.yml) [JSON](ResourceTemplates/ECS/JSON/HpcCluster.json)|
| 12 | JoinSecurityGroup | 创建 ECS JoinSecurityGroup | [YAML](ResourceTemplates/ECS/YAML/JoinSecurityGroup.yml) [JSON](ResourceTemplates/ECS/JSON/JoinSecurityGroup.json)|
| 13 | NatGateway | 创建 ECS NatGateway、BandwidthPackage | [YAML](ResourceTemplates/ECS/YAML/NatGateway.yml) [JSON](ResourceTemplates/ECS/JSON/NatGateway.json)|
| 14 | AssignPrivateIpAddresses | 创建 ECS AssignPrivateIpAddresses | [YAML](ResourceTemplates/ECS/YAML/AssignPrivateIpAddresses.yml) [JSON](ResourceTemplates/ECS/JSON/AssignPrivateIpAddresses.json)|
| 15 | PrepayInstance | 创建 ECS PrepayInstance | [YAML](ResourceTemplates/ECS/YAML/PrepayInstance.yml) [JSON](ResourceTemplates/ECS/JSON/PrepayInstance.json)|
| 16 | RunCommand | 创建 ECS RunCommand | [YAML](ResourceTemplates/ECS/YAML/RunCommand.yml) [JSON](ResourceTemplates/ECS/JSON/RunCommand.json)|
| 17 | Route | 创建 ECS Route、AssignIpv6Addresses | [YAML](ResourceTemplates/ECS/YAML/Route.yml) [JSON](ResourceTemplates/ECS/JSON/Route.json)|
| 18 | ForwardEntry | 创建 ECS ForwardEntry | [YAML](ResourceTemplates/ECS/YAML/ForwardEntry.yml) [JSON](ResourceTemplates/ECS/JSON/ForwardEntry.json)|
| 19 | SecurityGroupClone | 创建 ECS SecurityGroupClone | [YAML](ResourceTemplates/ECS/YAML/SecurityGroupClone.yml) [JSON](ResourceTemplates/ECS/JSON/SecurityGroupClone.json)|
| 20 | Disk | 创建 ECS Disk | [YAML](ResourceTemplates/ECS/YAML/Disk.yml) [JSON](ResourceTemplates/ECS/JSON/Disk.json)|
| 21 | InstanceGroup | 创建 ECS InstanceGroup、InstanceGroupClone、Command、Invocation | [YAML](ResourceTemplates/ECS/YAML/InstanceGroup.yml) [JSON](ResourceTemplates/ECS/JSON/InstanceGroup.json)|
| 22 | CustomImage | 创建 ECS CustomImage、CopyImage | [YAML](ResourceTemplates/ECS/YAML/CustomImage.yml) [JSON](ResourceTemplates/ECS/JSON/CustomImage.json)|
| 23 | DiskAttachment | 创建 ECS DiskAttachment、Snapshot | [YAML](ResourceTemplates/ECS/YAML/DiskAttachment.yml) [JSON](ResourceTemplates/ECS/JSON/DiskAttachment.json)|
### EDAS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ClusterMember | 创建 EDAS ClusterMember | [YAML](ResourceTemplates/EDAS/YAML/ClusterMember.yml) [JSON](ResourceTemplates/EDAS/JSON/ClusterMember.json)|
| 2 | Cluster | 创建 EDAS Cluster、App、DeployGroup | [YAML](ResourceTemplates/EDAS/YAML/Cluster.yml) [JSON](ResourceTemplates/EDAS/JSON/Cluster.json)|
### EHPC
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Cluster | 创建 EHPC Cluster | [YAML](ResourceTemplates/EHPC/YAML/Cluster.yml) [JSON](ResourceTemplates/EHPC/JSON/Cluster.json)|
### EMR
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Cluster | 创建 EMR Cluster | [YAML](ResourceTemplates/EMR/YAML/Cluster.yml) [JSON](ResourceTemplates/EMR/JSON/Cluster.json)|
### ESS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ScalingGroup | 创建 ESS ScalingGroup、ScalingRule、AlarmTask、AlarmTaskEnable、LifecycleHook、ScheduledTask | [YAML](ResourceTemplates/ESS/YAML/ScalingGroup.yml) [JSON](ResourceTemplates/ESS/JSON/ScalingGroup.json)|
| 2 | ScalingGroupEnable | 创建 ESS ScalingConfiguration、ScalingGroupEnable | [YAML](ResourceTemplates/ESS/YAML/ScalingGroupEnable.yml) [JSON](ResourceTemplates/ESS/JSON/ScalingGroupEnable.json)|
### ElasticSearch
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Instance | 创建 ElasticSearch Instance | [YAML](ResourceTemplates/ElasticSearch/YAML/Instance.yml) [JSON](ResourceTemplates/ElasticSearch/JSON/Instance.json)|
### FC
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | FunctionInvoker | 创建 FC FunctionInvoker、Trigger、Version、Alias、ProvisionConfig | [YAML](ResourceTemplates/FC/YAML/FunctionInvoker.yml) [JSON](ResourceTemplates/FC/JSON/FunctionInvoker.json)|
| 2 | CustomDomain | 创建 FC CustomDomain | [YAML](ResourceTemplates/FC/YAML/CustomDomain.yml) [JSON](ResourceTemplates/FC/JSON/CustomDomain.json)|
### FNF
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Flow | 创建 FNF Flow、Schedule | [YAML](ResourceTemplates/FNF/YAML/Flow.yml) [JSON](ResourceTemplates/FNF/JSON/Flow.json)|
### GWS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Cluster | 创建 GWS Cluster、Instance | [YAML](ResourceTemplates/GWS/YAML/Cluster.yml) [JSON](ResourceTemplates/GWS/JSON/Cluster.json)|
### IOT
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Rule | 创建 IOT Rule | [YAML](ResourceTemplates/IOT/YAML/Rule.yml) [JSON](ResourceTemplates/IOT/JSON/Rule.json)|
| 2 | DeviceGroup | 创建 IOT DeviceGroup | [YAML](ResourceTemplates/IOT/YAML/DeviceGroup.yml) [JSON](ResourceTemplates/IOT/JSON/DeviceGroup.json)|
| 3 | Device | 创建 IOT Product、Device | [YAML](ResourceTemplates/IOT/YAML/Device.yml) [JSON](ResourceTemplates/IOT/JSON/Device.json)|
### KMS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Key | 创建 KMS Key、Alias | [YAML](ResourceTemplates/KMS/YAML/Key.yml) [JSON](ResourceTemplates/KMS/JSON/Key.json)|
| 2 | Secret | 创建 KMS Secret | [YAML](ResourceTemplates/KMS/YAML/Secret.yml) [JSON](ResourceTemplates/KMS/JSON/Secret.json)|
### Kafka
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Instance | 创建 创建 Kafka Instance、Topic | [YAML](ResourceTemplates/Kafka/YAML/Instance.yml) [JSON](ResourceTemplates/Kafka/JSON/Instance.json)|
### MNS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Subscription | 创建 MNS Queue、Topic、Subscription | [YAML](ResourceTemplates/MNS/YAML/Subscription.yml) [JSON](ResourceTemplates/MNS/JSON/Subscription.json)|
### MSE
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Cluster | 创建 MSE Cluster | [YAML](ResourceTemplates/MSE/YAML/Cluster.yml) [JSON](ResourceTemplates/MSE/JSON/Cluster.json)|
### MarketPlace
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Order | 创建 MarketPlace Order | [YAML](ResourceTemplates/MarketPlace/YAML/Order.yml) [JSON](ResourceTemplates/MarketPlace/JSON/Order.json)|
### Memcache
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Instance | 创建 Memcache Instance、WhiteList | [YAML](ResourceTemplates/Memcache/YAML/Instance.yml) [JSON](ResourceTemplates/Memcache/JSON/Instance.json)|
### MongoDB
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ServerlessInstance | 创建 MONGODB ServerlessInstance | [YAML](ResourceTemplates/MongoDB/YAML/ServerlessInstance.yml) [JSON](ResourceTemplates/MongoDB/JSON/ServerlessInstance.json)|
| 2 | ShardingInstance | 创建 MongoDb ShardingInstance | [YAML](ResourceTemplates/MongoDB/YAML/ShardingInstance.yml) [JSON](ResourceTemplates/MongoDB/JSON/ShardingInstance.json)|
| 3 | MongoDBInstance | 创建 MONGODB Instance | [YAML](ResourceTemplates/MongoDB/YAML/MongoDBInstance.yml) [JSON](ResourceTemplates/MongoDB/JSON/MongoDBInstance.json)|
### NAS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | NAS | 创建 NAS AccessGroupName、AccessRule、FileSystem、MountTarget | [YAML](ResourceTemplates/NAS/YAML/NAS.yml) [JSON](ResourceTemplates/NAS/JSON/NAS.json)|
### OOS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Parameter | 创建 OOS Parameter | [YAML](ResourceTemplates/OOS/YAML/Parameter.yml) [JSON](ResourceTemplates/OOS/JSON/Parameter.json)|
| 2 | OOS | 创建 OOS Template、Execution | [YAML](ResourceTemplates/OOS/YAML/OOS.yml) [JSON](ResourceTemplates/OOS/JSON/OOS.json)|
### OSS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Bucket | 创建 OSS Bucket | [YAML](ResourceTemplates/OSS/YAML/Bucket.yml) [JSON](ResourceTemplates/OSS/JSON/Bucket.json)|
### OTS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | OTS | 创建 OTS Table、Instance、VpcBinder | [YAML](ResourceTemplates/OTS/YAML/OTS.yml) [JSON](ResourceTemplates/OTS/JSON/OTS.json)|
### POLARDB
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | POLARDB | 创建 POLARDB | [YAML](ResourceTemplates/POLARDB/YAML/POLARDB.yml) [JSON](ResourceTemplates/POLARDB/JSON/POLARDB.json)|
### PVTZ
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | PVTZ | 创建 PVTZ Zone、ZoneRecord、ZoneVpcBinder | [YAML](ResourceTemplates/PVTZ/YAML/PVTZ.yml) [JSON](ResourceTemplates/PVTZ/JSON/PVTZ.json)|
### RAM
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ManagedPolicy | 创建 RAM ManagedPolicy | [YAML](ResourceTemplates/RAM/YAML/ManagedPolicy.yml) [JSON](ResourceTemplates/RAM/JSON/ManagedPolicy.json)|
| 2 | Role | 创建 RAM Role | [YAML](ResourceTemplates/RAM/YAML/Role.yml) [JSON](ResourceTemplates/RAM/JSON/Role.json)|
| 3 | AccessKey | 创建 RAM User、AccessKey | [YAML](ResourceTemplates/RAM/YAML/AccessKey.yml) [JSON](ResourceTemplates/RAM/JSON/AccessKey.json)|
| 4 | AttachPolicyToRole | 创建 RAM Role、AttachPolicyToRole | [YAML](ResourceTemplates/RAM/YAML/AttachPolicyToRole.yml) [JSON](ResourceTemplates/RAM/JSON/AttachPolicyToRole.json)|
| 5 | User | 创建 RAM User、Group、AttachPolicyToUser、UserToGroupAddition | [YAML](ResourceTemplates/RAM/YAML/User.yml) [JSON](ResourceTemplates/RAM/JSON/User.json)|
### RDS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | PrepayDBInstance | 创建 RDS PrepayDBInstance | [YAML](ResourceTemplates/RDS/YAML/PrepayDBInstance.yml) [JSON](ResourceTemplates/RDS/JSON/PrepayDBInstance.json)|
| 2 | DBInstance | 创建 RDS DBInstance、Account、AccountPrivilege | [YAML](ResourceTemplates/RDS/YAML/DBInstance.yml) [JSON](ResourceTemplates/RDS/JSON/DBInstance.json)|
### ROCKETMQ
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ROCKETMQ | 创建 ROCKETMQ Instance、Group、Topic | [YAML](ResourceTemplates/ROCKETMQ/YAML/ROCKETMQ.yml) [JSON](ResourceTemplates/ROCKETMQ/JSON/ROCKETMQ.json)|
### ROS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Stack | 创建 ROS Stack | [YAML](ResourceTemplates/ROS/YAML/Stack.yml) [JSON](ResourceTemplates/ROS/JSON/Stack.json)|
| 2 | WaitCondition | 创建 ROS WaitCondition | [YAML](ResourceTemplates/ROS/YAML/WaitCondition.yml) [JSON](ResourceTemplates/ROS/JSON/WaitCondition.json)|
| 3 | CustomResource | 创建 ROS CustomResource | [YAML](ResourceTemplates/ROS/YAML/CustomResource.yml) [JSON](ResourceTemplates/ROS/JSON/CustomResource.json)|
| 4 | AutoEnableService | 创建 ROS AutoEnableService | [YAML](ResourceTemplates/ROS/YAML/AutoEnableService.yml) [JSON](ResourceTemplates/ROS/JSON/AutoEnableService.json)|
| 5 | WaitConditionHandle | 创建 ROS WaitConditionHandle | [YAML](ResourceTemplates/ROS/YAML/WaitConditionHandle.yml) [JSON](ResourceTemplates/ROS/JSON/WaitConditionHandle.json)|
### Redis
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Instance | 创建 创建 Redis Instance、Whitelist and Account | [YAML](ResourceTemplates/Redis/YAML/Instance.yml) [JSON](ResourceTemplates/Redis/JSON/Instance.json)|
| 2 | PrepayInstance | 创建 创建 Redis PrepayInstance | [YAML](ResourceTemplates/Redis/YAML/PrepayInstance.yml) [JSON](ResourceTemplates/Redis/JSON/PrepayInstance.json)|
### ResourceManeger
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ResourceGroup | 创建 ResourceManager ResourceGroup | [YAML](ResourceTemplates/ResourceManeger/YAML/ResourceGroup.yml) [JSON](ResourceTemplates/ResourceManeger/JSON/ResourceGroup.json)|
| 2 | Handshake | 创建 ResourceManager Handshake | [YAML](ResourceTemplates/ResourceManeger/YAML/Handshake.yml) [JSON](ResourceTemplates/ResourceManeger/JSON/Handshake.json)|
### SAE
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SAE | 创建 SAE Application、Namespace、SlbBinding, and deploy Application | [YAML](ResourceTemplates/SAE/YAML/SAE.yml) [JSON](ResourceTemplates/SAE/JSON/SAE.json)|
### SAG
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ACL | 创建 SAG ACL、ACLRule | [YAML](ResourceTemplates/SAG/YAML/ACL.yml) [JSON](ResourceTemplates/SAG/JSON/ACL.json)|
### SLB
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Listener | 创建 SLB LoadBalancer、Listener、LoadBalancerClone、Certificate、DomainExtension、VServerGroup、Rule | [YAML](ResourceTemplates/SLB/YAML/Listener.yml) [JSON](ResourceTemplates/SLB/JSON/Listener.json)|
| 2 | BackendServerAttachment | 创建 SLB BackendServerAttachment、MasterSlaveServerGroup | [YAML](ResourceTemplates/SLB/YAML/BackendServerAttachment.yml) [JSON](ResourceTemplates/SLB/JSON/BackendServerAttachment.json)|
| 3 | AccessControl | 创建 SLB AccessControl | [YAML](ResourceTemplates/SLB/YAML/AccessControl.yml) [JSON](ResourceTemplates/SLB/JSON/AccessControl.json)|
### SLS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SLS | 创建 SLS Project、Logstore、Alert、Index、SavedSearch、LogtailConfig、MachineGroup、ApplyConfigToMachineGroup、ApiGatewayLogConfig | [YAML](ResourceTemplates/SLS/YAML/SLS.yml) [JSON](ResourceTemplates/SLS/JSON/SLS.json)|
### UIS
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | UIS | 创建 UIS UisNode、UisConnection | [YAML](ResourceTemplates/UIS/YAML/UIS.yml) [JSON](ResourceTemplates/UIS/JSON/UIS.json)|
### VPC
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SnatEntry | 创建 Vpc SnatEntry、CommonBandwidthPackage、Ipv6Gateway、ECS AssignIpv6Addresses | [YAML](ResourceTemplates/VPC/YAML/SnatEntry.yml) [JSON](ResourceTemplates/VPC/JSON/SnatEntry.json)|
| 2 | RouterInterfaceUpdate | 创建 Vpc RouterInterface | [YAML](ResourceTemplates/VPC/YAML/RouterInterfaceUpdate.yml) [JSON](ResourceTemplates/VPC/JSON/RouterInterfaceUpdate.json)|
| 3 | RouteTable | 创建 Vpc RouteTable | [YAML](ResourceTemplates/VPC/YAML/RouteTable.yml) [JSON](ResourceTemplates/VPC/JSON/RouteTable.json)|
| 4 | Eip | 创建 Vpc EIP | [YAML](ResourceTemplates/VPC/YAML/Eip.yml) [JSON](ResourceTemplates/VPC/JSON/Eip.json)|
| 5 | EIPAssociation | 创建 Vpc EIPAssociation | [YAML](ResourceTemplates/VPC/YAML/EIPAssociation.yml) [JSON](ResourceTemplates/VPC/JSON/EIPAssociation.json)|
| 6 | RouterInterface | 创建 Vpc RouterInterface | [YAML](ResourceTemplates/VPC/YAML/RouterInterface.yml) [JSON](ResourceTemplates/VPC/JSON/RouterInterface.json)|
| 7 | NatGateway | 创建 VPC NatGateway | [YAML](ResourceTemplates/VPC/YAML/NatGateway.yml) [JSON](ResourceTemplates/VPC/JSON/NatGateway.json)|
### WAF
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Domain | 创建 Waf Domain | [YAML](ResourceTemplates/WAF/YAML/Domain.yml) [JSON](ResourceTemplates/WAF/JSON/Domain.json)|
| 2 | DomainConfig | 创建 Waf DomainConfig、AclRule、WafSwitch | [YAML](ResourceTemplates/WAF/YAML/DomainConfig.yml) [JSON](ResourceTemplates/WAF/JSON/DomainConfig.json)|
| 3 | Instance | Warning: Waf Instance only support prepay type | [YAML](ResourceTemplates/WAF/YAML/Instance.yml) [JSON](ResourceTemplates/WAF/JSON/Instance.json)|

# English
This repository contains examples and best practices for building ROS templates.

Welcome to access [ROS console](https://ros.console.aliyun.com), and to read [ROS document](https://www.alibabacloud.com/help/doc-detail/28852.htm) for more details.

## Examples
### Application
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ECSCloneJoinSLS | Clones an ECS instance, and consider it as the machine group of the related project logtail in Log Serivce. | [YAML](Examples/Application/YAML/ECSCloneJoinSLS.yml) [JSON](Examples/Application/JSON/ECSCloneJoinSLS.json) |
| 2 | ECSGroupJoinSLS | Creates a set of ECS instance, and consider it as the machine group of the related project logtail in Log Serivce. | [YAML](Examples/Application/YAML/ECSGroupJoinSLS.yml) [JSON](Examples/Application/JSON/ECSGroupJoinSLS.json) |

### CsApps
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | DockerDatacneterEnterprise | DDC for Aliyun. | [YAML](Examples/CsApps/YAML/DockerDatacneterEnterprise.yml) [JSON](Examples/CsApps/JSON/DockerDatacneterEnterprise.json) |
| 2 | DockerSwarm | Docker for Aliyun. | [YAML](Examples/CsApps/YAML/DockerSwarm.yml) [JSON](Examples/CsApps/JSON/DockerSwarm.json) |
| 3 | JStorm | Create one container service cluster and deploy JStorm with its dependency Zookeeper. | [YAML](Examples/CsApps/YAML/JStorm.yml) [JSON](Examples/CsApps/JSON/JStorm.json) |
| 4 | Jenkins | Create a container service clusters to deploy Jenkins master and slaves with different languages. | [YAML](Examples/CsApps/YAML/Jenkins.yml) [JSON](Examples/CsApps/JSON/Jenkins.json) |

### DB
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | MemcacheInstance | Creates one classic memcache instance. | [YAML](Examples/DB/YAML/MemcacheInstance.yml) [JSON](Examples/DB/JSON/MemcacheInstance.json) |
| 2 | MongoDBInstance | Creates one classic MongoDB instance. | [YAML](Examples/DB/YAML/MongoDBInstance.yml) [JSON](Examples/DB/JSON/MongoDBInstance.json) |
| 3 | RDSInstance | Creates one classic RDS instance. | [YAML](Examples/DB/YAML/RDSInstance.yml) [JSON](Examples/DB/JSON/RDSInstance.json) |
| 4 | RedisInstance | Creates one Redis instance. | [YAML](Examples/DB/YAML/RedisInstance.yml) [JSON](Examples/DB/JSON/RedisInstance.json) |

### Elastic
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ECSGroupAttachMultipleSLB | Creates an ECS Instance Group attach SLB. | [YAML](Examples/Elastic/YAML/ECSGroupAttachMultipleSLB.yml) [JSON](Examples/Elastic/JSON/ECSGroupAttachMultipleSLB.json) |
| 2 | ECSGroupClassic | One security group holds a set of ECS instances with the same configuration, using classic network. | [YAML](Examples/Elastic/YAML/ECSGroupClassic.yml) [JSON](Examples/Elastic/JSON/ECSGroupClassic.json) |
| 3 | ECSGroupClone | According the existing ECS instance, clone a set of ECS instanes with the same configuration(InstanceType, ImageId, InternetChargeType, InternetMaxBandwidthIn, InternetMaxBandwidthOut, system disk, data disk configurations, VPC properties). The user only needs to specify SourceInstanceId. | [YAML](Examples/Elastic/YAML/ECSGroupClone.yml) [JSON](Examples/Elastic/JSON/ECSGroupClone.json) |
| 4 | ECSGroupVPC | One VPC and security group hold a set of ECS instances with the same configuration. | [YAML](Examples/Elastic/YAML/ECSGroupVPC.yml) [JSON](Examples/Elastic/JSON/ECSGroupVPC.json) |
| 5 | ECSImageDiskSnapshot | Specify the image Id and snapshot to create ECS instance. | [YAML](Examples/Elastic/YAML/ECSImageDiskSnapshot.yml) [JSON](Examples/Elastic/JSON/ECSImageDiskSnapshot.json) |
| 6 | ECSMountMultipleUninitializedDataDisks | Creates an ECS and mount multiple uninitialized data disks. | [YAML](Examples/Elastic/YAML/ECSMountMultipleUninitializedDataDisks.yml) [JSON](Examples/Elastic/JSON/ECSMountMultipleUninitializedDataDisks.json) |
| 7 | ECSVPCInstance | Creates VPC ECS instance. | [YAML](Examples/Elastic/YAML/ECSVPCInstance.yml) [JSON](Examples/Elastic/JSON/ECSVPCInstance.json) |
| 8 | ECSWith2DataDisk | Creates an ecs, mounts two data disks created by snapshots. | [YAML](Examples/Elastic/YAML/ECSWith2DataDisk.yml) [JSON](Examples/Elastic/JSON/ECSWith2DataDisk.json) |
| 9 | ECSWithJavaWebEnviroment | This template installs jdk and tomcat on a new ECS instance. | [YAML](Examples/Elastic/YAML/ECSWithJavaWebEnviroment.yml) [JSON](Examples/Elastic/JSON/ECSWithJavaWebEnviroment.json) |
| 10 | ECSWithNodejsEnviroment | This template show how to deploy a Node.js environment and do a test based on a new ECS instance. ***WARNING***, this template only supports CentOS. | [YAML](Examples/Elastic/YAML/ECSWithNodejsEnviroment.yml) [JSON](Examples/Elastic/JSON/ECSWithNodejsEnviroment.json) |
| 11 | ECSWithRubyEnviroment | Creates a Ruby on Rails stack using a single ECS instance with a local MySQL database for storage. This example creates a simple hello world application from the template. *** WARNING *** This template only supports CentOS-7. When 'rvm install 2.3.1' may take long time. | [YAML](Examples/Elastic/YAML/ECSWithRubyEnviroment.yml) [JSON](Examples/Elastic/JSON/ECSWithRubyEnviroment.json) |
| 12 | ECSWithSSHKey | Creates an ECS and configure SSH key. | [YAML](Examples/Elastic/YAML/ECSWithSSHKey.yml) [JSON](Examples/Elastic/JSON/ECSWithSSHKey.json) |
| 13 | ESS1SLB2RDS2ECS | Creates 1 SLB, 2 ECS instances, 1 ESS and 1 RDS. Attach the instances and ESS to the SLB. | [YAML](Examples/Elastic/YAML/ESS1SLB2RDS2ECS.yml) [JSON](Examples/Elastic/JSON/ESS1SLB2RDS2ECS.json) |
| 14 | EntireECSClone | Clones ECS Instance And DataBase Disk. | [YAML](Examples/Elastic/YAML/EntireECSClone.yml) [JSON](Examples/Elastic/JSON/EntireECSClone.json) |
| 15 | HadoopDistributedEnv3ECS | Deploy a Hadoop environment on 3 ECS instances. One ECS instance plays role of master node, and the other 2 instances play role of worker node. *** WARNING *** Only test in CentOS-7. Maybe stopping firewall is needed. The deploying time mainly depends on the speed of downloading jdk and hadoop packages. | [YAML](Examples/Elastic/YAML/HadoopDistributedEnv3ECS.yml) [JSON](Examples/Elastic/JSON/HadoopDistributedEnv3ECS.json) |
| 16 | HadoopDistributedecsgroup | Deploy a Hadoop environment. One ECS instance plays role of master, and a instance group plays role of worker. *** WARNING *** Only test in CentOS-7. Maybe stopping firewall is needed. The deploying time mainly depends on the speed of downloading jdk and hadoop packages. | [YAML](Examples/Elastic/YAML/HadoopDistributedecsgroup.yml) [JSON](Examples/Elastic/JSON/HadoopDistributedecsgroup.json) |
| 17 | HadoopPseudoDistributedEnv | Deploy a Hadoop pseudo distributed environment on 1 ECS instance. The ECS instance plays the roles of master and slave. *** WARNING *** Only test in CentOS-7. Maybe stopping firewall is needed. The deploying time mainly depends on the speed of downloading JDK and hadoop packages. | [YAML](Examples/Elastic/YAML/HadoopPseudoDistributedEnv.yml) [JSON](Examples/Elastic/JSON/HadoopPseudoDistributedEnv.json) |
| 18 | JDKDNSSSHWithoutPassword3ECS | This template shows how to install and config a java jdk, domain name resolution and ssh login without password environment on 3 ECS instances. This template can be used as a start of other complex templates(like as hadoop and spark). | [YAML](Examples/Elastic/YAML/JDKDNSSSHWithoutPassword3ECS.yml) [JSON](Examples/Elastic/JSON/JDKDNSSSHWithoutPassword3ECS.json) |
| 19 | LNMPBasic | Deploy LNMP(Linux+Nginx+MySQL+PHP) stack on 1 ECS instance. *** WARNING *** Only support CentOS-7. | [YAML](Examples/Elastic/YAML/LNMPBasic.yml) [JSON](Examples/Elastic/JSON/LNMPBasic.json) |
| 20 | RDSWithECSInIpList | RDS instance + ECS instance + access for Intranet. | [YAML](Examples/Elastic/YAML/RDSWithECSInIpList.yml) [JSON](Examples/Elastic/JSON/RDSWithECSInIpList.json) |
| 21 | SLBWith2ECS | Firstly create one SLB, then create 2 ECS instances, finally attach the 2 instances to the SLB. | [YAML](Examples/Elastic/YAML/SLBWith2ECS.yml) [JSON](Examples/Elastic/JSON/SLBWith2ECS.json) |
| 22 | ScalingSimpleHAInfrastructure | According the existing ECS instance, clone a set of ECS instanes with the same configuration(InstanceType, ImageId, InternetChargeType, InternetMaxBandwidthIn, InternetMaxBandwidthOut, system disk, data disk configurations, VPC properties). The user needs to specify SourceInstanceId. | [YAML](Examples/Elastic/YAML/ScalingSimpleHAInfrastructure.yml) [JSON](Examples/Elastic/JSON/ScalingSimpleHAInfrastructure.json) |
| 23 | SimpleEcsInstance | One simple ECS instance with a security group and a vSwitch in a VPC. The user only needs to specify the image ID. | [YAML](Examples/Elastic/YAML/SimpleEcsInstance.yml) [JSON](Examples/Elastic/JSON/SimpleEcsInstance.json) |
| 24 | SimpleHighAvailableInfrastructure | User can create high available infrastructure. Some ECS  and one RDS will be created. ECS will be attached to one SLB. RDS is across multiple available zone. All the resources are under VPC environment. The customer could access this infrastructure through SLB. | [YAML](Examples/Elastic/YAML/SimpleHighAvailableInfrastructure.yml) [JSON](Examples/Elastic/JSON/SimpleHighAvailableInfrastructure.json) |
| 25 | SparkHadoopDistributedEnv3ECS | This template shows how to deploy a Hadoop-Spark environment on 3 ECS instances. One ECS instance plays role of master node, and the other 2 instances play role of worker node. Step 1 configs the ssh login without password. Step 2 installs and configs Java env. Step 3 installs and configs hadoop env. Step 4 installs and configs Spark env. *** WARNING *** Only support CentOS-7. Maybe stopping firewall is needed. The deploying time mainly depends on the speed of downloading 4 packages. | [YAML](Examples/Elastic/YAML/SparkHadoopDistributedEnv3ECS.yml) [JSON](Examples/Elastic/JSON/SparkHadoopDistributedEnv3ECS.json) |
| 26 | SparkHadoopEcsgroup | This template shows how to deploy a Hadoop-Spark environment. One ECS instance plays role of master, and one instance group plays role of worker. Step 1 configs the ssh login without password. Step 2 installs and configs Java env. Step 3 installs and configs hadoop env. Step 4 installs and configs Spark env. *** WARNING *** Only test in CentOS-7. Maybe stopping firewall is needed. The deploying time mainly depends on the speed of downloading 4 packages. | [YAML](Examples/Elastic/YAML/SparkHadoopEcsgroup.yml) [JSON](Examples/Elastic/JSON/SparkHadoopEcsgroup.json) |
| 27 | TensorFlowDeployment | Creates ECS instance and installs TensorFlow. | [YAML](Examples/Elastic/YAML/TensorFlowDeployment.yml) [JSON](Examples/Elastic/JSON/TensorFlowDeployment.json) |
| 28 | WordPressCluster | Creates a wordpress cluster. | [YAML](Examples/Elastic/YAML/WordPressCluster.yml) [JSON](Examples/Elastic/JSON/WordPressCluster.json) |
| 29 | WordPressClusterPhpMyAdmin | Deploys the WordPress site and the phpMyAdmin app. | [YAML](Examples/Elastic/YAML/WordPressClusterPhpMyAdmin.yml) [JSON](Examples/Elastic/JSON/WordPressClusterPhpMyAdmin.json) |
| 30 | WordPressInstance | Creates a wordpress instance. | [YAML](Examples/Elastic/YAML/WordPressInstance.yml) [JSON](Examples/Elastic/JSON/WordPressInstance.json) |

### Network
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | MicroVPCArchitecture | Micro business VPC network architecture. Create a VPC network and a subnet. ECS in sub-network access to international network through the public IP. | [YAML](Examples/Network/YAML/MicroVPCArchitecture.yml) [JSON](Examples/Network/JSON/MicroVPCArchitecture.json) |
| 2 | MiddleVPCArchitecture | Medium business VPC network architecture. Three subnets are created under VPC. ECS and SLB in Front subnet handle public network request. ECS, SLB, RDS, Redis, OSS and so on in Backend subnet provide core business logic. The network accesses the public network through NatGateway's SNAT. | [YAML](Examples/Network/YAML/MiddleVPCArchitecture.yml) [JSON](Examples/Network/JSON/MiddleVPCArchitecture.json) |
| 3 | SLBClone | Clones one SLB, and attaches ECS instances to the new LSB. The user only needs to specify the source SLB ID. | [YAML](Examples/Network/YAML/SLBClone.yml) [JSON](Examples/Network/JSON/SLBClone.json) |
| 4 | SmallVPCArchitecture | Small business VPC network architecture. Two subnets are created in the VPC. ECS access international network through NatGateway DNAT and SNAT. | [YAML](Examples/Network/YAML/SmallVPCArchitecture.yml) [JSON](Examples/Network/JSON/SmallVPCArchitecture.json) |
| 5 | VPC | Creates One VPC instance. | [YAML](Examples/Network/YAML/VPC.yml) [JSON](Examples/Network/JSON/VPC.json) |
| 6 | VPCNatGateway | Creates VPC environment and configures NatGateway to ensure ECS access internet and provider service for public. | [YAML](Examples/Network/YAML/VPCNatGateway.yml) [JSON](Examples/Network/JSON/VPCNatGateway.json) |
| 7 | VPCSnatGateway | Creates VPC environment and configures SnatGateway to ensure ECS access internet and provider service for public. | [YAML](Examples/Network/YAML/VPCSnatGateway.yml) [JSON](Examples/Network/JSON/VPCSnatGateway.json) |
| 8 | VPCVSwitchRouteSGECS | Creates one VPC, VSwitch, security group, ECS instance, and route. The user needs to specify the image ID. | [YAML](Examples/Network/YAML/VPCVSwitchRouteSGECS.yml) [JSON](Examples/Network/JSON/VPCVSwitchRouteSGECS.json) |

### Security
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | RAMCreateSubAccount | Creates a sub account, enable the console login, and create access key. | [YAML](Examples/Security/YAML/RAMCreateSubAccount.yml) [JSON](Examples/Security/JSON/RAMCreateSubAccount.json) |

### StackGroup
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | AliyunROSStackGroupAdministrationRole | Configure the AliyunROSStackGroupAdministrationRole to enable use of Alibaba Cloud ROS StackGroup. | [YAML](Examples/StackGroup/YAML/AliyunROSStackGroupAdministrationRole.yml) [JSON](Examples/StackGroup/JSON/AliyunROSStackGroupAdministrationRole.json) |
| 2 | AliyunROSStackGroupExecutionRole | Configure the AliyunROSStackGroupExecutionRole to enable use of your account as a target account in Alibaba Cloud ROS StackGroup. | [YAML](Examples/StackGroup/YAML/AliyunROSStackGroupExecutionRole.yml) [JSON](Examples/StackGroup/JSON/AliyunROSStackGroupExecutionRole.json) |

### Storage
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SimpleOSSBucket | Creates a simple oss bucket. | [YAML](Examples/Storage/YAML/SimpleOSSBucket.yml) [JSON](Examples/Storage/JSON/SimpleOSSBucket.json) |

### Windows
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SimpleWindowsInstanceWithSharepoint | Creates a Windows ECS instance with SharePoint2010 installed. | [YAML](Windows/YAML/SimpleWindowsInstanceWithSharepoint.yml) [JSON](Windows/JSON/SimpleWindowsInstanceWithSharepoint.json) |

## ResourceTemplates
### ACM
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Configuration | Create ACM Namespace、Configuration | [YAML](ResourceTemplates/ACM/YAML/Configuration.yml) [JSON](ResourceTemplates/ACM/JSON/Configuration.json)|
### ARMS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | AlertContactGroup | Create Arms AlertContact、AlertContactGroup | [YAML](ResourceTemplates/ARMS/YAML/AlertContactGroup.yml) [JSON](ResourceTemplates/ARMS/JSON/AlertContactGroup.json)|
| 2 | RetcodeApp | Create Arms RetcodeApp | [YAML](ResourceTemplates/ARMS/YAML/RetcodeApp.yml) [JSON](ResourceTemplates/ARMS/JSON/RetcodeApp.json)|
### ActionTrail
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | TrailLogging | Create ACTIONTRAIL Trail、TrailLogging | [YAML](ResourceTemplates/ActionTrail/YAML/TrailLogging.yml) [JSON](ResourceTemplates/ActionTrail/JSON/TrailLogging.json)|
### ApiGateway
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Api | Create ApiGateway Api、Group、App、Deployment、Authorization、Signature、SignatureBinding、TrafficControl、TrafficControlBinding、 | [YAML](ResourceTemplates/ApiGateway/YAML/Api.yml) [JSON](ResourceTemplates/ApiGateway/JSON/Api.json)|
| 2 | Instance | Create ApiGateway Instance | [YAML](ResourceTemplates/ApiGateway/YAML/Instance.yml) [JSON](ResourceTemplates/ApiGateway/JSON/Instance.json)|
| 3 | StageConfig | Create ApiGateway StageConfig | [YAML](ResourceTemplates/ApiGateway/YAML/StageConfig.yml) [JSON](ResourceTemplates/ApiGateway/JSON/StageConfig.json)|
| 4 | VpcAccessConfig | Create ApiGateway VpcAccessConfig | [YAML](ResourceTemplates/ApiGateway/YAML/VpcAccessConfig.yml) [JSON](ResourceTemplates/ApiGateway/JSON/VpcAccessConfig.json)|
| 5 | CustomDomain | Create ApiGateway CustomDomain | [YAML](ResourceTemplates/ApiGateway/YAML/CustomDomain.yml) [JSON](ResourceTemplates/ApiGateway/JSON/CustomDomain.json)|
### BSS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | WaitOrder | Create BSS WaitOrder | [YAML](ResourceTemplates/BSS/YAML/WaitOrder.yml) [JSON](ResourceTemplates/BSS/JSON/WaitOrder.json)|
### CAS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Certificate | Create CAS Certificate | [YAML](ResourceTemplates/CAS/YAML/Certificate.yml) [JSON](ResourceTemplates/CAS/JSON/Certificate.json)|
### CDN
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Domain | Create CDN Domain、DomainConfig | [YAML](ResourceTemplates/CDN/YAML/Domain.yml) [JSON](ResourceTemplates/CDN/JSON/Domain.json)|
### CEN
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Cen | Create Cen | [YAML](ResourceTemplates/CEN/YAML/Cen.yml) [JSON](ResourceTemplates/CEN/JSON/Cen.json)|
### CMS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Contact | Create CMS Contact、ContactGroup、DynamicTagGroup | [YAML](ResourceTemplates/CMS/YAML/Contact.yml) [JSON](ResourceTemplates/CMS/JSON/Contact.json)|
| 2 | MonitoringAgentProcess | Create CMS MonitoringAgentProcess | [YAML](ResourceTemplates/CMS/YAML/MonitoringAgentProcess.yml) [JSON](ResourceTemplates/CMS/JSON/MonitoringAgentProcess.json)|
| 3 | MonitorGroup | Create CMS MonitorGroup、MonitorGroupInstances | [YAML](ResourceTemplates/CMS/YAML/MonitorGroup.yml) [JSON](ResourceTemplates/CMS/JSON/MonitorGroup.json)|
| 4 | EventRule | Create CMS EventRule | [YAML](ResourceTemplates/CMS/YAML/EventRule.yml) [JSON](ResourceTemplates/CMS/JSON/EventRule.json)|
| 5 | EventRuleTargets | Create CMS EventRuleTargets | [YAML](ResourceTemplates/CMS/YAML/EventRuleTargets.yml) [JSON](ResourceTemplates/CMS/JSON/EventRuleTargets.json)|
### CR
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Repository | Create CR Repository | [YAML](ResourceTemplates/CR/YAML/Repository.yml) [JSON](ResourceTemplates/CR/JSON/Repository.json)|
| 2 | InstanceEndpointAclPolicy | Create create CR InstanceEndpointAclPolicy | [YAML](ResourceTemplates/CR/YAML/InstanceEndpointAclPolicy.yml) [JSON](ResourceTemplates/CR/JSON/InstanceEndpointAclPolicy.json)|
| 3 | Namespace | Create CR NameSpace | [YAML](ResourceTemplates/CR/YAML/Namespace.yml) [JSON](ResourceTemplates/CR/JSON/Namespace.json)|
### CS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | KubernetesCluster | Create Create KubernetesCluster | [YAML](ResourceTemplates/CS/YAML/KubernetesCluster.yml) [JSON](ResourceTemplates/CS/JSON/KubernetesCluster.json)|
| 2 | AnyCluster | Create AnyCluster | [YAML](ResourceTemplates/CS/YAML/AnyCluster.yml) [JSON](ResourceTemplates/CS/JSON/AnyCluster.json)|
| 3 | ManagedEdgeKubernetesCluster | Create ManagedEdgeKubernetesCluster | [YAML](ResourceTemplates/CS/YAML/ManagedEdgeKubernetesCluster.yml) [JSON](ResourceTemplates/CS/JSON/ManagedEdgeKubernetesCluster.json)|
| 4 | ManagedKubernetesCluster | Create Create ManagedKubernetesCluster | [YAML](ResourceTemplates/CS/YAML/ManagedKubernetesCluster.yml) [JSON](ResourceTemplates/CS/JSON/ManagedKubernetesCluster.json)|
| 5 | ServerlessKubernetesCluster | Create ServerlessKubernetesCluster | [YAML](ResourceTemplates/CS/YAML/ServerlessKubernetesCluster.yml) [JSON](ResourceTemplates/CS/JSON/ServerlessKubernetesCluster.json)|
### DNS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Domain | Create DNS Domain、DomainGroup | [YAML](ResourceTemplates/DNS/YAML/Domain.yml) [JSON](ResourceTemplates/DNS/JSON/Domain.json)|
| 2 | DomainRecord | Create DNS DomainRecord | [YAML](ResourceTemplates/DNS/YAML/DomainRecord.yml) [JSON](ResourceTemplates/DNS/JSON/DomainRecord.json)|
### DRDS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | DrdsInstance | Create DrdsInstance | [YAML](ResourceTemplates/DRDS/YAML/DrdsInstance.yml) [JSON](ResourceTemplates/DRDS/JSON/DrdsInstance.json)|
### DTS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | DTS | Create DTS MigrationJob、SynchronizationJob | [YAML](ResourceTemplates/DTS/YAML/DTS.yml) [JSON](ResourceTemplates/DTS/JSON/DTS.json)|
### DataHub
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Topic | Create DataHub Project、Topic | [YAML](ResourceTemplates/DataHub/YAML/Topic.yml) [JSON](ResourceTemplates/DataHub/JSON/Topic.json)|
### ECI
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ContainerGroup | Create ECI ContainerGroup | [YAML](ResourceTemplates/ECI/YAML/ContainerGroup.yml) [JSON](ResourceTemplates/ECI/JSON/ContainerGroup.json)|
| 2 | ImageCache | Create ECI ImageCache | [YAML](ResourceTemplates/ECI/YAML/ImageCache.yml) [JSON](ResourceTemplates/ECI/JSON/ImageCache.json)|
### ECS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SNatEntry | Create ECS SecurityGroupIngress | [YAML](ResourceTemplates/ECS/YAML/SNatEntry.yml) [JSON](ResourceTemplates/ECS/JSON/SNatEntry.json)|
| 2 | AutoSnapshotPolicy | Create ECS AutoSnapshotPolicy | [YAML](ResourceTemplates/ECS/YAML/AutoSnapshotPolicy.yml) [JSON](ResourceTemplates/ECS/JSON/AutoSnapshotPolicy.json)|
| 3 | SecurityGroupEgress | Create ECS SecurityGroupEgress | [YAML](ResourceTemplates/ECS/YAML/SecurityGroupEgress.yml) [JSON](ResourceTemplates/ECS/JSON/SecurityGroupEgress.json)|
| 4 | NetworkInterfaceAttachment | Create ECS NetworkInterface、NetworkInterfaceAttachment | [YAML](ResourceTemplates/ECS/YAML/NetworkInterfaceAttachment.yml) [JSON](ResourceTemplates/ECS/JSON/NetworkInterfaceAttachment.json)|
| 5 | InstanceClone | Create ECS Instance Clone | [YAML](ResourceTemplates/ECS/YAML/InstanceClone.yml) [JSON](ResourceTemplates/ECS/JSON/InstanceClone.json)|
| 6 | SecurityGroupIngress | Create ECS SecurityGroupIngress | [YAML](ResourceTemplates/ECS/YAML/SecurityGroupIngress.yml) [JSON](ResourceTemplates/ECS/JSON/SecurityGroupIngress.json)|
| 7 | DedicatedHost | Create ECS DedicatedHost | [YAML](ResourceTemplates/ECS/YAML/DedicatedHost.yml) [JSON](ResourceTemplates/ECS/JSON/DedicatedHost.json)|
| 8 | DeploymentSet | Create ECS DeploymentSet | [YAML](ResourceTemplates/ECS/YAML/DeploymentSet.yml) [JSON](ResourceTemplates/ECS/JSON/DeploymentSet.json)|
| 9 | Instance | Create Vpc ECS instance、EIP、NatGateway、SSHKeyPair | [YAML](ResourceTemplates/ECS/YAML/Instance.yml) [JSON](ResourceTemplates/ECS/JSON/Instance.json)|
| 10 | LaunchTemplate | Create ECS LaunchTemplate、AutoProvisioningGroup | [YAML](ResourceTemplates/ECS/YAML/LaunchTemplate.yml) [JSON](ResourceTemplates/ECS/JSON/LaunchTemplate.json)|
| 11 | HpcCluster | Create ECS HpcCluster | [YAML](ResourceTemplates/ECS/YAML/HpcCluster.yml) [JSON](ResourceTemplates/ECS/JSON/HpcCluster.json)|
| 12 | JoinSecurityGroup | Create ECS JoinSecurityGroup | [YAML](ResourceTemplates/ECS/YAML/JoinSecurityGroup.yml) [JSON](ResourceTemplates/ECS/JSON/JoinSecurityGroup.json)|
| 13 | NatGateway | Create ECS NatGateway、BandwidthPackage | [YAML](ResourceTemplates/ECS/YAML/NatGateway.yml) [JSON](ResourceTemplates/ECS/JSON/NatGateway.json)|
| 14 | AssignPrivateIpAddresses | Create ECS AssignPrivateIpAddresses | [YAML](ResourceTemplates/ECS/YAML/AssignPrivateIpAddresses.yml) [JSON](ResourceTemplates/ECS/JSON/AssignPrivateIpAddresses.json)|
| 15 | PrepayInstance | Create ECS PrepayInstance | [YAML](ResourceTemplates/ECS/YAML/PrepayInstance.yml) [JSON](ResourceTemplates/ECS/JSON/PrepayInstance.json)|
| 16 | RunCommand | Create ECS RunCommand | [YAML](ResourceTemplates/ECS/YAML/RunCommand.yml) [JSON](ResourceTemplates/ECS/JSON/RunCommand.json)|
| 17 | Route | Create ECS Route、AssignIpv6Addresses | [YAML](ResourceTemplates/ECS/YAML/Route.yml) [JSON](ResourceTemplates/ECS/JSON/Route.json)|
| 18 | ForwardEntry | Create ECS ForwardEntry | [YAML](ResourceTemplates/ECS/YAML/ForwardEntry.yml) [JSON](ResourceTemplates/ECS/JSON/ForwardEntry.json)|
| 19 | SecurityGroupClone | Create ECS SecurityGroupClone | [YAML](ResourceTemplates/ECS/YAML/SecurityGroupClone.yml) [JSON](ResourceTemplates/ECS/JSON/SecurityGroupClone.json)|
| 20 | Disk | Create ECS Disk | [YAML](ResourceTemplates/ECS/YAML/Disk.yml) [JSON](ResourceTemplates/ECS/JSON/Disk.json)|
| 21 | InstanceGroup | Create ECS InstanceGroup、InstanceGroupClone、Command、Invocation | [YAML](ResourceTemplates/ECS/YAML/InstanceGroup.yml) [JSON](ResourceTemplates/ECS/JSON/InstanceGroup.json)|
| 22 | CustomImage | Create ECS CustomImage、CopyImage | [YAML](ResourceTemplates/ECS/YAML/CustomImage.yml) [JSON](ResourceTemplates/ECS/JSON/CustomImage.json)|
| 23 | DiskAttachment | Create ECS DiskAttachment、Snapshot | [YAML](ResourceTemplates/ECS/YAML/DiskAttachment.yml) [JSON](ResourceTemplates/ECS/JSON/DiskAttachment.json)|
### EDAS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ClusterMember | Create EDAS ClusterMember | [YAML](ResourceTemplates/EDAS/YAML/ClusterMember.yml) [JSON](ResourceTemplates/EDAS/JSON/ClusterMember.json)|
| 2 | Cluster | Create EDAS Cluster、App、DeployGroup | [YAML](ResourceTemplates/EDAS/YAML/Cluster.yml) [JSON](ResourceTemplates/EDAS/JSON/Cluster.json)|
### EHPC
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Cluster | Create EHPC Cluster | [YAML](ResourceTemplates/EHPC/YAML/Cluster.yml) [JSON](ResourceTemplates/EHPC/JSON/Cluster.json)|
### EMR
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Cluster | Create EMR Cluster | [YAML](ResourceTemplates/EMR/YAML/Cluster.yml) [JSON](ResourceTemplates/EMR/JSON/Cluster.json)|
### ESS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ScalingGroup | Create ESS ScalingGroup、ScalingRule、AlarmTask、AlarmTaskEnable、LifecycleHook、ScheduledTask | [YAML](ResourceTemplates/ESS/YAML/ScalingGroup.yml) [JSON](ResourceTemplates/ESS/JSON/ScalingGroup.json)|
| 2 | ScalingGroupEnable | Create ESS ScalingConfiguration、ScalingGroupEnable | [YAML](ResourceTemplates/ESS/YAML/ScalingGroupEnable.yml) [JSON](ResourceTemplates/ESS/JSON/ScalingGroupEnable.json)|
### ElasticSearch
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Instance | Create ElasticSearch Instance | [YAML](ResourceTemplates/ElasticSearch/YAML/Instance.yml) [JSON](ResourceTemplates/ElasticSearch/JSON/Instance.json)|
### FC
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | FunctionInvoker | Create FC FunctionInvoker、Trigger、Version、Alias、ProvisionConfig | [YAML](ResourceTemplates/FC/YAML/FunctionInvoker.yml) [JSON](ResourceTemplates/FC/JSON/FunctionInvoker.json)|
| 2 | CustomDomain | Create FC CustomDomain | [YAML](ResourceTemplates/FC/YAML/CustomDomain.yml) [JSON](ResourceTemplates/FC/JSON/CustomDomain.json)|
### FNF
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Flow | Create FNF Flow、Schedule | [YAML](ResourceTemplates/FNF/YAML/Flow.yml) [JSON](ResourceTemplates/FNF/JSON/Flow.json)|
### GWS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Cluster | Create GWS Cluster、Instance | [YAML](ResourceTemplates/GWS/YAML/Cluster.yml) [JSON](ResourceTemplates/GWS/JSON/Cluster.json)|
### IOT
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Rule | Create IOT Rule | [YAML](ResourceTemplates/IOT/YAML/Rule.yml) [JSON](ResourceTemplates/IOT/JSON/Rule.json)|
| 2 | DeviceGroup | Create IOT DeviceGroup | [YAML](ResourceTemplates/IOT/YAML/DeviceGroup.yml) [JSON](ResourceTemplates/IOT/JSON/DeviceGroup.json)|
| 3 | Device | Create IOT Product、Device | [YAML](ResourceTemplates/IOT/YAML/Device.yml) [JSON](ResourceTemplates/IOT/JSON/Device.json)|
### KMS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Key | Create KMS Key、Alias | [YAML](ResourceTemplates/KMS/YAML/Key.yml) [JSON](ResourceTemplates/KMS/JSON/Key.json)|
| 2 | Secret | Create KMS Secret | [YAML](ResourceTemplates/KMS/YAML/Secret.yml) [JSON](ResourceTemplates/KMS/JSON/Secret.json)|
### Kafka
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Instance | Create create Kafka Instance、Topic | [YAML](ResourceTemplates/Kafka/YAML/Instance.yml) [JSON](ResourceTemplates/Kafka/JSON/Instance.json)|
### MNS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Subscription | Create MNS Queue、Topic、Subscription | [YAML](ResourceTemplates/MNS/YAML/Subscription.yml) [JSON](ResourceTemplates/MNS/JSON/Subscription.json)|
### MSE
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Cluster | Create MSE Cluster | [YAML](ResourceTemplates/MSE/YAML/Cluster.yml) [JSON](ResourceTemplates/MSE/JSON/Cluster.json)|
### MarketPlace
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Order | Create MarketPlace Order | [YAML](ResourceTemplates/MarketPlace/YAML/Order.yml) [JSON](ResourceTemplates/MarketPlace/JSON/Order.json)|
### Memcache
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Instance | Create Memcache Instance、WhiteList | [YAML](ResourceTemplates/Memcache/YAML/Instance.yml) [JSON](ResourceTemplates/Memcache/JSON/Instance.json)|
### MongoDB
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ServerlessInstance | Create MONGODB ServerlessInstance | [YAML](ResourceTemplates/MongoDB/YAML/ServerlessInstance.yml) [JSON](ResourceTemplates/MongoDB/JSON/ServerlessInstance.json)|
| 2 | ShardingInstance | Create MongoDb ShardingInstance | [YAML](ResourceTemplates/MongoDB/YAML/ShardingInstance.yml) [JSON](ResourceTemplates/MongoDB/JSON/ShardingInstance.json)|
| 3 | MongoDBInstance | Create MONGODB Instance | [YAML](ResourceTemplates/MongoDB/YAML/MongoDBInstance.yml) [JSON](ResourceTemplates/MongoDB/JSON/MongoDBInstance.json)|
### NAS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | NAS | Create NAS AccessGroupName、AccessRule、FileSystem、MountTarget | [YAML](ResourceTemplates/NAS/YAML/NAS.yml) [JSON](ResourceTemplates/NAS/JSON/NAS.json)|
### OOS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Parameter | Create OOS Parameter | [YAML](ResourceTemplates/OOS/YAML/Parameter.yml) [JSON](ResourceTemplates/OOS/JSON/Parameter.json)|
| 2 | OOS | Create OOS Template、Execution | [YAML](ResourceTemplates/OOS/YAML/OOS.yml) [JSON](ResourceTemplates/OOS/JSON/OOS.json)|
### OSS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Bucket | Create OSS Bucket | [YAML](ResourceTemplates/OSS/YAML/Bucket.yml) [JSON](ResourceTemplates/OSS/JSON/Bucket.json)|
### OTS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | OTS | Create OTS Table、Instance、VpcBinder | [YAML](ResourceTemplates/OTS/YAML/OTS.yml) [JSON](ResourceTemplates/OTS/JSON/OTS.json)|
### POLARDB
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | POLARDB | Create POLARDB | [YAML](ResourceTemplates/POLARDB/YAML/POLARDB.yml) [JSON](ResourceTemplates/POLARDB/JSON/POLARDB.json)|
### PVTZ
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | PVTZ | Create PVTZ Zone、ZoneRecord、ZoneVpcBinder | [YAML](ResourceTemplates/PVTZ/YAML/PVTZ.yml) [JSON](ResourceTemplates/PVTZ/JSON/PVTZ.json)|
### RAM
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ManagedPolicy | Create RAM ManagedPolicy | [YAML](ResourceTemplates/RAM/YAML/ManagedPolicy.yml) [JSON](ResourceTemplates/RAM/JSON/ManagedPolicy.json)|
| 2 | Role | Create RAM Role | [YAML](ResourceTemplates/RAM/YAML/Role.yml) [JSON](ResourceTemplates/RAM/JSON/Role.json)|
| 3 | AccessKey | Create RAM User、AccessKey | [YAML](ResourceTemplates/RAM/YAML/AccessKey.yml) [JSON](ResourceTemplates/RAM/JSON/AccessKey.json)|
| 4 | AttachPolicyToRole | Create RAM Role、AttachPolicyToRole | [YAML](ResourceTemplates/RAM/YAML/AttachPolicyToRole.yml) [JSON](ResourceTemplates/RAM/JSON/AttachPolicyToRole.json)|
| 5 | User | Create RAM User、Group、AttachPolicyToUser、UserToGroupAddition | [YAML](ResourceTemplates/RAM/YAML/User.yml) [JSON](ResourceTemplates/RAM/JSON/User.json)|
### RDS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | PrepayDBInstance | Create RDS PrepayDBInstance | [YAML](ResourceTemplates/RDS/YAML/PrepayDBInstance.yml) [JSON](ResourceTemplates/RDS/JSON/PrepayDBInstance.json)|
| 2 | DBInstance | Create RDS DBInstance、Account、AccountPrivilege | [YAML](ResourceTemplates/RDS/YAML/DBInstance.yml) [JSON](ResourceTemplates/RDS/JSON/DBInstance.json)|
### ROCKETMQ
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ROCKETMQ | Create ROCKETMQ Instance、Group、Topic | [YAML](ResourceTemplates/ROCKETMQ/YAML/ROCKETMQ.yml) [JSON](ResourceTemplates/ROCKETMQ/JSON/ROCKETMQ.json)|
### ROS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Stack | Create ROS Stack | [YAML](ResourceTemplates/ROS/YAML/Stack.yml) [JSON](ResourceTemplates/ROS/JSON/Stack.json)|
| 2 | WaitCondition | Create ROS WaitCondition | [YAML](ResourceTemplates/ROS/YAML/WaitCondition.yml) [JSON](ResourceTemplates/ROS/JSON/WaitCondition.json)|
| 3 | CustomResource | Create ROS CustomResource | [YAML](ResourceTemplates/ROS/YAML/CustomResource.yml) [JSON](ResourceTemplates/ROS/JSON/CustomResource.json)|
| 4 | AutoEnableService | Create ROS AutoEnableService | [YAML](ResourceTemplates/ROS/YAML/AutoEnableService.yml) [JSON](ResourceTemplates/ROS/JSON/AutoEnableService.json)|
| 5 | WaitConditionHandle | Create ROS WaitConditionHandle | [YAML](ResourceTemplates/ROS/YAML/WaitConditionHandle.yml) [JSON](ResourceTemplates/ROS/JSON/WaitConditionHandle.json)|
### Redis
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Instance | Create Create Redis Instance、Whitelist and Account | [YAML](ResourceTemplates/Redis/YAML/Instance.yml) [JSON](ResourceTemplates/Redis/JSON/Instance.json)|
| 2 | PrepayInstance | Create Create Redis PrepayInstance | [YAML](ResourceTemplates/Redis/YAML/PrepayInstance.yml) [JSON](ResourceTemplates/Redis/JSON/PrepayInstance.json)|
### ResourceManeger
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ResourceGroup | Create ResourceManager ResourceGroup | [YAML](ResourceTemplates/ResourceManeger/YAML/ResourceGroup.yml) [JSON](ResourceTemplates/ResourceManeger/JSON/ResourceGroup.json)|
| 2 | Handshake | Create ResourceManager Handshake | [YAML](ResourceTemplates/ResourceManeger/YAML/Handshake.yml) [JSON](ResourceTemplates/ResourceManeger/JSON/Handshake.json)|
### SAE
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SAE | Create SAE Application、Namespace、SlbBinding, and deploy Application | [YAML](ResourceTemplates/SAE/YAML/SAE.yml) [JSON](ResourceTemplates/SAE/JSON/SAE.json)|
### SAG
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ACL | Create SAG ACL、ACLRule | [YAML](ResourceTemplates/SAG/YAML/ACL.yml) [JSON](ResourceTemplates/SAG/JSON/ACL.json)|
### SLB
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Listener | Create SLB LoadBalancer、Listener、LoadBalancerClone、Certificate、DomainExtension、VServerGroup、Rule | [YAML](ResourceTemplates/SLB/YAML/Listener.yml) [JSON](ResourceTemplates/SLB/JSON/Listener.json)|
| 2 | BackendServerAttachment | Create SLB BackendServerAttachment、MasterSlaveServerGroup | [YAML](ResourceTemplates/SLB/YAML/BackendServerAttachment.yml) [JSON](ResourceTemplates/SLB/JSON/BackendServerAttachment.json)|
| 3 | AccessControl | Create SLB AccessControl | [YAML](ResourceTemplates/SLB/YAML/AccessControl.yml) [JSON](ResourceTemplates/SLB/JSON/AccessControl.json)|
### SLS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SLS | Create SLS Project、Logstore、Alert、Index、SavedSearch、LogtailConfig、MachineGroup、ApplyConfigToMachineGroup、ApiGatewayLogConfig | [YAML](ResourceTemplates/SLS/YAML/SLS.yml) [JSON](ResourceTemplates/SLS/JSON/SLS.json)|
### UIS
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | UIS | Create UIS UisNode、UisConnection | [YAML](ResourceTemplates/UIS/YAML/UIS.yml) [JSON](ResourceTemplates/UIS/JSON/UIS.json)|
### VPC
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SnatEntry | Create Vpc SnatEntry、CommonBandwidthPackage、Ipv6Gateway、ECS AssignIpv6Addresses | [YAML](ResourceTemplates/VPC/YAML/SnatEntry.yml) [JSON](ResourceTemplates/VPC/JSON/SnatEntry.json)|
| 2 | RouterInterfaceUpdate | Create Vpc RouterInterface | [YAML](ResourceTemplates/VPC/YAML/RouterInterfaceUpdate.yml) [JSON](ResourceTemplates/VPC/JSON/RouterInterfaceUpdate.json)|
| 3 | RouteTable | Create Vpc RouteTable | [YAML](ResourceTemplates/VPC/YAML/RouteTable.yml) [JSON](ResourceTemplates/VPC/JSON/RouteTable.json)|
| 4 | Eip | Create Vpc EIP | [YAML](ResourceTemplates/VPC/YAML/Eip.yml) [JSON](ResourceTemplates/VPC/JSON/Eip.json)|
| 5 | EIPAssociation | Create Vpc EIPAssociation | [YAML](ResourceTemplates/VPC/YAML/EIPAssociation.yml) [JSON](ResourceTemplates/VPC/JSON/EIPAssociation.json)|
| 6 | RouterInterface | Create Vpc RouterInterface | [YAML](ResourceTemplates/VPC/YAML/RouterInterface.yml) [JSON](ResourceTemplates/VPC/JSON/RouterInterface.json)|
| 7 | NatGateway | Create VPC NatGateway | [YAML](ResourceTemplates/VPC/YAML/NatGateway.yml) [JSON](ResourceTemplates/VPC/JSON/NatGateway.json)|
### WAF
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | Domain | Create Waf Domain | [YAML](ResourceTemplates/WAF/YAML/Domain.yml) [JSON](ResourceTemplates/WAF/JSON/Domain.json)|
| 2 | DomainConfig | Create Waf DomainConfig、AclRule、WafSwitch | [YAML](ResourceTemplates/WAF/YAML/DomainConfig.yml) [JSON](ResourceTemplates/WAF/JSON/DomainConfig.json)|
| 3 | Instance | Warning: Waf Instance only support prepay type | [YAML](ResourceTemplates/WAF/YAML/Instance.yml) [JSON](ResourceTemplates/WAF/JSON/Instance.json)|
