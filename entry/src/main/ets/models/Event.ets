/**
 * 活动数据模型
 */
export class Event {
  id: string = ''
  title: string = ''
  description: string = ''
  startTime: Date = new Date()
  endTime: Date = new Date()
  location: string = ''
  organizer: string = ''
  category: EventCategory = EventCategory.TECH_TALK
  maxParticipants: number = 0
  currentParticipants: number = 0
  tags: string[] = []
  isOnline: boolean = false
  meetingLink?: string
  status: EventStatus = EventStatus.UPCOMING
  createdAt: Date = new Date()
  updatedAt: Date = new Date()

  constructor(data?: EventData) {
    if (data) {
      this.id = data.id ?? ''
      this.title = data.title ?? ''
      this.description = data.description ?? ''
      this.startTime = data.startTime ?? new Date()
      this.endTime = data.endTime ?? new Date()
      this.location = data.location ?? ''
      this.organizer = data.organizer ?? ''
      this.category = data.category ?? EventCategory.TECH_TALK
      this.maxParticipants = data.maxParticipants ?? 0
      this.currentParticipants = data.currentParticipants ?? 0
      this.tags = data.tags ?? []
      this.isOnline = data.isOnline ?? false
      this.meetingLink = data.meetingLink
      this.status = data.status ?? EventStatus.UPCOMING
      this.createdAt = data.createdAt ?? new Date()
      this.updatedAt = data.updatedAt ?? new Date()
    }
  }
}

export enum EventCategory {
  TECH_TALK = 'tech_talk',
  WORKSHOP = 'workshop', 
  MEETUP = 'meetup',
  CONFERENCE = 'conference',
  HACKATHON = 'hackathon',
  NETWORKING = 'networking'
}

export enum EventStatus {
  UPCOMING = 'upcoming',
  ONGOING = 'ongoing', 
  COMPLETED = 'completed',
  CANCELLED = 'cancelled'
}

export interface EventData {
  id?: string
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
  createdAt?: Date
  updatedAt?: Date
}