import { faker } from '@faker-js/faker';

export const generateMockDonations = (count: number) => {
  return Array.from({ length: count }, () => ({
    donor_name: faker.person.fullName(),
    amount: faker.number.float({ min: 50, max: 500, precision: 0.01 }),
    date: faker.date.recent().toISOString(),
    status: 'completed'
  }));
};

export const mockProfile = {
  full_name: 'John Missionary',
  local_churches: { name: 'Main Campus Church' },
  monthly_goal: 5000,
  surplus_balance: 1200,
  role: 'missionary'
};

export const generateMockRequests = (count: number) => {
  return Array.from({ length: count }, (_, i) => ({
    id: `req_${i + 1}`,
    type: ['Surplus', 'Leave'][Math.floor(Math.random() * 2)],
    missionaryName: `Missionary ${i + 1}`,
    amount: Math.floor(Math.random() * 1000) + 500,
    status: ['Pending', 'Approved', 'Rejected'][Math.floor(Math.random() * 3)],
    date: new Date().toISOString()
  }))
}

export const generateMockChurches = (count: number) => {
  return Array.from({ length: count }, (_, i) => ({
    id: `church_${i + 1}`,
    name: `Local Church ${i + 1}`,
    memberCount: Math.floor(Math.random() * 500) + 100
  }))
}

export const generateMockUsers = (count: number) => {
  return Array.from({ length: count }, (_, i) => ({
    id: `user_${i + 1}`,
    full_name: `User ${i + 1}`,
    role: ['missionary', 'campus_director', 'finance_officer'][Math.floor(Math.random() * 3)],
    email: `user${i + 1}@example.com`
  }))
}

export const generateMockLeaveRequests = (count: number) => {
  return Array.from({ length: count }, (_, i) => ({
    id: `leave_${i + 1}`,
    type: 'Leave',
    startDate: faker.date.soon({ days: 7 }).toISOString().split('T')[0],
    endDate: faker.date.soon({ days: 14 }).toISOString().split('T')[0],
    reason: faker.lorem.sentence(),
    status: ['pending', 'approved', 'rejected'][Math.floor(Math.random() * 3)],
    date: faker.date.recent().toISOString()
  }))
}

export const generateMockSurplusRequests = (count: number) => {
  return Array.from({ length: count }, (_, i) => ({
    id: `surplus_${i + 1}`,
    type: 'Surplus',
    amount: faker.number.float({ min: 100, max: 1000, precision: 0.01 }),
    reason: faker.lorem.sentence(),
    status: ['pending', 'approved', 'rejected'][Math.floor(Math.random() * 3)],
    date: faker.date.recent().toISOString()
  }))
}