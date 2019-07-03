# [Click here for English Version](#english)

# ROS Templates
本仓库包含了编写 ROS 模板的示例和最佳实践。

## Application
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ECSCloneJoinSLS | 创建一组ECS，并将其作为指定的SLS中相关project的logtail的机器组。 | [YAML](Application/YAML/ECSCloneJoinSLS.yml) [JSON](Application/JSON/ECSCloneJoinSLS.json) |
| 2 | ECSGroupJoinSLS | 克隆ECS并将IP指向日志服务中新创建的机器组，并应用指定的规则。 | [YAML](Application/YAML/ECSGroupJoinSLS.yml) [JSON](Application/JSON/ECSGroupJoinSLS.json) |

## CsApps
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | DockerDatacneterEnterprise | 基于Docker EE一键部署 DDC。 | [YAML](CsApps/YAML/DockerDatacneterEnterprise.yml) [JSON](CsApps/JSON/DockerDatacneterEnterprise.json) |
| 2 | DockerSwarm | 一键创建Docker Swarm模式集群。 | [YAML](CsApps/YAML/DockerSwarm.yml) [JSON](CsApps/JSON/DockerSwarm.json) |
| 3 | JStorm | 创建JStorm容器服务集群。JStorm依赖的Zookeeper也会一并部署。 | [YAML](CsApps/YAML/JStorm.yml) [JSON](CsApps/JSON/JStorm.json) |
| 4 | Jenkins | 创建Jenkins容器服务集群。 | [YAML](CsApps/YAML/Jenkins.yml) [JSON](CsApps/JSON/Jenkins.json) |

## DB
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | MemcacheInstance | 创建一个云数据库Memcache版实例。 | [YAML](DB/YAML/MemcacheInstance.yml) [JSON](DB/JSON/MemcacheInstance.json) |
| 2 | MongoDBInstance | 创建一个云数据库MongoDB版实例。 | [YAML](DB/YAML/MongoDBInstance.yml) [JSON](DB/JSON/MongoDBInstance.json) |
| 3 | RDSInstance | 创建一个云数据库RDS版实例。 | [YAML](DB/YAML/RDSInstance.yml) [JSON](DB/JSON/RDSInstance.json) |
| 4 | RedisInstance | 创建一个云数据库Redis版实例。 | [YAML](DB/YAML/RedisInstance.yml) [JSON](DB/JSON/RedisInstance.json) |

