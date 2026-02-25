// @ts-check
import { defineConfig, passthroughImageService } from 'astro/config';

import tailwindcss from '@tailwindcss/vite';
import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  site: 'https://experiments.swm.cc',
  image: {
    service: passthroughImageService(),
  },
  vite: {
    plugins: [tailwindcss()]
  },
  integrations: [mdx(), sitemap()]
});