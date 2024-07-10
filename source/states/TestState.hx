package states;

import flixel.addons.nape.FlxNapeSpace;
import objects.BoyfriendRagdoll;
import objects.CrashoutMeter;
import objects.CenatShooter;

// author Daniel Hummus
class TestState extends MusicBeatState
{
	var fuckyou:Float = 0;

	//var meter:CrashoutMeter;

	override function create()
	{
		super.create();

		FlxNapeSpace.init();
        FlxNapeSpace.createWalls(0, -300, FlxG.width, FlxG.height - 30);
		FlxNapeSpace.space.gravity.setxy(0, 400);


		
        FlxG.camera.bgColor = FlxColor.GRAY;


		//meter.screenCenter();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);


        if (FlxG.mouse.justPressed)
            {
                var mousePos = FlxG.mouse.getScreenPosition();
                var ragdoll = new BoyfriendRagdoll(mousePos.x, mousePos.y, 1);
                add(ragdoll);
                trace(ragdoll);

            }
		// if (FlxG.keys.pressed.UP)
		// 	meter.bar.value += 1;
		// if (FlxG.keys.pressed.DOWN)
		// 	meter.bar.value -= 1;
	}
}
