import { BackupService, BackupInfo } from '../services/BackupService'

@Entry
@Component
struct SettingsPage {
  @State backupInfo: BackupInfo = {
    lastBackupTime: null,
    backupSize: '0MB',
    isCloudBackupEnabled: false,
    backupCount: 0
  }
  @State isBackingUp: boolean = false
  @State isRestoring: boolean = false
  private backupService = BackupService.getInstance()

  aboutToAppear() {
    this.loadBackupInfo()
  }

  build() {
    Column() {
      // 顶部导航
      Row() {
        Button('返回')
          .onClick(() => {
            // 返回上一页
          })
        
        Text('设置')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        Blank()
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')

      List() {
        // 备份与恢复
        ListItemGroup({ header: '数据备份' }) {
          ListItem() {
            this.BackupInfoItem()
          }
          
          ListItem() {
            this.BackupActionItem()
          }
          
          ListItem() {
            this.RestoreActionItem()
          }
          
          ListItem() {
            this.AutoBackupItem()
          }
        }
        .margin({ top: 16 })

        // 应用设置
        ListItemGroup({ header: '应用设置' }) {
          ListItem() {
            this.NotificationItem()
          }
          
          ListItem() {
            this.ThemeItem()
          }
          
          ListItem() {
            this.LanguageItem()
          }
        }
        .margin({ top: 16 })

        // 关于
        ListItemGroup({ header: '关于' }) {
          ListItem() {
            this.VersionItem()
          }
          
          ListItem() {
            this.FeedbackItem()
          }
        }
        .margin({ top: 16 })
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
  }

  @Builder BackupInfoItem() {
    Column() {
      Row() {
        Text('备份信息')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
        
        Text(this.backupInfo.isCloudBackupEnabled ? '已启用' : '未启用')
          .fontSize(14)
          .fontColor(this.backupInfo.isCloudBackupEnabled ? '#34C759' : '#FF3B30')
      }
      .width('100%')
      .margin({ bottom: 8 })

      if (this.backupInfo.lastBackupTime) {
        Text(`上次备份: ${this.formatDate(this.backupInfo.lastBackupTime)}`)
          .fontSize(12)
          .fontColor('#666')
          .alignSelf(ItemAlign.Start)
          .margin({ bottom: 4 })
      }

      Text(`备份大小: ${this.backupInfo.backupSize} | 备份次数: ${this.backupInfo.backupCount}`)
        .fontSize(12)
        .fontColor('#666')
        .alignSelf(ItemAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }

  @Builder BackupActionItem() {
    Row() {
      Column() {
        Text('立即备份')
          .fontSize(16)
        Text('备份您的活动和社区数据到云端')
          .fontSize(12)
          .fontColor('#666')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isBackingUp) {
        LoadingProgress()
          .width(24)
          .height(24)
      } else {
        Button('备份')
          .fontSize(14)
          .height(32)
          .backgroundColor('#007AFF')
          .onClick(() => {
            this.performBackup()
          })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }

  @Builder RestoreActionItem() {
    Row() {
      Column() {
        Text('恢复数据')
          .fontSize(16)
        Text('从云端恢复您的备份数据')
          .fontSize(12)
          .fontColor('#666')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isRestoring) {
        LoadingProgress()
          .width(24)
          .height(24)
      } else {
        Button('恢复')
          .fontSize(14)
          .height(32)
          .backgroundColor('#34C759')
          .onClick(() => {
            this.performRestore()
          })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }

  @Builder AutoBackupItem() {
    Row() {
      Column() {
        Text('自动备份')
          .fontSize(16)
        Text('应用退出时自动备份数据')
          .fontSize(12)
          .fontColor('#666')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Toggle({ type: ToggleType.Switch, isOn: this.backupInfo.isCloudBackupEnabled })
        .onChange((isOn: boolean) => {
          this.toggleAutoBackup(isOn)
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }

  @Builder NotificationItem() {
    Row() {
      Text('通知设置')
        .fontSize(16)
        .layoutWeight(1)
      
      Text('>')
        .fontSize(16)
        .fontColor('#C7C7CC')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      // 跳转到通知设置页面
    })
  }

  @Builder ThemeItem() {
    Row() {
      Text('主题设置')
        .fontSize(16)
        .layoutWeight(1)
      
      Text('跟随系统')
        .fontSize(14)
        .fontColor('#666')
        .margin({ right: 8 })
      
      Text('>')
        .fontSize(16)
        .fontColor('#C7C7CC')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      // 跳转到主题设置页面
    })
  }

  @Builder LanguageItem() {
    Row() {
      Text('语言设置')
        .fontSize(16)
        .layoutWeight(1)
      
      Text('简体中文')
        .fontSize(14)
        .fontColor('#666')
        .margin({ right: 8 })
      
      Text('>')
        .fontSize(16)
        .fontColor('#C7C7CC')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      // 跳转到语言设置页面
    })
  }

  @Builder VersionItem() {
    Row() {
      Text('版本信息')
        .fontSize(16)
        .layoutWeight(1)
      
      Text('v1.0.0')
        .fontSize(14)
        .fontColor('#666')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }

  @Builder FeedbackItem() {
    Row() {
      Text('意见反馈')
        .fontSize(16)
        .layoutWeight(1)
      
      Text('>')
        .fontSize(16)
        .fontColor('#C7C7CC')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      // 跳转到意见反馈页面
    })
  }

  private async loadBackupInfo() {
    this.backupInfo = await this.backupService.getBackupInfo()
  }

  private async performBackup() {
    if (!this.backupService.canBackup()) {
      // 显示错误提示
      return
    }

    this.isBackingUp = true
    try {
      const success = await this.backupService.backupUserData()
      if (success) {
        // 显示成功提示
        await this.loadBackupInfo()
      } else {
        // 显示失败提示
      }
    } finally {
      this.isBackingUp = false
    }
  }

  private async performRestore() {
    this.isRestoring = true
    try {
      const success = await this.backupService.restoreUserData()
      if (success) {
        // 显示成功提示
        await this.loadBackupInfo()
      } else {
        // 显示失败提示
      }
    } finally {
      this.isRestoring = false
    }
  }

  private async toggleAutoBackup(enabled: boolean) {
    // 更新自动备份设置
    this.backupInfo.isCloudBackupEnabled = enabled
    // 这里可以保存设置到本地存储
  }

  private formatDate(date: Date): string {
    const year = date.getFullYear()
    const month = (date.getMonth() + 1).toString().padStart(2, '0')
    const day = date.getDate().toString().padStart(2, '0')
    const hour = date.getHours().toString().padStart(2, '0')
    const minute = date.getMinutes().toString().padStart(2, '0')
    return `${year}-${month}-${day} ${hour}:${minute}`
  }
}