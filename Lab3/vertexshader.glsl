#version 330 core

layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec2 TexCoord;

uniform mat4 MV;
uniform mat4 P;
uniform float time;

out vec3 interpolatedNormal;
out vec2 st;

void main(){
  vec3 pos = Position + 0.01*Normal*sin(10.0*time+10.0*Position.y);
  gl_Position = (P * MV) * vec4(pos, 1.0);
  interpolatedNormal = mat3(MV) * Normal;
  st = TexCoord;
}

