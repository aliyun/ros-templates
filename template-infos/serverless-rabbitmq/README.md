## 方案概览

消息队列 RabbitMQ 版由阿里云基于 AMQP 标准协议自研，完全兼容 RabbitMQ 开源生态以及多语言客户端，打造分布式、高吞吐、低延迟、高可扩展的云消息服务。开箱即用，用户无需部署免运维，轻松实现快速上云，阿里云提供全托管服务，更专业、更可靠、更安全。

## 方案架构

本方案将创建云消息队列 RabbitMQ 版 Serverless 系列实例来进行消息的生产和消费，根据实际使用量计费，并查看指标变化和消息轨迹。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5754032271/p826418.png)

本方案架构包含消息生产者、消息队列、消息消费者三个核心模块。消息在云消息队列 RabbitMQ 版的组件之间流动过程为：

1. 生产者向 Exchange 发送消息；
2. Exchange 根据消息属性将消息路由到 Queue 进行存储；
3. 消费者从 Queue 拉取消息进行消费。

## 方案部署
### 部署准备

开始部署前，请按以下指引完成账号申请、账号充值。

#### 准备账号

1. 如果您还没有阿里云账号，请访问[阿里云账号注册页面](https://account.aliyun.com/register/qr_register.htm)，根据页面提示完成注册并进行个人实名认证。阿里云账号是您使用云资源的付费实体，因此是部署方案的必要前提。
2. [为阿里云账号充值](https://help.aliyun.com/document_detail/324650.html)。本方案的云资源支持按量付费，且默认设置均采用按量付费引导操作。
### 部署资源


#### 一键部署

单击[一键部署](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/service_template/technical-solution/serverless-rabbitmq.yml&hideStepRow=true&hideStackConfig=true&pageTitle=%E9%AB%98%E5%BC%B9%E6%80%A7%EF%BC%8C%E4%BD%8E%E6%88%90%E6%9C%AC%EF%BC%8C%E4%BA%91%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97%20RabbitMQ%E5%AE%9E%E8%B7%B5&disableRollback=false&isSimplified=true&disableNavigation=true&productNavBar=disabled)前往ROS控制台，修改资源栈名称，进行安全确认后点击创建。

**说明** 

ROS控制台目前不支持设置静态用户名和密码的步骤，用户可以在输出中查看AK和SK，然后到RabbitMQ控制台设置静态用户名和密码。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7347707271/p852141.png)

开始创建后，等待约5分钟左右，显示创建成功。

本方案中ROS模板完成的内容包括：

* 创建一个RAM用户
* 生成AccessKey ID和AccessKey Secret（用于身份验证和权限管理，用于访问和使用云计算资源）
* 创建一个云消息队列 RabbitMQ实例
* 创建资源和绑定关系

查看密钥
----

点击**输出**栏，查看AccessKeyId、AccessKeySecret。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8073891271/p826028.png)

设置静态用户名密码
---------

1. 在[云消息队列 RabbitMQ 版控制台](https://amqp.console.aliyun.com/)的左侧导航栏中，点击**实例列表**，打开具体实例，单击**静态用户名密码**。
![AAA451F3-8357-41D5-B5DE-06CCDD62D333.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5617781271/p821336.png)

2. 在**静态用户名密码**页面，单击**创建用户名密码**。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6347707271/p852185.png)

3. 在**创建用户名密码**面板，填写上一步创建的**AccessKey ID**和**AccessKey Secret**，单击**确定**。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8073891271/p826034.png)
4. 返回如下页面，您可查看到创建的用户名和密码。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8073891271/p826039.png)

### 方案验证


**一、通过Java实现消息收发，验证RabbitMQ消息流转**

