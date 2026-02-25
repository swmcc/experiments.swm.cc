import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';

export async function GET(context) {
  const posts = await getCollection('posts');
  const experiments = await getCollection('experiments');

  const items = posts
    .filter((post) => !post.data.draft)
    .sort((a, b) => b.data.pubDate.getTime() - a.data.pubDate.getTime())
    .map((post) => {
      const parts = post.id.split('/');
      const experimentSlug = parts[0];
      const postSlug = parts.slice(1).join('/').replace('.mdx', '').replace('.md', '');
      const experiment = experiments.find((e) => e.id.startsWith(experimentSlug + '/'));

      return {
        title: `${post.data.title} (${experiment?.data.title || experimentSlug})`,
        pubDate: post.data.pubDate,
        link: `/${experimentSlug}/${postSlug}/`,
      };
    });

  return rss({
    title: 'experiments.swm.cc',
    description: 'A digital lab notebook',
    site: context.site || 'https://experiments.swm.cc',
    items,
  });
}
