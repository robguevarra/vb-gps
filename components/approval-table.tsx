'use client'

import { Button } from '@/components/ui/button'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { cn } from '@/lib/utils'

export function ApprovalTable({
  data,
  columns,
  onApprove,
  onReject,
  onOverride
}: {
  data: any[]
  columns: Array<{
    header: string
    accessor: string | ((row: any) => string)
    format?: (value: any) => string
  }>
  onApprove: (id: any) => Promise<void>
  onReject: (id: any) => Promise<void>
  onOverride?: (id: any) => Promise<void>
}) {
  const getValue = (row: any, accessor: string | ((row: any) => string)) => {
    if (typeof accessor === 'function') return accessor(row)
    return accessor.split('.').reduce((obj, key) => obj?.[key], row)
  }

  return (
    <div className="rounded-md border">
      <Table>
        <TableHeader>
          <TableRow>
            {columns.map((column) => (
              <TableHead key={column.header}>{column.header}</TableHead>
            ))}
            <TableHead className="w-[200px]">Actions</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {data.map((row) => (
            <TableRow key={row.id}>
              {columns.map((column) => (
                <TableCell key={column.header}>
                  {column.format 
                    ? column.format(getValue(row, column.accessor))
                    : getValue(row, column.accessor)}
                </TableCell>
              ))}
              <TableCell className="flex gap-2">
                <Button
                  size="sm"
                  variant="success"
                  onClick={async () => await onApprove(row.id)}
                  className="h-8 px-3 text-xs"
                >
                  Approve
                </Button>
                <Button
                  size="sm"
                  variant="destructive"
                  onClick={async () => await onReject(row.id)}
                  className="h-8 px-3 text-xs"
                >
                  Reject
                </Button>
                {onOverride && (
                  <Button
                    size="sm"
                    variant="outline"
                    onClick={async () => await onOverride?.(row.id)}
                    className="h-8 px-3 text-xs"
                    title="Override campus director decision"
                  >
                    Override
                  </Button>
                )}
              </TableCell>
            </TableRow>
          ))}
          {data.length === 0 && (
            <TableRow>
              <TableCell colSpan={columns.length + 1} className="h-24 text-center">
                No pending requests
              </TableCell>
            </TableRow>
          )}
        </TableBody>
      </Table>
    </div>
  )
} 