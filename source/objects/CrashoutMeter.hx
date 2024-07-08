package objects;

import flixel.graphics.tile.FlxGraphicsShader;
import flixel.ui.FlxBar;

class CrashoutMeter extends FlxSpriteGroup
{
	public var bar:FlxBar;

	public function new()
	{
		super();

		var lineBG = new FlxSprite().loadGraphic(Paths.image("crashoutMeter/bar"));
		add(lineBG);
		lineBG.antialiasing = ClientPrefs.data.antialiasing;

		bar = new FlxBar(0, 0, LEFT_TO_RIGHT, 796, 111, null, "", 0, 2,
			false).createImageBar(null, Paths.image("crashoutMeter/gradiant"), FlxColor.TRANSPARENT);
		add(bar);
		bar.setPosition(12, 4);
		bar.setRange(0,1);
		bar.antialiasing = ClientPrefs.data.antialiasing;

		var ok = new FlxSprite().loadGraphic(Paths.image("crashoutMeter/okiedokie"));
		add(ok);
		ok.antialiasing = ClientPrefs.data.antialiasing;
		ok.y -= 70;

		var mild = new FlxSprite().loadGraphic(Paths.image("crashoutMeter/mild"));
		add(mild);
		mild.antialiasing = ClientPrefs.data.antialiasing;
		mild.x = (lineBG.width / 2) - (mild.width / 2) + 30;
		mild.y = -50;

		var kys = new FlxSprite().loadGraphic(Paths.image("crashoutMeter/crashout"));
		add(kys);
		kys.x = lineBG.width - (kys.width / 2) - 60;
		kys.y = lineBG.y - kys.height / 2;
		kys.antialiasing = ClientPrefs.data.antialiasing;
	}
}

