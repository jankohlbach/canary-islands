#version 300 es

precision mediump float;

uniform float u_midpoint;

out vec4 out_color;


void main() {
  out_color = vec4(45.0 / 255.0, 102.0 / 255.0, 164.0 / 255.0, 1.0);
}
