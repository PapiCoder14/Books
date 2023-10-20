import { z } from 'zod';

export const contentBlockSchema = z.object({
  title: z.string().max(140, 'Title must be 140 characters or less').nullish(),
  body: z.string(),
  url:z.string()
});

export type ContentBlockSchema = typeof contentBlockSchema;
