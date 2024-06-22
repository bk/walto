# Walto

Walto is a modern and lightweight [wmk](https://github.com/bk/wmk) theme for documentation sites. It is based upon the [Alto Hugo theme](https://github.com/CloudCannon/alto-hugo-template) by Liam Bigelow on behalf of CloudCannon. For an example of it in use, see [the wmk documentation site](https://wmk.baldr.net/). Main features:

- Pre-configured static site search with [Pagefind](https://pagefind.app).
- Light/dark modes and an easily adjustable color palette for both.
- Header and footer content configurable from `wmk_config.yaml`.
- Content-driven main navigation, optimized for a site [with `nav: auto`](https://wmk.baldr.net/pagevars/#automatically-generated).
- Optional announcement banner with a configurable expiration time.
- Creates a sitemap to facilitate search engine indexing (can be disabled).

## Dependencies

- The theme is designed for wmk v1.10 or newer. Older versions may not work.

- For the Pagefind functionality to work, you must have `npm` installed and
  have `npx` in your `PATH`.

- For syntax highlighting in code blocks you need either Pygments or pandoc to
  be installed.

## Configuration

Most of the settings affecting Walto are in the `site` part of `wmk_config`. They fall into 6 kinds: (1) General information about the page or website; (2) links and images for the header and footer; (3) attributes to add javascript or css additions to the header or body without having to touch templates; (4) navigation and search settings; (5) banner; and (6) colors.

### General information

This is metadata that mainly affects the `<head>` part of the HTML for the page, although some of it has more visible effects.

- `site.project_name` is just the name of the website. It appears as the site name in the metadata, is appended to the page title and is used as the alt text for the site logo.

- `site.base_url` and `site.leading_path`: If your website is served from an independent domain or subdomain, then the latter of these should be the empty string (the default). `site.base_url` should be set to the absolute URL to the root page of the website (including the leading path, if any), but without the trailing `/` or `/index.html`. Examples: `https://example.com`, `https://abc.def.io/docs`. The `base_url` must be set for much of the metadata to be of any use when sharing your page on social media and for the `sitemap.xml` file to be produced but has little effect otherwise.

- `site.default_og_image`: This is used as a fallback image for social media (the `og:image` property) if the page does not set a `page.main_img`.

- `site.favicon`: An object representing the different versions of the favicon for the site. It has the keys `default`. `large`, `small`, `apple_touch` , `msapp_tile_color` and `theme_color`. All are optional, but some defaults are set by Walto.

- `site.locale` can be overriden on a page-by-page basis with `page.locale`. It should consist of a five character string of the form `xx_YY`, where `xx` stands for the language code (lowercase) and `YY` for the country or territory (preferably uppercase). The `locale` setting affects the `og:locale` OpenGraph metadata attribute and may also affect the `lang` setting for the document (see below).

- `site.lang` can be overridden on a page-by-page basis with `page.lang`. It indicates the `lang` attribute of the HTML document, which [affects Pagefind search](https://pagefind.app/docs/multilingual/). If neither `page.lang` nor `site.lang` is specified but either `page.locale` or `site.locale` is, then the `lang` value is set to the first two letters of the `locale` value, or falls back to `en` if neither `locale` nor `lang` is known.

- `page.og_type` can be used to explicitly set the `og:type` OpenGraph metadata attribute, which defaults to `article` (except on the front page where it is set to `website`).

- `page.description`, if present, should contain a short description of the content of the page. It is used as the value of the `og:description` OpenGraph property. In the absence of `page.description`, `page.summary` is used instead. Note that `page.summary` [can be autogenerated](https://wmk.baldr.net/pagevars/#classic-meta-tags) from the content of the page by setting `page.generate_summary` to True.

- `page.title` appears in the `<title>` tag, as the value of the `og:title` OpenGraph property, and is also used as the headline of the page. (If the page is produced by a standalone template rather than normal content, the [inheritable attribute](https://docs.makotemplates.org/en/latest/inheritance.html#inheritable-attributes) `title` is used instead; similarly for `lang`, `locale`, `description`, `og_type`, and `main_img`).

- `site.disable_sitemap`: If this is true, then the `sitemap.xml` file will not be produced, even if `site.base_url` is set to an appropriate value.

### Header and footer

- `site.logo` is an object describing the logo and/or title at the left of the header, with a link to the front page of the site. Its three keys are `heading` (the abbreviated project name), `image` (the optional logo image for the site), and `image_dark` (an alternate version of the logo image to use in dark mode). If `image` points to an SVG image with `fill` set to `currentColor`, then `image_dark` can generally be omitted. If `site.logo` is not specified, then `site.project_name` is used as a fallback for `site.logo.heading`.

- `site.topnav_links` is an optional list of links to display in the right part of the header, immediately to the right of the mode switching icon and (in mobile) the main menu "hamburger" symbol. Each link is an object with the keys `url`, `label` and (optionally) `icon` and `alt`. The icon should be an SVG image whose height and width are equal; it will get a display size of 32x32 pixels. There is not much room here, so labels should be kept short and links few.

- `site.header_css_class` can be used to affect how the header is displayed on narrow screens, i.e. mobile phones. The value `wrap` causes the right (the logo) and left (the links, mode toggle and menu) parts of the header to be broken into two lines on mobile. The value `hidden-links` causes the `topnav_links` to be invisible in mobile. These may of course be combined if desired, i.e. `wrap hidden-links`.

- `site.footer` is an object with any of the keys `disable`, `css_class`, `html` or `links`. The first of these, if set to True, obviously removes the footer entirely, while the second specifies its css class. The default value of `css_class` is `contain`, meaning that the header is to be kept to the same width as the main body of the page. The value of `site.footer.html` is arbitrary HTML to insert at the start of the footer. As for `site.footer.links`, that should be a list of items whose keys are `url`, `title` (both required), `image` and `alt` (both optional).

### HTML snippets

- `site.head_extra` can be overridden by `page.head_extra` and, if present, should contain HTML to insert at the end of the `<head>` section. Typically this is additional Javascript or CSS.

- `site.end_of_body`, if present, should contain HTML to insert just before the closing `</body>` tag. Typically this is a `<script>` tag.

### Navigation and search

- `site.pagefind`: If this is True (the default), then Pagefind search is active on the page. If you disable this, you should also override the default `cleanup_commands` so as to remove the indexing step.

- `site.main_nav`: Contains settings for the main navigation unit (in the hamburger menu on mobile and on the left in desktop and tablet). The keys are `title` (default: "Docs") and `sections_collapsible` (default: false). The title is the heading for the menu (only visible in desktop), while `sections_collapsible` indicates that the items under each section heading are initially hidden. In this case, the items belonging to a particular section only become visible when one of the pages under it is active or the section is toggled open by the user. This is especially useful for sites that have many pages and/or sections in the main navigation menu.

### Banner

The `site.banner` setting defines an optional banner shown at the very top of the page with an announcement or welcome message. When dismissed, it will not reappear in that particular browser. The banner has the following keys:

- `enable`: If this is set to false, the banner will never be shown. Default: `true`.
- `html`: The message itself.
- `id`: The HTML `id` of the message. If you change this, the banner will reappear even if the user has dismissed it previously. Default: `walto-banner`.
- `show_until`: A datetime in ISO-8601 format indicating when the message expires. It will not be visible after that date.
- `close_label`: Text associated with the close button (for screen readers). Default: "Close".

### Colors

The setting `site.colors` can be used to almost completely redefine the color scheme of the page. Here are the contents of the default `data/wmk_config.d/site/colors.yaml` file of the theme:

```yaml
light:
  typography:
    text: '#000000'
    flip-text: '#ffffff'
    text-main: '#363636'
    text-bright: '#000000'
    text-muted: '#70777f'
    links: '#0076d1'
    highlight: '#de935f'
    selection: '#9e9e9e'
    form-placeholder: '#949494'
    form-text: '#1d1d1d'
  background_colors:
    background-body: '#fff'
    background-input: '#efefef'
    background-alt: '#f7f7f7'
  code_block_colors:
    # measured-light
    base00: "#fdf9f5"
    base01: "#f9f5f1"
    base02: "#ffeada"
    base03: "#5a5a5a"
    base04: "#404040"
    base05: "#292929"
    base06: "#181818"
    base07: "#000000"
    base08: "#ac1f35"
    base09: "#ad5601"
    base0a: "#645a00"
    base0b: "#0c680c"
    base0c: "#01716f"
    base0d: "#0158ad"
    base0e: "#6645c2"
    base0f: "#a81a66"
  button_colors:
    button-base: '#d0cfcf'
    button-hover: '#9b9b9b'
  scrollbar_colors:
    scrollbar-thumb: '#aaaaaa'
    scrollbar-thumb-hover: '#9b9b9b'
  border_colors:
    border: '#dbdbdb'
  focus_colors:
    focus: '#0096bfab'
  pagefind_colors:
    pagefind-ui-primary: '#000000'
    pagefind-ui-secondary: '#000000'
    pagefind-ui-background: '#efefef'
    pagefind-ui-border: '#dbdbdb'
    pagefind-ui-tag: '#efefef'
dark:
  typography:
    text: '#e6edf3'
    flip-text: '#e6edf3'
    text-main: '#e6edf3'
    text-bright: '#ffffff'
    text-muted: '#c8c8c8'
    links: '#58a4e0'
    highlight: '#de935f'
    selection: '#616161'
    form-placeholder: '#e0e0e0'
    form-text: '#f0f0f0'
  background_colors:
    background-body: '#121516'
    background-input: '#1d1f21'
    background-alt: '#080808'
  code_block_colors:
    # railscasts
    base00: "#2b2b2b"
    base01: "#272935"
    base02: "#3a4055"
    base03: "#5a647e"
    base04: "#d4cfc9"
    base05: "#e6e1dc"
    base06: "#f4f1ed"
    base07: "#f9f7f3"
    base08: "#da4939"
    base09: "#cc7833"
    base0a: "#ffc66d"
    base0b: "#a5c261"
    base0c: "#519f50"
    base0d: "#6d9cbe"
    base0e: "#b6b3eb"
    base0f: "#bc9458"
  button_colors:
    button-base: '#2b2b2b'
    button-hover: '#606060'
  scrollbar_colors:
    scrollbar-thumb: '#555555'
  border_colors:
    border: '#dbdbdb'
  focus_colors:
    focus: '#0096bfab'
  pagefind_colors:
    pagefind-ui-primary: '#D8D8D8'
    pagefind-ui-secondary: '#D8D8D8'
    pagefind-ui-background: '#1d1f21'
    pagefind-ui-border: '#2b2b2b'
    pagefind-ui-tag: '#1d1f21'
```

As can be seen from the above, there are separate settings for light and dark mode, each of which is divided into logical sections.  Most of them are self-explanatory. You only need to set the values for the colors that you actually modify (except for the `pagefind-ui` colors, since they apply to a separate stylesheet).

The code highlighting palette follows the [base16](https://github.com/chriskempson/base16) convention. A gallery with many such color palettes is available [here](https://tinted-theming.github.io/base16-gallery/).

### Other settings

The following defaults set by Walto apply at the top level of the configuration file and are not part of the `site` section.

- `pandoc` is not set by Waldo but is supported by the theme. If `pandoc` is set to true, Pandoc will be used to convert your markup to HTML. This is needed if you have non-markdown content or want to use some of Pandoc's special features. You may also prefer Pandoc's code highlighting output to that of Pygments – or possibly may want to avoid installing the latter.

- `toc`: This is is set to true by Walto, so as to ensure that subheadings get an `id` attribute in the HTML. This, in turn, activates the anchor link feature (the muted hashtag to the left of headings). Otherwise it does not affect rendering in this theme. If you have activated Pandoc, the `toc` setting is not needed for the anchor feature to work, and may be turned off for slightly improved performance.

- `markdown_extensions` is set to `['extra', 'sane_lists', 'toc', 'pymdownx.superfences', 'pymdownx.highlight']` by Waldo, and in the settings for `pymdownx.highlight` Pygments is turned on.

- `cleanup_commands` is set to `['npx -y pagefind --site htdocs']`, which builds the Pagefind index. If you have set `site.pagefind` to False you should turn this off as well (or replace it with your own commands).


## Content authoring

The only major consideration when authoring content for use by Waldo is to make sure that the main navigation menu is populated properly. Walto sets `nav` to `auto` by default, so the easiest and most natural way to do this is to add `nav_section` and `nav_order` (or `weight`) to the front matter in your content files. For details, see [the wmk documentation](https://wmk.baldr.net/pagevars/#automatically-generated).

The navigation menu can of course also be [defined manually](https://wmk.baldr.net/pagevars/#manually-configured). In this case, be aware that Walto does not support multiple levels of nesting out of the box. It is designed for a simple list of links or sections, with each section only containing links and no subsections of their own.
