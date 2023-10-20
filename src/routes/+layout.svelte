<script lang="ts">
  import { onMount } from 'svelte';
  import '../app.postcss';
  import type { LayoutData } from './$types';
  import { invalidate } from '$app/navigation';
  import Header from '$lib/components/home/header.svelte';

  export let data: LayoutData;

  $: ({ session, supabase, user } = data);

  onMount(() => {
    const {
      data: { subscription }
    } = supabase.auth.onAuthStateChange((event, _session) => {
      if (_session?.expires_at !== session?.expires_at) {
        invalidate('supabase:auth');
      }
    });
    return () => subscription.unsubscribe();
  });
</script>

<svelte:head>
  <title>Bookysh</title>
</svelte:head>

<Header />
<div class="p-4 mx-auto">
  <slot />
</div>
