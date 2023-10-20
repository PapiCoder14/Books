<script lang="ts">
  import * as Form from '$lib/components/ui/form';
  import { UserCircle } from 'lucide-svelte';
  import { profileSchema, type ProfileSchema } from './schema';
  import type { SuperValidated } from 'sveltekit-superforms';

  export let form: SuperValidated<ProfileSchema>;
</script>

<section class="px-6 pt-16">
  <div class="flex items-center font-semibold">
    <UserCircle />
    <span class="ml-4">Personal Details</span>
  </div>
  <p class="my-3 text-sm">Change the personal details associated with your account</p>

  <Form.Root method="POST" {form} schema={profileSchema} let:config action="?/updateProfile">
    <!-- <Form.Field {config} name="username">
      <Form.Item>
        <Form.Label>Username</Form.Label>
        <Form.Input />
        <Form.Description>This is your public display name.</Form.Description>
        <Form.Validation />
      </Form.Item>
    </Form.Field> -->
    <Form.Field {config} name="display_name">
      <Form.Item>
        <Form.Label>Display Name</Form.Label>
        <Form.Input />
        <!-- <Form.Description>This is your public display name.</Form.Description> -->
        <Form.Validation />
      </Form.Item>
    </Form.Field>
    <Form.Button>Update details</Form.Button>
  </Form.Root>
</section>
