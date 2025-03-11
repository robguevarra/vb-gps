// next.config.ts remains unchanged

// Updated middleware.ts
import { createServerClient, type CookieOptions } from '@supabase/ssr';
import { type NextRequest, NextResponse } from 'next/server';

/**
 * Middleware for handling caching and navigation optimizations
 * 
 * This middleware:
 * 1. Sets appropriate cache headers for different dashboard tabs
 * 2. Implements special caching for the Overview tab to prevent unnecessary reloads
 * 3. Respects refresh requests to bypass the cache when needed
 * 
 * The caching strategy improves performance by:
 * - Caching the Overview tab content in the browser
 * - Allowing manual refresh when fresh data is needed
 * - Using different cache settings for different tabs based on data volatility
 */
export async function middleware(request: NextRequest) {
  // If this is an OPTIONS request for an API route, handle it immediately
  if (request.method === 'OPTIONS' && request.nextUrl.pathname.startsWith('/api/')) {
    const origin = request.headers.get("origin") || "";
    const allowedOrigins = [
      "https://victorybulacan.org",
      "https://www.victorybulacan.org",
      "http://localhost:3000",
      "https://v0-gps.vercel.app"
    ];
    const isAllowed = allowedOrigins.includes(origin);

    return new NextResponse(null, {
      status: 204,
      headers: {
        "Access-Control-Allow-Origin": isAllowed ? origin : "",
        "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
        "Access-Control-Allow-Headers": "X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version, Authorization",
        "Access-Control-Allow-Credentials": "true",
        "Vary": "Origin"
      }
    });
  }

  // Start with a default response.
  let response = NextResponse.next({
    request: {
      headers: request.headers,
    },
  });

  // If this is an API route, add CORS headers.
  // Adjust the condition if you want to target specific routes.
  if (request.nextUrl.pathname.startsWith('/api/')) {
    const origin = request.headers.get("origin") || "";
    // You can restrict allowed origins if needed
    const allowedOrigins = [
      "https://victorybulacan.org",
      "https://www.victorybulacan.org",
      "http://localhost:3000",
      "https://v0-gps.vercel.app"
    ];
    const isAllowed = allowedOrigins.includes(origin);

    response.headers.set("Access-Control-Allow-Origin", isAllowed ? origin : "");
    response.headers.set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    response.headers.set(
      "Access-Control-Allow-Headers",
      "X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version, Authorization"
    );
    response.headers.set("Access-Control-Allow-Credentials", "true");
    // Include Vary header when using dynamic origin.
    response.headers.set("Vary", "Origin");
  }

  // Initialize Supabase client for SSR with cookies.
  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        get(name: string) {
          return request.cookies.get(name)?.value;
        },
        set(name: string, value: string, options: CookieOptions) {
          const cookieOptions = {
            ...options,
            maxAge: 60 * 60 * 24,
            expires: new Date(Date.now() + 1000 * 60 * 60 * 24),
          };
          request.cookies.set({ name, value, ...cookieOptions });
          response = NextResponse.next({
            request: {
              headers: request.headers,
            },
          });
          response.cookies.set({ name, value, ...cookieOptions });
        },
        remove(name: string, options: CookieOptions) {
          request.cookies.set({ name, value: '', ...options });
          response = NextResponse.next({
            request: {
              headers: request.headers,
            },
          });
          response.cookies.set({ name, value: '', ...options });
        },
      },
    }
  );

  // Refresh session if expired (required for Server Components)
  await supabase.auth.getSession();

  const url = new URL(request.url);
  
  // Only apply caching to dashboard routes
  if (url.pathname.includes('/dashboard/missionary')) {
    const searchParams = url.searchParams;
    const tab = searchParams.get('tab') || 'overview';
    const isRefreshRequest = searchParams.has('refresh');
    
    // Set different cache control headers based on the tab
    if (tab === 'overview' && !isRefreshRequest) {
      // Cache Overview tab for 5 minutes unless explicitly refreshed
      // This prevents the 2-3 second reload when switching back to Overview
      response.headers.set(
        'Cache-Control',
        'public, s-maxage=300, stale-while-revalidate=60'
      );
    } else if (isRefreshRequest) {
      // For refresh requests, bypass the cache completely
      response.headers.set(
        'Cache-Control',
        'no-store, must-revalidate'
      );
    } else {
      // For other tabs, use a shorter cache time
      response.headers.set(
        'Cache-Control',
        'public, s-maxage=60, stale-while-revalidate=30'
      );
    }
  }

  return response;
}

// Apply middleware to all routes except static assets, images, and favicon.
export const config = {
  matcher: [
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
  ],
};
