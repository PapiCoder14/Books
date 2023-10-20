<script lang="ts">
  import * as Form from '$lib/components/ui/form';
  import * as Card from '$lib/components/ui/card';
  import { contentBlockSchema, type ContentBlockSchema } from './schema';
  import type { SuperValidated } from 'sveltekit-superforms';
  export let form: SuperValidated<ContentBlockSchema>;
</script>

<div class="py-20">
  <div class="flex flex-col items-center w-full">
    <Card.Root class="w-full md:w-1/2 lg:w-1/3">
      <Card.Header>
        <Card.Title>Create Content Block</Card.Title>
        <!-- <Card.Description>Create a content block</Card.Description> -->
      </Card.Header>
      <Card.Content>
        <Form.Root method="POST" {form} schema={contentBlockSchema} let:config>
          <Form.Field {config} name="title">
            <Form.Item>
              <Form.Label>Title</Form.Label>
              <Form.Input />
              <!-- <Form.Description>This is your public display name.</Form.Description> -->
              <Form.Validation />
            </Form.Item>
          </Form.Field>
          <Form.Field {config} name="url">
            <Form.Item>
              <Form.Label>Video URL(optional)</Form.Label>
              <Form.Input placeholder="Paste the link to video here"/>
              <!-- <Form.Description>This is your public display name.</Form.Description> -->
              <Form.Validation />
            </Form.Item>
          </Form.Field>
          <Form.Field {config} name="body">
            <Form.Item>
              <Form.Label>Body</Form.Label>
              <Form.Textarea placeholder="body" />
              <!-- <Form.Description>Please login with your email.</Form.Description> -->
              <Form.Validation />
            </Form.Item>
          </Form.Field>

          <Form.Button>Submit</Form.Button>
        </Form.Root>
      </Card.Content>
      <!-- <Card.Footer class="flex justify-between">
      <Button variant="outline">Cancel</Button>
      <Button>Deploy</Button>
    </Card.Footer> -->
    </Card.Root>
  </div>
</div>
