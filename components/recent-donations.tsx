import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { formatDate, formatCurrency } from "@/lib/utils"

interface Donation {
  donor_name: string;
  date: string | Date;
  amount: number;
}

interface RecentDonationsProps {
  donations: Donation[];
}

export default function RecentDonations({ donations }: RecentDonationsProps) {
  return (
    <Card className="bg-white dark:bg-gray-800 shadow-lg rounded-xl overflow-hidden">
      <CardHeader>
        <CardTitle className="text-2xl font-bold text-gray-900 dark:text-white">Recent Donations</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          {donations.map((donation, index) => (
            <div key={index} className="flex justify-between items-center border-b border-gray-200 dark:border-gray-700 pb-4 last:border-b-0 last:pb-0">
              <div>
                <p className="font-semibold text-gray-800 dark:text-gray-200">{donation.donor_name}</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">{formatDate(donation.date)}</p>
              </div>
              <p className="text-lg font-bold text-green-600 dark:text-green-400">{formatCurrency(donation.amount)}</p>
            </div>
          ))}
        </div>
      </CardContent>
    </Card>
  )
}