## Elastic
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ECSGroupAttachMultipleSLB | 创建ECS，在/etc/hosts中绑定IP和机器名，并把ECS加入多个SLB。 | [YAML](Elastic/YAML/ECSGroupAttachMultipleSLB.yml) [JSON](Elastic/JSON/ECSGroupAttachMultipleSLB.json) |
| 2 | ECSGroupClassic | 创建一组相同配置的ECS实例，采用经典网络，同属一个安全组。 | [YAML](Elastic/YAML/ECSGroupClassic.yml) [JSON](Elastic/JSON/ECSGroupClassic.json) |
| 3 | ECSGroupClone | 根据已有的ECS实例，克隆出相同配置的一组ECS实例。 | [YAML](Elastic/YAML/ECSGroupClone.yml) [JSON](Elastic/JSON/ECSGroupClone.json) |
| 4 | ECSGroupVPC | 创建一组相同配置的ecs实例，同属一个VPC和安全组。 | [YAML](Elastic/YAML/ECSGroupVPC.yml) [JSON](Elastic/JSON/ECSGroupVPC.json) |
| 5 | ECSImageDiskSnapshot | 指定镜像、磁盘快照创建ECS实例。 | [YAML](Elastic/YAML/ECSImageDiskSnapshot.yml) [JSON](Elastic/JSON/ECSImageDiskSnapshot.json) |
| 6 | ECSMountMultipleUninitializedDataDisks | 在VPC环境中创建ECS，申请弹性IP，并分区，格式化，挂载多个数据盘。 | [YAML](Elastic/YAML/ECSMountMultipleUninitializedDataDisks.yml) [JSON](Elastic/JSON/ECSMountMultipleUninitializedDataDisks.json) |
| 7 | ECSVPCInstance | 创建VPC网络下的ECS实例。 | [YAML](Elastic/YAML/ECSVPCInstance.yml) [JSON](Elastic/JSON/ECSVPCInstance.json) |
| 8 | ECSWith2DataDisk | 创建一个ECS实例，挂载两个快照数据盘。 | [YAML](Elastic/YAML/ECSWith2DataDisk.yml) [JSON](Elastic/JSON/ECSWith2DataDisk.json) |
| 9 | ECSWithJavaWebEnviroment | 部署Java Web开发测试环境。 | [YAML](Elastic/YAML/ECSWithJavaWebEnviroment.yml) [JSON](Elastic/JSON/ECSWithJavaWebEnviroment.json) |
| 10 | ECSWithNodejsEnviroment | 部署Node.js开发测试环境。 | [YAML](Elastic/YAML/ECSWithNodejsEnviroment.yml) [JSON](Elastic/JSON/ECSWithNodejsEnviroment.json) |
| 11 | ECSWithRubyEnviroment | 基于一个ECS实例和本地MySQL部署Rails on Ruby。 | [YAML](Elastic/YAML/ECSWithRubyEnviroment.yml) [JSON](Elastic/JSON/ECSWithRubyEnviroment.json) |
| 12 | ECSWithSSHKey | 创建一个ECS实例，并配置SSH Key。 | [YAML](Elastic/YAML/ECSWithSSHKey.yml) [JSON](Elastic/JSON/ECSWithSSHKey.json) |
| 13 | ESS1SLB2RDS2ECS | 创建一个ESS实例，其下挂载一个SLB实例、两个RDS实例。SLB实例下挂两个ECS实例。 | [YAML](Elastic/YAML/ESS1SLB2RDS2ECS.yml) [JSON](Elastic/JSON/ESS1SLB2RDS2ECS.json) |
| 14 | EntireECSClone | 完全克隆一台ECS实例，包括源ECS中的数据。 | [YAML](Elastic/YAML/EntireECSClone.yml) [JSON](Elastic/JSON/EntireECSClone.json) |
| 15 | HadoopDistributedEnv3ECS | 部署Hadoop分布式开发环境。 | [YAML](Elastic/YAML/HadoopDistributedEnv3ECS.yml) [JSON](Elastic/JSON/HadoopDistributedEnv3ECS.json) |
| 16 | HadoopDistributedecsgroup | 基于ECS Group部署Hadoop分布式环境。 | [YAML](Elastic/YAML/HadoopDistributedecsgroup.yml) [JSON](Elastic/JSON/HadoopDistributedecsgroup.json) |
| 17 | HadoopPseudoDistributedEnv | 部署Hadoop伪分布式开发环境。 | [YAML](Elastic/YAML/HadoopPseudoDistributedEnv.yml) [JSON](Elastic/JSON/HadoopPseudoDistributedEnv.json) |
| 18 | JDKDNSSSHWithoutPassword3ECS | 创建3个ECS实例, 并安装配置JDK，域名解析和无密码ssh登录环境。基于该模板，我们可以编写其他的复杂模板（例如，Hadoop和Spark模板）。 | [YAML](Elastic/YAML/JDKDNSSSHWithoutPassword3ECS.yml) [JSON](Elastic/JSON/JDKDNSSSHWithoutPassword3ECS.json) |
| 19 | LNMPBasic | 一键部署LNMP(Linux+Nginx+MySQL+PHP)栈。 | [YAML](Elastic/YAML/LNMPBasic.yml) [JSON](Elastic/JSON/LNMPBasic.json) |
| 20 | RDSWithECSInIpList | 创建一个RDS实例和一个ECS实例，且内网可访问。 | [YAML](Elastic/YAML/RDSWithECSInIpList.yml) [JSON](Elastic/JSON/RDSWithECSInIpList.json) |
| 21 | SLBWith2ECS | 创建一个SLB实例和两个ECS实例，并进行挂载。 | [YAML](Elastic/YAML/SLBWith2ECS.yml) [JSON](Elastic/JSON/SLBWith2ECS.json) |
| 22 | ScalingSimpleHAInfrastructure | 根据指定的ECS实例，克隆指定数量的ECS，并加入到指定的SLB中。 | [YAML](Elastic/YAML/ScalingSimpleHAInfrastructure.yml) [JSON](Elastic/JSON/ScalingSimpleHAInfrastructure.json) |
| 23 | SimpleEcsInstance | 简单创建一个包含安全组和vSwitch的ECS实例。 | [YAML](Elastic/YAML/SimpleEcsInstance.yml) [JSON](Elastic/JSON/SimpleEcsInstance.json) |
| 24 | SimpleHighAvailableInfrastructure | 创建一个简单的高可用基础架构：在VPC网络下，创建ECS实例并加入到一个SLB，同时创建多可用区RDS。外部用户可通过SLB访问应用。 | [YAML](Elastic/YAML/SimpleHighAvailableInfrastructure.yml) [JSON](Elastic/JSON/SimpleHighAvailableInfrastructure.json) |
| 25 | SparkHadoopDistributedEnv3ECS | 基于3个ECS实例和NAT网关，部署Spark和Hadoop分布式环境。 | [YAML](Elastic/YAML/SparkHadoopDistributedEnv3ECS.yml) [JSON](Elastic/JSON/SparkHadoopDistributedEnv3ECS.json) |
| 26 | SparkHadoopEcsgroup | 基于ECS Group部署Spark和Hadoop分布式环境。 | [YAML](Elastic/YAML/SparkHadoopEcsgroup.yml) [JSON](Elastic/JSON/SparkHadoopEcsgroup.json) |
| 27 | TensorFlowDeployment | 创建ECS实例，并安装TensorFlow。 | [YAML](Elastic/YAML/TensorFlowDeployment.yml) [JSON](Elastic/JSON/TensorFlowDeployment.json) |
| 28 | WordPressCluster | 在VPC网络环境下创建WordPress集群，并配置VPC的SNAT功能访问网络。 | [YAML](Elastic/YAML/WordPressCluster.yml) [JSON](Elastic/JSON/WordPressCluster.json) |
| 29 | WordPressClusterPhpMyAdmin | 创建WordPress集群和phpMyAdmin应用。 | [YAML](Elastic/YAML/WordPressClusterPhpMyAdmin.yml) [JSON](Elastic/JSON/WordPressClusterPhpMyAdmin.json) |
| 30 | WordPressInstance | 基于ECS和RDS创建WordPress环境。 | [YAML](Elastic/YAML/WordPressInstance.yml) [JSON](Elastic/JSON/WordPressInstance.json) |

