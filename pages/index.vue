<script setup lang="ts">
import Lenis from 'lenis'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

onMounted(() => {
  window.addEventListener('resize', () => debounce(ScrollTrigger.refresh()))

  const lenis = new Lenis()

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
    <div style="margin-bottom: 20vw" />
    <Carousel />
    <div style="margin-bottom: 5vw" />
    <footer>
      <p>made by <a href="https://jankohlbach.com" target="_blank">Jan Kohlbach</a> with 🎧 and too much 🕑</p>
    </footer>
  </div>
</template>

<style lang="scss" scoped>
footer {
  display: block;
  width: 100%;
  text-align: center;
  padding: 0 30px 10px;
}
</style>
