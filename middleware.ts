// next.config.ts remains unchanged

// Updated middleware.ts
import { createServerClient, type CookieOptions } from '@supabase/ssr';
import { type NextRequest, NextResponse } from 'next/server';

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

  return response;
}

// Apply middleware to all routes except static assets, images, and favicon.
export const config = {
  matcher: [
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
  ],
};
