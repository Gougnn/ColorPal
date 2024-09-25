shader_type canvas_item;

uniform bool is_gradient = false;
uniform float steps;
uniform vec3 brightness;
uniform vec3 contrast;
uniform vec3 frequency;
uniform vec3 shift;

float quantize( float entry ) {
	return floor(entry / (1.0f/steps)) * (1.0f/steps);
}

void fragment() {
	vec3 col = brightness + contrast * cos(2.0f * PI *(frequency * (is_gradient ? UV.x : quantize(UV.x)) + shift));
	COLOR = vec4(col, 1.0f);
	//COLOR = vec4(vec3(quantize(UV.x)), 1.0f);
}