**说明：**云消息队列RabbitMQ版与开源RabbitMQ完全兼容，请关注[SDK使用注意事项](https://help.aliyun.com/zh/apsaramq-for-rabbitmq/developer-reference/use-open-source-sdks-to-access-apsaramq-for-rabbitmq-servers)。更多语言SDK，请参见[SDK列表及示例代码](https://help.aliyun.com/zh/apsaramq-for-rabbitmq/developer-reference/supported-sdks#table-9jf-iui-3jw)。

**说明** 

您需要提前[安装IDE](https://www.jetbrains.com/idea/?spm=a2c4g.11186623.0.0.6b1c2b361vaEHF)，[安装JDK](https://www.oracle.com/java/technologies/downloads/)，[安装Maven](https://www.oracle.com/java/technologies/downloads/)。您可以使用IntelliJ IDEA或者Eclipse，本文以IntelliJ IDEA Ultimate为例。

**安装Java依赖库**

1. 在IDEA中创建一个Java工程。
2. 在pom.xml文件中添加以下依赖引入Java依赖库。
   
   ```
   <dependency>
       <groupId>com.rabbitmq</groupId>
       <artifactId>amqp-client</artifactId>
       <version>5.5.0</version> 
   </dependency>
   ```
   **说明** 
   
   部署以下生产消息和订阅消息前，注意Maven的依赖问题，以下为pom.xml文件中添加后的示例结果截图：![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5514401371/p870137.png)

**重要** 

**代码参数说明**

| **参数** | **描述** | **获取步骤** |
| --- | --- | --- |
| hostName | 云消息队列 RabbitMQ 版实例接入点。 | 1. 登录[云消息队列 RabbitMQ 版控制台](https://amqp.console.aliyun.com/)，然后在左侧导航栏选择**实例列表**。 2. 在**实例列表**页面的顶部菜单栏选择地域，然后在实例列表中，单击目标实例名称。 3. 在**实例详情**页面的**接入点信息**页签，将鼠标指针移动到目标类型的接入点，单击复制公网接入点。 |
| userName | 客户端接入云消息队列 RabbitMQ 版服务端用于权限认证的静态用户名。 | 部署资源步骤中获取的静态用户名 |
| passWord | 客户端接入云消息队列 RabbitMQ 版服务端用于权限认证的静态用户密码。 | 部署资源步骤中获取的静态用户密码 |

**生产消息**

在已创建的Java工程中，创建消息发送程序，按照**代码参数说明**部分配置相关参数并运行。

示例代码如下：

```
import com.rabbitmq.client.AMQP;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.UUID;
import java.util.concurrent.TimeoutException;

public class ProducerTest {
    public static void main(String[] args) throws IOException, TimeoutException {
        //设置实例的接入点。
        String hostName = "xxx.xxx.aliyuncs.com";
        //设置实例的静态用户名密码。
        String userName = "UserName";
        String passWord = "PassWord";
        //设置实例的Vhost。
        String virtualHost = "test-vhost";

        //在生产环境中，建议提前创建好Connection，并在需要时重复使用，避免频繁创建和关闭Connection，
        // 以提高性能、复用连接资源，以及保证系统的稳定性。
        Connection connection = createConnection(hostName, userName, passWord, virtualHost);
        Channel channel = connection.createChannel();

        //设置Exchange、Queue和绑定关系。
        String exchangeName = "test-exchange";
        String queueName = "test-queue";
        String bindingKey = "test-routing-key";
        //设置Exchange类型。
        String exchangeType = "direct";

        //开始发送消息。
        for (int i = 0; i < 10; i++) {
            AMQP.BasicProperties props = new AMQP.BasicProperties.Builder().messageId(UUID.randomUUID().toString()).build();
            channel.basicPublish(exchangeName, bindingKey, true, props,
                    ("消息发送示例Body-" + i).getBytes(StandardCharsets.UTF_8));
            System.out.println("[SendResult] Message sent successfully, messageId: " + props.getMessageId()
                    + ", exchange: " + exchangeName + ", routingKey: " + bindingKey);
        }
        channel.close();
        connection.close();
    }

    public static Connection createConnection(String hostName, String userName, String passWord, String virtualHost)
            throws IOException, TimeoutException {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost(hostName);
        factory.setUsername(userName);
        factory.setPassword(passWord);
        //设置为true,开启Connection自动恢复功能；设置为false,关闭Connection自动恢复功能。
        factory.setAutomaticRecoveryEnabled(true);
        factory.setNetworkRecoveryInterval(5000);
        factory.setVirtualHost(virtualHost);
        //默认端口，非加密端口5672，加密端口5671。
        factory.setPort(5672);
        //基于网络环境合理设置超时时间。
        factory.setConnectionTimeout(30 * 1000);
        factory.setHandshakeTimeout(30 * 1000);
        factory.setShutdownTimeout(0);
        Connection connection = factory.newConnection();
        return connection;
    }
}
```

**订阅消息**

在已创建的Java工程中，创建消息订阅程序，按照**代码参数说明**部分配置相关参数并运行

示例代码如下：

```
import com.rabbitmq.client.AMQP;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.DefaultConsumer;
import com.rabbitmq.client.Envelope;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.concurrent.TimeoutException;

public class ConsumerTest {
    public static void main(String[] args) throws IOException, TimeoutException {
        //设置实例的接入点。
        String hostName = "xxx.xxx.aliyuncs.com";
        //设置实例的静态用户名密码。
        String userName = "UserName";
        String passWord = "PassWord";
        //设置实例的Vhost。
        String virtualHost = "test-vhost";

        Connection connection = createConnection(hostName, userName, passWord, virtualHost);
        final Channel channel = connection.createChannel();

        //声明Queue。
        String queueName = "test-queue";
        //创建${QueueName} ，该Queue必须在云消息队列RabbitMQ版控制台上已存在。
        AMQP.Queue.DeclareOk queueDeclareOk = channel.queueDeclare(queueName, true, false, false,
                new HashMap<String, Object>());

        //开始消费消息。
        channel.basicConsume(queueName, false, "test-consumerTag", new DefaultConsumer(channel) {
            @Override
            public void handleDelivery(String consumerTag, Envelope envelope,
                                       AMQP.BasicProperties properties, byte[] body)
                    throws IOException {
                //接收到的消息，进行业务逻辑处理。
                System.out.println("Received： " + new String(body, StandardCharsets.UTF_8) + ", deliveryTag: "
                        + envelope.getDeliveryTag() + ", messageId: " + properties.getMessageId());
                channel.basicAck(envelope.getDeliveryTag(), false);
            }
        });
    }

    public static Connection createConnection(String hostName, String userName, String passWord, String virtualHost)
            throws IOException, TimeoutException {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost(hostName);
        factory.setUsername(userName);
        factory.setPassword(passWord);
        //设置为true,开启Connection自动恢复功能；设置为false,关闭Connection自动恢复功能。
        factory.setAutomaticRecoveryEnabled(true);
        factory.setNetworkRecoveryInterval(5000);
        factory.setVirtualHost(virtualHost);
        // 默认端口，非加密端口5672，加密端口5671。
        factory.setPort(5672);
        factory.setConnectionTimeout(300 * 1000);
        factory.setHandshakeTimeout(300 * 1000);
        factory.setShutdownTimeout(0);
        Connection connection = factory.newConnection();
        return connection;
    }
}
```

**二、通过消息轨迹，验证消息传递过程**

1. 在IDEA中执行上一步创建的**生产消息**和**订阅消息**java项目。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5514401371/p870116.png)![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5514401371/p870118.png)

2. 返回消息队列RabbitMQ版控制台页签，在左侧导航栏中，单击**Dashboard**。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4617781271/p821372.png)

3. 在**服务关联角色**对话框中，单击**授权**。
**说明**：如果您是首次使用Dashboard功能，需要进行授权。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4617781271/p821373.png)

