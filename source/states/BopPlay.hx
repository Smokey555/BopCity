package states;

import objects.HealthIcon;
import backend.Song;
import backend.Highscore;
import backend.WeekData;



class BopPlay extends MusicBeatState
{
    var songs:Array<SongMeta> = [];
    var portraits:FlxSpriteGroup;
    var songTextList:FlxSpriteGroup;

    var songTxt:FlxText;
    var songTxtIcon:HealthIcon;

    static var curSel:Int = 0;

    var penthosChant:FlxSound;
    var penthosScare:FlxSprite;

    //i wanted to test smth
    //because flxtext kinda sucks i thought this could work better and it actually does wow
    var cachedTextGraphics:Map<String,flixel.graphics.FlxGraphic> = new Map();


    var controlLock:Bool = false;
    
    

    override function create() {

        persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);
        Difficulty.resetList();

		#if DISCORD_ALLOWED
		DiscordClient.changePresence("In the Menus", null);
		#end

        initBG();

		for (i in 0...WeekData.weeksList.length) {

			var curWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);

			WeekData.setDirectoryFromWeek(curWeek);
			for (song in curWeek.songs)
			{
                if (song[0] == 'yo' && !Misc.isPenthosUnlocked) continue;
                if (song[0] == 'piracy' && !Misc.piratedTheGame) continue;
                songs.push({
                    SN: song[0],
                    icon: song[1],
                    week: i,
                    dir: Mods.currentModDirectory
                });
			}
		}
		Mods.loadTopMod();

        
        penthosChant = new FlxSound().loadEmbedded(flixel.system.FlxAssets.getSound('assets/sounds/chat'),true);
        FlxG.sound.list.add(penthosChant);
        penthosChant.play();
        penthosChant.volume = 0;
        FlxG.signals.preStateSwitch.addOnce(()->{if (FlxG.sound.music != null && !FlxG.sound.music.playing) FlxG.sound.music.resume();penthosChant.fadeTween?.cancel();});




        portraits = new FlxSpriteGroup();
        add(portraits);

        songTextList = new FlxSpriteGroup();
        add(songTextList);

        generateList();

        penthosScare = new FlxSprite(120).loadGraphic(Paths.image('menu/fp/penscare'));
        penthosScare.scale.set(0.7,0.7);
        add(penthosScare);
        penthosScare.alpha = 0;
        

        super.create();



    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (!controlLock) {
            if (controls.BACK) MusicBeatState.switchState(new MainMenuState());
            if (controls.UI_DOWN_P || controls.UI_UP_P) changeSel(controls.UI_DOWN_P ? 1 : -1);
            if (controls.ACCEPT) {
                if (songs[curSel].SN == 'yo') penIntro();
                else load();
            }
            if(controls.RESET)
            {
                persistentUpdate = false;
                openSubState(new substates.ResetScoreSubState(songs[curSel].SN, 1, songs[curSel].icon));
                FlxG.sound.play(Paths.sound('scrollMenu'));
            }
            if(FlxG.keys.justPressed.CONTROL)
            {
                persistentUpdate = false;
                openSubState(new substates.GameplayChangersSubstate());
            }
        }

    }
    function penIntro() {
        controlLock = true;
        penthosScare.alpha = 1;
        new FlxTimer().start(0.5,Void->load());

    }
    function load() {
        persistentUpdate = false;
        var songLowercase:String = Paths.formatToSongPath(songs[curSel].SN);
        var formatted:String = Highscore.formatSong(songLowercase, 1);
        try
        {
            PlayState.SONG = Song.loadFromJson(formatted, songLowercase);
            PlayState.isStoryMode = false;
            PlayState.storyDifficulty = 1;
        }
        catch(e:Dynamic)
        {
            trace('ERROR! $e');

            var errorStr:String = e.toString();
            if(errorStr.startsWith('[file_contents,assets/data/')) errorStr = 'Missing file: ' + errorStr.substring(34, errorStr.length-1); //Missing chart
            FlxG.sound.play(Paths.sound('cancelMenu'));
            return;
        }

        LoadingState.loadAndSwitchState(new PlayState());

        FlxG.sound.music.volume = 0;
                
    }

    function changeSel(id:Int = 0) {

        if (id != 0) FlxG.sound.play(Paths.sound('scrollMenu'));



        portraits.members[curSel].alpha = 0.001;
        curSel = FlxMath.wrap(curSel + id,0,songs.length-1);
        portraits.members[curSel].alpha = 1;

        songTxt.loadGraphic(cachedTextGraphics.get(songs[curSel].SN));
        songTxt.x =  portraits.members[curSel].x + (portraits.members[curSel].width - songTxt.width)/2;

        songTxtIcon.changeIcon(songs[curSel].icon);
        songTxtIcon.update(FlxG.elapsed); //spr tracker bugs out for a sec so

        for (k=>i in songTextList.members)
        {
            var fo = cast(i,FPText);
            fo.targetY = k - curSel;
            fo.sc = k == curSel ? 1.2 : 1;
        }

        FlxTween.cancelTweensOf(songTxt);
        penthosChant.fadeTween?.cancel();

        var isPenthos = songs[curSel].SN == 'yo';
        if (isPenthos) {
            FlxTween.shake(songTxt,0.005,0.5,{type: PINGPONG});
            penthosChant.fadeIn(5,0,0.4);

            if (FlxG.sound.music.playing) FlxG.sound.music.pause();
        }
        else {
            penthosChant.volume = 0;
            if (!FlxG.sound.music.playing) FlxG.sound.music.resume();
        }

        for (i in bgs) i.visible = !isPenthos;
        songTxtIcon.visible = !isPenthos;

    }

    function generateList() {

        final baseSize = 500;
        final thickness = 20;
        for (k=>i in songs) {
            var spr = new FlxSprite().loadGraphic(Paths.image('menu/fp/p/${i.SN}'));
            // if (spr.graphic == null) {
            //     spr.frames = Paths.getSparrowAtlas('menu/fp/p/blank');
            //     spr.animation.addByPrefix('i','i');
            //     spr.animation.play('i');
            // }

            spr.setGraphicSize(baseSize,baseSize);
            spr.updateHitbox();
            // spr.screenCenter();
            // spr.x = ((FlxG.width/2) - spr.width) / 2;
            spr.x = 30;
            spr.y = 30;
            spr.alpha = 0;
            add(spr);
            portraits.add(spr);

            var songText:FPText = new FPText(800, 320, i.SN.replace('-',' '));
			songText.targetY = k;
            songTextList.add(songText);
            songText.snapToPosition();


            cachedTextGraphics.set(i.SN,songText.graphic);

        }
        var frame = new FlxSprite().makeGraphic(1,1,FlxColor.BLACK);
        frame.scale.set(baseSize + thickness,baseSize + thickness);
        frame.updateHitbox();
        frame.x = portraits.members[0].x - thickness/2;
        frame.y = portraits.members[0].y - thickness/2;
        insert(members.indexOf(portraits),frame);

        songTxt = new FlxText(0,0,0,'penis',48);
        songTxt.font = Paths.font('papyrus.ttf');
        songTxt.updateHitbox();
        add(songTxt);

        songTxt.y = portraits.members[curSel].y + portraits.members[curSel].height + 10;
        songTxtIcon = new HealthIcon(songs[curSel].icon);
        songTxtIcon.scale.set(0.5,0.5);
        songTxtIcon.updateHitbox();
        songTxtIcon.xyOffset[0]/=2;
        add(songTxtIcon);
        songTxtIcon.sprTracker = songTxt;



        changeSel();

    }

    var bgs:FlxSpriteGroup;
    function initBG() 
    {
        bgs = new FlxSpriteGroup();
        add(bgs);

        var exclude:Array<Int> = [];
        var nums:Array<Int> = [];

        for (i in 0...4) {
            nums.push(FlxG.random.int(1,3,exclude));
            exclude.push(i);
        }

        trace(nums);
        for (i in nums) {
            var b = new FlxSprite().loadGraphic(Paths.image('menu/fp/$i'));
            b.setGraphicSize(FlxG.width,FlxG.height);
            b.updateHitbox();
            bgs.add(b);
            b.alpha = 0;
            b.ID = i-1;
            b.scale.scale(2);
           // b.shader = new BlurShader();
        }

        final isX = FlxG.random.bool(30);
        final dirL = FlxG.random.bool(30);

        var obj = bgs.members[FlxG.random.int(0,bgs.members.length-1)];
        obj.alpha = 0.3;
        FlxTween.tween(obj, {x: isX ? dirL ? -200 : 200 : 0,y: isX ? 0 : dirL ? 200 : -200},5, {onComplete: Void->{ bgComplete(obj.ID,obj);}});


        
    }

    var bgTweens:Array<FlxTween> = []; //i forgot why i did this
    final t:Float = 0.7;

    function bgComplete(bgID:Int,prevOBJ:FlxSprite) {
        while (bgTweens.length > 0) bgTweens.pop();

        var nextOBJ = bgs.members[FlxG.random.int(0,bgs.members.length-1,[bgID])];
        var lastOBJ = prevOBJ;

        final isX = FlxG.random.bool(50);
        final dirL = FlxG.random.bool(30);
        bgTweens.push(FlxTween.tween(lastOBJ, {alpha: 0},t,{onComplete: Void->{lastOBJ.setPosition();}}));

        bgTweens.push(FlxTween.tween(nextOBJ, {alpha: 0.3},t));
        bgTweens.push(FlxTween.tween(nextOBJ, {x: isX ? dirL ? -200 : 200 : 0,y: isX ? 0 : dirL ? 200 : -200},5, {onComplete: Void->{bgComplete(nextOBJ.ID,nextOBJ);}}));

    }


}


