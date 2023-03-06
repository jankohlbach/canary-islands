uniform vec2 uOffset;
uniform sampler2D uTexture;
uniform float uAlpha;

varying vec2 vUv;


vec3 rgbShift(sampler2D textureImage, vec2 uv, vec2 offset) {
  vec2 rg = texture2D(textureImage, uv).rg;
  float b = texture2D(textureImage, uv + offset).b;

  return vec3(rg, b);
}

void main() {
  vec3 color = rgbShift(uTexture, vUv, uOffset);
  gl_FragColor = vec4(color, uAlpha);
}
