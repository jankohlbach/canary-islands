<script setup lang="ts">
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import * as THREE from 'three'
// import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'
// import { Pane } from 'tweakpane'

import vsSource from '~/assets/shader/carouselVertex.glsl'
import fsSource from '~/assets/shader/carouselFragment.glsl'

import img1 from '~/assets/images/tenerife.jpeg'
import img2 from '~/assets/images/grancanaria.jpeg'
import img3 from '~/assets/images/fuerteventura.jpeg'
import img4 from '~/assets/images/lanzarote.jpeg'

const images = [img1, img2, img3, img4]

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
  // pane.addInput(camera.position, 'z', { min: 1, max: 10 })

  // const cameraHelper = new THREE.CameraHelper(camera)
  // scene.add(cameraHelper)

  const textureLoader = new THREE.TextureLoader()
  images.unshift(images[images.length - 2], images[images.length - 1])
  images.splice(images.length - 2, 2)
  const textures = images.map(image => textureLoader.load(image))

  const geometry = new THREE.PlaneGeometry(1, 0.75, 10, 10)

  const uOffset = new THREE.Vector2(0, 0)
  const meshes: { mesh: THREE.Mesh; index: number; }[] = []
  for (let i = 0; i < textures.length; i++) {
    const mesh = new THREE.Mesh(
      geometry,
      new THREE.ShaderMaterial({
        uniforms: {
          uOffset: { value: uOffset },
          uTexture: { value: textures[i] },
          uAlpha: { value: 1.0 }
        },
        vertexShader: vsSource,
        fragmentShader: fsSource
      })
    )
    meshes.push({ mesh, index: i })
    scene.add(mesh)
  }

  const renderer = new THREE.WebGLRenderer({ canvas: canvas.value, alpha: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

  // const controls = new OrbitControls(camera, canvas.value)
  // controls.enableDamping = true
  // controls.enableZoom = false

  const updateMeshes = () => {
    const width = 1.1
    const wholeWidth = meshes.length * width

    meshes.forEach((mesh) => {
      mesh.mesh.position.x = ((width * mesh.index) - (st.progress * 10) + (42069 * wholeWidth)) % wholeWidth - 2 * width
    })
  }

  const render = () => {
    uOffset.set(st.getVelocity() * 0.00005, 0)

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
  <div ref="wrap" class="carousel-wrap">
    <canvas ref="canvas" />
  </div>
</template>

<style lang="scss" scoped>
canvas {
  width: 100%;
  height: 100%;
}
</style>
