// A simple SL surface shader to render a planet-like sphere
// Lab2, Marcus Nygren and Linnéa Mellblom,  marny568, linme882 2014
surface planet_surface() {

  float isOcean = 0.0; // if we have ocean or not (0 or 1)
  float elevation = 0.0; // elevation over the sea

  // define different colors
  color mountainColor = color(140/255.0, 140/255.0, 130/255.0);
  color oceanColor = color(48/255.0, 52/255.0, 107/255.0);  
  color greenColor = color(28/255.0, 92/255.0, 17/255.0);  
  color ERRORCOLOR = color(1.0, 0.0, 0.0); // used if error found

  color terrainColor = color(0.0, 0.0,0.0); // the output color

  // get the variable elevation from displacement shader
  if(displacement("elevation", elevation) == 1) {
  }
  else {
    terrainColor = ERRORCOLOR;
  }

  // deside if there is ocean
  if(displacement("isOcean", isOcean) == 1) {
    if (isOcean == 1.0) {
      terrainColor = oceanColor;
      terrainColor = terrainColor *specular(N, normalize(-I), 0.7); // add specular to the sea
    }
    else { // if there is land instead
      point offsetPoint = P + (noise(2.0*P)-0.5); // move so the land is not so regular
      float noiseStructure = 0;
      noiseStructure = noise(60.0*P);
      noiseStructure = mix(noiseStructure,float noise(40*P*offsetPoint+10),0.6);
      
      // make the land more irregular
      terrainColor = greenColor;
      terrainColor = mix(terrainColor, color(2)*noiseStructure, 0.2);

      // add border from the land to the sea
      color sandColor = color(0.67, 0.5, 0.3);
      if (elevation<0.0001) 
        terrainColor = mix(terrainColor, sandColor, 0.7);
    }
  }
  else {
    terrainColor = ERRORCOLOR; // Value not found, signal error
  }

  // check if the terrain is high enough to be a mountain, add color
  if(elevation > 0.05) {
    terrainColor = mix(terrainColor,mountainColor,0.9);

    if (elevation > 0.2) {// deside if the mountain is high enoungh to have snow
     terrainColor = mix(terrainColor, color(1.0,1.0,1.0), 0.8);
    } 
  }

  Ci = terrainColor * diffuse(N);
}
