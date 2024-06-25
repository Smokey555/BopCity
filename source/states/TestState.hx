package states;

import objects.CenatShooter;

class TestState extends MusicBeatState
{



    override function create()
        {
            super.create();
            var shooter = new CenatShooter(FlxG.camera);
            add(shooter);




        }


}