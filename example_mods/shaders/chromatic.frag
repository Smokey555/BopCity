#pragma header


uniform float offset;

void main()
{
	vec4 col1 = flixel_texture2D(bitmap, openfl_TextureCoordv.st - vec2(offset, 0.0));
	vec4 col2 = flixel_texture2D(bitmap, openfl_TextureCoordv.st);
	vec4 col3 = flixel_texture2D(bitmap, openfl_TextureCoordv.st + vec2(offset, 0.0));

	vec4 toUse = flixel_texture2D(bitmap, openfl_TextureCoordv);

	toUse.r = col1.r;
	toUse.g = col2.g;
	toUse.b = col3.b;
	//float someshit = col4.r + col4.g + col4.b;

	gl_FragColor = toUse;
}