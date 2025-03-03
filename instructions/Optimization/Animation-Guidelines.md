# Staff Portal - Animation & Interaction Guidelines

**Version 1.0 - June 2024**

## 🎯 Purpose

This document provides comprehensive guidelines for implementing animations and interactions throughout the Staff Portal application. These guidelines ensure a consistent, engaging, and performance-optimized user experience while maintaining accessibility standards.

## 🧩 Animation Principles

### Core Animation Values

1. **Purposeful**: Every animation should serve a specific purpose:
   - Guide user attention
   - Provide feedback
   - Establish spatial relationships
   - Enhance perceived performance

2. **Subtle**: Animations should enhance the experience without overwhelming it:
   - Quick durations (150-300ms for most interactions)
   - Natural easing functions
   - Appropriate scale and distance

3. **Consistent**: Animation patterns should be predictable across the application:
   - Similar elements animate in similar ways
   - Consistent timing and easing
   - Predictable motion patterns

4. **Performant**: Animations must maintain 60fps on target devices:
   - Prefer CSS transforms and opacity
   - Avoid animating layout properties
   - Use hardware acceleration appropriately
   - Implement will-change for complex animations

## 🎬 Animation Categories

### 1. Page Transitions

**Purpose**: Create a sense of continuity between routes and reduce perceived loading time.

**Implementation**:
```tsx
// Page transition wrapper component
export function PageTransition({ children, mode = "fade" }) {
  const pathname = usePathname();
  
  const variants = {
    fade: {
      initial: { opacity: 0 },
      animate: { opacity: 1, transition: { duration: 0.3 } },
      exit: { opacity: 0, transition: { duration: 0.2 } }
    },
    slide: {
      initial: { x: 10, opacity: 0 },
      animate: { x: 0, opacity: 1, transition: { duration: 0.3 } },
      exit: { x: -10, opacity: 0, transition: { duration: 0.2 } }
    },
    scale: {
      initial: { scale: 0.98, opacity: 0 },
      animate: { scale: 1, opacity: 1, transition: { duration: 0.3 } },
      exit: { scale: 0.98, opacity: 0, transition: { duration: 0.2 } }
    }
  };
  
  return (
    <AnimatePresence mode="wait">
      <motion.div
        key={pathname}
        initial={variants[mode].initial}
        animate={variants[mode].animate}
        exit={variants[mode].exit}
        className="w-full"
      >
        {children}
      </motion.div>
    </AnimatePresence>
  );
}
```

**Usage Guidelines**:
- Use subtle fade transitions for most page changes
- Use slide transitions for hierarchical navigation
- Use scale transitions for modal-like pages
- Keep transitions under 300ms to maintain responsiveness

### 2. Micro-Interactions

**Purpose**: Provide immediate feedback for user actions and enhance perceived responsiveness.

**Implementation**:
```tsx
// Button with feedback
<Button
  onClick={handleClick}
  className="transition-all duration-200 hover:scale-105 active:scale-95"
>
  Submit
</Button>

// Input focus effect
<div className="relative">
  <input 
    className="border-2 border-gray-300 transition-all duration-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200"
  />
</div>

// Toggle switch
<Switch
  checked={isEnabled}
  onChange={setIsEnabled}
  className={`${
    isEnabled ? 'bg-blue-600' : 'bg-gray-200'
  } relative inline-flex h-6 w-11 items-center rounded-full transition-colors duration-200`}
>
  <span
    className={`${
      isEnabled ? 'translate-x-6' : 'translate-x-1'
    } inline-block h-4 w-4 transform rounded-full bg-white transition-transform duration-200`}
  />
</Switch>
```

**Usage Guidelines**:
- Keep micro-interactions subtle and quick (150-200ms)
- Ensure visual feedback for all interactive elements
- Maintain consistency across similar interaction types
- Use appropriate easing functions (ease-out for entering, ease-in for exiting)

### 3. Loading States

**Purpose**: Reduce perceived waiting time and provide feedback during asynchronous operations.

