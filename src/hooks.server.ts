// src/hooks.server.ts
import { ENV } from '$lib/server/env';
import { redirect } from '@sveltejs/kit';

import { createSupabaseServerClient } from '@supabase/auth-helpers-sveltekit';
import type { Handle } from '@sveltejs/kit';
import { sequence } from '@sveltejs/kit/hooks';

const handleSupaBase: Handle = async ({ event, resolve }) => {
  event.locals.supabase = createSupabaseServerClient({
    supabaseUrl: ENV.PUBLIC_SUPABASE_URL,
    supabaseKey: ENV.PUBLIC_SUPABASE_ANON_KEY,
    event
  });

  event.locals.getSession = async () => {
    const {
      data: { session }
    } = await event.locals.supabase.auth.getSession();
    return session;
  };

  return resolve(event, {
    /**
     * There´s an issue with `filterSerializedResponseHeaders` not working when using `sequence`
     *
     * https://github.com/sveltejs/kit/issues/8061
     */
    filterSerializedResponseHeaders(name) {
      return name === 'content-range';
    }
  });
};

const handleUserDetails = (async ({ event, resolve }) => {
  const session = await event.locals.getSession();
  const supabaseClient = event.locals.supabase;

  if (session) {
    // console.log('🚀 ~ file: hooks.server.ts:1 ~ handle:Handle= ~ session', session.access_token);
    const { data: user, error } = await supabaseClient
      .from('user_accounts')
      .select('*')
      .eq('id', session.user.id)
      .single();
    console.log("🚀 ~ file: hooks.server.ts:46 ~ handleUserDetails ~ user:", user)
    if (error) {
      // await supabaseClient.auth.signOut();
      throw redirect(302, '/auth/login');
    }

    if (!error || user) {
      console.log(' router id ', event.route.id);
      const route = event.route.id;

      if (route?.includes('/auth/login')) {
        // console.log(' on boarded page after onborded');
        throw redirect(302, '/');
      }

      event.locals.user = user;

      // if route is contain admin and then check if user is admin or not
      // if (route?.includes('admin')) {
      //   if (user.role_id !== 'admin') throw redirect(302, '/');
      // }


    }
  }

  return resolve(event);
  
}) satisfies Handle;

export const handle = sequence(handleSupaBase, handleUserDetails);
