package states.stages;

import flixel.addons.display.FlxBackdrop;

class SkibidiStage extends BaseStage
{



    override function create()
        {
           
            var bg = new FlxBackdrop(Paths.image("bg/skibidi/skibidibgstage"),X);
            bg.scrollFactor.set(0.7,0.7);
            bg.setPosition(-175,-50);
           

            var sky = new FlxBackdrop(Paths.image("bg/skibidi/sky"),XY);
            sky.scrollFactor.set(0.7,0.7);
            sky.setPosition(bg.x,bg.y - sky.height);
        

    
            add(sky);
            add(bg);


            

        }


        
}