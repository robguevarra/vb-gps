'use client'

import { useState } from 'react'
import { Command, CommandInput, CommandItem, CommandList, CommandEmpty, CommandGroup } from '@/components/ui/command'
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover'
import { Button } from '@/components/ui/button'
import { Check, ChevronsUpDown, Plus, Loader2 } from 'lucide-react'
import { cn } from '@/lib/utils'

interface DonorComboboxProps {
  donors: Array<{ id: string; name: string }>;
  value: string;
  onSelect: (donorId: string) => void;
  onSearch: (searchTerm: string) => void;
  onCreateDonor: (name: string) => Promise<string | undefined>;
  loading: boolean;
}

export function DonorCombobox({
  donors,
  value,
  onSelect,
  onSearch,
  onCreateDonor,
  loading
}: DonorComboboxProps) {
  const [open, setOpen] = useState(false);
  const [inputValue, setInputValue] = useState('');

    // Find the selected donor's name for display
    const selectedDonorName = donors.find(d => d.id === value)?.name;

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild>
        <Button
          variant="outline"
          role="combobox"
          aria-expanded={open}
          className="w-[300px] justify-between"
        >
          {value ? selectedDonorName || "Select donor..." : "Select donor..."}
          <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
        </Button>
      </PopoverTrigger>
      <PopoverContent className="w-[300px] p-0">
        <Command>
          <CommandInput
            placeholder="Search donors..."
            value={inputValue}
            onValueChange={(value) => {
                setInputValue(value);
                onSearch(value); // Call the onSearch prop (debounced in parent)
                if (!open) setOpen(true); // Keep open while typing
            }}
          />
          {loading && (  // Show loading indicator
            <div className="p-2 text-sm text-muted-foreground">
              <Loader2 className="mr-2 h-4 w-4 animate-spin" />
              Searching...
            </div>
          )}
          <CommandList>
            <CommandEmpty>No donor found.</CommandEmpty>
            <CommandGroup>
              {donors.map((donor) => (
                <CommandItem
                  key={donor.id}
                  value={donor.id}
                  onSelect={() => {
                    onSelect(donor.id);
                    setOpen(false);
                    setInputValue(''); // Clear input after selection
                  }}
                >
                  <Check
                    className={cn(
                      "mr-2 h-4 w-4",
                      value === donor.id ? "opacity-100" : "opacity-0"
                    )}
                  />
                  {donor.name}
                </CommandItem>
              ))}
              {inputValue.trim() && (
                <CommandItem
                  value="create"
                  onSelect={async () => {
                    const newDonorId = await onCreateDonor(inputValue.trim());
                    if (newDonorId) {
                      onSelect(newDonorId);
                      setOpen(false);
                      setInputValue(''); // Clear input after creation
                    }
                  }}
                  className="text-green-600"
                >
                  <Plus className="mr-2 h-4 w-4" />
                  Create "{inputValue.trim()}"
                </CommandItem>
              )}
            </CommandGroup>
          </CommandList>
        </Command>
      </PopoverContent>
    </Popover>
  );
} 