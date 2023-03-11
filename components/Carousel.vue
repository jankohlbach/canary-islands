<script setup lang="ts">
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import * as THREE from 'three'
// import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'
// import { Pane } from 'tweakpane'

import vsSource from '~/assets/shader/carouselVertex.glsl'
import fsSource from '~/assets/shader/carouselFragment.glsl'

import img1 from '~/assets/images/slider-1.jpeg'
import img2 from '~/assets/images/slider-2.jpeg'
import img3 from '~/assets/images/slider-3.jpeg'
import img4 from '~/assets/images/slider-4.jpeg'
import img5 from '~/assets/images/slider-5.jpeg'
import img6 from '~/assets/images/slider-6.jpeg'
import img7 from '~/assets/images/slider-7.jpeg'
import img8 from '~/assets/images/slider-8.jpeg'
import img9 from '~/assets/images/slider-9.jpeg'

const images = [img1, img2, img3, img4, img5, img6, img7, img8, img9]

const watermarkWrap = ref()
const watermarkText = ref()
const wrap = ref()
const canvas = ref()

const resizeCanvas = (camera: THREE.PerspectiveCamera, renderer: THREE.WebGLRenderer) => {
  camera.aspect = window.innerWidth / window.innerHeight
  camera.updateProjectionMatrix()

  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
}

onMounted(() => {
  gsap.registerPlugin(ScrollTrigger)

  const tlWatermark = gsap.timeline({
    scrollTrigger: {
      trigger: watermarkWrap.value,
      start: 'top top',
      end: '+=600%',
      scrub: true,
      pin: true,
      pinSpacing: false
    },
    defaults: { ease: 'none' }
  })

  tlWatermark
    .fromTo(
      watermarkText.value,
      { x: '20%' },
      { x: '-60%' }
    )

  const st = ScrollTrigger.create({
    trigger: wrap.value,
    start: 'top top',
    end: '+=500%',
    pin: true
  })

  // const pane = new Pane()

  const scene = new THREE.Scene()

  const camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 0.1, 100)
  camera.position.z = 2
  camera.position.y = 0.3
  camera.rotation.z = 2 * Math.PI * 0.01
  // pane.addInput(camera.position, 'z', { min: 1, max: 10 })

  // const cameraHelper = new THREE.CameraHelper(camera)
  // scene.add(cameraHelper)

  const textureLoader = new THREE.TextureLoader()
  images.unshift(images[images.length - 2], images[images.length - 1])
  images.splice(images.length - 2, 2)
  const textures = images.map(image => textureLoader.load(image))

  const geometry = new THREE.PlaneGeometry(1, 0.75, 10, 10)

  const uOffset = new THREE.Vector2(0, 0)
  const items: { mesh: THREE.Mesh; index: number; }[] = []
  for (let i = 0; i < textures.length; i++) {
    const mesh = new THREE.Mesh(
      geometry,
      new THREE.ShaderMaterial({
        uniforms: {
          u_offset: { value: uOffset },
          u_texture: { value: textures[i] },
          u_alpha: { value: 1.0 }
        },
        vertexShader: vsSource,
        fragmentShader: fsSource,
        glslVersion: THREE.GLSL3
      })
    )
    items.push({ mesh, index: i })
    scene.add(mesh)
  }

  const renderer = new THREE.WebGLRenderer({ canvas: canvas.value, alpha: true, antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

  // const controls = new OrbitControls(camera, canvas.value)
  // controls.enableDamping = true
  // controls.enableZoom = false

  const updateMeshes = () => {
    const width = 1.1
    const wholeWidth = items.length * width

    items.forEach((item) => {
      item.mesh.position.x = ((width * item.index) - (st.progress * 10) + (42069 * wholeWidth)) % wholeWidth - 2 * width
      item.mesh.rotation.y = 2 * Math.PI * 0.03
    })
  }

  const render = () => {
    if (st.isActive) {
      uOffset.set(st.getVelocity() * 0.00002, 0)
    } else {
      uOffset.set(0, 0)
    }

    updateMeshes()

    renderer.render(scene, camera)

    // controls.update()

    requestAnimationFrame(render)
  }

  requestAnimationFrame(render)

  window.addEventListener('resize', () => debounce(resizeCanvas(camera, renderer)))
})
</script>

<template>
  <div ref="watermarkWrap" class="watermark-wrap">
    <span ref="watermarkText">Culture</span>
  </div>
  <div ref="wrap" class="carousel-wrap">
    <canvas ref="canvas" />
  </div>
</template>

<style lang="scss" scoped>
.watermark-wrap {
  overflow: hidden;
}

span {
  display: inline-block;
  font-size: 35vw;
  font-weight: var(--fw-black);
  line-height: 1;
  text-transform: uppercase;
  opacity: 0.05;
  pointer-events: none;
}

canvas {
  width: 100%;
  height: 100%;
}
</style>
