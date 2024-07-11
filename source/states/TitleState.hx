package states;

import backend.WeekData;
import backend.Highscore;

import flixel.input.keyboard.FlxKey;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import haxe.Json;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

import shaders.ColorSwap;

import states.StoryMenuState;
import states.OutdatedState;
import states.MainMenuState;

typedef TitleData =
{
	titlex:Float,
	titley:Float,
	startx:Float,
	starty:Float,
	gfx:Float,
	gfy:Float,
	backgroundSprite:String,
	bpm:Float
}

class TitleState extends MusicBeatState
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

	public static var updateVersion:String = '';
	public static var initialized:Bool = false;


	var swagShader:ColorSwap = null;
	var transitioning:Bool = false;

	var logoBl:FlxSprite;
	var titleText:FlxText;

	override public function create():Void
	{
		Paths.clearStoredMemory();

		#if LUA_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		FlxG.fixedTimestep = false;
		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];

		super.create();

		FlxG.save.bind('funkin', CoolUtil.getSavePath());

		ClientPrefs.loadPrefs();

		Highscore.load();

		if(!initialized)
		{
			if(FlxG.save.data != null && FlxG.save.data.fullscreen)
			{
				FlxG.fullscreen = FlxG.save.data.fullscreen;
			}
			persistentUpdate = true;
			persistentDraw = true;
		}

		if (FlxG.save.data.weekCompleted != null)
		{
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		FlxG.mouse.visible = false;
		// if(FlxG.save.data.flashing == null && !FlashingState.leftState) {
		// 	FlxTransitionableState.skipNextTransIn = true;
		// 	FlxTransitionableState.skipNextTransOut = true;
		// 	MusicBeatState.switchState(new FlashingState());
		// } else {
			if (initialized)
				startIntro();
			else
			{
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					startIntro();
				});
			}
		//}
	}



	function startIntro()
	{
		if (!initialized)
		{
			if(FlxG.sound.music == null) {
				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			}
		}

		Conductor.bpm = 70;
		persistentUpdate = true;

		logoBl = new FlxSprite().loadGraphic(Paths.image('menu/playNow'));
		logoBl.screenCenter();

		if(ClientPrefs.data.shaders) swagShader = new ColorSwap();
		add(logoBl);
		logoBl.shader = swagShader.shader;

		titleText = new FlxText(0,720 - 120,FlxG.width,'pres anything to start',72);
		titleText.alignment = CENTER;
        titleText.font = Paths.font('papyrus.ttf');
        titleText.updateHitbox();
        add(titleText);
		
		if (initialized)
			skipIntro();
		else
			initialized = true;

		Paths.clearUnusedMemory();
	}



	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		var pressedEnter:Bool = false;

		final keyCode = FlxG.keys.firstJustPressed();
		if (keyCode != -1) {
			final exclusions = [].concat(muteKeys).concat(volumeDownKeys).concat(volumeUpKeys);
			pressedEnter = !exclusions.contains(keyCode);
		}

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}
		

		// EASTER EGG

		if (initialized && !transitioning && skippedIntro)
		{

			
			if(pressedEnter)
			{
		
				FlxTransitionableState.skipNextTransIn = FlxTransitionableState.skipNextTransOut = true;
				FlxG.camera.flash(ClientPrefs.data.flashing ? FlxColor.WHITE : 0x4CFFFFFF, 1);
				FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

				transitioning = true;

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					MusicBeatState.switchState(new MainMenuState());
					closedState = true;
				});
			}
		}

		if (initialized && pressedEnter && !skippedIntro)
		{
			skipIntro();
		}

		if(swagShader != null)
		{
			swagShader.hue += elapsed * 0.1;
		}

		super.update(elapsed);
	}

	private var sickBeats:Int = 0; //Basically curBeat but won't be skipped if you hold the tab or resize the screen
	public static var closedState:Bool = false;
	override function beatHit()
	{
		super.beatHit();

		if (logoBl != null) {
			final scale = curBeat % 2 == 0 ? 1.5 : 1;
			logoBl.scale.set(scale * FlxG.random.float(0.5,1.5),scale * FlxG.random.float(0.5,1.5));

		}


		if(!closedState) {
			sickBeats++;
			switch (sickBeats)
			{
				case 1:
					FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
					FlxG.sound.music.fadeIn(4, 0, 0.7);
					skipIntro();

			}
		}
	}

	var skippedIntro:Bool = false;
	var increaseVolume:Bool = false;
	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			FlxG.camera.flash(FlxColor.WHITE, 4);
			skippedIntro = true;
		}
	}
}