**Implementation**:
```tsx
// Skeleton loader
export function CardSkeleton() {
  return (
    <div className="rounded-lg border p-4 space-y-3">
      <div className="h-4 w-2/3 bg-gray-200 rounded animate-pulse" />
      <div className="h-10 bg-gray-200 rounded animate-pulse" />
      <div className="h-4 w-1/2 bg-gray-200 rounded animate-pulse" />
    </div>
  );
}

// Animated spinner
export function LoadingSpinner({ size = "md" }) {
  const sizeClasses = {
    sm: "h-4 w-4",
    md: "h-8 w-8",
    lg: "h-12 w-12"
  };
  
  return (
    <div className="flex justify-center items-center">
      <svg
        className={`animate-spin ${sizeClasses[size]} text-primary`}
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 24 24"
      >
        <circle
          className="opacity-25"
          cx="12"
          cy="12"
          r="10"
          stroke="currentColor"
          strokeWidth="4"
        />
        <path
          className="opacity-75"
          fill="currentColor"
          d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
        />
      </svg>
    </div>
  );
}

// Progress indicator
export function ProgressBar({ value, max = 100 }) {
  return (
    <div className="w-full bg-gray-200 rounded-full h-2.5">
      <div
        className="bg-blue-600 h-2.5 rounded-full transition-all duration-500 ease-out"
        style={{ width: `${(value / max) * 100}%` }}
      />
    </div>
  );
}
```

**Usage Guidelines**:
- Use skeleton loaders for content that takes >300ms to load
- Use spinners for actions that take <300ms
- Implement progress indicators for operations with known duration
- Ensure loading states match the layout of the content they replace

### 4. List & Data Animations

**Purpose**: Enhance the perception of data changes and help users track items in lists.

**Implementation**:
```tsx
// Animated list with staggered children
export function AnimatedList({ items }) {
  return (
    <motion.ul
      initial="hidden"
      animate="visible"
      variants={{
        visible: {
          transition: {
            staggerChildren: 0.05
          }
        },
        hidden: {}
      }}
      className="space-y-2"
    >
      {items.map((item) => (
        <motion.li
          key={item.id}
          variants={{
            visible: { opacity: 1, y: 0 },
            hidden: { opacity: 0, y: 20 }
          }}
          transition={{ duration: 0.2 }}
          className="p-4 border rounded-lg"
        >
          {item.content}
        </motion.li>
      ))}
    </motion.ul>
  );
}

// Animated data changes
export function AnimatedValue({ value, prefix = "", suffix = "" }) {
  return (
    <motion.span
      key={value}
      initial={{ opacity: 0, y: -10 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: 10 }}
      transition={{ duration: 0.2 }}
    >
      {prefix}{value}{suffix}
    </motion.span>
  );
}
```

**Usage Guidelines**:
- Use staggered animations for lists with >3 items
- Keep stagger delay short (30-50ms between items)
- Animate data changes to draw attention to updates
- Use AnimatePresence for elements that enter/exit the DOM

### 5. Attention-Guiding Animations

**Purpose**: Direct user attention to important elements or changes.

**Implementation**:
```tsx
// Highlight animation
export function HighlightEffect({ children }) {
  return (
    <motion.div
      initial={{ backgroundColor: "rgba(59, 130, 246, 0.2)" }}
      animate={{ backgroundColor: "rgba(59, 130, 246, 0)" }}
      transition={{ duration: 1.5 }}
    >
      {children}
    </motion.div>
  );
}

// Pulse animation
export function PulseEffect({ children }) {
  return (
    <div className="relative">
      <motion.div
        className="absolute inset-0 rounded-lg bg-blue-500"
        initial={{ opacity: 0.5, scale: 0.85 }}
        animate={{ 
          opacity: 0,
          scale: 1.2,
          transition: { 
            repeat: Infinity,
            duration: 1.5
          }
        }}
      />
      {children}
    </div>
  );
}
```

**Usage Guidelines**:
- Use sparingly to avoid overwhelming the user
- Apply to truly important elements that require attention
- Ensure animations eventually stop or become subtle
- Use colors that align with the meaning (blue for info, red for alerts)

## 🎭 Animation Patterns by Component

### Buttons & Controls

**Primary Buttons**:
- Hover: Scale up slightly (105%)
- Active/Press: Scale down slightly (95%)
- Focus: Ring outline with subtle pulse
- Loading: Replace text with spinner, maintain width

**Secondary/Ghost Buttons**:
- Hover: Background opacity change
- Active/Press: Background opacity increase
- Focus: Ring outline
- Loading: Reduced opacity with spinner

**Toggle Controls**:
- State change: Smooth transition between states
- Knob movement: Slight overshoot for playfulness
- Color change: Synchronize with movement

### Form Elements

**Inputs**:
- Focus: Border color change with subtle expansion
- Validation: Gentle shake for errors
- Completion: Subtle success indicator

