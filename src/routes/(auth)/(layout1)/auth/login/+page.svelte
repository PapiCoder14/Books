<script lang="ts">
  import * as Form from '$lib/components/ui/form';
  import * as Card from '$lib/components/ui/card';
  import { loginUserSchema, type LoginUserSchema } from './schema';
  import type { SuperValidated } from 'sveltekit-superforms';
  import Button from '$lib/components/ui/button/button.svelte';
  export let form: SuperValidated<LoginUserSchema>;
</script>

<div class="py-20">
  <div class="flex flex-col items-center w-full">
    <Card.Root class="w-full md:w-1/2 lg:w-1/3">
      <Card.Header>
        <Card.Title>Sign in</Card.Title>
        <Card.Description>Login to start finishing books</Card.Description>
      </Card.Header>
      <Card.Content>
        <Form.Root method="POST" {form} schema={loginUserSchema} let:config>
          <Form.Field {config} name="email">
            <Form.Item>
              <Form.Label>Email</Form.Label>
              <Form.Input type="email" placeholder="email" />
              <Form.Description>Please login with your email.</Form.Description>
              <Form.Validation />
            </Form.Item>
          </Form.Field>
          <Form.Field {config} name="password">
            <Form.Item>
              <Form.Label>Password</Form.Label>
              <Form.Input type="password" placeholder="password" />
              <!-- <Form.Description>Please login with your email.</Form.Description> -->
              <Form.Validation />
            </Form.Item>
          </Form.Field>

          <Form.Button>Submit</Form.Button>
        </Form.Root>
      </Card.Content>
      <Card.Footer class="flex justify-between">
        <span>or <Button href="/auth/register" variant="ghost">Register here</Button> </span>
      </Card.Footer>
    </Card.Root>
  </div>
</div>

<!-- 
<div class="py-20">
  <div class="flex flex-col items-center w-full">
    <div class="max-w-2xl text-center">
      <h1 class="text-4xl font-semibold">Register for an account</h1>
    </div>
    <Card class="w-full mt-6" padding="xl" size="md">
      <form method="POST" class="flex flex-col space-y-6" use:enhance>
        <label class="space-y-2" for="full_name">
          <span>Name</span>
          <input type="text" name="full_name" bind:value={$form.full_name} />
          {#if $errors.full_name}
            <span class="block text-red-600 dark:text-red-500">{$errors.full_name}</span>
          {/if}
        </label>
        <label class="space-y-2" for="email">
          <span>Email</span>
          <input type="email" name="email" bind:value={$form.email} />
          {#if $errors.email}
            <span class="block text-red-600 dark:text-red-500">{$errors.email}</span>
          {/if}
        </label>
        <label class="space-y-2" for="password">
          <span>Password</span>
          <input type="password" name="password" bind:value={$form.password} />
          {#if $errors.password}
            <span class="block text-red-600 dark:text-red-500">{$errors.password}</span>
          {/if}
        </label>
        <label class="space-y-2" for="passwordConfirm">
          <span>Confirm Password</span>
          <input type="password" name="passwordConfirm" bind:value={$form.passwordConfirm} />
          {#if $errors.passwordConfirm}
            <span class="block text-red-600 dark:text-red-500">{$errors.passwordConfirm}</span>
          {/if}
        </label>
        <Button type="submit" class="w-full">Register</Button>
        <div class="text-sm font-medium text-gray-500 dark:text-gray-300">
          Already have an account? <a
            href="/login"
            class="text-blue-700 hover:underline dark:text-blue-500">Sign in</a
          >
        </div>
      </form>
    </Card>
  </div>
</div> -->
