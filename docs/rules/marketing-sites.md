# Marketing Sites

For public sites whose job is to sell or explain a product, app or company: landing pages, product and launch sites. Applies when the project's platforms include `marketing-site`. A repo that holds both an app and its marketing pages lists both platforms, and these rules apply only to the marketing pages.

## Design

- Marketing sites are exempt from [design-principles.md](design-principles.md), including the minimal UI of principle 9. Those principles are for apps people work in; a marketing site has to catch attention and be remembered.
- Make it creative and interesting, and spend real time on it. Use bold typography, distinctive layouts, strong color, motion and scroll effects where they help tell the story. A generic template look is a failure, not a safe default.
- Some things still apply, because a site people can't read or use sells nothing:
  - It works on phones, tablets and large displays, with no horizontal scrolling at 375px wide.
  - Text is readable over its background and meets [WCAG 2.1](https://www.w3.org/TR/WCAG21/) contrast, and the site is usable by keyboard.
  - Motion respects `prefers-reduced-motion`. Animations may be longer than 300ms, but nothing blocks the content while it plays.
  - The code standards in [frontend.md](frontend.md) apply (styles, views, components, scripts, accessibility).

## Message and calls to action

- The first screen says what the product is and who it's for in one headline and one short line under it, and shows the main call to action.
- Each page has one main call to action (download, sign up, buy, contact) with a specific label, such as "Download for Mac" rather than "Learn more". It appears again further down long pages.
- If the app can be downloaded, the site has a download link for it, usually as the main call to action. The file is served from blob storage (such as DigitalOcean Spaces or Amazon S3), behind a CDN where possible, not from the site's own server.
  - The link points to a stable URL for the latest version (such as `/download/mac`) that redirects to the current file, so a new release never breaks it.
  - Next to the button, show the version, file size and system requirements.
- App store and download links go straight to the right store or file for the visitor's device where that can be detected, with the official store badges. Other platforms stay one click away.
- Show proof where it exists: real customer quotes with names, press mentions, ratings and user counts. Never invent them.
- Focus on the product's value and its top features: what it does for the visitor and why that matters to them. Lead with the value, then show the few features that deliver it, each with a screenshot or video of it in use. Leave minor features, settings and internals for docs or a later page.
- Copy is short and concrete: what the product does for the visitor, not a list of its internals.
- For a closed-source app, the site never exposes intellectual property: say what the app does and what it's good at, never how proprietary features, algorithms, models or data pipelines work. This covers everything public, including copy, FAQ answers, `llms.txt`, structured data, alt text, video narration, image file names and source maps.

## Imagery and video

- When the site markets an app, show the app: real screenshots and short videos of it in use come first. Keep them current with the shipped UI.
- Screenshots can be cropped and zoomed to focus on the part of the app a section is about, such as one feature or panel, instead of always showing the whole window.
- Otherwise, prefer large photos and other free imagery over small decorative graphics. Use only images licensed for commercial use (public domain or free-license sources such as Unsplash and Pexels), note each image's source and license next to it in the repo, and credit it on the site when the license asks for that.
- Videos autoplay only when muted, loop, play inline, and have a poster image. A video with speech has captions.
- Images are optimized: modern formats (AVIF or WebP) with a fallback, responsive `srcset` sizes, and `width` and `height` set so nothing shifts as they load. Images below the first screen are lazy-loaded; the first screen's main image is not.
- The logo is shown as the bare mark or wordmark, preferably without the typical rounded-corner app icon tile behind it. Use the tile only where an app icon is expected, such as next to a store badge.
- Every meaningful image has alt text. Decorative images have an empty `alt`.

## Performance

- Pages are fast on a phone: Largest Contentful Paint under 2.5s, Cumulative Layout Shift under 0.1, Interaction to Next Paint under 200ms.
- Cache rendered pages at a CDN. Ship only the JavaScript a page needs; a page with no interaction needs none.
- Web fonts are subset, self-hosted where the license allows, preloaded for the first screen, and use `font-display: swap`.
- Large videos are compressed and streamed or lazy-loaded, never loaded before the first screen has rendered.

## SEO

- Every page has a unique `<title>` (at most 60 characters) and meta description (at most 160 characters), a canonical URL, and one `<h1>` with headings in order below it.
- Server-side rendering is preferred: every page's content is in the HTML the server sends, so search engines and AI crawlers read it without running scripts. Never render a page's content only in the browser. The `<html>` element sets `lang`, and a site in several languages links them with `hreflang`.
- URLs are short, readable and lowercase with dashes. A page that moves gets a permanent (301) redirect from its old URL.
- Pages use semantic HTML (`header`, `nav`, `main`, `section`, `footer`) and describe the product with structured data in JSON-LD: `Organization` and `WebSite`, plus `SoftwareApplication` or `Product` for what's being sold and `FAQPage` for a FAQ.
- Links between pages are normal `<a href>` links with descriptive text.
- `robots.txt` exists at the root and points to the sitemap. Preview and staging deployments are `noindex`.
- There is a real 404 page that returns a 404 status and links back home. Moved pages return 301, never a 200 or a redirect to the home page.
- Every internal and outbound link resolves: `make test` crawls the built site for broken links.
- After each deploy, check the production canonical host, `robots.txt` and sitemap, not only the local build.

## GEO (generative engine optimization)

Make the site easy for AI assistants and AI search to read, quote and cite correctly.

- Near the top of the home page, state in plain text what the product is, who it's for, what it costs and how it differs. Write these as short, factual sentences that make sense when quoted alone.
- Include a FAQ with direct answers to the questions people ask about the product.
- Keep names, prices and facts the same on every page and in the structured data.
- Anything important is in text, not only in an image or a video. Videos have a transcript on the page.
- Keep an `llms.txt` at the root: a short Markdown summary of the site with links to its key pages.
- Don't block AI crawlers (such as GPTBot, ClaudeBot, PerplexityBot and Google-Extended) in `robots.txt` unless the user asks to.

## Sitemap

- `sitemap.xml` at the root lists every indexable page by its canonical URL, with `lastmod`. It leaves out redirects and `noindex` pages.
- Generate it in the build from the site's pages, so it never drifts from them. Don't keep it by hand.

## Favicon

- An SVG favicon that reads on both light and dark browser tabs, plus a 32×32 `favicon.ico` fallback.
- A 180×180 `apple-touch-icon`, and a web app manifest with 192×192 and 512×512 icons and a `theme-color`.

## Open Graph

- Every page sets `og:title`, `og:description`, `og:image`, `og:url`, `og:type` and `og:site_name`, plus `twitter:card` set to `summary_large_image`.
- `og:image` is an absolute URL to a 1200×630 image under 1MB, designed for the share preview rather than a cropped hero. The home page and each key page get their own.
- Check the preview before calling a page done: the title, description and image all show and nothing is cut off.

## Analytics and privacy

- Measure visits and the main call to action, so it's clear whether the site works. Prefer privacy-friendly analytics that need no cookie banner; ask the user before adding anything that tracks people across sites.
- If the site sets cookies that need consent, it asks before setting them, and declining is as easy as accepting.
- The footer links to a privacy policy, and to terms where the product has them, plus a contact or support link.

## Forms

- Signup and contact forms ask only for what's needed (an email for a waitlist), show a clear success message, and show errors next to the field.
- Forms are protected from spam without a puzzle for people, such as a honeypot field or an invisible challenge.
