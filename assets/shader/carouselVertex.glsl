float PI = 3.141592653589793;

uniform vec2 u_offset;

out vec2 v_uv;


vec3 deformationCurve(vec3 position, vec2 uv) {
  position.x = position.x - (sin(uv.y * PI) * u_offset.x);

  return position;
}

void main() {
  v_uv = uv;

  vec3 newPosition = deformationCurve(position, uv);
  gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);
}
