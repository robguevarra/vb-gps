export type Database = {
  public: {
    Tables: {
      local_churches: {
        Row: {
          id: number
          name: string
          district_id: number | null
          lead_pastor_id: string | null
        }
      }
      // Add other table definitions here
    }
  }
} 