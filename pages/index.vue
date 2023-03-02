<script setup lang="ts">
import Lenis from '@studio-freight/lenis'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

onMounted(() => {
  window.addEventListener('resize', () => debounce(ScrollTrigger.refresh()))

  const lenis = new Lenis({
    duration: 1.2,
    easing: t => Math.min(1, 1.001 - Math.pow(2, -10 * t)), // https://www.desmos.com/calculator/brs54l4xou
    direction: 'vertical', // vertical, horizontal
    gestureDirection: 'vertical', // vertical, horizontal, both
    smooth: true,
    mouseMultiplier: 1,
    smoothTouch: false,
    touchMultiplier: 2,
    infinite: false
  })

  function raf (time: any) {
    lenis.raf(time)
    requestAnimationFrame(raf)
  }

  requestAnimationFrame(raf)

  lenis.stop()

  window.addEventListener('lenis:start', () => {
    lenis.start()
    document.body.style.overflowY = 'scroll'
  })
})
</script>

<template>
  <div>
    <Cursor />
    <Intro />
    <div style="margin-bottom: 30vw" />
    <Map />
    <div style="margin-bottom: 30vw" />
    <TextFadeIn />
    <div style="margin-bottom: 30vw" />
    <Carousel />
  </div>
</template>
