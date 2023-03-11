uniform vec2 u_offset;
uniform sampler2D u_texture;
uniform float u_alpha;

in vec2 v_uv;

out vec4 out_color;


vec3 rgbShift(sampler2D textureImage, vec2 uv, vec2 offset) {
  vec2 rg = texture(textureImage, uv).rg;
  float b = texture(textureImage, uv + offset).b;

  return vec3(rg, b);
}

void main() {
  vec3 color = rgbShift(u_texture, v_uv, u_offset);
  out_color = vec4(color, u_alpha);
}
