import { Label } from "./ui/label"
import { Input } from "./ui/input"

export default function CreateDonationForm() {
  return (
    <form>
      <Label htmlFor="amount">Amount (₱)</Label>
      <Input
        id="amount"
        type="number"
        placeholder="Enter amount in PHP"
      /> 
    </form>
  )
} 