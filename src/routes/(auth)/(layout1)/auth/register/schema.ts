import { z } from 'zod';

export const registerUserSchema = z.object({
  full_name: z.string().min(2,"Enter Valid Name").max(140, 'Name must be 140 characters or less'),
  email: z.string().email('Invalid email address'),
  password: z
    .string()
    .min(6, 'Password must be at least 6 characters')
    .max(64, 'Password must be 64 characters or less'),
  passwordConfirm: z
    .string()
    .min(6, 'Password must be at least 6 characters')
    .max(64, 'Password must be 64 characters or less')
});

export type RegisterUserSchema = typeof registerUserSchema;