**Dropdowns & Select**:
- Open: Fade in with slight expansion
- Close: Quick fade out
- Selection: Highlight row before closing

**Modals & Dialogs**:
- Enter: Fade in with slight scale up from center
- Exit: Quick fade out with slight scale down
- Backdrop: Synchronized fade with slight delay

### Data Visualization

**Charts & Graphs**:
- Initial load: Progressive reveal from axis
- Data updates: Smooth transition between values
- Hover states: Quick response without delay

**Progress Indicators**:
- Linear progress: Smooth width transitions
- Circular progress: Continuous rotation for indeterminate state
- Milestone indicators: Distinct state changes with celebration animations

### Navigation Elements

**Menu transitions**:
- Expand/collapse: Natural physics-based motion
- Active indicators: Smooth position changes
- Mobile drawer: Slide in from edge with backdrop fade

**Tabs & Pagination**:
- Selection indicator: Smooth position transition
- Content change: Coordinated exit/enter animations
- Loading states: Maintain structure with skeletons

## 🧰 Technical Implementation

### CSS Transitions

**For simple state changes**:
```css
.element {
  transition-property: transform, opacity, background-color;
  transition-duration: 200ms;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

.element:hover {
  transform: scale(1.05);
}

.element:active {
  transform: scale(0.95);
}
```

### CSS Animations

**For repeating animations**:
```css
@keyframes pulse {
  0% { opacity: 0.7; transform: scale(1); }
  50% { opacity: 1; transform: scale(1.05); }
  100% { opacity: 0.7; transform: scale(1); }
}

.pulsing-element {
  animation: pulse 2s ease-in-out infinite;
}
```

### Framer Motion

**For complex, orchestrated animations**:
```tsx
// Coordinated animations with variants
const containerVariants = {
  hidden: { opacity: 0 },
  visible: {
    opacity: 1,
    transition: {
      when: "beforeChildren",
      staggerChildren: 0.1
    }
  }
};

const itemVariants = {
  hidden: { y: 20, opacity: 0 },
  visible: {
    y: 0,
    opacity: 1,
    transition: { type: "spring", stiffness: 300, damping: 24 }
  }
};

function AnimatedContainer({ children }) {
  return (
    <motion.div
      variants={containerVariants}
      initial="hidden"
      animate="visible"
    >
      {children.map(child => (
        <motion.div key={child.key} variants={itemVariants}>
          {child}
        </motion.div>
      ))}
    </motion.div>
  );
}
```

### Tailwind CSS Animation Classes

**For standardized animations**:
```tsx
// Using Tailwind's animation utilities
<div className="animate-fade-in-up">Content</div>
<div className="animate-pulse">Loading...</div>
<div className="animate-bounce">Attention</div>
```

**Custom Tailwind animations**:
```js
// In tailwind.config.js
module.exports = {
  theme: {
    extend: {
      keyframes: {
        "fade-in-up": {
          "0%": { opacity: "0", transform: "translateY(10px)" },
          "100%": { opacity: "1", transform: "translateY(0)" }
        },
        "slide-in-right": {
          "0%": { transform: "translateX(100%)" },
          "100%": { transform: "translateX(0)" }
        }
      },
      animation: {
        "fade-in-up": "fade-in-up 0.3s ease-out",
        "slide-in-right": "slide-in-right 0.4s ease-out"
      }
    }
  }
};
```

## 🌐 Responsive Animation Considerations

### Performance Optimization

**Reduce animation complexity on mobile**:
```tsx
function ResponsiveAnimation() {
  const isReducedMotion = useReducedMotion();
  const isMobile = useMediaQuery("(max-width: 768px)");
  
  const variants = {
    desktop: {
      hidden: { opacity: 0, y: 20 },
      visible: { 
        opacity: 1, 
        y: 0, 
        transition: { 
          type: "spring", 
          stiffness: 300, 
          damping: 24 
        } 
      }
    },
    mobile: {
      hidden: { opacity: 0 },
      visible: { 
        opacity: 1, 
        transition: { duration: 0.2 } 
      }
    },
    reduced: {
      hidden: { opacity: 0 },
      visible: { opacity: 1 }
    }
  };
  
  const currentVariant = isReducedMotion 
    ? "reduced" 
    : isMobile 
      ? "mobile" 
      : "desktop";
  
  return (
    <motion.div
      variants={variants[currentVariant]}
      initial="hidden"
      animate="visible"
    >
      Content
    </motion.div>
  );
}
```

### Device-Specific Adjustments

