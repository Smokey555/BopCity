import objects.VideoSprite;
import flixel.sound.FlxSound;
import backend.Conductor;
import flixel.FlxSprite;
import Misc;

var bg;
var jump;
var leavenow;
var leaveJ;
var evilmode;
var leaveFinal;

var jumpSound;
function onCreate() {
    
    bg = new FlxSprite(-200,-50).loadGraphic(Paths.image('bg/jump/bg'));
    bg.scale.set(0.8,0.8);
    bg.updateHitbox();
    addBehindDad(bg);
    bg.alpha= 0;

    evilmode = new FlxSprite(75,500).loadGraphic(Paths.image('bg/jump/evilmode'));
    evilmode.updateHitbox();
    add(evilmode);
    evilmode.alpha= 0;


   leavenow = new FlxSprite(bg.x,bg.y).loadGraphic(Paths.image('bg/jump/leave2'));
   addBehindDad(leavenow);
   leavenow.setGraphicSize(bg.width,bg.height);
   leavenow.updateHitbox();
   leavenow.alpha = 0;


   leaveFinal = new FlxSprite().loadGraphic(Paths.image('bg/jump/leaveFinalChace'));
   add(leaveFinal);
   leaveFinal.setGraphicSize(FlxG.width,FlxG.height);
   leaveFinal.updateHitbox();
   leaveFinal.alpha = 0;
   leaveFinal.cameras = [camOther];

   leaveJ = new FlxSprite().loadGraphic(Paths.image('bg/jump/leave'));
   add(leaveJ);
   leaveJ.setGraphicSize(FlxG.width,FlxG.height);
   leaveJ.updateHitbox();
   leaveJ.alpha = 0;
   leaveJ.cameras = [camOther];

    jump = new VideoSprite();
    jump.addCallback('onFormat',()->{
        jump.setGraphicSize(FlxG.with,FlxG.height);
        jump.updateHitbox();
        jump.cameras = [camOther];
    });
    jump.addCallback('onEnd',()->{
        camOther.bgColor = FlxColor.BLACK;
        Misc.crashGame();
    });
    jump.load('kaiscare.mp4',[VideoSprite.muted]);
    VideoSprite.cacheVid('kaiscare.mp4');
    addBehindDad(jump);
    
    jumpSound = new FlxSound().loadEmbedded(Paths.sound('jump'));
    FlxG.sound.list.add(jumpSound);


    onPauseSignal.add(()->{
        if (jumpSound.playing)
        jumpSound.pause();
    });
    onResumeSignal.add(()->{
        if (!jumpSound.playing)
            jumpSound.resume();
    });

}

function onDestroy() {
    if (jump != null) jump.destroy();
    if (FlxG.signals.focusLost.has(focusLock)) FlxG.signals.focusLost.remove(focusLock);
}

function focusLock() {
    FlxG.stage.window.focus();
}
function onSongStart() {
    game.songLength = 23000;
    
}
function onCreatePost() {
    if (!Misc.experiencedPiracy) {
        Misc.experiencedPiracy = true;
        game.canPause = false;
        game.cpuControlled = false;
        game.healthLoss = 0;
        FlxG.stage.window.fullscreen = false;
        FlxG.stage.window.borderless = true;
        FlxG.signals.focusLost.add(focusLock);
    }


}
var lockT:Bool = false;
var time:Float = 0;
var fakeTime;
function onUpdatePost(elapsed) {
    if (lockT) {
        var tempTime = time;
        tempTime+=FlxG.random.int(-3,3);
        Conductor.songPosition = tempTime;
        checkEventNote();
    }
    fakeTime = FlxG.sound.music.time;
}

function checkEventNote() {
    while(game.eventNotes.length > 0) {
        var leStrumTime:Float = game.eventNotes[0].strumTime;
        if(fakeTime < leStrumTime) {
            return;
        }

        var value1:String = '';
        if(game.eventNotes[0].value1 != null)
            value1 = game.eventNotes[0].value1;

        var value2:String = '';
        if(game.eventNotes[0].value2 != null)
            value2 = game.eventNotes[0].value2;

        game.triggerEvent(eventNotes[0].event, value1, value2, leStrumTime);
        game.eventNotes.shift();
    }
}

function onEvent(ev,v1,v2) {
    if (ev == '') {
        switch (v1) {
            case 'evil':
            evilmode.alpha = 1;
            dad.alpha = 0;
            camHUD.alpha = 0;
            game.cameraSpeed = 9999;
            case 'unlock':
                game.clearNotesBefore(time + 10000);
                lockT = false;
                for (i in game.opponentStrums) i.x = -1000;

            case 'lockConductor': 
                lockT = true;
                time = Conductor.songPosition;
            case 'cut':
                    camOther.bgColor = camOther.bgColor == FlxColor.BLACK ? 0x0 : FlxColor.BLACK;
            case 'pirate':
                FlxTween.tween(leaveJ, {alpha: 1},27.69 - 25.85);
                game.timeBar.visible = game.timeTxt.visible = false;
            case 'pirateL':
                leaveJ.alpha = 0;
            case 'pirateClose':
                leaveJ.scale.set(3.5,2);
                leaveJ.x = 1300;
                leaveJ.y = 50;
            case 'lastWarn':
                FlxTween.tween(leaveFinal, {alpha: 1},27.69 - 25.85);
            case 'finalLas':
                camOther.bgColor = 0x0;
                leaveFinal.alpha = 0;
            case 'gameOver':
                lockT = true;
                time = Conductor.songPosition;
                jumpSound.play();
                jump.visible = true;
                jump.play();

                FlxG.sound.music.onComplete = ()->{};
                FlxG.resizeWindow(FlxG.stage.fullScreenWidth,FlxG.stage.fullScreenHeight);
                FlxG.stage.window.x = 0;
                FlxG.stage.window.y = 0;

            case 'mute':
                FlxG.sound.music.volume = 0;
            case 'bg':

                game.iconP1.visible = false;
                game.iconP2.visible = false;
                game.healthBar.visible = false;
                camOther.bgColor = 0x0;
   

                leavenow.alpha = 0.5;
                bg.alpha = 0.5;

                // FlxTween.tween(bg, {alpha: 0.5},27.69 - 25.85);
                 //camOther.fade(FlxColor.BLACK,27.69 - 25.85,true);
            case 'jump':

                //jump.animation.play('i');
 
        }
    }
}