## Network
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | MicroVPCArchitecture | 微型VPC企业网络架构。在VPC下创建了一个子网。ECS实例通过公网IP访问外部网络。 | [YAML](Network/YAML/MicroVPCArchitecture.yml) [JSON](Network/JSON/MicroVPCArchitecture.json) |
| 2 | MiddleVPCArchitecture | 中型VPC企业网络架构。在VPC下创建了三个子网。前端子网中的ECS和SLB处理公共网络请求。后端子网中的ECS、SLB、RDS、Redis、OSS等提供核心业务逻辑。网络通过NatGateway的SNAT访问公共网络。 | [YAML](Network/YAML/MiddleVPCArchitecture.yml) [JSON](Network/JSON/MiddleVPCArchitecture.json) |
| 3 | SLBClone | 将源负载均衡挂载的实例挂载到一个新的负载均衡上。 | [YAML](Network/YAML/SLBClone.yml) [JSON](Network/JSON/SLBClone.json) |
| 4 | SmallVPCArchitecture | 小型企业VPC网络架构。在VPC中创建了两个子网。ECS通过NatGateway DNAT和SNAT访问外部网络。 | [YAML](Network/YAML/SmallVPCArchitecture.yml) [JSON](Network/JSON/SmallVPCArchitecture.json) |
| 5 | VPC | 创建一个VPC实例。 | [YAML](Network/YAML/VPC.yml) [JSON](Network/JSON/VPC.json) |
| 6 | VPCNatGateway | 在VPC网络下创建ECS实例并配置NatGateway使VPC网络中的ECS实例可访问外网和提供服务。 | [YAML](Network/YAML/VPCNatGateway.yml) [JSON](Network/JSON/VPCNatGateway.json) |
| 7 | VPCSnatGateway | 一键创建SNAT网关，VPC环境下创建一个绑定了EIP的ECS实例做为SNAT网关。 | [YAML](Network/YAML/VPCSnatGateway.yml) [JSON](Network/JSON/VPCSnatGateway.json) |
| 8 | VPCVSwitchRouteSGECS | 创建一个VPC、一个VSwitch、一个安全组、一个ECS实例和一条自定义路由。 | [YAML](Network/YAML/VPCVSwitchRouteSGECS.yml) [JSON](Network/JSON/VPCVSwitchRouteSGECS.json) |

