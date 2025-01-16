## 方案概览

基于对象存储 OSS 构建的数据湖，可对接多种数据输入方式，存储任何规模的结构化、半结构化、非结构化数据，打破数据湖孤岛；无缝对接多种数据分析产品，对存储在对象存储 OSS 中的数据直接进行数据分析和机器学习，洞察业务价值。同时，数据湖提供多种存储类型的冷热分层转换能力，通过数据全生命周期管理优化存储成本。

本技术解决方案以搭建一个大数据分析服务和一个机器学习服务为例，为您演示：

* 如何使用 OSS 中的数据完成一个大数据分析任务
* 如何使用 OSS 中的数据训练一个深度学习模型

## 方案架构

方案提供的默认设置完成部署后在阿里云上搭建的运行环境如架构图所示（蓝色高亮部分）。实际部署时您可以根据资源规划修改部分设置，但最终形成的运行环境与架构图相似。


本方案以大数据分析场景和机器学习场景为例。本方案的技术架构包括以下基础设施和云服务：

* 1 个对象存储 OSS ：提供数据存储。
* 1 个EMR集群：提供大数据计算引擎。
* 1 个PAI：提供机器学习引擎。

## 方案部署
### 部署准备


开始部署前，请按以下指引完成账号申请、账号充值、服务开通、RAM 用户创建和授权。

#### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [开通对象存储 OSS](https://oss.console.aliyun.com/overview?spm=5176.7933691.J_5253785160.3.12a52c47BQREC6)、[开通阿里云 E-MapReduce](https://emr-next.console.aliyun.com/?spm=5176.21211227.J_5253785160.3.2b86123ceW6T7G#/create/ecs) 、[开通 PAI 并创建默认工作空间](https://pai.console.aliyun.com/?regionId=cn-shanghai&spm=5176.14066474.J_5834642020.3.6175754ckPAydC)。
3. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。
   
   1. 为节省成本，本方案默认选择使用按量付费及抢占式资源，使用按量付费资源需要确保账户余额不小于 100 元。
   2. 完成本方案的部署及体验，预计产生费用不超过 5 元（假设您选择最低规格资源，且资源运行时间不超过 30 分钟。如调整了资源规格，请以控制台显示的实际报价以及最终账单为准）。
      
      | 序号 | 产品 | 费用来源 | 规格 | 地域 | 预估费用参考 | 说明 |
      | --- | --- | --- | --- | --- | --- | --- |
      | 1 | 对象存储 OSS | 标准存储（本地冗余）容量（Storage）费 | - | 华东2（上海） | 0.12元/GB/月 | 测试数据量较少 |
      | PUT 类或 GET 类请求费 | - | 华东2（上海） | 0.01元/万次 | 测试请求量较少 |
      | 2 | 阿里云 E-MapReduce | ECS 产品费用 | ecs.g6.xlarge\*3 | 华东2（上海） | 3.0元/小时 |  |
      | E-MapReduce 服务费用 | ecs.g6.xlarge\*3 | 华东2（上海） | 0.45元/小时 |  |
      | 3 | 人工智能平台 PAI | DLC 深度学习训练费用 | ecs.g6.xlarge\*1 | 华东2（上海） | 1.1元/小时 |  |
      | 按量费用：4.71元/时 | | | | | | |
