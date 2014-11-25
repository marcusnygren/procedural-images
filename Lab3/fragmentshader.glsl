#version 330 core

uniform float time;
uniform sampler2D tex;

in vec3 interpolatedNormal;
in vec2 st;

out vec4 color;

void main() {
	vec3 groundcolor = texture(tex,st).rgb;
	float alpha = texture(tex, st+vec2(-0.02*time, 0.0)).a;
	vec3 cloudcolor = vec3(1.0, 1.0, 1.0);
	vec3 diffusecolor = mix(groundcolor, cloudcolor, alpha);
	
	vec3 nNormal = normalize(interpolatedNormal);
	float diffuselighting = max(0.0, nNormal.z);

	color = vec4(diffusecolor*diffuselighting, 1.0);
}