4. 在**开通ARMS服务**对话框中，单击**开通**。
**说明**：如果您是首次使用Dashboard功能，需要开通ARMS服务。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5617781271/p821374.png)

5. 查看RabbitMQ实例的概览指标，可以查看每个Queue的消息堆积数，消息速率等指标。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6347707271/p852145.png)

6. 在左侧导航栏中，单击**Queue列表**。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5617781271/p821377.png)

7. 在**Queue列表**页面，单击**test-queue**。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7347707271/p852146.png)

8. 在test-queue详情页面，单击**Dashboard**。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6347707271/p852150.png)

9. 在**Dashboard**页签，可以查看指定Queue的详细指标变化趋势，用于定位问题。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7347707271/p852159.png)

10. 在左侧导航栏中，单击**消息轨迹**。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5617781271/p821382.png)

11. 在消息轨迹页面，您可以根据按Message ID查询和按Queue查询。
    * 按Message ID查询：根据IntelliJ IDEA控制台打印的messageId可以精确查询对应消息的轨迹。
    ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7347707271/p852241.png)
    * 按Queue查询：根据Queue名称可以查询对应Queue下所有消息的轨迹。
    ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7347707271/p852162.png)

12. 选择任意一条消息的轨迹，单击**轨迹详情**，查询对应消息的生产和投递轨迹详情。
![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6347707271/p852243.png)

