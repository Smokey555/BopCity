import flixel.tweens.FlxEase;
import openfl.filters.ShaderFilter;
import psychlua.LuaUtils;
import flixel.FlxSprite;



var thickness = 80;

var directory = 'bg/penthos/';

var newWidth = FlxG.width * 1.25;
var newHeight = FlxG.height * 1.25;
var offsetX = (FlxG.width-newWidth)/2;
var offsetY = (FlxG.height-newHeight)/2;

var allowedRotation:Bool = false;
var desiredAngle:Float = 0;
function setRotation(v) {
    allowedRotation = v; 
    if (!v) {
        desiredAngle = 0;
        FlxTween.cancelTweensOf(FlxG.camera, ['angle']);
        FlxTween.tween(FlxG.camera, {angle: 0},0.25,{ease: FlxEase.backOut});
    }
}

function init() {
    game.skipCountdown = true;
    // FlxG.camera.setSize(newWidth,newHeight);
    // FlxG.camera.x += offsetX;
    // FlxG.camera.y += offsetY;
}


var b_up;
var b_down;
var video;


var zoomTween:FlxTween;
var penShader;

var heStares;


var goodIntro;
var badIntro;


var penthosDance;



function onCreate() {
    init();

    goodIntro = new FlxSprite().loadGraphic(pImage('bop'));
    add(goodIntro);
    goodIntro.cameras = [camOther];
    goodIntro.scale.set(0.5,0.5);
    goodIntro.alpha = 0;

    badIntro = new FlxSprite().loadGraphic(pImage('evil'));
    add(badIntro);
    badIntro.cameras = [camOther];
    badIntro.scale.set(0.5,0.5);
    badIntro.alpha = 0;

    camOther.bgColor = FlxColor.BLACK;
    


    var red = new FlxSprite(-900,-1550).loadGraphic(pImage('red'));
    red.scale.set(0.7,0.7);
    red.updateHitbox();
    addBehindDad(red);


    var particles = new FlxSprite(-300,50);
    particles.frames = pFrames('fireparticles');
    particles.animation.addByPrefix('i','burn',20);
    particles.animation.play('i');
    particles.scale.set(3,3);
    particles.updateHitbox();
    particles.alpha = 0.6;
    addBehindDad(particles);
    particles.blend = BlendMode.SCREEN;

    var particles = new FlxSprite(1000,-50);
    particles.frames = pFrames('fireparticles');
    particles.animation.addByPrefix('i','burn',24);
    particles.animation.play('i');
    particles.scale.set(3.5,3.5);
    particles.updateHitbox();
    particles.alpha = 0.4;
    addBehindDad(particles);
    particles.blend = BlendMode.SCREEN;

    var particles = new FlxSprite( -100,-350);
    particles.frames = pFrames('fireparticles');
    particles.animation.addByPrefix('i','burn',22);
    particles.animation.play('i');
    particles.scale.set(3.5,3.5);
    particles.updateHitbox();
    particles.alpha = 0.2;
    particles.flipX = true;
    addBehindDad(particles);
    particles.blend = BlendMode.SCREEN;

    var staticFilter = new FlxSprite(-800,-750);
    staticFilter.frames = pFrames('statid');
    staticFilter.animation.addByPrefix('i','idle',22);
    staticFilter.animation.play('i');
    staticFilter.scale.set(3.5,3);
    staticFilter.updateHitbox();
    staticFilter.alpha = 0.07;
    staticFilter.flipX = true;
    addBehindDad(staticFilter);
    staticFilter.blend = BlendMode.DIFFERENCE;


    heStares = new FlxSprite(900,800);
    heStares.frames = pFrames('penhead');
    heStares.animation.addByPrefix('L','look1',24,false);
    heStares.animation.addByPrefix('R','look2',24,false);
    heStares.animation.play('L');
    addBehindDad(heStares);

    var stage = new FlxSprite( -600,-50).loadGraphic(pImage('stage'));
    stage.scale.set(0.7,0.7);
    stage.updateHitbox();
    addBehindDad(stage);

    var chari = new FlxSprite(-50,-50).loadGraphic(pImage('chair'));
    chari.scale.set(0.7,0.7);
    chari.updateHitbox();
    addBehindDad(chari);
    FlxTween.tween(chari, {y: -75, angle: 3}, 1.67,{ease: FlxEase.sineInOut,type: FlxTweenType.PINGPONG});

    var table = new FlxSprite(1500,-50).loadGraphic(pImage('table'));
    table.scale.set(0.7,0.7);
    table.updateHitbox();
    addBehindDad(table);
    FlxTween.tween(table, {y: -75, angle: -2}, 2.5,{startDelay: 1.2, ease: FlxEase.sineInOut,type: FlxTweenType.PINGPONG});

    
    var sans = new FlxSprite(2000,250).loadGraphic(pImage('mask'));
    sans.scale.set(0.7,0.7);
    sans.updateHitbox();
    addBehindDad(sans);
    FlxTween.tween(sans, {y: 300, angle: -2}, 4,{ease: FlxEase.sineInOut,type: FlxTweenType.PINGPONG});

    var particles = new FlxSprite(800,550);
    particles.frames = pFrames('fireparticles');
    particles.animation.addByPrefix('i','burn',20);
    particles.animation.play('i');
    particles.scale.set(4,4);
    particles.updateHitbox();
    particles.alpha = 0.4;
    add(particles);
    particles.blend = BlendMode.SCREEN;


    var particles = new FlxSprite(-400,650);
    particles.frames = pFrames('fireparticles');
    particles.animation.addByPrefix('i','burn',20);
    particles.animation.play('i');
    particles.scale.set(4,4);
    particles.updateHitbox();
    particles.alpha = 0.7;
    add(particles);
    particles.blend = BlendMode.SCREEN;

    var particles = new FlxSprite( -900,530);
    particles.frames = pFrames('fireparticles');
    particles.animation.addByPrefix('i','burn',21);
    particles.animation.play('i');
    particles.scale.set(4,4);
    particles.updateHitbox();
    particles.alpha = 0.7;
    add(particles);
    particles.blend = BlendMode.SCREEN;

    var staticFilter = new FlxSprite(-800,-750);
    staticFilter.frames = pFrames('statid');
    staticFilter.animation.addByPrefix('i','idle',22);
    staticFilter.animation.play('i');
    staticFilter.scale.set(3.5,3);
    staticFilter.updateHitbox();
    staticFilter.alpha = 0.04;
    staticFilter.flipX = true;
    add(staticFilter);
    staticFilter.blend = BlendMode.DIFFERENCE;

    




    b_up = new FlxSprite().makeGraphic(FlxG.width,thickness,FlxColor.BLACK);
    b_up.cameras = [game.camHUD];
    addBehindDad(b_up);

    b_down = new FlxSprite(0,FlxG.height -thickness).makeGraphic(FlxG.width,thickness,FlxColor.BLACK);
    b_down.cameras = [game.camHUD];
    addBehindDad(b_down);

}

