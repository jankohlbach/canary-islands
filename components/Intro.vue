<script setup lang="ts">
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

const wrap = ref()
const imgWrap = ref()
const img = ref()
const textTop = ref()
const textBottom = ref()

const createTimeline2 = () => {
  const tl2 = gsap.timeline({
    scrollTrigger: {
      trigger: wrap.value,
      start: 'top top',
      scrub: true
    }
  })

  tl2
    .to(
      textTop.value,
      { x: '-40%' },
      0
    )
    .to(
      textBottom.value,
      { x: '40%' },
      0
    )
    .to(
      img.value,
      { y: '20%' },
      0
    )
}

onMounted(() => {
  gsap.registerPlugin(ScrollTrigger)

  const tl = gsap.timeline({
    defaults: { duration: 1, ease: 'power3.out' },
    onComplete: () => {
      window.dispatchEvent(new CustomEvent('lenis:start'))
      createTimeline2()
    }
  })

  tl
    .delay(0.4)
    .to(
      textTop.value.querySelectorAll('span'),
      { y: '0', stagger: 0.08, duration: 1.2 }
    )
    .to(
      textBottom.value.querySelectorAll('span'),
      { y: '0', stagger: 0.08, duration: 1.2 },
      '<0.2'
    )
    .addLabel('textMove', '>-0.3')
    .to(
      [textTop.value, textBottom.value],
      { transform: 'translateX(calc(0vw + 0%))' },
      'textMove'
    )
    .to(
      [textTop.value, textBottom.value],
      { scaleX: 1.5 },
      'textMove'
    )
    .to(
      [textTop.value, textBottom.value],
      { scaleX: 1 },
      '<50%'
    )
    .to(
      imgWrap.value,
      { clipPath: 'inset(49.5% 0%)' },
      'textMove+=0.2'
    )
    .to(
      imgWrap.value,
      { clipPath: 'inset(0% 0%)' },
      '>-0.1'
    )
})
</script>

<template>
  <div ref="wrap" class="intro-wrap">
    <div ref="imgWrap" class="intro-image">
      <img ref="img" src="~/assets/images/intro.jpeg">
    </div>
    <span ref="textTop" class="intro-text intro-text--top">
      <span>C</span>
      <span>A</span>
      <span>N</span>
      <span>A</span>
      <span>R</span>
      <span>Y</span>
    </span>
    <span ref="textBottom" class="intro-text intro-text--bottom">
      <span>I</span>
      <span>S</span>
      <span>L</span>
      <span>A</span>
      <span>N</span>
      <span>D</span>
      <span>S</span>
    </span>
  </div>
  <!-- TODO: remove later -->
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
  <h1>placeholder</h1>
</template>

<style lang="scss" scoped>
.intro-wrap {
  position: relative;
  height: 100dvh;
  background-color: var(--c-primary);
}

.intro-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  clip-path: inset(49.5% 50%);

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
}

.intro-text {
  position: absolute;
  font-size: 14vw;
  font-weight: var(--fw-semibold);
  line-height: 1;
  color: var(--c-light);
  overflow: hidden;

  span {
    display: inline-block;
    transform: translateY(100%);
  }

  &--top {
    top: 0;
    left: 0;
    transform-origin: center left;
    transform: translateX(calc(100vw - 100%));
  }

  &--bottom {
    right: clamp(0rem, 1.25vw, 1.5rem);
    bottom: 0;
    transform-origin: center right;
    transform: translateX(calc(-100vw + 100%));
  }
}
</style>
