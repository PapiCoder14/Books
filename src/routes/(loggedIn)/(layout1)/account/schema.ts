// src/lib/schemas.ts
import { z } from 'zod';

export const profileSchema = z.object({
  display_name: z.string().max(64, 'Name must be 64 characters or less').nullish(),
  username: z.string().max(64, 'Name must be 64 characters or less').nullish()
});

export type ProfileSchema = typeof profileSchema;

export const emailSchema = z.object({
  email: z.string().email('Invalid email address')
});

export type EmailSchema = typeof emailSchema;

export const passwordSchema = z.object({
  password: z
    .string()
    .min(6, 'Password must be at least 6 characters')
    .max(64, 'Password must be 64 characters or less'),
  passwordConfirm: z
    .string()
    .min(6, 'Password must be at least 6 characters')
    .max(64, 'Password must be 64 characters or less')
});

export type PasswordSchema = typeof passwordSchema;
