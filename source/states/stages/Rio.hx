package states.stages;

import cpp.Lib;
import flixel.graphics.tile.FlxGraphicsShader;

class Rio extends BaseStage
{
	var shader:ShittyGradientShader;

	public function new()
	{
		super();

		var bg = new FlxSprite().loadGraphic(Paths.image("bg/rio/rio"));
		bg.antialiasing = true;
		bg.setPosition(-745, -250);
		add(bg);

		if (ClientPrefs.data.shaders)
		{
			shader = new ShittyGradientShader();
			bg.shader = shader;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (ClientPrefs.data.shaders)
			shader.iTime.value[0] += elapsed;
    }
}

class ShittyGradientShader extends FlxGraphicsShader
{
	@:glFragmentSource('
    
    #pragma header

    uniform vec2 iResolution;
    uniform float iTime;
    void main()
    {
    vec2 fragCoord = openfl_TextureCoordv * iResolution;
    vec2 uv = fragCoord / iResolution.xy;
    

    
    
    float t = iTime * 0.1;
    float e = 2.0;
    
    vec2 pointPos[4];
    pointPos[0] = (0.5 + 0.5 * vec2(cos(-t), sin(-t))) * e;
    pointPos[1] = (0.5 + 0.5 * vec2(cos(t * 1.7856), sin(t * 1.234))) * e;
    pointPos[2] = (0.5 + 0.5 * vec2(cos(-t * 2.78633), sin(-t * 3.564))) * e;
    pointPos[3] = (0.5 + 0.5 * vec2(cos(t * 4.567), sin(t * 3.124))) * e;
    
    // pointPos[0] = vec2(cos(t * 0.23849) * 0.3 + 0.25, 0.72);
    // pointPos[1] = vec2(0.82, 0.7 + sin(t * 0.39940) * 0.2);
    // pointPos[2] = vec2(0.8 + cos(t * 0.2339) * 0.2, 0.22);
    // pointPos[3] = vec2(cos(t * 0.12238 + 1.8942) * 0.35 + 0.3, sin(t * 0.1837 + 120.39) * 0.5 + 0.4) * 0.4;
    
    vec3 pointCol[4];
     pointCol[0] = vec3(0.537,0.016,0.643);
    pointCol[1] = vec3(0.412,0.235,0.827);
    pointCol[2] = vec3(0.475,0.024,0.718);
    pointCol[3] = vec3(0.761,0.353,0.180);
    
    float blend = 4.0;
    
    vec3 col = vec3(0.0);
    float totalWeight = 0.0;
    for (int i = 0; i < 4; ++i) {
        float dist = distance(uv, pointPos[i]);
        float weight = 1.0 / (pow(dist, blend) + 0.01);

        col += pointCol[i] * weight;
        totalWeight += weight;
    }
    col /= totalWeight;
    
    gl_FragColor = vec4(col, 1.0);
}')
	public function new()
	{
		super();
        iResolution.value = [openfl.Lib.current.stage.stageWidth,openfl.Lib.current.stage.stageHeight];
        iTime.value = [0];
	}
}
