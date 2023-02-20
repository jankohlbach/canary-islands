<script setup lang="ts">
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import SplitType from 'split-type'

const wrap = ref()
const paragraph = ref()

onMounted(() => {
  gsap.registerPlugin(ScrollTrigger)

  const splitText = SplitType.create(paragraph.value)

  const tl = gsap.timeline({
    scrollTrigger: {
      trigger: wrap.value,
      start: 'top top',
      end: '+=200%',
      scrub: true,
      pin: true
    },
    defaults: { ease: 'none' }
  })

  gsap.set(splitText.chars, { transformOrigin: 'center top' })

  tl
    .fromTo(
      splitText.chars,
      { autoAlpha: 0.02, scaleY: 1.8 },
      { autoAlpha: 1, scaleY: 1, stagger: 0.1 }
    )
})
</script>

<template>
  <div ref="wrap" class="text-wrap">
    <p ref="paragraph">
      long hours of sunshine with barely any clouds all year round off the coast of morocco
    </p>
  </div>
</template>

<style lang="scss" scoped>
@use '~/assets/styles/functions' as *;

.text-wrap {
  display: flex;
  flex-direction: column;
  justify-content: center;
  max-width: min(rem(1200), 90vw);
  height: 100svh;
  margin-inline: auto;
}

p {
  text-align: center;
  font-size: clamp(rem(30), calc(0.66rem + 6.5vw), rem(110));
  line-height: 1.25;
}
</style>
