import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';

export async function GET(context) {
  const posts = await getCollection('posts');
  const experiments = await getCollection('experiments');

  // Build a map of experiment slugs to titles
  const experimentMap = new Map();
  experiments.forEach((e) => {
    const slug = e.id.replace('/index', '');
    experimentMap.set(slug, e.data.title);
  });

  // Posts as feed items
  const postItems = posts
    .filter((post) => !post.data.draft)
    .map((post) => {
      const parts = post.id.split('/');
      const experimentSlug = parts[0];
      const postSlug = parts.slice(1).join('/').replace('.mdx', '').replace('.md', '');
      const experimentTitle = experimentMap.get(experimentSlug) || experimentSlug;

      return {
        title: `${post.data.title} (${experimentTitle})`,
        description: `New update in ${experimentTitle}`,
        pubDate: post.data.pubDate,
        link: `/${experimentSlug}/${postSlug}/`,
      };
    });

  // Experiments as feed items (when they start)
  const experimentItems = experiments.map((experiment) => {
    const slug = experiment.id.replace('/index', '');
    return {
      title: `New experiment: ${experiment.data.title}`,
      description: experiment.data.description,
      pubDate: experiment.data.started,
      link: `/${slug}/`,
    };
  });

  // Combine and sort by date
  const items = [...postItems, ...experimentItems].sort(
    (a, b) => b.pubDate.getTime() - a.pubDate.getTime()
  );

  return rss({
    title: 'experiments.swm.cc',
    description: 'A digital lab notebook',
    site: context.site || 'https://experiments.swm.cc',
    items,
  });
}
