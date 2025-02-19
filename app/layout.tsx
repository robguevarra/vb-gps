// app/layout.tsx
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import '../styles/globals.css'
import { cn } from '@/lib/utils'
import { Toaster } from '@/components/ui/toaster'

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
      <body
        className={cn(
          'bg-background font-sans antialiased min-h-screen',
          inter.className
        )}
      >
        {/* No sidebar spacing here. Only global UI (like a global <Navbar> if you want it on non-dashboard pages too). */}
        {children}
        <Toaster />
      </body>
    </html>
  )
}
