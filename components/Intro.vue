<script setup lang="ts">
import gsap from 'gsap'

const img = ref()
const textTop = ref()
const textBottom = ref()

onMounted(() => {
  const tl = gsap.timeline({ defaults: { duration: 1, ease: 'power3.out' } })

  tl
    .delay(0.4)
    .to(
      textTop.value.querySelectorAll('span'),
      { y: '0', stagger: 0.1 }
    )
    .to(
      textBottom.value.querySelectorAll('span'),
      { y: '0', stagger: 0.1 },
      '<0.3'
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
      img.value,
      { clipPath: 'inset(49.5% 0%)' },
      'textMove+=0.2'
    )
    .to(
      img.value,
      { clipPath: 'inset(0% 0%)' },
      '>-0.1'
    )
})
</script>

<template>
  <div class="intro-wrap">
    <div ref="img" class="intro-image">
      <img src="~/assets/images/intro-test.jpg">
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
</template>

<style lang="scss" scoped>
.intro-wrap {
  position: relative;
  height: 100vh;
  background-color: var(--c-primary);
}

.intro-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100vh;
  clip-path: inset(49.5% 50%);

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
}

.intro-text {
  position: absolute;
  font-size: 12vw;
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
    right: 0;
    bottom: 0;
    transform-origin: center right;
    transform: translateX(calc(-100vw + 100%));
  }
}
</style>
