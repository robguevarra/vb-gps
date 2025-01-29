'use client'

import {
  ColumnDef,
  flexRender,
  getCoreRowModel,
  useReactTable,
} from '@tanstack/react-table'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'

interface Missionary {
  id: string
  full_name: string
  monthly_goal: number
  surplus_balance: number
  local_church: { name: string }
}

export const columns: ColumnDef<Missionary>[] = [
  {
    accessorKey: 'full_name',
    header: 'Name',
  },
  {
    accessorKey: 'local_church.name',
    header: 'Local Church',
  },
  {
    accessorKey: 'monthly_goal',
    header: 'Monthly Goal',
    cell: ({ row }) => formatCurrency(row.getValue('monthly_goal')),
  },
  {
    accessorKey: 'surplus_balance',
    header: 'Surplus Balance',
    cell: ({ row }) => formatCurrency(row.getValue('surplus_balance')),
  },
]

export function MissionariesTable({ missionaries }: { missionaries: Missionary[] }) {
  const table = useReactTable({
    data: missionaries,
    columns,
    getCoreRowModel: getCoreRowModel(),
  })

  return (
    <div className="rounded-md border">
      <Table>
        <TableHeader>
          {table.getHeaderGroups().map((headerGroup) => (
            <TableRow key={headerGroup.id}>
              {headerGroup.headers.map((header) => (
                <TableHead key={header.id}>
                  {flexRender(
                    header.column.columnDef.header,
                    header.getContext()
                  )}
                </TableHead>
              ))}
            </TableRow>
          ))}
        </TableHeader>
        <TableBody>
          {table.getRowModel().rows?.length ? (
            table.getRowModel().rows.map((row) => (
              <TableRow key={row.id}>
                {row.getVisibleCells().map((cell) => (
                  <TableCell key={cell.id}>
                    {flexRender(cell.column.columnDef.cell, cell.getContext())}
                  </TableCell>
                ))}
              </TableRow>
            ))
          ) : (
            <TableRow>
              <TableCell colSpan={columns.length} className="h-24 text-center">
                No missionaries found
              </TableCell>
            </TableRow>
          )}
        </TableBody>
      </Table>
    </div>
  )
} 