## Security
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | RAMCreateSubAccount | 创建子帐号, 生成ak，并开启控制台登录。 | [YAML](Security/YAML/RAMCreateSubAccount.yml) [JSON](Security/JSON/RAMCreateSubAccount.json) |

## Storage
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SimpleOSSBucket | 创建一个OSS Bucket。 | [YAML](Storage/YAML/SimpleOSSBucket.yml) [JSON](Storage/JSON/SimpleOSSBucket.json) |

## Windows
| 序号   | 名称           | 描述（用途）                     | 链接         |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SimpleWindowsInstanceWithSharepoint | 创建一个Windows实例，并安装SharePoint。 | [YAML](Windows/YAML/SimpleWindowsInstanceWithSharepoint.yml) [JSON](Windows/JSON/SimpleWindowsInstanceWithSharepoint.json) |

# English
This repository contains examples and best practices for building ROS templates.

## Application
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ECSCloneJoinSLS | Clones an ECS instance, and consider it as the machine group of the related project logtail in Log Serivce. | [YAML](Application/YAML/ECSCloneJoinSLS.yml) [JSON](Application/JSON/ECSCloneJoinSLS.json) |
| 2 | ECSGroupJoinSLS | Creates a set of ECS instance, and consider it as the machine group of the related project logtail in Log Serivce. | [YAML](Application/YAML/ECSGroupJoinSLS.yml) [JSON](Application/JSON/ECSGroupJoinSLS.json) |

## CsApps
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | DockerDatacneterEnterprise | DDC for Aliyun. | [YAML](CsApps/YAML/DockerDatacneterEnterprise.yml) [JSON](CsApps/JSON/DockerDatacneterEnterprise.json) |
| 2 | DockerSwarm | Docker for Aliyun. | [YAML](CsApps/YAML/DockerSwarm.yml) [JSON](CsApps/JSON/DockerSwarm.json) |
| 3 | JStorm | Create one container service cluster and deploy JStorm with its dependency Zookeeper. | [YAML](CsApps/YAML/JStorm.yml) [JSON](CsApps/JSON/JStorm.json) |
| 4 | Jenkins | Create a container service clusters to deploy Jenkins master and slaves with different languages. | [YAML](CsApps/YAML/Jenkins.yml) [JSON](CsApps/JSON/Jenkins.json) |

## DB
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | MemcacheInstance | Creates one classic memcache instance. | [YAML](DB/YAML/MemcacheInstance.yml) [JSON](DB/JSON/MemcacheInstance.json) |
| 2 | MongoDBInstance | Creates one classic MongoDB instance. | [YAML](DB/YAML/MongoDBInstance.yml) [JSON](DB/JSON/MongoDBInstance.json) |
| 3 | RDSInstance | Creates one classic RDS instance. | [YAML](DB/YAML/RDSInstance.yml) [JSON](DB/JSON/RDSInstance.json) |
| 4 | RedisInstance | Creates one Redis instance. | [YAML](DB/YAML/RedisInstance.yml) [JSON](DB/JSON/RedisInstance.json) |