typedef SongMeta = {SN:String,week:Int,dir:String,icon:String}



class BlurShader extends flixel.system.FlxAssets.FlxShader
{
    @:glFragmentSource('
    #pragma header
    //https://www.shadertoy.com/view/Xltfzj

    void main()
    {
        float Pi = 6.28318530718; // Pi*2
        
        // GAUSSIAN BLUR SETTINGS {{{
        float Directions = 16.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
        float Quality = 3.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
        float Size = 8.0; // BLUR SIZE (Radius)
        // GAUSSIAN BLUR SETTINGS }}}
    
        vec2 Radius = Size/openfl_TextureSize.xy;
        
        // Normalized pixel coordinates (from 0 to 1)
        vec2 uv = openfl_TextureCoordv.xy;
        // Pixel colour
        vec4 Color = flixel_texture2D(bitmap, uv);
        
        // Blur calculations
        for( float d=0.0; d<Pi; d+=Pi/Directions)
        {
            for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
            {
                Color += flixel_texture2D(bitmap, uv+vec2(cos(d),sin(d))*Radius*i);		
            }
        }
        
        // Output to screen
        Color /= Quality * Directions - 15.0;
        gl_FragColor =  Color;
    }

    ')
    public function new()
    {
        super();
    }

}


class FPText extends FlxText
{

	public var targetY:Int = 0;

	public var distancePerItem:FlxPoint = new FlxPoint(20, 120);
	public var startPosition:FlxPoint = new FlxPoint(0, 0); //for the calculations

    public var sc:Float = 1;

    public function new(x:Float=0,y:Float=0,e:String = '') {
        super(x,y,0,e,48);
        font = Paths.font('papyrus.ttf');
        updateHitbox();
        startPosition.set(x,y);
    }

    override function update(elapsed:Float)
    {

        var lerpVal:Float = Math.exp(-elapsed * 9.6);
        y = FlxMath.lerp((targetY * 1.3 * distancePerItem.y) + startPosition.y, y, lerpVal);

        final s = FlxMath.lerp(sc,scale.x, lerpVal);
        scale.set(s,s);

        super.update(elapsed);
    }

    public function snapToPosition()
    {
        y = (targetY * 1.3 * distancePerItem.y) + startPosition.y;
    }

}