**Adjust timing based on device**:
- Mobile: Faster animations (150-200ms)
- Desktop: Standard animations (200-300ms)
- Consider touch vs. mouse interactions

**Adjust animation distance**:
- Mobile: Smaller translation distances
- Desktop: More pronounced movements

## ♿ Accessibility Considerations

### Respecting User Preferences

**Honor reduced motion settings**:
```tsx
import { useReducedMotion } from "framer-motion";

function AccessibleAnimation() {
  const shouldReduceMotion = useReducedMotion();
  
  return (
    <motion.div
      animate={{ 
        x: shouldReduceMotion ? 0 : 100,
        opacity: 1
      }}
    >
      Content
    </motion.div>
  );
}
```

**CSS approach**:
```css
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
  }
}
```

### Animation Alternatives

**Provide non-animated alternatives**:
- Use color and opacity changes instead of motion
- Ensure functionality works without animation
- Focus on essential feedback animations

## 📏 Animation Timing Guidelines

| Animation Type | Duration | Easing | Notes |
|----------------|----------|--------|-------|
| Micro-interactions | 100-200ms | ease-out | Button clicks, toggles |
| Page transitions | 200-300ms | ease-in-out | Route changes |
| Content reveals | 300-500ms | ease-out | Progressive loading |
| Attention grabbing | 500-800ms | spring | Notifications, alerts |
| Background effects | 1000-2000ms | linear or ease-in-out | Ambient animations |

## 🎮 Interactive Examples

### Button States
```tsx
export function AnimatedButton({ children, onClick }) {
  return (
    <motion.button
      onClick={onClick}
      className="px-4 py-2 bg-blue-500 text-white rounded-lg"
      whileHover={{ scale: 1.05 }}
      whileTap={{ scale: 0.95 }}
      transition={{ type: "spring", stiffness: 400, damping: 17 }}
    >
      {children}
    </motion.button>
  );
}
```

### Card Hover Effects
```tsx
export function AnimatedCard({ title, description }) {
  return (
    <motion.div
      className="p-6 bg-white rounded-xl shadow-md"
      initial={{ boxShadow: "0 4px 6px -1px rgba(0,0,0,0.1)" }}
      whileHover={{ 
        y: -5,
        boxShadow: "0 10px 25px -5px rgba(0,0,0,0.1)",
        transition: { duration: 0.2 }
      }}
    >
      <h3 className="text-lg font-medium">{title}</h3>
      <p className="mt-2 text-gray-500">{description}</p>
    </motion.div>
  );
}
```

### Notification Animation
```tsx
export function Notification({ message, onClose }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: -20, scale: 0.95 }}
      animate={{ opacity: 1, y: 0, scale: 1 }}
      exit={{ opacity: 0, y: -20, scale: 0.95 }}
      transition={{ duration: 0.3 }}
      className="p-4 bg-green-100 border-l-4 border-green-500 rounded-r-lg"
    >
      <div className="flex justify-between">
        <p>{message}</p>
        <button onClick={onClose}>×</button>
      </div>
    </motion.div>
  );
}
```

## 🧠 Decision Framework

When implementing animations, follow this decision tree:

1. **Purpose**: Does this animation serve a clear purpose?
   - Yes → Continue
   - No → Don't animate

2. **Performance**: Will this animation maintain 60fps?
   - Yes → Continue
   - No → Simplify or remove

3. **Accessibility**: Does this respect user preferences?
   - Yes → Continue
   - No → Provide alternatives

4. **Consistency**: Is this consistent with our patterns?
   - Yes → Implement
   - No → Revise to match patterns

## 🔄 Implementation Process

1. **Identify animation opportunities** during design phase
2. **Categorize** by animation type
3. **Implement** using appropriate technical approach
4. **Test** for performance and accessibility
5. **Refine** based on user feedback

## 📋 Animation Audit Checklist

- [ ] Animations serve a clear purpose
- [ ] Timing follows guidelines for animation type
- [ ] Respects reduced motion preferences
- [ ] Maintains 60fps on target devices
- [ ] Consistent with established patterns
- [ ] Enhances rather than hinders UX
- [ ] Provides appropriate feedback
- [ ] Works across all supported browsers
- [ ] Degrades gracefully when needed

## 🌟 Conclusion

Thoughtful animation is a powerful tool for enhancing the Staff Portal user experience. By following these guidelines, we ensure animations are purposeful, performant, accessible, and consistent across the application. Remember that animation should enhance functionality, not replace it, and should always serve the user's needs first. 