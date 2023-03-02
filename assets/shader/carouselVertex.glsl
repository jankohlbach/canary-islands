float PI = 3.141592653589793;

uniform vec2 uOffset;

varying vec2 vUv;


vec3 deformationCurve(vec3 position, vec2 uv) {
  position.x = position.x - (sin(uv.y * PI) * uOffset.x);

  return position;
}

void main() {
  vUv = uv;

  vec3 newPosition = deformationCurve(position, uv);
  gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);
}
