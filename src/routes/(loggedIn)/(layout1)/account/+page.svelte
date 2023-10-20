<script lang="ts">
  import ProfileForm from './ProfileForm.svelte';
  import EmailForm from './EmailForm.svelte';
  import PasswordForm from './PasswordForm.svelte';
  import type { PageData } from '../../account/$types';
  import { Button } from '$lib/components/ui/button';
  import { Rocket } from 'lucide-svelte';

  export let data: PageData;
</script>

<div class="py-20">
  <!-- Account Page Header -->
  <div class="flex flex-col items-center max-w-2xl pb-20 mx-auto text-center">
    <span class="mt-2 text-5xl font-bold">Account Settings</span>
    <span class="mt-4 text-lg leading-8 text-center text-neutral-content">
      Manage your email, password, billing, and other account details.
    </span>
  </div>
  <div
    class="max-w-xl mx-auto space-y-16 divide-y divide-gray-300 divide-surface-700 dark:divide-gray-700"
  >
    <!-- Current Plan & Billing Section -->
    <!-- <section class="px-6">
      <div class="flex items-center font-semibold">
        <Rocket />
        <span class="ml-4">Current Plan & Billing</span>
      </div>
      <p class="mt-3 text-sm max-w-none">Manage your current plan and billing details</p>
      <div class="mt-8">
        <div>
          Current Plan: <strong>Free</strong>
        </div>
        <Button class="mt-4">Manage Billing</Button>
      </div>
    </section> -->
    <ProfileForm form={data.profileForm} />
    <EmailForm form={data.emailForm} />
    <PasswordForm form={data.passwordForm} />
  </div>
</div>
