# TemplateInfo 介绍
`template-infos` 目录用于描述模板的基本信息，其中 `template-info.yml` 文件用于介绍模板的基本信息，包括模板名称、描述、模板类型、
架构图等。每个模板的使用文档和架构图放在模板名称对应的子目录中，架构图需要以 icon 开头，模板介绍文档为 README.md 文件。

## 资源编排 ROS 公共模板
ROS 公共模板是 ROS 官方提供的模板，用于快速创建资源，提高资源创建效率。公共模板的模板文件托管在当前仓库下，如果您希望贡献公共模板，
可以向改仓库的对应目录下提交模板文件，并且在 `template-infos` 目录下新增目录介绍文档和架构图，架构图可以使用 ROS 可视化编辑器生成，
然后在`template-info.yml` 文件新增以下内容：

标签注意事项
`ApplicationScenes` 表示应用场景，目前支持的应用场景有：
- 互联网应用开发
- 数据分析与迁移
- 人工智能
- 容灾与备份
- 安全合规
- 上云与迁云
- 账号管理
- RPC与消息总线
- 日志管理与可观测监控

`BasicServices` 表示云计算基础服务，目前支持的基础服务有：
- 弹性计算
- 容器
- 存储
- 网络与CDN
- 安全
- 数据库
- 大数据计算
- 人工智能与机器学习

```
AnalyticDB-and-Bailian-system: # 模板id, 需要和模板文件名称保持一致
  Categories: # 分类，列表类型，Solution 表示解决方案，Example 表示入门模板
    - Solution
  Description: # 模板描述，列表类型，en 表示英文描述，zh-cn 表示中文描述
    en: AnalyticDB and Bailian build intelligent question and answer system.
    zh-cn: AnalyticDB与百炼搭建智能问答系统。
  Detail: https://raw.githubusercontent.com/aliyun/ros-templates/refs/heads/master/template-infos/AnalyticDB-and-Bailian-system/README_EN.md # 模板介绍文档地址(英文)，github 中的文件 url，需要以 raw 开头，文件格式为 Markdown 格式
  DetailAlias： https://raw.githubusercontent.com/aliyun/ros-templates/refs/heads/master/template-infos/AnalyticDB-and-Bailian-system/README.md # 模板介绍文档地址(中文)
  Icon: https://raw.githubusercontent.com/aliyun/ros-templates/refs/heads/master/template-infos/AnalyticDB-and-Bailian-system/icon.svg # 模板架构图地址（英文），github 中的文件 url，需要以 raw 开头
  IconAlias: https://raw.githubusercontent.com/aliyun/ros-templates/refs/heads/master/template-infos/AnalyticDB-and-Bailian-system/icon-en.svg # 模板架构图地址（中文）
  Labels: # 标签，ApplicationScenes 表示应用场景，DeployTypes 表示部署类型，ResourceTypes 表示资源类型
    ApplicationScenes: # 应用场景，列表类型
      - AI模型
    BasicServices:   #云计算基础服务，列表类型
       - 数据库
      - 人工智能与机器学习
    DeployTypes: # 部署类型，列表类型 ROS 表示 ROS 模板，Terraform 表示 Terraform 模板
      - ROS
    ResourceTypes: # 模板涉及的资源类型，列表类型
      - ALIYUN::ECS::InstanceGroup
      - ALIYUN::ECS::RunCommand
      - ALIYUN::ECS::SecurityGroup
      - ALIYUN::ECS::VPC
      - ALIYUN::ECS::VSwitch
      - ALIYUN::GPDB::DBInstance
      - ALIYUN::ROS::WaitCondition
      - ALIYUN::ROS::WaitConditionHandle
  LinkUrl: https://help.aliyun.com/document_detail/2837375.html # 模板帮助文档地址，选填
  TemplateName: AnalyticDB and Bailian build an intelligent question-and-answer system # 模板名称 英文
  TemplateNameAlias: AnalyticDB与百炼搭建智能问答系统   # 模板名称 中文
  TemplateUrl: https://raw.githubusercontent.com/aliyun/ros-templates/refs/heads/master/documents/solution/ai/AnalyticDB-and-Bailian-system.yml # 模板地址，github 中的文件 url，需要以 raw 开头，文件格式为 YAML 格式
```

提交之后，联系 ROS 团队审核并发布，发布后模板信息会自动同步到 ROS 官网。
更新 template-info 信息之后 10 分钟生效。
