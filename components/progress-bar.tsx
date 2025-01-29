interface ProgressBarProps {
    current: number
    goal: number
  }
  
  export default function ProgressBar({ current, goal }: ProgressBarProps) {
    const percentage = Math.min((current / goal) * 100, 100)
  
    return (
      <div className="space-y-2">
        <div className="flex justify-between text-sm text-muted-foreground">
          <span>Current: ${current.toLocaleString()}</span>
          <span>Goal: ${goal.toLocaleString()}</span>
        </div>
        <div className="h-4 bg-secondary rounded-full overflow-hidden">
          <div
            className="h-full bg-primary transition-all duration-500 ease-in-out"
            style={{ width: `${percentage}%` }}
          />
        </div>
        <div className="text-right text-sm font-medium text-primary">{percentage.toFixed(1)}%</div>
      </div>
    )
  }
  
  