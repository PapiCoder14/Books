<script lang="ts">
  import { page } from '$app/stores';

  import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
  import * as Avatar from '$lib/components/ui/avatar';
  import { Button } from '$lib/components/ui/button';
  const { data } = $page;
  $: user = data.user;
</script>

{#if user}
  <DropdownMenu.Root positioning={{ placement: 'bottom-end' }}>
    <DropdownMenu.Trigger asChild let:builder>
      <Button variant="ghost" builders={[builder]} class="relative w-8 h-8 rounded-full">
        <Avatar.Root class="w-8 h-8">
          <Avatar.Image
            src={user.avatar_url == '' || !user.avatar_url
              ? 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'
              : user.avatar_url}
            alt="avatar"
          />
          <!-- <Avatar.Fallback>{user.display_name}</Avatar.Fallback> -->
        </Avatar.Root>
      </Button>
    </DropdownMenu.Trigger>
    <DropdownMenu.Content class="w-56">
      <!-- <DropdownMenu.Label class="font-normal">
      <div class="flex flex-col space-y-1">
        <p class="text-sm font-medium leading-none">{user.display_name}</p>
        <p class="text-xs leading-none text-muted-foreground">m@example.com</p>
      </div>
    </DropdownMenu.Label>
    <DropdownMenu.Separator /> -->
      <DropdownMenu.Group>
        <DropdownMenu.Item>
          Profile
          <!-- <DropdownMenu.Shortcut>⇧⌘P</DropdownMenu.Shortcut> -->
        </DropdownMenu.Item>
        <!-- <DropdownMenu.Item>
        Billing
        <DropdownMenu.Shortcut>⌘B</DropdownMenu.Shortcut>
      </DropdownMenu.Item> -->
        <DropdownMenu.Item>
          <a href="/admin" class="w-full">Admin</a>
          <!-- <DropdownMenu.Shortcut>⌘S</DropdownMenu.Shortcut> -->
        </DropdownMenu.Item>
        <DropdownMenu.Item>
          <a href="/account" class="w-full">Settings</a>
          <!-- <DropdownMenu.Shortcut>⌘S</DropdownMenu.Shortcut> -->
        </DropdownMenu.Item>
        <!-- <DropdownMenu.Item>New Team</DropdownMenu.Item> -->
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Item>
        <form action="/auth/logout" method="POST"><button class="w-full">Log out</button></form>
        <!-- <DropdownMenu.Shortcut>⇧⌘Q</DropdownMenu.Shortcut> -->
      </DropdownMenu.Item>
    </DropdownMenu.Content>
  </DropdownMenu.Root>
{:else}
  <Button href="/auth/login">Login</Button>
{/if}
