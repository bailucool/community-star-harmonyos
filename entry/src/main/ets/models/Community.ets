/**
 * 社区数据模型
 */
export class Community {
  id: string = ''
  name: string = ''
  description: string = ''
  logo: string = ''
  memberCount: number = 0
  isJoined: boolean = false
  tags: string[] = []
  createdAt: Date = new Date()

  constructor(data?: CommunityData) {
    if (data) {
      this.id = data.id ?? ''
      this.name = data.name ?? ''
      this.description = data.description ?? ''
      this.logo = data.logo ?? ''
      this.memberCount = data.memberCount ?? 0
      this.isJoined = data.isJoined ?? false
      this.tags = data.tags ?? []
      this.createdAt = data.createdAt ?? new Date()
    }
  }
}

export interface CommunityData {
  id?: string
  name?: string
  description?: string
  logo?: string
  memberCount?: number
  isJoined?: boolean
  tags?: string[]
  createdAt?: Date
}

/**
 * 用户数据模型
 */
export class User {
  id: string = ''
  username: string = ''
  avatar: string = ''
  email: string = ''
  joinedCommunities: string[] = []
  createdAt: Date = new Date()

  constructor(data?: UserData) {
    if (data) {
      this.id = data.id ?? ''
      this.username = data.username ?? ''
      this.avatar = data.avatar ?? ''
      this.email = data.email ?? ''
      this.joinedCommunities = data.joinedCommunities ?? []
      this.createdAt = data.createdAt ?? new Date()
    }
  }
}

export interface UserData {
  id?: string
  username?: string
  avatar?: string
  email?: string
  joinedCommunities?: string[]
  createdAt?: Date
}
}