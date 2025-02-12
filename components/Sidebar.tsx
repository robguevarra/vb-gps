'use client'

import Link from 'next/link'
import { usePathname, useSearchParams } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Sheet, SheetContent, SheetTrigger } from '@/components/ui/sheet'
import { Menu } from 'lucide-react'

interface SidebarProps {
  isCampusDirector?: boolean
}

export function Sidebar({ isCampusDirector = false }: SidebarProps) {
  const pathname = usePathname()
  const searchParams = useSearchParams()
  const currentTab = searchParams.get('tab') || 'overview'

  const navItems = [
    { name: 'Overview', href: '?tab=overview' },
    { name: 'Request History', href: '?tab=history' },
    { name: 'Manual Remittance', href: '?tab=manual-remittance' },
    ...(isCampusDirector ? [{ name: 'Approvals', href: '?tab=approvals' }] : [])
  ]

  return (
    <>
      <Sheet>
        <SheetTrigger asChild className="lg:hidden">
          <Button variant="outline" size="icon" className="shrink-0">
            <Menu className="h-5 w-5" />
            <span className="sr-only">Toggle navigation menu</span>
          </Button>
        </SheetTrigger>
        <SheetContent side="left" className="flex flex-col">
          <nav className="grid gap-2 text-lg font-medium">
            {navItems.map((item) => {
              const params = new URLSearchParams(searchParams.toString())
              const newParams = new URLSearchParams(item.href.split('?')[1] || '')

              params.forEach((value, key) => {
                if (key !== 'tab' && !newParams.has(key)) {
                  newParams.set(key, value)
                }
              })

              return (
                <Link
                  key={item.name}
                  href={`${pathname}?${newParams.toString()}`}
                  className={`mx-[-0.65rem] flex items-center gap-4 rounded-xl px-3 py-2 ${
                    currentTab === item.href.split('=')[1] 
                      ? 'bg-muted text-foreground'
                      : 'text-muted-foreground hover:text-foreground'
                  }`}
                >
                  {item.name}
                </Link>
              )
            })}
          </nav>
        </SheetContent>
      </Sheet>

      {/* Desktop sidebar */}
      <div className="hidden lg:block w-64">
        <nav className="flex flex-col gap-1">
          {navItems.map((item) => {
            const params = new URLSearchParams(searchParams.toString())
            const newParams = new URLSearchParams(item.href.split('?')[1] || '')

            params.forEach((value, key) => {
              if (key !== 'tab' && !newParams.has(key)) {
                newParams.set(key, value)
              }
            })

            return (
              <Link
                key={item.name}
                href={`${pathname}?${newParams.toString()}`}
                className={`px-4 py-2 rounded-lg ${
                  currentTab === item.href.split('=')[1]
                    ? 'bg-muted font-semibold'
                    : 'hover:bg-accent'
                }`}
              >
                {item.name}
              </Link>
            )
          })}
        </nav>
      </div>
    </>
  )
} 