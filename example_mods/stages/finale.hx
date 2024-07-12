
import objects.VideoSprite;
import flixel.sound.FlxSound;
import backend.Conductor;
import flixel.FlxSprite;
import Misc;


var video;
var head;
function onCreate()
{
	game.camOffset = 15;
	video = new VideoSprite();
	video.addCallback('onFormat', () ->
	{
		video.setGraphicSize(FlxG.width, FlxG.height);
		video.updateHitbox();
		video.cameras = [camHUD];
		camOther.stopFade();
		camOther.fade(FlxColor.WHITE,0.5,true);
		game.showCombo = false;
		game.showComboNum = false;
		game.showRating = false;
	
	});
	video.addCallback('onEnd', () ->
	{
	});
	video.load('kaisupercutscene.mp4', [VideoSprite.muted]);
	addBehindDad(video);
	VideoSprite.cacheVid('kaisupercutscene.mp4');


}


function onCreatePost() {
	head = new FlxSprite(900,800);
	head.frames = Paths.getSparrowAtlas('bg/finale/headkai');
	head.animation.addByPrefix('i','idle',24);
	head.animation.addByPrefix('charge','charge0',24);
	head.animation.addByPrefix('chargeup','chargeup',24,false);
	head.animation.addByPrefix('appear','appearhead',24,false);
	head.animation.play('i');
	head.scale.set(0.9,0.9);
	head.updateHitbox();
	insert(members.indexOf(game.modchartSprites.get('memes'))+1,head);
	head.alpha = 0;


	head.animation.finishCallback = (s)->{
		if (s == 'appear') {
			head.animation.play('i');
		}
		if (s == 'chargeup') {
			head.animation.play('charge');
		}
	}
}

function initHead() {
	head.animation.play('appear');
	head.alpha = 1;
}

function onUpdatePost(elapsed) {

}

function onEvent(ev,v1,v2) {
    if (ev == '') {
        switch (v1) {
			case 'endeee':
				game.uiGroup.visible = false;
				for (i in game.playerStrums) i.x = -1000;

			case 'headpp':initHead();
		
			case 'headCharge': head.animation.play('chargeup');

			case 'fadeW':
				var t = 102.31 - 101.97;
				camOther.fade(FlxColor.WHITE,t);
			case 'myworld':
				FlxG.camera.shake(0.01,101.58 - 100.77);
			case 'zoomin':
				var time = 0.7;
				game.isCameraOnForcedPos = true;
				var x = boyfriend.getMidpoint().x - 100;
				x -=boyfriend.cameraPosition[0] - game.boyfriendCameraOffset[0];
				var y = boyfriend.getMidpoint().y - 100;
				y += boyfriend.cameraPosition[1] + game.boyfriendCameraOffset[1];
				
				game.camFollow.setPosition(x + 300,y + 200);

				FlxTween.num(game.defaultCamZoom, game.defaultCamZoom + 0.3,time,{ease: FlxEase.cubeOut},(f)->{
					FlxG.camera.zoom = f;
					game.defaultCamZoom = f;
				});

          case "cutscene":
            video.play();
 
        }
    }
}