# 社区之星 - Community Star

基于HarmonyOS开发的开源技术社区明星展示与活动管理应用，展示社区优秀贡献者，管理社区活动，集成轻备份技术实现数据云端备份。

## 🚀 功能特性

### 核心功能
- 🌟 **明星展示** - 展示社区优秀贡献者和技术专家
- 📅 **活动日历** - 直观的日历视图展示社区活动
- 🎯 **活动管理** - 创建、编辑、参与技术活动
- 🏆 **成就系统** - 记录和展示个人贡献成就
- � **智能提醒**  - 活动开始前自动提醒
- 💾 **数据备份** - 基于华为云的轻备份技术
- 🌐 **线上线下** - 支持线上直播和线下聚会

### 技术特色
- **零侵入备份** - 集成 [backup_air](https://gitee.com/ripple-gallop/backup_air) 轻备份技术
- **声明式UI** - 使用ArkTS开发，组件化架构
- **云端同步** - 华为云存储，数据安全可靠
- **跨设备同步** - 支持多设备数据同步

## 🏗️ 项目结构

```
├── AppScope/                   # 应用级配置
├── entry/                      # 主入口模块
│   ├── src/main/
│   │   ├── ets/
│   │   │   ├── components/     # 可复用组件
│   │   │   │   ├── CalendarView.ets    # 日历组件
│   │   │   │   └── EventCard.ets       # 活动卡片组件
│   │   │   ├── models/         # 数据模型
│   │   │   │   ├── Event.ets           # 活动模型
│   │   │   │   └── Community.ets       # 社区模型
│   │   │   ├── pages/          # 页面
│   │   │   │   ├── Index.ets           # 主页面
│   │   │   │   └── SettingsPage.ets    # 设置页面
│   │   │   └── services/       # 业务服务
│   │   │       ├── EventService.ets    # 活动服务
│   │   │       └── BackupService.ets   # 备份服务
│   │   └── resources/          # 资源文件
│   └── src/test/              # 测试文件
└── hvigor/                    # 构建配置
```

## 🛠️ 技术栈

- **开发语言**: ArkTS (TypeScript超集)
- **UI框架**: ArkUI (声明式UI)
- **目标平台**: HarmonyOS 6.0.0+
- **备份技术**: backup_air 轻备份框架
- **云存储**: 华为云对象存储
- **构建工具**: hvigor

## 📱 功能截图

### 主要界面
- **明星榜单**: 展示社区优秀贡献者和技术专家
- **日历视图**: 月历展示，点击日期查看当日活动
- **活动列表**: 所有活动的列表视图，支持筛选
- **活动详情**: 活动信息、参与人数、位置等
- **个人中心**: 查看个人成就和贡献记录

### 备份功能
- **自动备份**: 应用退出时自动备份数据
- **手动备份**: 用户主动触发备份操作
- **数据恢复**: 从云端恢复历史备份
- **备份管理**: 查看备份历史和状态

## 🚀 快速开始

### 环境要求
- HarmonyOS SDK 6.0.0+
- DevEco Studio 5.0+
- Node.js 16+

### 安装步骤

1. **克隆项目**
```bash
git clone [项目地址]
cd community-star
```

2. **安装依赖**
```bash
# 项目会自动下载依赖
```

3. **配置备份服务**
编辑 `entry/src/main/ets/services/BackupService.ets`，配置华为云存储凭证：
```typescript
// 配置你的华为云存储信息
bucketName: "your-bucket-name",
productId: 'your-product-id',
client_id: 'your-client-id',
client_secret: 'your-client-secret',
oauth_client_id: "your-oauth-client-id",
oauth_client_secret: "your-oauth-client-secret"
```

4. **运行项目**
- 在DevEco Studio中打开项目
- 连接HarmonyOS设备或启动模拟器
- 点击运行按钮

## 🔧 配置说明

### 备份配置
项目集成了 backup_air 轻备份技术，需要配置以下权限：

```json
"requestPermissions": [
  {
    "name": "ohos.permission.INTERNET"
  },
  {
    "name": "ohos.permission.KEEP_BACKGROUND_RUNNING"
  },
  {
    "name": "ohos.permission.GET_NETWORK_INFO"
  },
  {
    "name": "ohos.permission.GET_WIFI_INFO"
  }
]
```

### 华为云配置
1. 创建华为云账号并开通对象存储服务
2. 创建存储桶用于备份数据
3. 获取API凭证和OAuth2凭证
4. 在BackupService中配置相关参数

## 📋 开发计划

### v1.0.0 (当前版本)
- [x] 基础日历功能
- [x] 活动创建和管理
- [x] 备份服务集成
- [x] 基础UI组件

### v1.1.0 (计划中)
- [ ] 活动搜索和筛选
- [ ] 推送通知
- [ ] 社区功能完善
- [ ] 用户个人中心

### v1.2.0 (计划中)
- [ ] 活动评论和评分
- [ ] 社交分享功能
- [ ] 数据统计和分析
- [ ] 多语言支持

## 🤝 贡献指南

欢迎参与项目开发！请遵循以下步骤：

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

### 代码规范
- 使用ArkTS语法规范
- 组件命名采用PascalCase
- 服务类命名以Service结尾
- 添加必要的注释和文档

## 📄 开源协议

本项目采用 Apache 2.0 开源协议。详见 [LICENSE](LICENSE) 文件。

## 🙏 致谢

- [backup_air](https://gitee.com/ripple-gallop/backup_air) - 提供轻备份技术支持
- HarmonyOS开发者社区 - 技术支持和文档
- 所有贡献者和使用者

## 📞 联系我们

- 项目地址: [GitHub/Gitee链接]
- 问题反馈: [Issues页面]
- 技术交流: [社区群组]

---

**让开源技术社区的活动管理更简单！** 🎉