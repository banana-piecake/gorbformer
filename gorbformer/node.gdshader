shader_type canvas_item;

uniform float speed = 2.0;
uniform float frequency = 5.0;

void fragment() {
	vec3 rainbow = 0.5 + 0.5 * cos((TIME * speed) + (UV.x * frequency) + vec3(0.0, 2.0, 4.0));
	
	// ooh fancy shader
	COLOR = vec4(rainbow, 0.3);
}