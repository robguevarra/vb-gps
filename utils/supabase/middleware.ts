import { NextRequest, NextResponse } from 'next/server';
import { supabase } from './supabaseClient';
import jwt from 'jsonwebtoken';

export async function updateSession(request: NextRequest) {
  const token = request.cookies.get('sb:token')?.value;

  if (!token) {
    return NextResponse.redirect(new URL('/login', request.url));
  }

  try {
    // Replace 'your_jwt_secret' with your actual JWT secret
    const { sub: userId } = jwt.verify(token, process.env.JWT_SECRET!) as { sub: string };

    const { data: user, error } = await supabase.auth.getUser(token);

    if (error || !user) {
      return NextResponse.redirect(new URL('/login', request.url));
    }

    // Attach user information to the request if needed
    // You can use request.headers or other methods to pass user info

    return NextResponse.next();
  } catch (err) {
    console.error('Authentication error:', err);
    return NextResponse.redirect(new URL('/login', request.url));
  }
}