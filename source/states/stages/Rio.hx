package states.stages;

import flixel.graphics.tile.FlxGraphicsShader;

class Rio extends BaseStage
{



    public function new()
        {
            super();
            


        }




}




//ignore this didnt even port it over yet
class ShittyGradientShader extends FlxGraphicsShader
{

    @:glFragmentSource('
    
    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    {
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    float rt = uv.x;
    
    
    //use uv.x or uv.y to switch gradient orientation
    //smoothstep use hermite interpolation to get interpolated value from given range / 0-1 input
    float y = smoothstep(-0.75,0.75,rt);
    
    // Time varying pixel color
    vec3 col = vec3(cos(y)+0.25, 0.5, abs(sin(iTime)));
    

    // Output to screen
    fragColor = vec4(col,1.0);
}'
)



}