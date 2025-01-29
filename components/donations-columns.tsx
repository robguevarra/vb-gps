import { ColumnDef } from "@tanstack/react-table"
import { Donation } from "@/types"
import { formatCurrency, formatDate } from "@/lib/utils"

export const columns: ColumnDef<Donation>[] = [
  {
    accessorKey: "date",
    header: "Date",
    cell: ({ row }) => formatDate(row.getValue("date")),
  },
  {
    accessorKey: "amount",
    header: "Amount",
    cell: ({ row }) => formatCurrency(row.getValue("amount")),
  },
  {
    accessorKey: "donor_name",
    header: "Donor",
  },
  {
    accessorKey: "status",
    header: "Status",
  },
] 