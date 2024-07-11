package states;

import backend.InputFormatter;
import flixel.input.mouse.FlxMouseEvent;
import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.7.3'; // This is also used for Discord RPC

    var walls:FlxSpriteGroup;

    var buttons:FlxSpriteGroup;
    var bg:FlxSprite;

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end


		FlxG.worldBounds.set(FlxG.width,FlxG.height);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = true;

        FlxG.mouse.visible = true;
        bg = new FlxSprite().makeGraphic(1,1,FlxColor.ORANGE);
        bg.scale.set(FlxG.width,FlxG.height);
        bg.updateHitbox();
        add(bg);

        walls = new FlxSpriteGroup();
        add(walls);

        buttons = new FlxSpriteGroup();
        add(buttons);

		final thick = 30;
        var l = new FlxSprite(-thick).makeGraphic(thick,FlxG.height);
        l.immovable = true;
        walls.add(l);

        var r = new FlxSprite(FlxG.width).makeGraphic(thick,FlxG.height);
        r.immovable = true;
        walls.add(r);

        var u = new FlxSprite(0,-thick).makeGraphic(FlxG.width,thick);
        u.immovable = true;
        walls.add(u);

        var b = new FlxSprite(0,FlxG.height).makeGraphic(FlxG.width,thick);
        b.immovable = true;
        walls.add(b);

        generatebuttons();

        super.create();

	}

    var tempBu = ['freeplay','playNow','credits','options'];
    function generatebuttons() {

        var len:Array<String> = [for (i in 0...5)'$i'];
        for (i in tempBu) {
            var random = FlxG.random.int(0,len.length-1);
            // len.remove(len[random]);
            len.insert(random,i);
        }
        trace(len);

        for (i in 0...len.length) {
            
            var graphic = !tempBu.contains(len[i]) ? 'die' : len[i];
            var spr:MenuSrp = cast new MenuSrp().loadGraphic(Paths.image('menu/$graphic'));
            spr.name = graphic;


            spr.elasticity = 1;
            spr.velocity.y = FlxG.random.int(200,FlxG.random.bool(40) ? 400 : 700);
            spr.velocity.x = FlxG.random.int(200,FlxG.random.bool(40) ? 400 : 700);
            spr.setGraphicSize(200 * FlxG.random.float(0.7,1.4),(200 * FlxG.random.float(0.7,1.4)));
            spr.updateHitbox();

			spr.x = FlxG.random.int(0,Std.int(FlxG.width-spr.width));
            spr.y = FlxG.random.int(0,Std.int(FlxG.height-spr.height));

            buttons.add(spr); 

            FlxMouseEvent.add(spr,(o:FlxSprite)->{
                FlxMouseEvent.removeAll();
                
                var s:MenuSrp = cast o;
                switch (s.name) {
                    case 'freeplay': MusicBeatState.switchState(new BopPlay());
                    case 'credits': MusicBeatState.switchState(new CreditsState());
                    case 'playNow':
						PlayState.SONG = backend.Song.loadFromJson("bop-city", "bop-city");
						MusicBeatState.switchState(new PlayState());
                    case 'options':MusicBeatState.switchState(new options.OptionsState());
                    case 'die':
                        final prevSize = [s.width,s.height];
                        s.loadGraphic(Paths.image('menu/die2'));
                        s.setGraphicSize(prevSize[0],prevSize[1]);
                        s.updateHitbox();
                        bg.visible = false;
                        for (i in buttons) {
                            i.velocity.set();
                            i.alpha = 0;
                        }
						FlxG.sound.music.stop();
                        FlxTween.shake(s,0.025,Paths.sound('closegame').length/1000);

						FlxTween.tween(s, {'scale.x': FlxG.width / s.frameWidth, 'scale.y': FlxG.height/ s.frameHeight},Paths.sound('closegame').length/1000);
                        s.alpha =1;
						s.setColorTransform();
						s.color = FlxColor.RED;
                        FlxG.camera.flash();
                        (FlxG.sound.play(Paths.sound('closegame')).play()).onComplete = ()->{Sys.exit(0);}
						

                }
                

            },null,(o:FlxSprite)->{
                o.setColorTransform(1,1,1,1,255);

            },(o:FlxSprite)->{
                o.setColorTransform(1,1,1,1);

            },false,true,false);
        }
    }

    var penkaruTimeout:Float = 0;
    var penkaru = '';
	override function update(elapsed:Float)
	{
        penkaruTimeout+=elapsed;
        if (penkaruTimeout >= 1) penkaru = '';

        final keycode = FlxG.keys.firstJustPressed();
        if (keycode != -1) {
            penkaruTimeout = 0;
            penkaru += InputFormatter.getKeyName(keycode);
            if (penkaru == 'PENKARU') {
                Misc.isPenthosUnlocked = true;
                FlxG.camera.visible = false;
                FlxG.sound.music.volume = 0;

                Difficulty.resetList();
                var songLowercase:String = Paths.formatToSongPath('yo');
                var formatted:String = backend.Highscore.formatSong(songLowercase, 1);
     
                PlayState.SONG = backend.Song.loadFromJson(formatted, songLowercase);
                PlayState.isStoryMode = false;
                PlayState.storyDifficulty = 1;


                LoadingState.loadAndSwitchState(new PlayState());

            }



        }

	
		super.update(elapsed);

		for (i in buttons) {
			FlxG.collide(i,walls);
		}
	}


}


class MenuSrp extends FlxSprite {public var name:String = '';}