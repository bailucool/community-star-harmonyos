import { Event, EventStatus, EventCategory } from '../models/Event'

interface EventUpdateData {
  title?: string
  description?: string
  startTime?: Date
  endTime?: Date
  location?: string
  organizer?: string
  category?: EventCategory
  maxParticipants?: number
  currentParticipants?: number
  tags?: string[]
  isOnline?: boolean
  meetingLink?: string
  status?: EventStatus
}

/**
 * 活动服务类
 */
export class EventService {
  private static instance: EventService
  private events: Event[] = []

  static getInstance(): EventService {
    if (!EventService.instance) {
      EventService.instance = new EventService()
    }
    return EventService.instance
  }

  /**
   * 获取所有活动
   */
  async getAllEvents(): Promise<Event[]> {
    // 模拟数据，实际应用中从数据库或API获取
    return this.events
  }

  /**
   * 根据日期获取活动
   */
  async getEventsByDate(date: Date): Promise<Event[]> {
    const targetDate = new Date(date.getFullYear(), date.getMonth(), date.getDate())
    return this.events.filter(event => {
      const eventDate = new Date(event.startTime.getFullYear(), 
        event.startTime.getMonth(), event.startTime.getDate())
      return eventDate.getTime() === targetDate.getTime()
    })
  }

  /**
   * 创建活动
   */
  async createEvent(event: Event): Promise<boolean> {
    event.id = Date.now().toString()
    event.createdAt = new Date()
    event.updatedAt = new Date()
    this.events.push(event)
    return true
  }

  /**
   * 更新活动
   */
  async updateEvent(eventId: string, updates: EventUpdateData): Promise<boolean> {
    const index = this.events.findIndex(e => e.id === eventId)
    if (index !== -1) {
      const event = this.events[index]
      if (updates.title !== undefined) event.title = updates.title
      if (updates.description !== undefined) event.description = updates.description
      if (updates.startTime !== undefined) event.startTime = updates.startTime
      if (updates.endTime !== undefined) event.endTime = updates.endTime
      if (updates.location !== undefined) event.location = updates.location
      if (updates.organizer !== undefined) event.organizer = updates.organizer
      if (updates.category !== undefined) event.category = updates.category
      if (updates.maxParticipants !== undefined) event.maxParticipants = updates.maxParticipants
      if (updates.currentParticipants !== undefined) event.currentParticipants = updates.currentParticipants
      if (updates.tags !== undefined) event.tags = updates.tags
      if (updates.isOnline !== undefined) event.isOnline = updates.isOnline
      if (updates.meetingLink !== undefined) event.meetingLink = updates.meetingLink
      if (updates.status !== undefined) event.status = updates.status
      event.updatedAt = new Date()
      return true
    }
    return false
  }

  /**
   * 删除活动
   */
  async deleteEvent(eventId: string): Promise<boolean> {
    const index = this.events.findIndex(e => e.id === eventId)
    if (index !== -1) {
      this.events.splice(index, 1)
      return true
    }
    return false
  }

  /**
   * 参加活动
   */
  async joinEvent(eventId: string): Promise<boolean> {
    const event = this.events.find(e => e.id === eventId)
    if (event && event.currentParticipants < event.maxParticipants) {
      event.currentParticipants++
      return true
    }
    return false
  }
}