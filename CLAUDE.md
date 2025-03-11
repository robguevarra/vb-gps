# Victory Bible GPS Code Guidelines

## Build/Lint/Test Commands
- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run start` - Start production server
- `npm run lint` - Run ESLint

## Code Style Guidelines
- **TypeScript**: Use strict typing with interfaces defined in `/types` directory
- **Components**: Server components by default; use "use client" only when necessary
- **Imports**: Group by: 1) React/Next.js, 2) External libraries, 3) Internal components, 4) Utils/types
- **Naming**: PascalCase for components, camelCase for functions/variables, kebab-case for files
- **Error Handling**: Use try/catch with proper logging and user-friendly error messages
- **Data Fetching**: Use server components for initial data, React Query for client-side updates
- **Animation**: Use Framer Motion for complex animations, CSS transitions for simple ones
- **Performance**: Use React.memo for expensive components, virtualization for long lists
- **State Management**: Zustand for global state, useState for local component state
- **Formatting**: Follow ESLint/Next.js config, use consistent spacing and braces

## Component Architecture Patterns
- **Pure Server Components**: For data-display components without interactivity
- **Hybrid Components**: Server wrapper for data + client islands for interactivity
- **Client Components**: Only for highly interactive UI with complex state

## Optimization Workflow
1. Convert data-fetching to server component wrapper
2. Implement parallel data fetching with Promise.all
3. Use React Query for client-side state with proper caching
4. Add Suspense boundaries with skeleton loaders
5. Implement progressive loading with staggered animations