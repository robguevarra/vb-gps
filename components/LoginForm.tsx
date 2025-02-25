import { Input } from "./ui/input"

export default function LoginForm() {
  return (
    <form>
      <Input 
        id="email"
        name="email"
        type="email"
        autoComplete="off"
        data-lpignore="true"
      />

      <Input
        id="password"
        name="password"
        type="password"
        autoComplete="new-password"
        data-lpignore="true"
      /> 
    </form>
  )
} 