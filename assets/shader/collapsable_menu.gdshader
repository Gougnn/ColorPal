shader_type canvas_item;

uniform bool is_gradient = false;
uniform float steps;
uniform vec3 brightness;
uniform vec3 contrast;
uniform vec3 frequency;
uniform vec3 shift;

vec3 rgb_to_hsv( vec3 rgb ) {
	float r = rgb.r, g = rgb.g, b = rgb.b;
	float v = max(max(r, g), b);
	float delta = v - min(min(r, g), b);
	float h = v == r ? (g-b)/delta : (v == g ? 2.0f + (b-r)/delta : 4.0f + (r-g)/delta);
	h /= 360.0f;
	h += (h<0.0f) ? 360.0f : 0.0f;
	float s = delta/v; 
	
	return vec3(h, s, v);
}

vec3 hsv_to_rgb(vec3 hsv) {
	float h = hsv.x * 360.0f, s = hsv.y, v = hsv.z;
	float c = v * s;
	float x = c * (1.0f - abs(float(int(h/60.0f) % 2) - 1.0f));
	vec3 rgb_prime;
	
	if (h >= 0.0f && h <= 60.0f) {
		rgb_prime = vec3(c, x, 0);
	} if (h > 60.0f && h <= 120.0f) {
		rgb_prime = vec3(x, c, 0);
	} if (h > 120.0f && h <= 180.0f) {
		rgb_prime = vec3(0, c, x);
	} if (h > 180.0f && h <= 240.0f) {
		rgb_prime = vec3(0, x, c);
	} if (h > 240.0f && h <= 300.0f) {
		rgb_prime = vec3(x, 0, c);
	} if (h > 300.0f && h <= 360.0f) {
		rgb_prime = vec3(c, 0, x);
	}
	
	return rgb_prime + (v-c);
}


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
	//COLOR = vec4(vec3(quantize(UV.x)), 1.0f);
}
