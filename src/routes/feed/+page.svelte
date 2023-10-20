<script context="module" lang="ts">
  import { onMount } from 'svelte';
  import { Video, Player } from '@vime/svelte';
</script>

<script lang="ts">
  let contentBlocks: ContentBlock[] = [];

  type ContentBlock = {
    id: number;
    title: string;
    url: string | null;
    body: string;
  };

  const fetchData = async () => {
    const url = 'http://localhost:65431/rest/v1/content_blocks';
    const apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU'; // Replace with your service role key

    const response = await fetch(url, {
      method: 'GET',
      headers: {
        apikey: apiKey
      }
    });

    if (response.ok) {
      contentBlocks = await response.json();
    }
  };

  onMount(() => {
    fetchData();
  });
</script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@vime/core@^5/themes/default.css" />

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@vime/core@^5/themes/light.css" />
<div class="content">
  {#if contentBlocks.length === 0}
    <p>Loading...</p>
  {:else}
    {#each contentBlocks as contentBlock (contentBlock.id)}
      <div class="content-block">
        <h2>{contentBlock.title}</h2>
        {#if contentBlock.url}
          <Player controls>
            <Video poster="https://media.vimejs.com/poster.png">
              <source src="https://www.youtube.com/watch?v=7Ck8wSoKJXI" />
            </Video>
          </Player>
        {/if}
        <p>{contentBlock.body}</p>
      </div>
    {/each}
  {/if}
</div>

<style>
  .content {
    display: flex;
    flex-wrap: wrap;
  }

  .content-block {
    margin: 10px;
    padding: 10px;
    border: 1px solid #ccc;
  }
</style>
