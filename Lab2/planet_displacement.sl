// A simple SL displacement shader to render a planet-like sphere
displacement planet_displacement(output varying float elevation = 0.0; output varying float isOcean = 0.0; ) {
  
  // add irregularity to the sphere
  elevation = noise(2*P)-0.5;
  elevation += 0.5*(noise(4*P)-0.5);
  elevation += 0.25*(noise(8*P)-0.5);
  //elevation += 0.125*(noise(16*P)-0.5);
  elevation += 0.0625*(noise(32*P)-0.5);
  elevation += 0.0625*0.5*(noise(64*P)-0.5);
  elevation = max(elevation, 0.0); // Clip negative values to zero
  isOcean = 0.0; 

  // öka elevation så det blir "mer" om berg
  elevation = elevation*elevation*elevation*7;

  // set the output variable isOcean to true, if there is no elevation. 
  if (elevation == 0.0) {
    isOcean = 1.0;
    // add a little bit noise to the ocean
    elevation = 0.0625*0.25*(noise(128*P)-0.5);
    elevation = max(elevation, 0.0); // Clip negative values to zero
  }

  // set the ouput
  P = P + N * 0.2 * elevation;
  N = calculatenormal(P);
}
