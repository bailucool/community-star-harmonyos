import { Event } from '../models/Event'

@Component
export struct CalendarView {
  @State currentDate: Date = new Date()
  @State selectedDate: Date = new Date()
  @State events: Event[] = []
  onDateSelect?: (date: Date) => void

  build() {
    Column() {
      // 月份导航
      Row() {
        Button('<')
          .onClick(() => {
            this.currentDate = new Date(this.currentDate.getFullYear(), 
              this.currentDate.getMonth() - 1, 1)
          })
        
        Text(`${this.currentDate.getFullYear()}年${this.currentDate.getMonth() + 1}月`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        Button('>')
          .onClick(() => {
            this.currentDate = new Date(this.currentDate.getFullYear(), 
              this.currentDate.getMonth() + 1, 1)
          })
      }
      .width('100%')
      .padding(16)

      // 星期标题
      Row() {
        Text('日').width('14.28%').textAlign(TextAlign.Center).fontSize(14).fontColor('#666')
        Text('一').width('14.28%').textAlign(TextAlign.Center).fontSize(14).fontColor('#666')
        Text('二').width('14.28%').textAlign(TextAlign.Center).fontSize(14).fontColor('#666')
        Text('三').width('14.28%').textAlign(TextAlign.Center).fontSize(14).fontColor('#666')
        Text('四').width('14.28%').textAlign(TextAlign.Center).fontSize(14).fontColor('#666')
        Text('五').width('14.28%').textAlign(TextAlign.Center).fontSize(14).fontColor('#666')
        Text('六').width('14.28%').textAlign(TextAlign.Center).fontSize(14).fontColor('#666')
      }
      .width('100%')

      // 日期网格
      Grid() {
        ForEach(this.generateCalendarDays(), (day: CalendarDay) => {
          GridItem() {
            this.DayCell(day)
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
      .rowsGap(8)
      .columnsGap(8)
      .padding(16)
    }
  }

  @Builder DayCell(day: CalendarDay) {
    Column() {
      Text(day.day.toString())
        .fontSize(16)
        .fontColor(day.isCurrentMonth ? '#333' : '#ccc')
        .fontWeight(day.isToday ? FontWeight.Bold : FontWeight.Normal)
      
      if (day.hasEvents) {
        Circle({ width: 6, height: 6 })
          .fill('#007AFF')
          .margin({ top: 2 })
      }
    }
    .width(40)
    .height(40)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(day.isSelected ? '#007AFF' : 'transparent')
    .borderRadius(20)
    .onClick(() => {
      this.selectedDate = day.date
      this.onDateSelect?.(day.date)
    })
  }

  private generateCalendarDays(): CalendarDay[] {
    const days: CalendarDay[] = []
    const year = this.currentDate.getFullYear()
    const month = this.currentDate.getMonth()
    
    // 获取当月第一天和最后一天
    const firstDay = new Date(year, month, 1)
    const lastDay = new Date(year, month + 1, 0)
    
    // 获取第一天是星期几
    const startWeekDay = firstDay.getDay()
    
    // 添加上个月的日期
    for (let i = startWeekDay - 1; i >= 0; i--) {
      const date = new Date(year, month, -i)
      days.push(new CalendarDay(date, false))
    }
    
    // 添加当月的日期
    for (let day = 1; day <= lastDay.getDate(); day++) {
      const date = new Date(year, month, day)
      days.push(new CalendarDay(date, true))
    }
    
    // 添加下个月的日期补齐6行
    const remainingCells = 42 - days.length
    for (let day = 1; day <= remainingCells; day++) {
      const date = new Date(year, month + 1, day)
      days.push(new CalendarDay(date, false))
    }
    
    return days
  }
}

class CalendarDay {
  date: Date
  day: number
  isCurrentMonth: boolean
  isToday: boolean
  isSelected: boolean
  hasEvents: boolean

  constructor(date: Date, isCurrentMonth: boolean) {
    this.date = date
    this.day = date.getDate()
    this.isCurrentMonth = isCurrentMonth
    this.isToday = this.isSameDay(date, new Date())
    this.isSelected = false
    this.hasEvents = false // 实际应用中需要检查该日期是否有活动
  }

  private isSameDay(date1: Date, date2: Date): boolean {
    return date1.getFullYear() === date2.getFullYear() &&
           date1.getMonth() === date2.getMonth() &&
           date1.getDate() === date2.getDate()
  }
}