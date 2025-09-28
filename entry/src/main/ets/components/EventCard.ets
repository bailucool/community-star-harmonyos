import { Event, EventCategory, EventStatus } from '../models/Event'

@Component
export struct EventCard {
  @Prop event: Event
  onJoin?: (eventId: string) => void
  onEdit?: (eventId: string) => void

  build() {
    Column() {
      // 活动标题和状态
      Row() {
        Text(this.event.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        
        Text(this.getStatusText())
          .fontSize(12)
          .fontColor(this.getStatusColor())
          .backgroundColor(this.getStatusBgColor())
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(12)
      }
      .width('100%')
      .margin({ bottom: 8 })

      // 活动描述
      if (this.event.description) {
        Text(this.event.description)
          .fontSize(14)
          .fontColor('#666')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 8 })
      }

      // 时间和地点
      Row() {
        Text('🕐')
          .width(16)
          .height(16)
          .margin({ right: 4 })
        
        Text(this.formatDateTime(this.event.startTime))
          .fontSize(12)
          .fontColor('#666')
          .layoutWeight(1)
      }
      .width('100%')
      .margin({ bottom: 4 })

      Row() {
        Text('📍')
          .width(16)
          .height(16)
          .margin({ right: 4 })
        
        Text(this.event.isOnline ? '线上活动' : this.event.location)
          .fontSize(12)
          .fontColor('#666')
          .layoutWeight(1)
      }
      .width('100%')
      .margin({ bottom: 8 })

      // 参与人数和操作按钮
      Row() {
        Text(`${this.event.currentParticipants}/${this.event.maxParticipants}人`)
          .fontSize(12)
          .fontColor('#666')
          .layoutWeight(1)
        
        if (this.event.status === EventStatus.UPCOMING) {
          Button('参加')
            .fontSize(12)
            .height(28)
            .backgroundColor('#007AFF')
            .onClick(() => {
              this.onJoin?.(this.event.id)
            })
        }
      }
      .width('100%')

      // 标签
      if (this.event.tags.length > 0) {
        Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Start }) {
          ForEach(this.event.tags, (tag: string) => {
            Text(`#${tag}`)
              .fontSize(10)
              .fontColor('#007AFF')
              .backgroundColor('#F0F8FF')
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .borderRadius(8)
              .margin({ right: 4, top: 4 })
          })
        }
        .width('100%')
        .margin({ top: 8 })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
  }

  private getStatusText(): string {
    switch (this.event.status) {
      case EventStatus.UPCOMING:
        return '即将开始'
      case EventStatus.ONGOING:
        return '进行中'
      case EventStatus.COMPLETED:
        return '已结束'
      case EventStatus.CANCELLED:
        return '已取消'
      default:
        return ''
    }
  }

  private getStatusColor(): string {
    switch (this.event.status) {
      case EventStatus.UPCOMING:
        return '#007AFF'
      case EventStatus.ONGOING:
        return '#34C759'
      case EventStatus.COMPLETED:
        return '#8E8E93'
      case EventStatus.CANCELLED:
        return '#FF3B30'
      default:
        return '#8E8E93'
    }
  }

  private getStatusBgColor(): string {
    switch (this.event.status) {
      case EventStatus.UPCOMING:
        return '#F0F8FF'
      case EventStatus.ONGOING:
        return '#F0FFF4'
      case EventStatus.COMPLETED:
        return '#F5F5F5'
      case EventStatus.CANCELLED:
        return '#FFF5F5'
      default:
        return '#F5F5F5'
    }
  }

  private formatDateTime(date: Date): string {
    const month = (date.getMonth() + 1).toString().padStart(2, '0')
    const day = date.getDate().toString().padStart(2, '0')
    const hour = date.getHours().toString().padStart(2, '0')
    const minute = date.getMinutes().toString().padStart(2, '0')
    return `${month}-${day} ${hour}:${minute}`
  }
}