shader_type canvas_item;

uniform sampler2D noise: hint_normal;
uniform float scale: hint_range(0.0, 1.0) = 0.25;
uniform float noiseImpact: hint_range(0.0, 2.0) = 0.5;
uniform float radius: hint_range(0.0, 1.0) = 0.25;

uniform sampler2D color: hint_default_black;

uniform float speed: hint_range(0., 10) = 1.0;

vec2 polar_coordinates(vec2 uv, vec2 center, float zoom, float repeat)
{
	vec2 dir = uv - center;
	float r = length(dir) * 2.0;
	float angle = atan(dir.y, dir.x) * 1.0/(3.1416 * 2.0);
	return mod(vec2(r * zoom, angle * repeat), 1.0);
}

void fragment() {
    // Called for every pixel the material is visible on.
	vec2 toCenter = UV - 0.5;
	vec2 circle = vec2(cos(TIME * speed), sin(TIME * speed));
	float innerRadius = (0.5 - (0.5 * scale));
	
	vec2 scaled = scale * toCenter;
	vec2 angle = vec2(cos(UV.x), sin(UV.y));
	vec2 offset = angle*scaled + 0.5;
	
	vec2 texturePoint = offset + (innerRadius * circle);
	
	float circlePoint = texture(noise, texturePoint).x;
	
	float area = step(length(toCenter), radius + (noiseImpact * circlePoint ));
	COLOR = vec4(texture(color, UV).rgb, area);
}