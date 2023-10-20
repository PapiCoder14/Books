import { error, redirect } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

export const POST: RequestHandler = async (event) => {
  //   console.log('coming to logout');
  const { error: logoutError } = await event.locals.supabase.auth.signOut();

  if (logoutError) {
    throw error(500, 'Error logging you out. Please try again.');
  }

  throw redirect(302, '/auth/login');
};
