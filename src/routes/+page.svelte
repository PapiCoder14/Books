<script lang="ts">
  import { page } from '$app/stores';
  const { data } = $page;
  const { user } = data;
  import Button from '$lib/components/ui/button/button.svelte';

</script>

{#if user}
  hello {user.display_name}
  <Button href="/feed">Click Me</Button>
{/if}
