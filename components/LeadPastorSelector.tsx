"use client"

import { useState, useEffect } from "react"
import { useRouter } from "next/navigation"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { User } from "lucide-react"

const LeadPastorSelector = ({ leadPastors, userId: initialUserId }) => {
  const router = useRouter()
  const [selected, setSelected] = useState(initialUserId || "clear")

  useEffect(() => {
    setSelected(initialUserId || "clear")
  }, [initialUserId])

  const handleValueChange = (value: string) => {
    setSelected(value)

    const newParams = new URLSearchParams(window.location.search)
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

export default LeadPastorSelector