**三、通过多线程并发测试，验证RabbitMQ高并发性能**

1.为了验证RabbitMQ在高并发场景下的性能，我们可以通过多线程的方式来模拟大量消息的并发发送。具体代码如下：

```
import com.rabbitmq.client.AMQP;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.UUID;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeoutException;

public class ConcurrentProducerTest {
    public static void main(String[] args) throws IOException, TimeoutException {
        // 设置实例的接入点。
        String hostName = "xxx.xxx.aliyuncs.com";
        // 设置实例的静态用户名密码。
        String userName = "UserName";
        String passWord = "PassWord";
        // 设置实例的Vhost。
        String virtualHost = "test-vhost";

        // 创建连接
        Connection connection = createConnection(hostName, userName, passWord, virtualHost);
        Channel channel = connection.createChannel();

        // 设置Exchange、Queue和绑定关系。
        String exchangeName = "test-exchange";
        String queueName = "test-queue";
        String bindingKey = "test-routing-key";
        String exchangeType = "direct";

        // 创建线程池
        int threadCount = 50; // 线程数量
        ExecutorService executorService = Executors.newFixedThreadPool(threadCount);

        // 开始发送消息
        for (int i = 0; i < threadCount; i++) {
            executorService.submit(() -> {
                try {
                    for (int j = 0; j < 1000; j++) { // 每个线程发送1000条
                        AMQP.BasicProperties props = new AMQP.BasicProperties.Builder().messageId(UUID.randomUUID().toString()).build();
                        channel.basicPublish(exchangeName, bindingKey, true, props,
                                ("并发消息发送示例Body-" + Thread.currentThread().getId() + "-" + j).getBytes(StandardCharsets.UTF_8));
                        System.out.println("[SendResult] Thread ID: " + Thread.currentThread().getId()
                                + ", Message sent successfully, messageId: " + props.getMessageId());
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
        }

        // 关闭线程池
        executorService.shutdown();
        while (!executorService.isTerminated()) {
            // 等待所有线程完成
        }

        // 关闭通道和连接
        channel.close();
        connection.close();
    }

    // 创建连接的方法
    public static Connection createConnection(String hostName, String userName, String passWord, String virtualHost)
            throws IOException, TimeoutException {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost(hostName);
        factory.setUsername(userName);
        factory.setPassword(passWord);
        factory.setAutomaticRecoveryEnabled(true);
        factory.setNetworkRecoveryInterval(5000);
        factory.setVirtualHost(virtualHost);
        factory.setPort(5672);
        factory.setConnectionTimeout(30 * 1000);
        factory.setHandshakeTimeout(30 * 1000);
        factory.setShutdownTimeout(0);
        return factory.newConnection();
    }
}

```

以上代码模拟50个用户并发发送消息的场景，总共发送5万条消息。

2.运行上述的并发生产者代码后，消费者代码依然使用之前的示例代码。参考之前的步骤，查看队列的Dashboard。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7347707271/p852214.png)

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7347707271/p852220.png)

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6347707271/p852229.png)

可以看到，当前队列的消息处理耗时为22ms，消息堆积在4分钟内完成发送，消息处理延时则最大为37ms。这表明，RabbitMQ能够在高并发场景下处理大量并发消息的发送和接收，保持高效的消息传递。低延时的表现确保了实时性要求较高的应用场景能够正常运行。

### 完成及清理

点击[ROS控制台](https://ros.console.aliyun.com/cn-hangzhou/stacks)，在**资源栈列表**中找到创建的实例，点击**删除**，清理创建的资源。

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/8073891271/p826051.png)

#### 自建迁移上云（可选）

如果您希望从开源 RabbitMQ 迁移到云消息队列 RabbitMQ 版，请参见[开源RabbitMQ迁移上云](https://help.aliyun.com/zh/apsaramq-for-rabbitmq/use-cases/migrate-open-source-rabbitmq-clusters-to-the-cloud)。

