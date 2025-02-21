'use client'

import { Line } from 'react-chartjs-2'
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
} from 'chart.js'

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
)

export default function ProgressChart({
  goal,
  current
}: {
  goal: number
  current: number
}) {
  const data = {
    labels: ['Progress'],
    datasets: [
      {
        label: 'Monthly Goal',
        data: [goal],
        borderColor: '#3b82f6',
        backgroundColor: '#bfdbfe',
        borderWidth: 2,
        barPercentage: 0.5,
      },
      {
        label: 'Current Donations',
        data: [current],
        borderColor: '#10b981',
        backgroundColor: '#a7f3d0',
        borderWidth: 2,
        barPercentage: 0.5,
      },
    ],
  }

  const options = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'top' as const,
      },
      tooltip: {
        callbacks: {
          label: (context: any) => {
            const label = context.dataset.label || ''
            const value = context.parsed.y || 0
            return `${label}: ₱${value.toLocaleString()}`
          }
        }
      }
    },
    scales: {
      y: {
        beginAtZero: true,
        grid: {
          color: '#e5e7eb',
        },
        ticks: {
          callback: (value: any) => `₱${value.toLocaleString()}`,
        },
      },
      x: {
        grid: {
          display: false,
        },
      },
    },
  }

  return (
    <div className="h-full">
      <Line data={data} options={options} />
    </div>
  )
} 