// A simple SL surface shader to render a planet-like sphere
surface planet_surface() {

  float isOcean = 0.0; // if we have ocean or not (0 or 1)
  float greenBlend = 0.0; // terrain
  float isMountain = 0.0; // mountain 
  float elevation = 0.0; // elevation over the sea

  color mountainColor = color(140/255.0, 140/255.0, 130/255.0);
  color oceanColor = color(48/255.0, 52/255.0, 107/255.0);  
  color greenColor = color(90/255.0, 124/255.0, 49/255.0);  
  color ERRORCOLOR = color(1.0, 0.0, 0.0); // used if error found

  color terrainColor = 0.0; // decide which color to use
  // deside if there is ocean
  if(displacement("isOcean", isOcean) == 1) {
    if (isOcean == 1.0) {
      terrainColor = oceanColor;
      terrainColor += 0.25*(noise(16*u,8*v)-0.5);
      terrainColor += 0.0625*0.5*(noise(64*P)-0.5);
    }
    else {
      terrainColor = greenColor;
      terrainColor += 0.7*(noise(8*u,8*v)-0.5);
    }
  }
  else {
    terrainColor = ERRORCOLOR; // Value not found, signal error
  }

  // get the variable elevation from displacement shader
  if(displacement("elevation", elevation) == 1) {
  }
  else {
    terrainColor = ERRORCOLOR;
  }

  // check if the terrain is high enough to be a mountain, add color
  if(elevation > 0.05) {
    terrainColor = mountainColor;

    if (elevation > 0.2) {// deside if the mountain is high enoungh to snow
     terrainColor = mix(terrainColor, color(1.0,1.0,1.0), 0.8);
    } 
  }

  Ci = terrainColor * diffuse(N);
}
