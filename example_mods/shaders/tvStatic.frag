#pragma header

uniform float iTime;
uniform float strengthMulti;
uniform float offset;
uniform float darkness;
uniform float contrast;

const float maxStrength = .8;
const float minStrength = 0.3;

const float speed = 20.00;

float random (vec2 noise)
{
	return fract(sin(dot(noise.xy,vec2(10.998,98.233)))*12433.14159265359);
}

void main()
{
		
	vec2 uv = openfl_TextureCoordv.xy;
	vec2 uv2 = fract(openfl_TextureCoordv.xy*fract(sin(iTime*speed)));
		
	float _maxStrength = clamp(sin(iTime/2.0),minStrength,maxStrength) * strengthMulti;
		
	vec3 colour = vec3(random(uv2.xy) - 0.1)*_maxStrength;
	vec4 background = flixel_texture2D(bitmap, uv);
	background.rgb =background.rgb - colour;
		

	vec4 red = flixel_texture2D(bitmap, uv.st - vec2(offset, 0.0));
	vec4 blue = flixel_texture2D(bitmap, uv.st + vec2(offset, 0.0));

	background.r = (red.r - colour.r);
	background.b = (blue.b - colour.b);

	background.rgb = ((background.rgb - 0.5) * max(1.0 * contrast, 0.0)) + 0.5;
    background *= 1.0 - darkness;

	gl_FragColor = background;
}