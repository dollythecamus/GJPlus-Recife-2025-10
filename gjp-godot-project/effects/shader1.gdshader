shader_type canvas_item;

uniform vec2 iResolution;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec3 tot = vec3(0.);
  for(int m=-1; m<2; m++)
  {
    for(int n=-1; n<2; n++)
    {
      vec2 o = vec2(float(m),float(n)) * 0.5;
      vec2 s = (-iResolution.xy + 2.0*(UV.xy+o))/iResolution.xy;
      s.x *= iResolution.x/iResolution.y;    
      float scalar = clamp((cos(TIME*0.5)*2.),-0.8,0.369);
      s *= (acos(length(s) * scalar));
      s *= 0.95+scalar*0.65;
      vec2 grid = 5.-pow(vec2(1.39),abs(vec2(0.5)-fract(s*20.))*10.3);
      vec3 color = vec3(1. - clamp(min(grid.x,grid.y),0.,1.));       
      color *= step(s.x,1.4008) * step(-1.4008,s.x) * step(s.y,1.051) * step(-1.051,s.y);
      tot += color;
    }
  }
  tot *= float(1./9.);
  COLOR.rgba = vec4(vec3(tot),1);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
