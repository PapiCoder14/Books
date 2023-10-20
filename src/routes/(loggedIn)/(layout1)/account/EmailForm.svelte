<script lang="ts">
  import * as Form from '$lib/components/ui/form';
  import { Mail } from 'lucide-svelte';
  import { emailSchema, type EmailSchema } from './schema';
  import type { SuperValidated } from 'sveltekit-superforms';

  export let form: SuperValidated<EmailSchema>;
</script>

<section class="px-6 pt-16">
  <div class="flex items-center font-semibold">
    <Mail />
    <span class="ml-4">Email Address</span>
  </div>
  <p class="my-3 text-sm">Change the email associated with your account</p>

  <Form.Root method="POST" {form} schema={emailSchema} let:config action="?/updateEmail">
    <Form.Field {config} name="email">
      <Form.Item>
        <Form.Label>Email</Form.Label>
        <Form.Input />
        <!-- <Form.Description>This is your public display name.</Form.Description> -->
        <Form.Validation />
      </Form.Item>
    </Form.Field>
    <Form.Button>Update Email</Form.Button>
  </Form.Root>
</section>
