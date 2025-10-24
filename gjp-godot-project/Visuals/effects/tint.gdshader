shader_type canvas_item;

uniform vec4 tint : source_color;
uniform float intensity;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

float mag(vec4 x) {
	return ((x.r + x.g + x.b) / 4.0f);
}

vec4 color(vec4 x, vec4 y, float i) {
	return vec4((mag(x) * y.rgb) * i, 1.0f);
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 screen = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = color(screen.rgba, tint.rgba, intensity);
}