## Elastic
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | ECSGroupAttachMultipleSLB | Creates an ECS Instance Group attach SLB. | [YAML](Elastic/YAML/ECSGroupAttachMultipleSLB.yml) [JSON](Elastic/JSON/ECSGroupAttachMultipleSLB.json) |
| 2 | ECSGroupClassic | One security group holds a set of ECS instances with the same configuration, using classic network. | [YAML](Elastic/YAML/ECSGroupClassic.yml) [JSON](Elastic/JSON/ECSGroupClassic.json) |
| 3 | ECSGroupClone | According the existing ECS instance, clone a set of ECS instanes with the same configuration(InstanceType, ImageId, InternetChargeType, InternetMaxBandwidthIn, InternetMaxBandwidthOut, system disk, data disk configurations, VPC properties). The user only needs to specify SourceInstanceId. | [YAML](Elastic/YAML/ECSGroupClone.yml) [JSON](Elastic/JSON/ECSGroupClone.json) |
| 4 | ECSGroupVPC | One VPC and security group hold a set of ECS instances with the same configuration. | [YAML](Elastic/YAML/ECSGroupVPC.yml) [JSON](Elastic/JSON/ECSGroupVPC.json) |
| 5 | ECSImageDiskSnapshot | Specify the image Id and snapshot to create ECS instance. | [YAML](Elastic/YAML/ECSImageDiskSnapshot.yml) [JSON](Elastic/JSON/ECSImageDiskSnapshot.json) |
| 6 | ECSMountMultipleUninitializedDataDisks | Creates an ECS and mount multiple uninitialized data disks. | [YAML](Elastic/YAML/ECSMountMultipleUninitializedDataDisks.yml) [JSON](Elastic/JSON/ECSMountMultipleUninitializedDataDisks.json) |
| 7 | ECSVPCInstance | Creates VPC ECS instance. | [YAML](Elastic/YAML/ECSVPCInstance.yml) [JSON](Elastic/JSON/ECSVPCInstance.json) |
| 8 | ECSWith2DataDisk | Creates an ecs, mounts two data disks created by snapshots. | [YAML](Elastic/YAML/ECSWith2DataDisk.yml) [JSON](Elastic/JSON/ECSWith2DataDisk.json) |
| 9 | ECSWithJavaWebEnviroment | This template installs jdk and tomcat on a new ECS instance. | [YAML](Elastic/YAML/ECSWithJavaWebEnviroment.yml) [JSON](Elastic/JSON/ECSWithJavaWebEnviroment.json) |
| 10 | ECSWithNodejsEnviroment | This template show how to deploy a Node.js environment and do a test based on a new ECS instance. ***WARNING***, this template only supports CentOS. | [YAML](Elastic/YAML/ECSWithNodejsEnviroment.yml) [JSON](Elastic/JSON/ECSWithNodejsEnviroment.json) |
| 11 | ECSWithRubyEnviroment | Creates a Ruby on Rails stack using a single ECS instance with a local MySQL database for storage. This example creates a simple hello world application from the template. *** WARNING *** This template only supports CentOS-7. When 'rvm install 2.3.1' may take long time. | [YAML](Elastic/YAML/ECSWithRubyEnviroment.yml) [JSON](Elastic/JSON/ECSWithRubyEnviroment.json) |
| 12 | ECSWithSSHKey | Creates an ECS and configure SSH key. | [YAML](Elastic/YAML/ECSWithSSHKey.yml) [JSON](Elastic/JSON/ECSWithSSHKey.json) |
| 13 | ESS1SLB2RDS2ECS | Creates 1 SLB, 2 ECS instances, 1 ESS and 1 RDS. Attach the instances and ESS to the SLB. | [YAML](Elastic/YAML/ESS1SLB2RDS2ECS.yml) [JSON](Elastic/JSON/ESS1SLB2RDS2ECS.json) |
| 14 | EntireECSClone | Clones ECS Instance And DataBase Disk. | [YAML](Elastic/YAML/EntireECSClone.yml) [JSON](Elastic/JSON/EntireECSClone.json) |
| 15 | HadoopDistributedEnv3ECS | Deploy a Hadoop environment on 3 ECS instances. One ECS instance plays role of master node, and the other 2 instances play role of worker node. *** WARNING *** Only test in CentOS-7. Maybe stopping firewall is needed. The deploying time mainly depends on the speed of downloading jdk and hadoop packages. | [YAML](Elastic/YAML/HadoopDistributedEnv3ECS.yml) [JSON](Elastic/JSON/HadoopDistributedEnv3ECS.json) |
| 16 | HadoopDistributedecsgroup | Deploy a Hadoop environment. One ECS instance plays role of master, and a instance group plays role of worker. *** WARNING *** Only test in CentOS-7. Maybe stopping firewall is needed. The deploying time mainly depends on the speed of downloading jdk and hadoop packages. | [YAML](Elastic/YAML/HadoopDistributedecsgroup.yml) [JSON](Elastic/JSON/HadoopDistributedecsgroup.json) |
| 17 | HadoopPseudoDistributedEnv | Deploy a Hadoop pseudo distributed environment on 1 ECS instance. The ECS instance plays the roles of master and slave. *** WARNING *** Only test in CentOS-7. Maybe stopping firewall is needed. The deploying time mainly depends on the speed of downloading JDK and hadoop packages. | [YAML](Elastic/YAML/HadoopPseudoDistributedEnv.yml) [JSON](Elastic/JSON/HadoopPseudoDistributedEnv.json) |
| 18 | JDKDNSSSHWithoutPassword3ECS | This template shows how to install and config a java jdk, domain name resolution and ssh login without password environment on 3 ECS instances. This template can be used as a start of other complex templates(like as hadoop and spark). | [YAML](Elastic/YAML/JDKDNSSSHWithoutPassword3ECS.yml) [JSON](Elastic/JSON/JDKDNSSSHWithoutPassword3ECS.json) |
| 19 | LNMPBasic | Deploy LNMP(Linux+Nginx+MySQL+PHP) stack on 1 ECS instance. *** WARNING *** Only support CentOS-7. | [YAML](Elastic/YAML/LNMPBasic.yml) [JSON](Elastic/JSON/LNMPBasic.json) |
| 20 | RDSWithECSInIpList | RDS instance + ECS instance + access for Intranet. | [YAML](Elastic/YAML/RDSWithECSInIpList.yml) [JSON](Elastic/JSON/RDSWithECSInIpList.json) |
| 21 | SLBWith2ECS | Firstly create one SLB, then create 2 ECS instances, finally attach the 2 instances to the SLB. | [YAML](Elastic/YAML/SLBWith2ECS.yml) [JSON](Elastic/JSON/SLBWith2ECS.json) |
| 22 | ScalingSimpleHAInfrastructure | According the existing ECS instance, clone a set of ECS instanes with the same configuration(InstanceType, ImageId, InternetChargeType, InternetMaxBandwidthIn, InternetMaxBandwidthOut, system disk, data disk configurations, VPC properties). The user needs to specify SourceInstanceId. | [YAML](Elastic/YAML/ScalingSimpleHAInfrastructure.yml) [JSON](Elastic/JSON/ScalingSimpleHAInfrastructure.json) |
| 23 | SimpleEcsInstance | One simple ECS instance with a security group and a vSwitch in a VPC. The user only needs to specify the image ID. | [YAML](Elastic/YAML/SimpleEcsInstance.yml) [JSON](Elastic/JSON/SimpleEcsInstance.json) |
| 24 | SimpleHighAvailableInfrastructure | User can create high available infrastructure. Some ECS  and one RDS will be created. ECS will be attached to one SLB. RDS is across multiple available zone. All the resources are under VPC environment. The customer could access this infrastructure through SLB. | [YAML](Elastic/YAML/SimpleHighAvailableInfrastructure.yml) [JSON](Elastic/JSON/SimpleHighAvailableInfrastructure.json) |
| 25 | SparkHadoopDistributedEnv3ECS | This template shows how to deploy a Hadoop-Spark environment on 3 ECS instances. One ECS instance plays role of master node, and the other 2 instances play role of worker node. Step 1 configs the ssh login without password. Step 2 installs and configs Java env. Step 3 installs and configs hadoop env. Step 4 installs and configs Spark env. *** WARNING *** Only support CentOS-7. Maybe stopping firewall is needed. The deploying time mainly depends on the speed of downloading 4 packages. | [YAML](Elastic/YAML/SparkHadoopDistributedEnv3ECS.yml) [JSON](Elastic/JSON/SparkHadoopDistributedEnv3ECS.json) |
| 26 | SparkHadoopEcsgroup | This template shows how to deploy a Hadoop-Spark environment. One ECS instance plays role of master, and one instance group plays role of worker. Step 1 configs the ssh login without password. Step 2 installs and configs Java env. Step 3 installs and configs hadoop env. Step 4 installs and configs Spark env. *** WARNING *** Only test in CentOS-7. Maybe stopping firewall is needed. The deploying time mainly depends on the speed of downloading 4 packages. | [YAML](Elastic/YAML/SparkHadoopEcsgroup.yml) [JSON](Elastic/JSON/SparkHadoopEcsgroup.json) |
| 27 | TensorFlowDeployment | Creates ECS instance and installs TensorFlow. | [YAML](Elastic/YAML/TensorFlowDeployment.yml) [JSON](Elastic/JSON/TensorFlowDeployment.json) |
| 28 | WordPressCluster | Creates a wordpress cluster. | [YAML](Elastic/YAML/WordPressCluster.yml) [JSON](Elastic/JSON/WordPressCluster.json) |
| 29 | WordPressClusterPhpMyAdmin | Deploys the WordPress site and the phpMyAdmin app. | [YAML](Elastic/YAML/WordPressClusterPhpMyAdmin.yml) [JSON](Elastic/JSON/WordPressClusterPhpMyAdmin.json) |
| 30 | WordPressInstance | Creates a wordpress instance. | [YAML](Elastic/YAML/WordPressInstance.yml) [JSON](Elastic/JSON/WordPressInstance.json) |

