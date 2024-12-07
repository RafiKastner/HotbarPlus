import {themes as prismThemes} from 'prism-react-renderer';

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'HotbarPlus',
  tagline: 'Hotbars in a couple lines or less',
  favicon: 'img/logo.webp',

  url: 'https://github.com',
  baseUrl: '/HotbarPlus/',

  organizationName: 'RafiKastner',
  projectName: 'HotbarPlus',
  deploymentBranch: 'gh-pages',
  trailingSlash: false,

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: './sidebars.js',
          path: 'docs',
          routeBasePath: '/'
        },
        theme: {
          customCss: './src/css/custom.css',
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      image: 'img/docusaurus-social-card.jpg',
      navbar: {
        title: 'HotbarPlus',
        logo: {
          alt: 'TopbarPlus logo',
          src: 'img/logo.webp',
        },
        items: [
          {
            type: 'docSidebar',
            sidebarId: 'introSidebar',
            position: 'left',
            label: 'Intro',
          },
          {
            type: 'docSidebar',
            sidebarId: 'docsSidebar',
            position: 'left',
            label: 'Docs',
          },
          {
            href: 'https://create.roblox.com/store/asset/77390116626784/Hotbar',
            label: 'Module',
            position: 'right',
          },
          {
            href: 'https://github.com/RafiKastner/HotbarPlus',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              {
                label: 'Tutorial',
                to: '/intro',
              },
            ],
          },
          {
            title: 'Community',
            items: [
              {
                label: 'Discord',
                href: 'https://discordapp.com',
              },
              {
                label: 'DevForum',
                href: 'https://devforum.roblox.com',
              },
            ],
          },
          {
            title: 'More',
            items: [
              {
                label: 'My GitHub',
                href: 'https://github.com/RafiKastner',
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} Rafi Kastner.`,
      },
      prism: {
        theme: prismThemes.github,
        darkTheme: prismThemes.vsDark,
        additionalLanguages: ['lua'],
      },
      colorMode: {
        defaultMode: 'dark',
      }
    }),
};

export default config;
