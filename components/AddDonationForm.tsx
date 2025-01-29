'use client'

import { useSupabase } from '@/app/supabase-provider'
import { useState } from 'react'

export default function AddDonationForm() {
  const { supabase } = useSupabase()
  const [loading, setLoading] = useState(false)
  const [formState, setFormState] = useState({
    missionary_id: '',
    amount: '',
    donor_name: '',
    date: new Date().toISOString().split('T')[0]
  })

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)

    const { error } = await supabase.from('donations').insert