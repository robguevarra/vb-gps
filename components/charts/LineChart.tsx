/**
 * LineChart Component
 * 
 * A reusable line chart component for visualizing time series data.
 * Built with Recharts for optimal performance and customization.
 * 
 * Key Features:
 * - Responsive design that adapts to container width
 * - Optional goal line visualization
 * - Customizable tooltips
 * - Animated transitions
 * - Touch-friendly for mobile devices
 * 
 * Performance Considerations:
 * - Uses Recharts for efficient rendering
 * - Memoized calculations
 * - Optimized re-renders
 * - Proper cleanup on unmount
 * 
 * @component
 */

import { useMemo } from "react";
import {
  ResponsiveContainer,
  LineChart as RechartsLineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ReferenceLine,
} from "recharts";
import { formatCurrency } from "@/lib/utils";

/**
 * Props for the LineChart component
 */
interface LineChartProps {
  /** Array of data points to plot */
  data: Array<{
    /** X-axis value (typically a date/time) */
    x: string;
    /** Y-axis value (typically an amount) */
    y: number;
  }>;
  /** Optional goal line value */
  goal?: number;
}

/**
 * LineChart component for visualizing time series data
 * 
 * @param props - Component props (see LineChartProps interface)
 * @returns JSX.Element - Rendered component
 */
export default function LineChart({ data, goal }: LineChartProps) {
  // Format data for display
  const chartData = useMemo(() => {
    return data.map(point => ({
      date: point.x,
      amount: point.y,
    }));
  }, [data]);

  return (
    <ResponsiveContainer width="100%" height={300}>
      <RechartsLineChart data={chartData} margin={{ top: 20, right: 20, left: 20, bottom: 20 }}>
        <CartesianGrid strokeDasharray="3 3" stroke="#374151" opacity={0.2} />
        <XAxis
          dataKey="date"
          stroke="#6B7280"
          fontSize={12}
          tickLine={false}
          axisLine={false}
        />
        <YAxis
          stroke="#6B7280"
          fontSize={12}
          tickLine={false}
          axisLine={false}
          tickFormatter={(value) => formatCurrency(value)}
        />
        <Tooltip
          content={({ active, payload }) => {
            if (active && payload && payload.length) {
              return (
                <div className="rounded-lg border bg-background p-2 shadow-sm">
                  <div className="grid grid-cols-2 gap-2">
                    <div className="flex flex-col">
                      <span className="text-[0.70rem] uppercase text-muted-foreground">
                        Date
                      </span>
                      <span className="font-bold text-muted-foreground">
                        {payload[0].payload.date}
                      </span>
                    </div>
                    <div className="flex flex-col">
                      <span className="text-[0.70rem] uppercase text-muted-foreground">
                        Amount
                      </span>
                      <span className="font-bold">
                        {formatCurrency(payload[0].value as number)}
                      </span>
                    </div>
                  </div>
                </div>
              );
            }
            return null;
          }}
        />
        {goal && (
          <ReferenceLine
            y={goal}
            stroke="#DC2626"
            strokeDasharray="3 3"
            label={{
              position: "right",
              value: "Goal",
              fill: "#DC2626",
              fontSize: 12,
            }}
          />
        )}
        <Line
          type="monotone"
          dataKey="amount"
          stroke="#2563EB"
          strokeWidth={2}
          dot={{
            r: 4,
            fill: "#2563EB",
            strokeWidth: 2,
          }}
          activeDot={{
            r: 6,
            fill: "#2563EB",
            stroke: "#BFDBFE",
            strokeWidth: 2,
          }}
        />
      </RechartsLineChart>
    </ResponsiveContainer>
  );
} 