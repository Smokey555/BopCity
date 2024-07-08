package states;

import objects.CrashoutMeter;
import objects.CenatShooter;

//author Daniel Hummus
class TestState extends MusicBeatState
{


    var fuckyou:Float = 0;

    var meter:CrashoutMeter;
    override function create()
        {
            super.create();

            FlxG.camera.bgColor = FlxColor.GRAY;
            meter = new CrashoutMeter();
            add(meter);

            meter.screenCenter();




        }


    override function update(elapsed:Float)
        {
            super.update(elapsed);

            if (FlxG.keys.pressed.UP)
                meter.bar.value += 1;
            if (FlxG.keys.pressed.DOWN)
                meter.bar.value  -= 1;


        }


}