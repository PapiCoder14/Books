<script lang="ts">
  import * as Form from '$lib/components/ui/form';
  import { Lock } from 'lucide-svelte';
  import { passwordSchema, type PasswordSchema } from './schema';
  import type { SuperValidated } from 'sveltekit-superforms';

  export let form: SuperValidated<PasswordSchema>;
</script>

<section class="px-6 pt-16">
  <div class="flex items-center font-semibold">
    <Lock />
    <span class="ml-4">Password</span>
  </div>
  <p class="my-3 text-sm">Change the password associated with your account</p>

  <Form.Root method="POST" {form} schema={passwordSchema} let:config action="?/updatePassword">
    <Form.Field {config} name="password">
      <Form.Item>
        <Form.Label>Password</Form.Label>
        <Form.Input />
        <!-- <Form.Description>This is your public display name.</Form.Description> -->
        <Form.Validation />
      </Form.Item>
    </Form.Field>
    <Form.Field {config} name="passwordConfirm">
      <Form.Item>
        <Form.Label>Confirm New Password</Form.Label>
        <Form.Input />
        <!-- <Form.Description>This is your public display name.</Form.Description> -->
        <Form.Validation />
      </Form.Item>
    </Form.Field>
    <Form.Button>Change Password</Form.Button>
  </Form.Root>
</section>
