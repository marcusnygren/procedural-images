// A simple SL surface shader to render a clouds
// Lab2, Marcus Nygren and Linnéa Mellblom,  marny568, linme882 2014

surface cloud_surface() {
  // the code about the clouds in inspired by Johan Henriksson (johhe332@student.liu.se)
  // lab 2 during 2011 course. Tellus 2.0

  // coefficients for the light
  float Ka = 1, Kd =1, Ks = 0.5;
  float roughness = 0.1;
  color specularcolor = 1;

  color cloudColor = color(1.0, 1.0, 1.0); 

  // structure of the clouds
  point offsetPoint= P + 1.5*noise(2.0*P); // move so the cloud is not so regular
  float noiseStructure = 0;
  noiseStructure = noise(600.0*P + 2.5);
  noiseStructure = mix(noiseStructure,float noise(400*P*offsetPoint+2),0.4);
  noiseStructure = mix(noiseStructure,float noise(60*P*offsetPoint),0.3);
  noiseStructure = mix(noiseStructure,float noise(10*P*offsetPoint+3),0.2);
  noiseStructure = mix(noiseStructure,float noise(2.5+P*offsetPoint),0.4);

  // opacity of the clouds
  float cloudOpaq = mix(noise(noise(offsetPoint)), noiseStructure ,0.5);

  // smooth the clouds
  float opac = smoothstep(0.572,0.58, cloudOpaq);
  color clouds = mix(Cs, color(2)*noiseStructure, opac);
  opac = min(max(opac,0.02),0.9);

  // calculate the final color
  normal Nf = normalize(N);
  Ci = clouds * (Ka*ambient() + Kd*diffuse(Nf)) + specularcolor * Ks*specular(Nf,-normalize(I),roughness);
  Oi = opac;  Ci *= opac; // set output, opacity and color
}
