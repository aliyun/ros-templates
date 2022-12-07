# 说明

此工程是基于Springboot的示例工程。工程使用Springboot-mvc用于提供Web API，使用Springboot-data-jpa提供数据访问，使用liquibase初始化数据库。

## 构建Docker镜像

以下命令需要在代码根目录（pom.xml所在目录）执行。

1. 使用Maven将程序打包为Jar包，Jar包会自动生成到target目录中

```shell
mvn install
```

2. 构建Docker镜像

```shell
docker build --build-arg JAR_FILE=target/*.jar -t <your-image-tag> .
```