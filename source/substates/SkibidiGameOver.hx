package substates;

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
class SkibidiGameOver extends MusicBeatSubstate
{
	public var boyfriendRagdoll:BoyfriendRagdoll;
	var camFollow:FlxObject;
	var moveCamera:Bool = false;
	var playingDeathSound:Bool = false;

	var stageSuffix:String = "";


	public static var instance:SkibidiGameOver;

	

	var charX:Float = 0;
	var charY:Float = 0;

	var impactSounds:Array<Sound> = [];
	override function create()
	{
		instance = this;

		for (path in FileSystem.readDirectory(Paths.modFolders("sounds/impact/")))
			{
				if (path.endsWith(".ogg"))
					impactSounds.push(Sound.fromFile((Paths.getPath('sounds/impact/$path', SOUND, null, true))));
			}


		Conductor.songPosition = 0;
        PlayState.instance.boyfriend.visible = false;
        PlayState.instance.camHUD.visible = false;

        FlxNapeSpace.init();
        var walls = FlxNapeSpace.createWalls(0, -9000, 25000, PlayState.instance.boyfriend.y + PlayState.instance.boyfriend.height - 100);
        FlxNapeSpace.space.gravity.setxy(0, 800);
		FlxNapeSpace.velocityIterations = 2;
		FlxNapeSpace.space.worldLinearDrag = 0.01;
		FlxNapeSpace.space.worldAngularDrag = 0.02;
		walls.setShapeMaterials(Material.steel());


		var toilet = new FlxNapeSprite();
		toilet.loadGraphic(Paths.image("death/toilet"));
		toilet.setPosition(PlayState.instance.dad.x, PlayState.instance.dad.y);
		toilet.antialiasing = true;
		add(toilet);
		toilet.createRectangularBody();
		toilet.body.velocity = new Vec2(FlxG.random.int(8000,12000),FlxG.random.int(500,800));

		boyfriendRagdoll = new BoyfriendRagdoll(PlayState.instance.boyfriend.x + 10, PlayState.instance.boyfriend.y + 10);
		add(boyfriendRagdoll);
		boyfriendRagdoll.torso.body.velocity = new Vec2(FlxG.random.int(8000,12000),FlxG.random.int(2000,4000));
		boyfriendRagdoll.torso.body.angularVel = 15;

		//@:privateAccess
		var group1:CbType = new CbType();
		var group2:CbType = new CbType();

		
	
		

		//boyfriendRagdoll.arm.body.cbTypes.add(group1);
		//boyfriendRagdoll.head.body.cbTypes.add(group1);
		boyfriendRagdoll.torso.body.cbTypes.add(group1);
		walls.cbTypes.add(group2);
	
		var listener = new PreListener(InteractionType.COLLISION, group1, group2,onCollision);
		listener.space = FlxNapeSpace.space;
		
       

		FlxG.sound.play(Paths.sound("dead"));

		var redOverlay = new FlxSprite().makeGraphic(1,1,FlxColor.fromRGB(255,0,0,90));
		redOverlay.cameras = [PlayState.instance.camOther];
		redOverlay.setGraphicSize(FlxG.width, FlxG.height);
		redOverlay.updateHitbox();
		redOverlay.screenCenter();
		add(redOverlay);
		redOverlay.blend = ADD;

		FlxTween.tween(redOverlay,{alpha:0},1,{startDelay: 4});


		var deathMessage = new FlxSprite().loadGraphic(Paths.image("death/message"));
		deathMessage.scale.set(0.7,0.7);
		deathMessage.updateHitbox();
		deathMessage.antialiasing = true;
		deathMessage.setPosition(935,40);
		deathMessage.cameras = [PlayState.instance.camOther];
		add(deathMessage);
		

		
		FlxTween.tween(deathMessage,{alpha:0},1.2,{startDelay: 6.5});

		//FlxG.camera.scroll.set();
		//FlxG.camera.target = null;

		
		FlxG.camera.follow(boyfriendRagdoll.torso);
		FlxG.camera.setScrollBounds(null,null,null,PlayState.instance.boyfriend.y + PlayState.instance.boyfriend.height - 100);
		//camFollow = new FlxObject(0, 0, 1, 1);
		//camFollow.setPosition(boyfriend.getGraphicMidpoint().x + boyfriend.cameraPosition[0], boyfriend.getGraphicMidpoint().y + boyfriend.cameraPosition[1]);
		//FlxG.camera.focusOn(new FlxPoint(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxG.camera.scroll.y + (FlxG.camera.height / 2)));
		//add(camFollow);
		
		PlayState.instance.setOnScripts('inGameOver', true);
		PlayState.instance.callOnScripts('onGameOverStart', []);
		

		super.create();
	}

	function onCollision(cb:PreCallback):PreFlag
		{
			FlxG.sound.play(impactSounds[FlxG.random.int(0, impactSounds.length - 1)]);
			return PreFlag.ACCEPT;
		}
	


	public var startedDeath:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.camera.snapToTarget();
		PlayState.instance.callOnScripts('onUpdate', [elapsed]);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			#if DISCORD_ALLOWED DiscordClient.resetClientID(); #end
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.chartingMode = false;

			Mods.loadTopMod();
			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new StoryMenuState());
			else
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