function onCreatePost() {

    penthosDance = new FlxSprite();
    penthosDance.frames = pFrames('IShowIndie');
    penthosDance.animation.addByPrefix('i','bounce',54);
    penthosDance.animation.play('i');
    penthosDance.scale.set(2.8,2.8);
    penthosDance.updateHitbox();
    addBehindDad(penthosDance);
    penthosDance.setPosition(dad.x + 85,dad.y + 25);
    penthosDance.alpha = 0;
    //dad.alpha = 0;

    video = new VideoSprite();
    video.addCallback('onFormat',()->{
        video.setGraphicSize(0,FlxG.height);
        video.updateHitbox();
        video.cameras = [game.camOther];
        FlxG.camera.visible = false;
    });
    video.addCallback('onEnd',()->{
        FlxG.camera.flash(FlxColor.BLACK);
        FlxG.camera.zoom -= 0.25;
        FlxG.camera.visible = true;
        FlxTween.num(1,1.25,2, {},(f)->penShader.setFloat('contrast',f));
    });
    video.load('aethospen.mp4',[VideoSprite.muted]);
    add(video);
    VideoSprite.cacheVid('aethospen.mp4');



    camHUD.alpha = 0;

    penShader = game.createRuntimeShader('tvStatic');
    penShader.setFloat('offset',0.0025);
    penShader.setFloat('strengthMulti',0.5);
    penShader.setFloat('contrast',1);
    penShader.setFloat('darkness',0);
    FlxG.camera.filters = [new ShaderFilter(penShader)];
}

