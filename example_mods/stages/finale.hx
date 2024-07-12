package example_mods.stages;

import objects.VideoSprite;
import flixel.sound.FlxSound;
import backend.Conductor;
import flixel.FlxSprite;
import Misc;


var video;

function onCreate()
{
	video = new VideoSprite();
	video.addCallback('onFormat', () ->
	{
		video.setGraphicSize(FlxG.with, FlxG.height);
		video.updateHitbox();
		video.cameras = [camOther];
	});
	video.addCallback('onEnd', () ->
	{
	});
	video.load('kaisupercutscene.mp4', [VideoSprite.muted]);
	VideoSprite.cacheVid('kaisupercutscene.mp4');

}


function onEvent(ev,v1,v2) {
    if (ev == '') {
        switch (v1) {
          case "cutscene":
            video.play();
 
        }
    }
}