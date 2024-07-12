package substates;

import objects.VideoSprite;
import flixel.addons.nape.FlxNapeSprite;
import openfl.media.Sound;
import nape.callbacks.CbType;
import nape.callbacks.Listener;
import nape.phys.Material;
import nape.callbacks.PreFlag;
import nape.callbacks.PreCallback;
import nape.callbacks.InteractionType;
import nape.callbacks.PreListener;
import nape.geom.Vec2;
import flixel.addons.nape.FlxNapeSpace;
import objects.BoyfriendRagdoll;
import backend.WeekData;

import objects.Character;
import flixel.FlxObject;
import flixel.FlxSubState;

import states.StoryMenuState;
import states.FreeplayState;

//author Daniel Hummus
class GriddyGameover extends MusicBeatSubstate
{
	var camFollow:FlxObject;
	var moveCamera:Bool = false;
	var playingDeathSound:Bool = false;

	var stageSuffix:String = "";


	public static var instance:GriddyGameover;

	var vidPath = '';

	public function new(vid:String) {
		super();
		vidPath = vid;
	}

	override function create()
	{
		instance = this;

		var video = new VideoSprite();
		video.addCallback(ONFORMAT,()->{
			video.setGraphicSize(0,FlxG.height);
			video.updateHitbox();
			video.screenCenter();
		});
		video.addCallback(ONEND,()->{
			endBullshit();
		});
		video.load(vidPath);
		video.play();
		add(video);

		PlayState.instance.camOther.bgColor = FlxColor.BLACK;
		Conductor.songPosition = 0;
        PlayState.instance.boyfriend.visible = false;
        PlayState.instance.camHUD.visible = false;
		PlayState.instance.setOnScripts('inGameOver', true);
		PlayState.instance.callOnScripts('onGameOverStart', []);
		
		super.create();
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length-1]];
	}


	public var startedDeath:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.camera.snapToTarget();
		PlayState.instance.callOnScripts('onUpdate', [elapsed]);

		// if (controls.ACCEPT)
		// {
		// 	endBullshit();
		// }

		if (controls.BACK)
		{
			#if DISCORD_ALLOWED DiscordClient.resetClientID(); #end
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.chartingMode = false;

			Mods.loadTopMod();
			MusicBeatState.switchState(new states.BopPlay());

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			PlayState.instance.callOnScripts('onGameOverConfirm', [false]);
		}
		
		
		
		PlayState.instance.callOnScripts('onUpdatePost', [elapsed]);
	}

	var isEnding:Bool = false;



	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					MusicBeatState.resetState();
				});
			});
			PlayState.instance.callOnScripts('onGameOverConfirm', [true]);
		}
	}

	override function destroy()
	{
		instance = null;
		super.destroy();
	}
}