function onDestroy() {
    if (video != null) video.destroy();
}

var timer = 0;
function onUpdatePost(elapsed) {
    timer+=elapsed;
    penShader.setFloat('iTime',timer);
    if (allowedRotation) {
        if (curSection > 0)
            FlxG.camera.angle = FlxMath.lerp(FlxG.camera.angle,desiredAngle,1 - Math.exp(-elapsed * 2.4 * game.cameraSpeed * game.playbackRate));
    }

    penShader.setFloat('offset',FlxG.random.float(0.0015,0.0035));

   // setZoom(0.3);
}

function onSongStart() {
    FlxTween.tween(goodIntro, {alpha: 1},2, {startDelay: 1});
}


function onBeatHit() {
    if (penthosDance.alpha == 1) penthosDance.animation.play('i',true);
}

function onMoveCamera(char) {
    var isDad = (char == 'dad');
  //  game.defaultCamZoomMult = (isDad ? 1.2 : 1);
    if (allowedRotation) desiredAngle = (isDad ? -2 : 2);
    heStares.animation.play(isDad ? 'L' : 'R');
}

function onEvent(ev,v1,v2) {
    if (ev == '') {
        switch (v1) {
            case 'chat':
                penthosDance.alpha = penthosDance.alpha == 0 ? 1 : 0;
                dad.alpha = dad.alpha == 0 ? 1 : 0;
            case 'badFade':
                FlxTween.tween(goodIntro, {alpha: 0},1.5);
                FlxTween.tween(badIntro, {alpha: 1},1.5);
            case 'introfade':
                game.isCameraOnForcedPos = true;
                setZoom(1);
                var x = dad.getMidpoint().x + 150 + (dad.cameraPosition[0] + game.opponentCameraOffset[0]);
                var y = dad.getMidpoint().y - 100 + (dad.cameraPosition[1] + game.opponentCameraOffset[1]);
                x += -200;
                game.camFollow.setPosition(x,y - 200);
                FlxG.camera.snapToTarget();
                FlxTween.tween(camFollow, {y: y},5.14, {ease: FlxEase.cubeInOut});

                onEvent('hummusZoom','0.6,5.14','cubeInOut');
                FlxG.camera.fade(FlxColor.BLACK,5.14,true);
            case 'introApp':
                FlxTween.cancelTweensOf(badIntro, ['alpha']);
                FlxTween.cancelTweensOf(goodIntro, ['alpha']);
                badIntro.alpha = 0;
                goodIntro.alpha = 0;
                camOther.bgColor = 0x0;

                game.isCameraOnForcedPos = false;
                camHUD.alpha = 1;
                camHUD.zoom = 2;
                setRotation(true);
            case 'video':
                video.play();
            case 'headPea':
                onEvent('hummusZoom','0.5,2.54','cubeInOut');

                FlxTween.tween(heStares, {y:- 300},1.7, {ease: FlxEase.backOut,onComplete:Void->{
                    FlxTween.tween(heStares, {y: -275}, 2,{ease: FlxEase.sineInOut,type: FlxTweenType.PINGPONG});
                }});
        }
    }
    if (ev == 'hummusZoom') {
        if (zoomTween != null) zoomTween.cancel();

        var splitV1 = v1.split(',');
        var data = {
            val: Std.parseFloat(splitV1[0]),
            time: Std.parseFloat(splitV1[1]),
            ease: LuaUtils.getTweenEaseByString(v2)
        }

        zoomTween = FlxTween.num(FlxG.camera.zoom,data.val,data.time, {ease: data.ease, onComplete: Void->{game.camZooming=true;}},(f)->{
            game.defaultCamZoom = f;
            FlxG.camera.zoom = f;
            game.camZooming = false;
        });

    }
    
}

function setZoom(v) {
    game.defaultCamZoom = FlxG.camera.zoom = v;
}

function pImage(path:String) {
    return Paths.image(directory + path);
}
function pFrames(path:String) {
    return Paths.getSparrowAtlas(directory + path);
}