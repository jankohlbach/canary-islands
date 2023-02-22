<script setup lang="ts">
// @ts-expect-error
import vsSource from '~/assets/shader/vertex.glsl'
// @ts-expect-error
import fsSource from '~/assets/shader/fragment.glsl'

const canvas = ref()
const cursorCurrent = [0, 0]
const cursorTarget = [0, 0]

const resizeCanvas = (gl: WebGL2RenderingContext) => {
  canvas.value.width = window.innerWidth * Math.min(window.devicePixelRatio, 2)
  canvas.value.height = window.innerHeight * Math.min(window.devicePixelRatio, 2)
  canvas.value.style.width = `${window.innerWidth}px`
  canvas.value.style.height = `${window.innerHeight}px`

  gl.viewport(0, 0, gl.canvas.width, gl.canvas.height)
}

onMounted(() => {
  const gl: WebGL2RenderingContext = canvas.value.getContext('webgl2')

  resizeCanvas(gl)

  const shaderProgram = createShaderProgram(gl, vsSource, fsSource)

  const midpointUniformLocation = gl.getUniformLocation(shaderProgram, 'u_midpoint')

  const positionAttributeLocation = gl.getAttribLocation(shaderProgram, 'a_position')
  const vertexBuffer = gl.createBuffer()
  gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer)

  const radius = 50
  const segmentsCount = 40
  const angleStep = (2 * Math.PI) / segmentsCount

  const draw = () => {
    gl.clearColor(0, 0, 0, 0)
    gl.clear(gl.COLOR_BUFFER_BIT)

    cursorTarget[0] = lerp(cursorCurrent[0], cursorTarget[0], 0.95)
    cursorTarget[1] = lerp(cursorCurrent[1], cursorTarget[1], 0.95)

    gl.uniform1f(midpointUniformLocation, cursorTarget[0])

    const vertices = [cursorTarget[0] + 0.05, cursorTarget[1] - 0.05]

    for (let i = 0; i <= segmentsCount; i++) {
      const angle = i * angleStep
      const x = (Math.cos(angle) / radius) + cursorTarget[0] + 0.05
      const y = (Math.sin(angle) / radius * (window.innerWidth / window.innerHeight)) + cursorTarget[1] - 0.05
      vertices.push(x, y)
    }

    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW)
    gl.enableVertexAttribArray(positionAttributeLocation)
    gl.vertexAttribPointer(positionAttributeLocation, 2, gl.FLOAT, false, 0, 0)
    gl.drawArrays(gl.TRIANGLE_FAN, 0, segmentsCount + 2)

    requestAnimationFrame(draw)
  }

  requestAnimationFrame(draw)

  window.addEventListener('mousemove', (event) => {
    const mouseX = event.clientX
    const mouseY = event.clientY
    cursorCurrent[0] = (mouseX / window.innerWidth) * 2 - 1
    cursorCurrent[1] = (mouseY / window.innerHeight) * -2 + 1
  })

  window.addEventListener('resize', () => debounce(resizeCanvas(gl)))
})
</script>

<template>
  <canvas ref="canvas" />
</template>

<style lang="scss" scoped>
@use '~/assets/styles/mixins' as *;

canvas {
  position: fixed;
  inset: 0;
  z-index: 100;
  display: none;
  width: 100%;
  height: 100%;
  pointer-events: none;

  @include has-hover {
    display: block;
  }
}
</style>
