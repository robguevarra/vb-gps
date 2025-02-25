import { Label } from "./ui/label"
import { Input } from "./ui/input"

export default function SurplusRequestForm() {
  return (
    <form>
      <Label>Requested Amount (₱)</Label>
      <Input
        placeholder="Enter amount in PHP"
      /> 
    </form>
  )
} 