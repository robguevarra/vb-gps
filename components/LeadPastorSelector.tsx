/**
 * LeadPastorSelector Component
 * 
 * Client component that allows selecting a lead pastor from a dropdown.
 * This component is used in the lead pastor dashboard to switch between different lead pastors.
 * 
 * @component
 */

"use client"

import { useState, useEffect, Suspense } from "react"
import { useRouter, useSearchParams } from "next/navigation"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { User } from "lucide-react"

interface LeadPastor {
  id: string;
  full_name: string;
  role: string;
}

interface LeadPastorSelectorProps {
  leadPastors: LeadPastor[];
  userId: string;
}

/**
 * SelectorContent Component
 * 
 * This component handles the actual selection logic and URL updates.
 * It's separated to properly handle the useSearchParams hook which needs
 * to be wrapped in a Suspense boundary.
 */
function SelectorContent({ leadPastors, userId }: LeadPastorSelectorProps) {
  const router = useRouter()
  const searchParams = useSearchParams()
  const [selected, setSelected] = useState(userId || "clear")

  useEffect(() => {
    setSelected(userId || "clear")
  }, [userId])

  const handleValueChange = (value: string) => {
    setSelected(value)

    const newParams = new URLSearchParams(searchParams?.toString() || "")
    newParams.set("_t", Date.now().toString())

    if (value === "clear") {
      newParams.delete("userId")
    } else {
      newParams.set("userId", value)
    }

    const newUrl = `${window.location.pathname}?${newParams.toString()}`
    router.push(newUrl, { scroll: false })
  }

  return (
    <Select value={selected} onValueChange={handleValueChange}>
      <SelectTrigger className="w-[250px]">
        <SelectValue placeholder="Select lead pastor" />
      </SelectTrigger>
      <SelectContent>
        <SelectItem value="clear" className="flex items-center gap-2">
          <span>View as myself</span>
        </SelectItem>
        {leadPastors.map((leadPastor) => (
          <SelectItem key={leadPastor.id} value={leadPastor.id} className="flex items-center gap-2">
            <span>{leadPastor.full_name}</span>
          </SelectItem>
        ))}
      </SelectContent>
    </Select>
  )
}

/**
 * LeadPastorSelector Component
 * 
 * Wrapper component that provides a Suspense boundary for the SelectorContent.
 */
const LeadPastorSelector = (props: LeadPastorSelectorProps) => {
  return (
    <Suspense fallback={
      <Select disabled value={props.userId || "clear"}>
        <SelectTrigger className="w-[250px]">
          <SelectValue placeholder="Loading..." />
        </SelectTrigger>
      </Select>
    }>
      <SelectorContent {...props} />
    </Suspense>
  )
}

export default LeadPastorSelector

