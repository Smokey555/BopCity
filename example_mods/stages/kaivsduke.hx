import flixel.FlxSprite;

var bg;
var jump;
var leavenow;
function onCreate() {
    bg = new FlxSprite(-200,-50).loadGraphic(Paths.image('bg/jump/bg'));
    bg.scale.set(0.8,0.8);
    bg.updateHitbox();
    addBehindDad(bg);
    bg.alpha= 0;

   leavenow = new FlxSprite(bg.x,bg.y).loadGraphic(Paths.image('bg/jump/leave2'));
   addBehindDad(leavenow);
   leavenow.setGraphicSize(bg.width,bg.height);
   leavenow.updateHitbox();
   leavenow.alpha = 0;

    jump = new FlxSprite();
    jump.frames = Paths.getSparrowAtlas('bg/jump/jumpscare');
    jump.animation.addByPrefix('i','scare',24,false);
    addBehindDad(jump);
    jump.setGraphicSize(FlxG.with,FlxG.height);
    jump.updateHitbox();
    jump.cameras = [camHUD];
    jump.animation.play('i');
    jump.visible = false;
    jump.animation.finishCallback = (s)->{
        jump.visible = false;
    }
}


function onCreatePost() {

}

function onEvent(ev,v1,v2) {
    if (ev == '') {
        switch (v1) {
            case 'bg':
                FlxTween.tween(bg, {alpha: 0.5},1, {onComplete:Void->{
                    leavenow.alpha = 1;
                }});
            case 'jump':
                jump.visible = true;

                jump.animation.play('i');
 
        }
    }
}