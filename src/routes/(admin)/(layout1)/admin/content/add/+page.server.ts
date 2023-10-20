import type { Actions, PageServerLoad } from './$types';
import { setError, superValidate } from 'sveltekit-superforms/server';
import { fail, redirect } from '@sveltejs/kit';
import { contentBlockSchema } from './schema';

export const load: PageServerLoad = async ({ request, locals, params }) => {
  const { getSession, supabase } = locals;
  const session = await getSession();

  if (!session) {
    throw redirect(302, '/auth/login');
  }
  return {
    form: superValidate(contentBlockSchema)
  };
};

export const actions: Actions = {
  default: async (event) => {
    const { getSession, supabase } = event.locals;
    const session = await getSession();

    if (!session) {
      throw redirect(307, '/auth/login');
    }

    const form = await superValidate(event, contentBlockSchema);

    if (!form.valid) {
      return fail(400, {
        form
      });
    }

    const { data: content, error: contentError } = await supabase
      .from('content_blocks')
      .insert({
        title: form.data.title,
        body: form.data.body,
        url:form.data.url,
        creator_id: session.user.id
      })
      .single();

    return {
      form
    };
  }
};
