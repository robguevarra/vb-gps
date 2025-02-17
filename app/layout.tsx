import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import '../styles/globals.css'
import { cn } from '@/lib/utils'
import Navbar from '@/components/navbar'
import { Toaster } from "@/components/ui/toaster"

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Missionary Staff Portal',
  description: 'Donation and leave management system',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en" className="h-full">
      <body className={cn(
        'bg-background font-sans antialiased min-h-screen',
        inter.className
      )}>
        <Navbar />
        <div className="pt-16 lg:pl-64">
          <main className="max-w-screen-xl mx-auto w-full p-4">
            {children}
          </main>
        </div>
        <Toaster />
      </body>
    </html>
  )
} 