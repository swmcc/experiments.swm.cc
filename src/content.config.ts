import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const experiments = defineCollection({
  loader: glob({ pattern: '**/index.{md,mdx}', base: './src/content/experiments' }),
  schema: z.object({
    title: z.string(),
    tagline: z.string().optional(),
    description: z.string(),
    status: z.enum(['active', 'paused', 'stalled', 'completed', 'archived']),
    started: z.coerce.date(),
    repo: z.string().url().optional(),
    writeup: z.string().url().optional(),
    writeup2: z.string().url().optional(),
    note: z.string().url().optional(),
    tags: z.array(z.string()).default([]),
    cover: z.string().optional(),
  }),
});

const posts = defineCollection({
  loader: glob({ pattern: '**/[0-9]*.{md,mdx}', base: './src/content/experiments' }),
  schema: z.object({
    title: z.string(),
    pubDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    pr: z.string().url().optional(),
    snapshot: z.string().url().optional(),
    tags: z.array(z.string()).default([]),
    draft: z.boolean().default(false),
  }),
});

export const collections = { experiments, posts };
