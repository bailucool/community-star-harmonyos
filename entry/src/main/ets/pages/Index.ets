import { CalendarView } from '../components/CalendarView'
import { EventCard } from '../components/EventCard'
import { Event, EventCategory, EventStatus } from '../models/Event'
import { EventService } from '../services/EventService'

@Entry
@Component
struct Index {
  @State currentTab: number = 0
  @State selectedDate: Date = new Date()
  @State todayEvents: Event[] = []
  @State allEvents: Event[] = []
  private eventService = EventService.getInstance()

  aboutToAppear() {
    this.loadMockData()
    this.loadTodayEvents()
  }

  build() {
    Column() {
      // 顶部导航
      Row() {
        Text('社区之星')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
        
        Button('创建活动')
          .fontSize(14)
          .height(32)
          .backgroundColor('#007AFF')
          .onClick(() => {
            // 跳转到创建活动页面
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')

      // Tab切换
      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          this.StarTab()
        }.tabBar('明星')

        TabContent() {
          this.CalendarTab()
        }.tabBar('日历')

        TabContent() {
          this.EventListTab()
        }.tabBar('活动')

        TabContent() {
          this.ProfileTab()
        }.tabBar('我的')
      }
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentTab = index
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder CalendarTab() {
    Column() {
      CalendarView({
        onDateSelect: (date: Date) => {
          this.selectedDate = date
          this.loadEventsByDate(date)
        }
      })
      
      // 选中日期的活动列表
      if (this.todayEvents.length > 0) {
        Column() {
          Text(`${this.selectedDate.getMonth() + 1}月${this.selectedDate.getDate()}日的活动`)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 12 })
          
          ForEach(this.todayEvents, (event: Event) => {
            EventCard({
              event: event,
              onJoin: (eventId: string) => {
                this.joinEvent(eventId)
              }
            })
              .margin({ bottom: 8 })
          })
        }
        .width('100%')
        .padding(16)
      } else {
        Column() {
          Text('这一天没有活动')
            .fontSize(14)
            .fontColor('#999')
            .margin({ top: 32 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder EventListTab() {
    List() {
      ForEach(this.allEvents, (event: Event) => {
        ListItem() {
          EventCard({
            event: event,
            onJoin: (eventId: string) => {
              this.joinEvent(eventId)
            }
          })
        }
        .margin({ left: 16, right: 16, top: 8, bottom: 8 })
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder StarTab() {
    Column() {
      // 明星榜单标题
      Row() {
        Text('🌟 社区明星榜')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
        
        Button('提名明星')
          .fontSize(12)
          .height(28)
          .backgroundColor('#FF6B35')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')

      // 明星列表
      List() {
        ListItem() {
          this.StarCard('张三', 'HarmonyOS开发专家', '贡献了15个开源项目', '⭐⭐⭐⭐⭐', '#FFD700')
        }
        ListItem() {
          this.StarCard('李四', 'Vue.js社区活跃者', '组织了8场技术分享', '⭐⭐⭐⭐', '#C0C0C0')
        }
        ListItem() {
          this.StarCard('王五', '开源新星', '参与了多个社区项目', '⭐⭐⭐', '#CD7F32')
        }
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
  }

  @Builder StarCard(name: string, title: string, achievement: string, stars: string, badgeColor: string) {
    Row() {
      // 头像
      Circle({ width: 50, height: 50 })
        .fill('#E0E0E0')
        .margin({ right: 12 })
      
      // 信息
      Column() {
        Row() {
          Text(name)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .layoutWeight(1)
          
          Text(stars)
            .fontSize(14)
        }
        .width('100%')
        .margin({ bottom: 4 })
        
        Text(title)
          .fontSize(14)
          .fontColor('#007AFF')
          .margin({ bottom: 2 })
        
        Text(achievement)
          .fontSize(12)
          .fontColor('#666')
          .maxLines(2)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      
      // 徽章
      Circle({ width: 8, height: 8 })
        .fill(badgeColor)
        .margin({ left: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ left: 16, right: 16, top: 8, bottom: 8 })
    .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }

  @Builder ProfileTab() {
    Column() {
      Text('个人中心开发中...')
        .fontSize(16)
        .fontColor('#999')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  private async loadMockData() {
    // 创建一些模拟数据
    const event1 = new Event()
    event1.title = 'HarmonyOS开发技术分享'
    event1.description = '深入了解HarmonyOS应用开发的最佳实践和新特性'
    event1.startTime = new Date(2025, 0, 15, 19, 0)
    event1.endTime = new Date(2025, 0, 15, 21, 0)
    event1.location = '北京市朝阳区科技园'
    event1.organizer = '华为开发者社区'
    event1.category = EventCategory.TECH_TALK
    event1.maxParticipants = 100
    event1.currentParticipants = 45
    event1.tags = ['HarmonyOS', 'ArkTS', '移动开发']
    event1.isOnline = false
    event1.status = EventStatus.UPCOMING

    const event2 = new Event()
    event2.title = 'Vue.js 3.0 实战工作坊'
    event2.description = '从零开始学习Vue.js 3.0的组合式API和新特性'
    event2.startTime = new Date(2025, 0, 18, 14, 0)
    event2.endTime = new Date(2025, 0, 18, 17, 0)
    event2.location = '线上直播'
    event2.organizer = 'Vue.js中文社区'
    event2.category = EventCategory.WORKSHOP
    event2.maxParticipants = 200
    event2.currentParticipants = 156
    event2.tags = ['Vue.js', 'JavaScript', '前端']
    event2.isOnline = true
    event2.meetingLink = 'https://meeting.example.com/vue-workshop'
    event2.status = EventStatus.UPCOMING

    await this.eventService.createEvent(event1)
    await this.eventService.createEvent(event2)
    
    this.allEvents = await this.eventService.getAllEvents()
  }

  private async loadTodayEvents() {
    this.todayEvents = await this.eventService.getEventsByDate(this.selectedDate)
  }

  private async loadEventsByDate(date: Date) {
    this.todayEvents = await this.eventService.getEventsByDate(date)
  }

  private async joinEvent(eventId: string) {
    const success = await this.eventService.joinEvent(eventId)
    if (success) {
      // 刷新数据
      this.allEvents = await this.eventService.getAllEvents()
      this.loadEventsByDate(this.selectedDate)
    }
  }
}