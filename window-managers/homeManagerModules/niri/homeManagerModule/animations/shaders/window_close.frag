// Example https://www.shadertoy.com/view/XfscDX
// Modified to match Niri's uniforms and GLES version

// Niri only supports OpenGL ES 2 which doesn't have support for some of the types we need
// This extension enables them.
#extension GL_EXT_gpu_shader4 : enable
// How much detail in the burning edges.
// Performs exponential (2^LoD) function calls.
#define LEVEL_OF_DETAIL 10.0
// Threshold for how much of the edges should be burning
#define BURN_AMOUNT 0.004

precision highp int;
precision highp float;

// Converts color to grayscale
vec3 grayscale(vec3 color) {
    float avg = (color.r + color.g + color.b) / 3.0;
    return vec3(avg);
}

// Maps a range to another range in a linear fashion
// Used to remap the burning edges from [0.0, 1.0]
float map(float value, float in_min, float in_max, float out_min, float out_max) {
  return out_min + (out_max - out_min) * (value - in_min) / (in_max - in_min);
}

// Maps a HSV encoded color to a RGB encoded c(olor)
vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

// Hash Functions for GPU Rendering, Jarzynski et al.
// http://www.jcgt.org/published/0009/03/02/
vec3 random_pcg3d(uvec3 v) {
  v = v * 1664525u + 1013904223u;

  v.x += v.y * v.z;
  v.y += v.z * v.x;
  v.z += v.x * v.y;

  v ^= v >> 16u;

  v.x += v.y * v.z;
  v.y += v.z * v.x;
  v.z += v.x * v.y;

  return vec3(v) / float(0xffffffffu);
}

// Generates value only noise texture ([0,1] black and white) at each
// pos(ition) by generating points limited number of points based on
// on grid_size and interpolating between them. The higher the grid_size
// the most detail (e.g. if grid_size == resolution, each pixel is random)
vec3 value_noise(vec2 pos, float grid_size, uint seed) {
  // Generate the new position based off the grid_size
  // Split into integer and fractional parts (i,f)
  vec2  grid_pos = pos * grid_size;
  vec2  f = fract(grid_pos);
  uvec2 i = uvec2(grid_pos);

  // Generated the values at corners of the grid
  vec3 c1 = random_pcg3d(uvec3(i.x, i.y, seed));
  vec3 c2 = random_pcg3d(uvec3(i.x + 1u, i.y, seed));
  vec3 c3 = random_pcg3d(uvec3(i.x, i.y + 1u, seed));
  vec3 c4 = random_pcg3d(uvec3(i.x + 1u, i.y + 1u, seed));

  // Slightly nicer than pure linear interpolation
  f = smoothstep(0.0, 1.0, f);

  // 2D Interpolation
  vec3 q1 = mix(c1, c2, vec3(f.x));
  vec3 q2 = mix(c3, c4, vec3(f.x));
  vec3 p  = mix(q1, q2, vec3(f.y));

  return p;
}

// Call the noise funcation repeatedly, with finer grid_sizes
// summing the higher frequency results exponentially less to
// produce more detail and the final color of the texture at that pos(ition).
vec3 fractal_value_noise(vec2 pos, float level_of_detail, uint seed) {
  vec3 color = vec3(0.0);

  for (float i = 1.0; i <= level_of_detail; ++i) {
      float frequency = pow(2.0, i);
      float amplitude = (1.0 / frequency);

      color += amplitude * value_noise(pos, frequency, seed);
  }
  return color;
}

vec4 burn_mask(vec2 st) {
    // Convert seed to an unsigned integer
    uint seed = uint(niri_random_seed * 99999.0);

    // Calculate the color at that position, take average to turn the image grayscale
    vec3 color = fractal_value_noise(st, LEVEL_OF_DETAIL, seed);
    color = grayscale(color);

    float completion = niri_clamped_progress;
    // Check if we're in an intermediate value, if so, apply burn effect
    // if not, clamp to black or white.
    float low_threshold   = max(0.0, completion - BURN_AMOUNT);
    float high_threshold = min(1.0, completion + BURN_AMOUNT);
    if (color.r > low_threshold && color.r < high_threshold) {
        // Remap burning area from "red" for low temp flames, and "yellow" for
        // hot temp flames (based on the HSV model of color).
        float hue = map(color.r, low_threshold, high_threshold, 0.0, 55.0 / 255.0);
        float value = 0.8 + map(color.r, low_threshold, high_threshold, 0.0, 0.2);
        // Full saturation, and high value (these are flames we're simulating)
        vec3 hsv = vec3(hue, value, value);
        // Convert back to RGB because we are material girls and we live in a material world
        color = hsv2rgb(hsv);
    } else { color = vec3(step(completion, color.r)); } // Clamp to black/white mask values

    // Output to screen
    return vec4(color, color.b);
}

vec4 close_color(vec3 coords_geo, vec3 size_geo) {
  vec4 color = vec4(0.0);

  // Paint only the area inside the current geometry.
  if (0.0 <= coords_geo.x && coords_geo.x <= 1.0 && 0.0 <= coords_geo.y && coords_geo.y <= 1.0) {
    vec4 mask = burn_mask(coords_geo.xy);

    // Get color from the window texture.
    vec3 coords_tex = niri_geo_to_tex * coords_geo;
    vec4 window_color = texture2D(niri_tex, coords_tex.st);

    // Set the color based on the mask
    if (mask.a == 1.0) {
      color = window_color;
    } else if (mask.a == 0.0) {
      color = vec4(0.0);
    } else {
      color = mask;
      color.a = 1.0;
    }
  }
  return color;
}