## Network
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | MicroVPCArchitecture | Micro business VPC network architecture. Create a VPC network and a subnet. ECS in sub-network access to international network through the public IP. | [YAML](Network/YAML/MicroVPCArchitecture.yml) [JSON](Network/JSON/MicroVPCArchitecture.json) |
| 2 | MiddleVPCArchitecture | Medium business VPC network architecture. Three subnets are created under VPC. ECS and SLB in Front subnet handle public network request. ECS, SLB, RDS, Redis, OSS and so on in Backend subnet provide core business logic. The network accesses the public network through NatGateway's SNAT. | [YAML](Network/YAML/MiddleVPCArchitecture.yml) [JSON](Network/JSON/MiddleVPCArchitecture.json) |
| 3 | SLBClone | Clones one SLB, and attaches ECS instances to the new LSB. The user only needs to specify the source SLB ID. | [YAML](Network/YAML/SLBClone.yml) [JSON](Network/JSON/SLBClone.json) |
| 4 | SmallVPCArchitecture | Small business VPC network architecture. Two subnets are created in the VPC. ECS access international network through NatGateway DNAT and SNAT. | [YAML](Network/YAML/SmallVPCArchitecture.yml) [JSON](Network/JSON/SmallVPCArchitecture.json) |
| 5 | VPC | Creates One VPC instance. | [YAML](Network/YAML/VPC.yml) [JSON](Network/JSON/VPC.json) |
| 6 | VPCNatGateway | Creates VPC environment and configures NatGateway to ensure ECS access internet and provider service for public. | [YAML](Network/YAML/VPCNatGateway.yml) [JSON](Network/JSON/VPCNatGateway.json) |
| 7 | VPCSnatGateway | Creates VPC environment and configures SnatGateway to ensure ECS access internet and provider service for public. | [YAML](Network/YAML/VPCSnatGateway.yml) [JSON](Network/JSON/VPCSnatGateway.json) |
| 8 | VPCVSwitchRouteSGECS | Creates one VPC, VSwitch, security group, ECS instance, and route. The user needs to specify the image ID. | [YAML](Network/YAML/VPCVSwitchRouteSGECS.yml) [JSON](Network/JSON/VPCVSwitchRouteSGECS.json) |

## Security
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | RAMCreateSubAccount | Creates a sub account, enable the console login, and create access key. | [YAML](Security/YAML/RAMCreateSubAccount.yml) [JSON](Security/JSON/RAMCreateSubAccount.json) |

## Storage
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SimpleOSSBucket | Creates a simple oss bucket. | [YAML](Storage/YAML/SimpleOSSBucket.yml) [JSON](Storage/JSON/SimpleOSSBucket.json) |

## Windows
| No.   | Name           | Description                     | Links        |
| ----- | -------------- | ------------------------------- | ------------ |
| 1 | SimpleWindowsInstanceWithSharepoint | Creates a Windows ECS instance with SharePoint2010 installed. | [YAML](Windows/YAML/SimpleWindowsInstanceWithSharepoint.yml) [JSON](Windows/JSON/SimpleWindowsInstanceWithSharepoint.json) |
