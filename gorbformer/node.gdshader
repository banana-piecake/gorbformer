shader_type canvas_item;

uniform float speed = 4.0;
uniform float frequency = 3.0;

void fragment() {
	vec3 rainbow = 0.6 + 0.34 * cos((TIME * speed) + (UV.x * frequency) + vec3(0.0, 2.0, 4.0));
	
	// ooh fancy shader
	COLOR = vec4(rainbow, 0.5);
}