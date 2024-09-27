shader_type canvas_item;

uniform bool is_gradient = false;
uniform float steps;
uniform vec3 brightness;
uniform vec3 contrast;
uniform vec3 frequency;
uniform vec3 shift;

const mat3 m1 = mat3(
	vec3( 0.8189330101,  0.0329845436,  0.0482003018), 
	vec3( 0.3618667424,  0.9293118715,  0.2643662691), 
	vec3(-0.1288597137,  0.0361456387,  0.6338517070)
	);
const mat3 m2 = mat3(
	vec3( 0.2104542553,  1.9779984951,  0.0259040371), 
	vec3( 0.7936177850, -2.4285922050,  0.7827717662), 
	vec3(-0.0040720468,  0.4505937099, -0.8086757660)
	);


vec3 rgb_to_lab( vec3 rgb ) {
	vec3 lms = m1 * rgb;
	vec3 lms_prime = vec3(pow(lms.x, 1.0f/3.0f), pow(lms.y, 1.0f/3.0f), pow(lms.z, 1.0f/3.0f));
	return m2 * lms_prime;
}

vec3 lab_to_lch( vec3 lab ) {
	float c = sqrt(pow(lab.y, 2) + pow(lab.z, 2));
	float h = atan(lab.z, lab.y);
	
	return vec3(lab.x, c, h);
}



float quantize( float entry ) {
	return floor(entry / (1.0f/steps)) * (1.0f/(steps +1.0f));
}

void fragment() {
	vec3 col = brightness + contrast * cos(2.0f * PI *(frequency * (is_gradient ? UV.x : quantize(UV.x)) + shift));
	COLOR = vec4(col, 1.0f);
	//COLOR = vec4(vec3(quantize(UV.x)), 1.0f);
}
