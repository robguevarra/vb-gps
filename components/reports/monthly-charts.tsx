'use client'

import { Donation } from '@/types'
import { LineChart, PieChart, Line, Pie, XAxis, YAxis, Tooltip, Legend } from 'recharts'
import { formatCurrency } from '@/lib/utils'

export function MonthlyCharts({ donations }: { donations: Donation[] }) {
  const monthlyData = donations.reduce((acc, d) => {
    const month = new Date(d.date).toLocaleString('default', { month: 'short' })
    acc[month] = (acc[month] || 0) + d.amount
    return acc
  }, {} as Record<string, number>)

  const sourceData = donations.reduce((acc, d) => {
    acc[d.source] = (acc[d.source] || 0) + 1
    return acc
  }, {} as Record<string, number>)

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mt-8">
      <div className="p-4 bg-card rounded-lg">
        <h3 className="text-lg font-semibold mb-4">Donations Trend</h3>
        <LineChart width={500} height={300} data={Object.entries(monthlyData).map(([name, value]) => ({ name, value }))}>
          <XAxis dataKey="name" />
          <YAxis tickFormatter={value => formatCurrency(value)} />
          <Tooltip formatter={(value: number) => formatCurrency(value)} />
          <Line type="monotone" dataKey="value" stroke="#2563eb" />
        </LineChart>
      </div>

      <div className="p-4 bg-card rounded-lg">
        <h3 className="text-lg font-semibold mb-4">Donation Sources</h3>
        <PieChart width={500} height={300}>
          <Pie
            data={Object.entries(sourceData).map(([name, value]) => ({ name, value }))}
            dataKey="value"
            nameKey="name"
            cx="50%"
            cy="50%"
            outerRadius={100}
            label
          />
          <Tooltip />
          <Legend />
        </PieChart>
      </div>
    </div>
  )
} 