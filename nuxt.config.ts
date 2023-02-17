// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  ssr: process.env.NUXT_ENV_VERCEL_ENV === 'production',
  app: {
    head: {
      htmlAttrs: {
        lang: 'en'
      },
      title: 'canary islands',
      link: [
        // { rel: 'icon', href: '/favicon.ico', sizes: 'any' },
        { rel: 'icon', href: '/favicon.svg', type: 'image/svg+xml' }
        // { rel: 'apple-touch-icon', href: '/apple-touch-icon.png' },
        // { rel: 'manifest', href: '/manifest.webmanifest' }
      ],
      meta: [
        { name: 'robots', content: 'noindex,nofollow' },
        { name: 'theme-color', content: '#2D66A4' },
        { name: 'description', content: 'a little story about the sunny islands' },
        { name: 'og:title', content: 'canary islands' },
        { name: 'og:description', content: 'a little story about the sunny islands' },
        // { name: 'og:image', content: '/og-image.jpg' },
        { name: 'og:type', content: 'website' },
        { name: 'og:locale', content: 'en' }
      ]
    }
  },
  typescript: {
    typeCheck: true
  },
  css: [
    '@/assets/styles/global.scss'
  ]
})
