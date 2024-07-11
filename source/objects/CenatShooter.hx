package objects;

import flixel.input.mouse.FlxMouseEvent;
import openfl.media.Sound;
import flixel.graphics.FlxGraphic;

class CenatShooter extends FlxSpriteGroup
{
	var crosshair:FlxSprite;
	var cenatImages:Array<FlxGraphic> = [];
	var cenatsToShoot:FlxSpriteGroup;

	var cenatDeathSounds:Array<Sound> = [];

	var cenatShootSounds:Array<Sound> = [];

	var playedSounds:Array<FlxSound> = [];

	public var started:Bool = false;

	public var finishCallback:Void->Void;
	public var failCallback:Void->Void;

	var timer:FlxTimer;

	var cam:FlxCamera;

	public function new(_cam:FlxCamera)
	{
		super();
		cam = _cam;
		cameras = [cam];

		var bg = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		bg.setGraphicSize(1280, 720);
		bg.updateHitbox();
		bg.screenCenter();
		bg.alpha = 0.7;
		add(bg);

		for (path in FileSystem.readDirectory(Paths.modFolders("images/something/fuckyou/")))
		{
			if (path.endsWith(".png"))
				cenatImages.push(FlxGraphic.fromAssetKey(Paths.getPath('images/something/fuckyou/$path', IMAGE, null, true)));
		}

		for (path in FileSystem.readDirectory(Paths.modFolders("sounds/fuckyou/")))
		{
			if (path.endsWith(".ogg"))
				cenatShootSounds.push(Sound.fromFile((Paths.getPath('sounds/fuckyou/$path', SOUND, null, true))));
		}

		for (path in FileSystem.readDirectory(Paths.modFolders("sounds/fuckyou2/")))
		{
			if (path.endsWith(".ogg"))
				cenatDeathSounds.push(Sound.fromFile((Paths.getPath('sounds/fuckyou2/$path', SOUND, null, true))));
		}

		cenatsToShoot = new FlxSpriteGroup();
		cenatsToShoot.cameras = [cam];
		add(cenatsToShoot);
		var text = new FlxSprite().loadGraphic(Paths.image("something/text"));
		add(text);
		text.scale.set(1.2,1.2);
		text.updateHitbox();
		text.setPosition(FlxG.width - text.width, FlxG.height - text.height);

		crosshair = new FlxSprite().loadGraphic(Paths.image("something/c"));
		add(crosshair);

		visible = false;
	}

	public function start(amount:Int, time:Float)
	{
		if (started)
			return;

		for (i in 0...amount)
		{
			var cenatSprite = new FlxSprite().loadGraphic(cenatImages[FlxG.random.int(0, cenatImages.length - 1)]);
			cenatSprite.scale.y = FlxG.random.float(0.4,1);
			cenatSprite.updateHitbox();
			cenatsToShoot.add(cenatSprite);
			cenatSprite.setPosition(FlxG.random.float(100, 1280 - cenatSprite.width), FlxG.random.float(0, 600 - cenatSprite.height));
			cenatSprite.velocity.set(FlxG.random.int(200, 600), FlxG.random.int(200, 600));
		}
		timer = new FlxTimer().start(time, function(_)
		{
			finish(true);
		});

		started = true;
		visible = true;
	}

	function finish(fail:Bool)
	{
		timer.cancel();
		visible = false;
		started = false;
		cenatsToShoot.forEach(function(spr)
		{
			spr.kill();
			cenatsToShoot.remove(spr);
		});
		for (snd in playedSounds)
		{
			snd.stop();
		}
		if (fail)
		{
			if (failCallback != null)
				failCallback();
		}
		else
		{
			if (finishCallback != null)
				finishCallback();
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (visible)
		{
			var mousePos = FlxG.mouse.getScreenPosition(cam);
			crosshair.setPosition(mousePos.x - crosshair.width / 2, mousePos.y - crosshair.height / 2);

			cenatsToShoot.forEachExists(function(spr)
			{
				if (spr.x <= 0)
				{
					spr.x = 0;
					spr.velocity.x *= -1;
				}
				if (spr.x + spr.width >= FlxG.width)
				{
					spr.x = FlxG.width - spr.width;
					spr.velocity.x *= -1;
				}
				if (spr.y <= 0)
				{
					spr.y = 0;
					spr.velocity.y *= -1;
				}
				if (spr.y + spr.height >= FlxG.height)
				{	
					spr.y = FlxG.height - spr.height;
					spr.velocity.y *= -1;
				}
			});

			if (FlxG.mouse.justPressed)
			{
				cam.flash(FlxColor.WHITE, 0.1);
				playedSounds.push(FlxG.sound.play(cenatShootSounds[FlxG.random.int(0, cenatShootSounds.length - 1)]));

				var sprs = cenatsToShoot.members.copy();
				sprs.reverse();
				for (spr in sprs)
				{
					if (FlxG.mouse.overlaps(spr, cam))
					{
						var sound = FlxG.sound.play(cenatDeathSounds[FlxG.random.int(0, cenatDeathSounds.length - 1)]);
						sound.pitch = FlxG.random.float(0.5, 1);
						playedSounds.push(sound);
						cenatsToShoot.remove(spr, true);
						spr.kill();
						break;
					}
				}
				sprs = null;
			}

			if (started && cenatsToShoot.members.length == 0)
			{
				finish(false);
			}
		}
	}
}