4. 创建用于方案部署的 RAM 用户。
   
   1. 创建 1 个 RAM 用户。具体操作，请参见[创建 RAM 用户](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user)。
   2. 为 RAM 用户授予以下云服务的访问权限以完成方案部署。具体操作，请参见[为 RAM 用户授权](https://help.aliyun.com/zh/ram/user-guide/grant-permissions-to-the-ram-user)。
      
      | **云服务** | **需要的权限** | **描述** |
      | --- | --- | --- |
      | 云服务器 ECS | AliyunECSFullAccess | 管理云服务器 ECS 的权限 |
      | 专有网络 VPC | AliyunVPCFullAccess | 管理专有网络 VPC 的权限 |
      | 对象存储 OSS | AliyunOSSFullAccess | 管理对象存储 OSS 权限 |
      | E-MapReduce | AliyunEMRFullAccess | 管理 E-MapReduce 的权限 |
      | 机器学习 PAI | AliyunPAIFullAccess | 管理机器学习（PAI）的权限 |
      | 资源编排服务 ROS | AliyunROSFullAccess | 管理资源编排服务 ROS 的权限 |
      | 运维编排服务 OOS | AliyunOOSFullAccess | 管理运维编排服务 OOS 的权限 |
      | 配额 Quotas | AliyunQuotasFullAccess | 管理配额 Quotas 的权限 |
      | 访问控制 RAM | AliyunRAMFullAccess | 管理访问控制 RAM 的权限，即管理用户以及授权的权限 |
      | 标签服务 TAG | AliyunTagManagerAccess | 管理标签服务 TAG 的权限 |
### 一键部署


一键部署基于阿里云资源编排服务 ROS（Resource Orchestration Service）实现，ROS 模板已定义好脚本，可自动化地完成云资源的创建和配置，提高资源的创建和部署效率。ROS 模板完成的内容包括：

#### 操作步骤

您可以通过下方提供的 ROS 一键部署链接，来自动化地完成这些资源的创建和配置：

* 创建 1 个对象存储 OSS Bucket 。
* 创建并绑定 1 个 EMR 集群
* 创建 1 个 PAI 工作空间

1. 一键部署 EMR 集群和 OSS Bucket 。
   
   1. 打开[一键部署链接](https://ros.console.aliyun.com/region/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/cloud-native-enterprise-data-lake.yml&pageTitle=云原生企业级数据湖&disableRollback=false&isSimplified=true&productNavBar=disabled)，并选择华东 2（上海）地域。
   2. 在**配置模板参数**页面上修改资源栈名称，配置 EMR 集群、OSS Bucket 、PAI 工作空间，然后单击**创建**开始一键配置。
   3. 当**资源栈信息**页面的**状态**显示为**创建成功**时表示一键配置完成。
2. 上传待分析的数据。
   
   1. 下载待分析的文件。
      
      示例文件：[The\_Sorrows\_of\_Young\_Werther.txt](https://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/cn/emr/1.3.7/assets/res/The_Sorrows_of_Young_Werther.txt?spm=a2c4g.28128.0.0.b1ac456fW3JkHH&file=The_Sorrows_of_Young_Werther.txt)
   2. 上传待分析的文件到 OSS 。
      
      1. 登录 [OSS 管理控制台](https://oss.console.aliyun.com/overview)。
      2. 在左侧导航栏，选择**Bucket列表**。
      3. **Bucket 列表**页面，单击目标 Bucket 。
      4. 在左侧导航栏，选择**文件管理 > 文件列表**。
      5. 在**文件列表**页面，单击**新建目录**，新建 inputs 目录，然后单击**上传文件**，将待分析的文件上传到 inputs 目录下。
3. 编写数据分析作业。
   
   1. 在本地安装 Maven 和 Java 环境。
      
      本示例中 Maven 是 3.0 版本，Java 是 1.8 版本。
   2. 执行以下命令生成工程框架。
      
      例如，您的工程开发根目录是 D:/workspace。
      
      ```
      mvn archetype:generate -DgroupId=com.aliyun.emr.hadoop.examples -DartifactId=wordcountv2 -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
      ```
      
      通过以上命令会自动生成一个空的 Sample 工程位于 D:/workspace/wordcountv2（和您指定的 artifactId 一致），里面包含一个简单的 pom.xml 和 App 类（类的包路径和您指定的 groupId 一致）。
   3. 加入 Hadoop 依赖。
      
      使用 IDE 打开 Sample 工程，编辑 pom.xml 文件，当 Hadoop 是 2.8.5 版本时，需要添加如下内容。
      
      ```
      <dependency>
       <groupId>org.apache.hadoop</groupId>
       <artifactId>hadoop-mapreduce-client-common</artifactId>
       <version>2.8.5</version>
      </dependency>
      <dependency>
       <groupId>org.apache.hadoop</groupId>
       <artifactId>hadoop-common</artifactId>
       <version>2.8.5</version>
      </dependency>
      ```
   4. 编写代码。
      
      1. 在 com.aliyun.emr.hadoop.examples 中和 App 类平行的位置添加新类EMapReduceOSSUtil 。
         
         ```
         package com.aliyun.emr.hadoop.examples;
          import org.apache.hadoop.conf.Configuration;
          public class EMapReduceOSSUtil {
          private static String SCHEMA = "oss://";
          private static String EPSEP = ".";
          private static String HTTP_HEADER = "http://";
          /**
          * complete OSS uri
          * convert uri like: oss://bucket/path to oss://bucket.endpoint/path
          * ossref do not need this
          *
          * @param oriUri original OSS uri
          */
          public static String buildOSSCompleteUri(String oriUri, String endpoint) {
          if (endpoint == null) {
          System.err.println("miss endpoint");
          return oriUri;
          }
          int index = oriUri.indexOf(SCHEMA);
          if (index == -1 || index != 0) {
          return oriUri;
          }
          int bucketIndex = index + SCHEMA.length();
          int pathIndex = oriUri.indexOf("/", bucketIndex);
          String bucket = null;
          if (pathIndex == -1) {
          bucket = oriUri.substring(bucketIndex);
          } else {
          bucket = oriUri.substring(bucketIndex, pathIndex);
          }
          StringBuilder retUri = new StringBuilder();
          retUri.append(SCHEMA)
          .append(bucket)
          .append(EPSEP)
          .append(stripHttp(endpoint));
          if (pathIndex > 0) {
          retUri.append(oriUri.substring(pathIndex));
          }
          return retUri.toString();
          }
          public static String buildOSSCompleteUri(String oriUri, Configuration conf) {
          return buildOSSCompleteUri(oriUri, conf.get("fs.oss.endpoint"));
          }
          private static String stripHttp(String endpoint) {
          if (endpoint.startsWith(HTTP_HEADER)) {
          return endpoint.substring(HTTP_HEADER.length());
          }
          return endpoint;
          }
          }
         ```
      2. 在 com.aliyun.emr.hadoop.examples 中和 App 类平行的位置添加新类WordCount2.java ，并修改其中的访问密钥和 Endpoint 。其中，Endpoint 使用OSS Bucket 的内网域名。
         
         ```
         package com.aliyun.emr.hadoop.examples;
         import java.io.BufferedReader;
         import java.io.FileReader;
         import java.io.IOException;
         import java.net.URI;
         import java.util.ArrayList;
         import java.util.HashSet;
         import java.util.List;
         import java.util.Set;
         import java.util.StringTokenizer;
         import org.apache.hadoop.conf.Configuration;
         import org.apache.hadoop.fs.Path;
         import org.apache.hadoop.io.IntWritable;
         import org.apache.hadoop.io.Text;
         import org.apache.hadoop.mapreduce.Job;
         import org.apache.hadoop.mapreduce.Mapper;
         import org.apache.hadoop.mapreduce.Reducer;
         import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
         import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
         import org.apache.hadoop.mapreduce.Counter;
         import org.apache.hadoop.util.GenericOptionsParser;
         import org.apache.hadoop.util.StringUtils;
         
         
         public class WordCount2 {
             public static class TokenizerMapper
                     extends Mapper<Object, Text, Text, IntWritable>{
                 static enum CountersEnum { INPUT_WORDS }
                 private final static IntWritable one = new IntWritable(1);
                 private Text word = new Text();
                 private boolean caseSensitive;
                 private Set<String> patternsToSkip = new HashSet<String>();
                 private Configuration conf;
                 private BufferedReader fis;
                 @Override
                 public void setup(Context context) throws IOException,
                         InterruptedException {
                     conf = context.getConfiguration();
                     caseSensitive = conf.getBoolean("wordcount.case.sensitive", true);
                     if (conf.getBoolean("wordcount.skip.patterns", true)) {
                         URI[] patternsURIs = Job.getInstance(conf).getCacheFiles();
                         System.out.print(conf.toString());
                         System.out.print(patternsURIs);
                         if (patternsURIs == null) {
                             return;
                         }
                         for (URI patternsURI : patternsURIs) {
                             Path patternsPath = new Path(patternsURI.getPath());
                             String patternsFileName = patternsPath.getName().toString();
                             parseSkipFile(patternsFileName);
                         }
                     }
                 }
                 private void parseSkipFile(String fileName) {
                     try {
                         fis = new BufferedReader(new FileReader(fileName));
                         String pattern = null;
                         while ((pattern = fis.readLine()) != null) {
                             patternsToSkip.add(pattern);
                         }
                     } catch (IOException ioe) {
                         System.err.println("Caught exception while parsing the cached file '"
                                 + StringUtils.stringifyException(ioe));
                     }
                 }
                 @Override
                 public void map(Object key, Text value, Context context
                 ) throws IOException, InterruptedException {
                     String line = (caseSensitive) ?
                             value.toString() : value.toString().toLowerCase();
                     for (String pattern : patternsToSkip) {
                         line = line.replaceAll(pattern, "");
                     }
                     StringTokenizer itr = new StringTokenizer(line);
                     while (itr.hasMoreTokens()) {
                         word.set(itr.nextToken());
                         context.write(word, one);
                         Counter counter = context.getCounter(CountersEnum.class.getName(),
                                 CountersEnum.INPUT_WORDS.toString());
                         counter.increment(1);
                     }
                 }
             }
             public static class IntSumReducer
                     extends Reducer<Text,IntWritable,Text,IntWritable> {
                 private IntWritable result = new IntWritable();
                 public void reduce(Text key, Iterable<IntWritable> values,
                                    Context context
                 ) throws IOException, InterruptedException {
                     int sum = 0;
                     for (IntWritable val : values) {
                         sum += val.get();
                     }
                     result.set(sum);
                     context.write(key, result);
                 }
             }
             public static void main(String[] args) throws Exception {
                 Configuration conf = new Configuration();
                 conf.set("fs.oss.accessKeyId", "<yourAccessKeyID>"); 
                 conf.set("fs.oss.accessKeySecret", "<yourAccessKeySecret>");
                 conf.set("fs.oss.endpoint","<yourOSSEndpoint>");
                 GenericOptionsParser optionParser = new GenericOptionsParser(conf, args);
                 String[] remainingArgs = optionParser.getRemainingArgs();
                 if (!(remainingArgs.length != 2 || remainingArgs.length != 4)) {
                     System.err.println("Usage: wordcount <in> <out> [-skip skipPatternFile]");
                     System.exit(2);
                 }
                 Job job = Job.getInstance(conf, "word count");
                 job.setJarByClass(WordCount2.class);
                 job.setMapperClass(TokenizerMapper.class);
                 job.setCombinerClass(IntSumReducer.class);
                 job.setReducerClass(IntSumReducer.class);
                 job.setOutputKeyClass(Text.class);
                 job.setOutputValueClass(IntWritable.class);
                 List<String> otherArgs = new ArrayList<String>();
                 for (int i=0; i < remainingArgs.length; ++i) {
                     if ("-skip".equals(remainingArgs[i])) {
                         job.addCacheFile(new Path(EMapReduceOSSUtil.buildOSSCompleteUri(remainingArgs[++i], conf)).toUri());
                         job.getConfiguration().setBoolean("wordcount.skip.patterns", true);
                     } else {
                         otherArgs.add(remainingArgs[i]);
                     }
                 }
                 FileInputFormat.addInputPath(job, new Path(EMapReduceOSSUtil.buildOSSCompleteUri(otherArgs.get(0), conf)));
                 FileOutputFormat.setOutputPath(job, new Path(EMapReduceOSSUtil.buildOSSCompleteUri(otherArgs.get(1), conf)));
                 System.exit(job.waitForCompletion(true) ? 0 : 1);
             }
         }
         ```
   5. 在工程的目录下，执行如下命令，编译并打包文件。
      
      ```
      mvn clean package -DskipTests
      ```
      
      您可以在工程目录的 target 目录下看到名称为 wordcountv2-1.0-SNAPSHOT.jar 的JAR 包。
4. 创建并运行数据分析作业。
   
   1. 登录 [EMR on ECS 控制台](https://emr-next.console.aliyun.com/region/cn-hangzhou/resource/all/ecs/list#/region/cn-hangzhou/resource/all/ecs/list)。
   2. 在顶部菜单栏处，选择**华东 2（上海**）地域。
   3. 在 **EMR on ECS** 页面，单击创建的集群的 ID。
   4. 选择**节点管理**页签，单击 emr-master 节点组左侧的加号，然后单击 master-1-1 节点的 ID 。
   5. 在云服务器 ECS 的**实例详情**页面的**基本信息**中，单击**远程连接**，然后根据页面提示登录ECS 。
   6. 在顶部菜单栏，选择**文件 > 打开新文件管理 > root**，单击**上传文件**，根据页面提示上传 wordcountv2-1.0-SNAPSHOT.jar 。
   7. 在 root 目录下执行以下命令创建并运行数据分析作业。
      
      ```
      spark-submit --class com.aliyun.emr.hadoop.examples.WordCount2 wordcountv2-1.0-SNAPSHOT.jar oss://<OSS创建的Bucket名称>/inputs oss://<OSS创建的Bucket名称>/outputs
      ```
5. 上传待训练的数据。
   
   1. 下载并解压待训练的文件。
      
      示例文件：[hymenoptera\_data.zip](https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20231116/rhqs/hymenoptera_data.zip)
   2. 上传待训练的文件夹到 OSS 。
      
      1. 登录 [OSS 管理控制台](https://oss.console.aliyun.com/overview)。
      2. 在左侧导航栏，选择 **Bucket 列表**。
      3. **Bucket 列表**页面，单击目标 Bucket 。
      4. 在左侧导航栏，选择**文件管理 > 文件列表**。
      5. 在**文件列表**页面，然后单击**上传文件**，选择**扫描文件夹**，然后根据页面提示，上传待训练的文件夹。文件夹中的文件数量较多，请勿中途关闭上传页面，以免上传失败。
6. 创建数据集。
   
   1. 登录 [PAI 控制台](https://pai.console.aliyun.com/?regionId=cn-shanghai)。
   2. 在左侧导航栏，选择 **AI 资产管理 > 数据集**。
   3. 在**数据集管理**页面，单击**创建数据集**。
   4. 在**创建数据集**面板，参考下表填写参数，然后单击**提交**。
      
      | **项目** | **说明** | **示例值** |
      | --- | --- | --- |
      | 数据集名称 | 本文以常用数据集hymenoptera\_data 为例。该数据集用于图像分类任务，特别是昆虫分类。它包含了两个类别的昆虫图像：蚂蚁和蜜蜂。 | hymenoptera\_data |
      | 从阿里云云存储创建 | 选择上一步将训练数据上传到 OSS Bucket 后生成的文件路径。 | oss://<OSS的Bucket>.oss-cn-shanghai.aliyuncs.com/hymenoptera\_data/ |
7. 创建并运行模型训练任务。
   
   1. 在 [PAI 控制台](https://pai.console.aliyun.com/?regionId=cn-shanghai)的左侧导航栏，选择**模型开发与训练 > 分布式训练（DLC）**。
   2. 在**分布式训练**页面，单击**新建任务**，参考下表填写参数，然后单击**提交**。
      
      | **项目** | **说明** | **示例值** |
      | --- | --- | --- |
      | 任务名称 | 本文要训练的模型是基于ResNet18 架构进行微调的，用于图像分类任务。 | resnet18-ft-hymenoptera-classifier |
      | 节点镜像 | 本文以 pytorch 社区镜像为例。 | easyanimate:1.1.5-pytorch2.2.0-gpu-py310-cu118-ubuntu22.04 |
      | 框架 | 本文以深度学习框架PyTorch 为例。PyTorch 提供了用于构建和训练神经网络的高级 API 和工具，是一个用于进行机器学习和深度学习的强大工具。 | PyTorch |
      | 数据集配置 | 选择创建的数据集进行挂载。 | hymenoptera\_data  /mnt/data |
      | 执行命令 | 示例执行命令使用 wget 下载名为 main.py 的 Python 脚本文件，并通过python 命令将输入目录`/mnt/data`和输出目录`/mnt/data/`作为命令行参数传递给该脚本。 | ``` wget https://pai-public-data.oss-cn-beijing.aliyuncs.com/hol-pytorch-transfer-cv/main.py && python main.py -i /mnt/data -o /mnt/data/ ``` |
      | 任务资源 | 点击资源规格，在弹窗中选择 GPU 。 | ecs.gn7i-c8g1.2xlarge |
      
      ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2814798271/p859277.png)
      ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2814798271/p859282.png)
### 验证及清理


#### 方案验证

##### 一、通过监控大数据处理任务，验证 EMR 集群的数据处理能力

1. 监控任务执行
   
   1. 登录 [EMR on ECS 控制台](https://emr-next.console.aliyun.com/region/cn-hangzhou/resource/all/ecs/list#/region/cn-hangzhou/resource/all/ecs/list)。
   2. 在顶部菜单栏，选择**华东 2（上海**）地域。
   3. 在 EMR on ECS 页面，单击创建的集群的 ID 。
   4. 选择**监控诊断 > 指标监控**，**dashboard** 选择 **YARN-HOME** 。![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2814798271/p859297.png)
   5. 可以查看任务提交到 Yarn 后的执行情况。在当前页面，还可以进一步选择其他组件如 Spark 和 HDFS ，以查看它们的监控数据。这些指标和日志信息能帮助您全面了解集群的运行状态和性能表现，及时发现和解决潜在的问题。
2. 验证数据分析结果
   
   1. 登录 [OSS 管理控制台](https://oss.console.aliyun.com/overview)。
   2. 在左侧导航栏，选择 **Bucket 列表**。
   3. **Bucket 列表**页面，单击目标 Bucket 。
   4. 在左侧导航栏，选择**文件管理 > 文件列表**。
   5. 在 outputs 目录下，可以看到文件名为 \_SUCCESS ，这表明 MR 作业执行成功；part-r 开头的文件即为输出的结果文件。可以将这些结果文件下载到本地进行进一步查看和分析。
   ![image.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2814798271/p859334.png)

##### 二、通过监控模型训练任务，验证 PAI 的模型训练能力

1. 监控模型训练任务
   
   1. 登录 [PAI 控制台](https://pai.console.aliyun.com/?regionId=cn-shanghai)。
   2. 左侧导航栏，选择**模型开发与训练 > 分布式训练（DLC）**。
   3. 点击当前任务操作栏中的**监控**按钮，可以查看任务详情。
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2814798271/p859338.png)
   4. 在训练任务详情页面，可以监控任务的执行进度，包括任务状态、资源使用情况（如 GPU、内存）以及执行日志等信息。
   ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2814798271/p859340.png)
2. 验证模型训练结果
   
   1. 登录 [OSS 管理控制台](https://oss.console.aliyun.com/overview)。
   2. 在左侧导航栏，选择 **Bucket 列表**。
   3. **Bucket 列表**页面，单击目标 Bucket 。
   4. 在左侧导航栏，选择**文件管理 > 文件列表**。
   5. 在 hymenoptera\_data 目录下，确认 PAI 训练的深度学习模型文件 model.pth 存在，并将其下载到本地进行进一步验证。
##### 三、通过加载和测试模型文件，验证 PAI 模型训练结果

1. 安装必要的依赖
    
    确保本地环境中安装了 PyTorch 。如果没有安装，可以使用以下命令进行安装。
    
    ```
    pip install torch torchvision
    ```

2. 加载并验证模型文件

    将下载的模型文件 model.pth 加载到本地的深度学习环境中（如 PyTorch），使用加载的模型进行推理，具体的代码示例如下。
    
    ```
    import torch
    import torchvision.transforms as transforms
    from PIL import Image
    import requests
    from io import BytesIO
    
    # 定义模型架构
    from torchvision.models import resnet18
    
    class_names = ['ant', 'bee']  # 定义类别名称：蚂蚁和蜜蜂
    
    # 加载预训练模型并修改最后的全连接层
    model = resnet18()
    num_ftrs = model.fc.in_features
    model.fc = torch.nn.Linear(num_ftrs, len(class_names))  # 修改最后的全连接层
    
    # 加载预训练权重
    model.load_state_dict(torch.load('model.pth', map_location=torch.device('cpu')))
    model.eval()  # 设置模型为评估模式
    
    # 定义图像预处理步骤
    preprocess = transforms.Compose([
        transforms.Resize(256),
        transforms.CenterCrop(224),
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
    ])
    
    # 下载并预处理一张测试图像（蚂蚁或蜜蜂）
    url = "https://example.com/path/to/ant_or_bee_image.jpg"  # 替换为实际的蚂蚁或蜜蜂图像URL
    response = requests.get(url)
    img = Image.open(BytesIO(response.content))
    img_t = preprocess(img)
    batch_t = torch.unsqueeze(img_t, 0)
    
    # 进行预测
    with torch.no_grad():
        out = model(batch_t)
        _, predicted = torch.max(out, 1)
    
    # 输出预测结果
    print(f'Predicted: {class_names[predicted[0]]}')
    ```

3. 代码运行后，输出预测结果如图所示。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2814798271/p859369.png)

#### 清理资源

在本方案中，您创建了 1 个 EMR 集群、1 台交换机、1 个专有网络 VPC 、1 个 OSS Bucket 、1 个 PAI 工作空间和 1 个 PAI 默认工作空间。测试完方案后，您可以参考以下规则处理对应产品的实例，避免继续产生费用。其中，PAI按量付费，您无需考虑释放默认工作空间。

1. 登录[ROS 控制台](https://ros.console.aliyun.com/overview)。
2. 在左侧导航栏，选择**资源栈**。
3. 在**资源栈**页面的顶部选择部署的资源栈所在地域，找到资源栈，然后在其右侧**操作**列，单击**删除**。
4. 在**删除资源栈**对话框，选择**删除方式**为**释放资源**，然后单击**确定**，根据提示完成资源释放。
