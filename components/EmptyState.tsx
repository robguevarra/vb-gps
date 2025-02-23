import { ReactNode } from "react"
import { cn } from "@/lib/utils"

interface EmptyStateProps {
  icon?: ReactNode
  title: string
  description: string
  className?: string
}

export function EmptyState({ icon, title, description, className }: EmptyStateProps) {
  return (
    <div className={cn("text-center p-8 border rounded-lg bg-muted/20", className)}>
      {icon && <div className="mx-auto mb-4 text-muted-foreground">{icon}</div>}
      <h3 className="text-sm font-medium text-foreground">{title}</h3>
      <p className="mt-1 text-sm text-muted-foreground">{description}</p>
    </div>
  )
} 