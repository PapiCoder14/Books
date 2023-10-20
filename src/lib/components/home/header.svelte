<script lang="ts">
  import DashboardMainNav from './main-nav.svelte';
  import Search from './search.svelte';

  import UserNav from './user-nav.svelte';
</script>

<div class="border-b">
  <div class="flex items-center h-16 px-4">
    <DashboardMainNav class="mx-6" />
    <div class="flex items-center ml-auto space-x-4">
      <Search />
      <UserNav />
    </div>
  </div>
</div>
