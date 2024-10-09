shader_type canvas_item;

uniform bool is_gradient = false;
uniform float steps;
uniform vec3 brightness;
uniform vec3 contrast;
uniform vec3 frequency;
uniform vec3 shift;


float quantize( float entry ) {
	return floor(entry / (1.0f/steps)) * (1.0f/(steps +1.0f));
}

void fragment() {
	vec3 
		b = (brightness),
		c = (contrast),
		f = (frequency),
		s = (shift);
	vec3 col = b + c * cos(2.0f * PI *(f * (is_gradient ? UV.x : quantize(UV.x)) + s));
	COLOR = vec4(col, 1.0f);
}
