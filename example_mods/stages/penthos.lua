local thickness = 80
local newWidth = screenWidth * 1.5
local newHeight = screenHeight * 1.5
local offsetX = (screenWidth-newWidth)/2
local offsetY = (screenHeight-newHeight)/2
local FILE_DIR = "bg/penthos/"



function onCreatePost()
	

	doTweenAlpha('GUItween1', 'camHUD', 0, 0.01, 'linear');
    setGlobalFromScript('scripts/neocam', 'freeze', true)
    setProperty('cameraSpeed', 200)
    doTweenZoom('f', 'camGame', 0.6, 1.8, 'backout')
    triggerEvent('Camera Follow Pos', '10100', '-550')
	setProperty('introart.alpha', tonumber(0))
	setProperty("camHUD.alpha", 0.0001)
end



function onCreate()
	setProperty("skipCountdown", true)

    runHaxeCode([[
        FlxG.camera.setSize(]]..newWidth..[[,]]..newHeight..[[);
        FlxG.camera.x += ]]..offsetX..[[;
        FlxG.camera.y += ]]..offsetY..[[;
    ]])

	makeLuaSprite('red','red', -900,-1550)
	addLuaSprite('red',false)
	scaleObject("red", 0.7, 0.7)


	makeAnimatedLuaSprite('fireparticles', 'bg/penthos/fireparticles', -300,50)
	addAnimationByPrefix('fireparticles', 'burn', 'burn', 20, true)
	addLuaSprite('fireparticles', false)
	scaleObject("fireparticles", 3, 3)
	setProperty('fireparticles.alpha', tonumber(0.6))

	makeAnimatedLuaSprite('fireparticles2', 'bg/penthos/fireparticles', 1000,-50)
	addAnimationByPrefix('fireparticles2', 'burn', 'burn', 24, true)
	addLuaSprite('fireparticles2', false)
	scaleObject("fireparticles2", 3.5, 3.5)
	setProperty('fireparticles2.alpha', tonumber(0.4))

	makeAnimatedLuaSprite('fireparticles3', 'bg/penthos/fireparticles', -100,-350)
	addAnimationByPrefix('fireparticles3', 'burn', 'burn', 22, true)
	addLuaSprite('fireparticles3', false)
	scaleObject("fireparticles3", 3.5, 3.5)
	setProperty('fireparticles3.alpha', tonumber(0.2))
	setProperty('fireparticles3.flipX', true) 

	makeAnimatedLuaSprite('statid', 'bg/penthos/statid', -800,-750)
	addAnimationByPrefix('statid', 'idle', 'idle', 22, true)
	addLuaSprite('statid', false)
	scaleObject("statid", 3.5, 3)
	setProperty('statid.alpha', tonumber(0.07))
	setProperty('statid.flipX', true) 

	setBlendMode('statid', 'difference')
	setBlendMode('fireparticles', 'screen')
	setBlendMode('fireparticles2', 'screen')
	setBlendMode('fireparticles3', 'screen')

	makeLuaSprite('stage','bg/penthos/stage', -600,-50)
	addLuaSprite('stage',false)
	scaleObject("stage", 0.7, 0.7)

	makeAnimatedLuaSprite('fireparticles4', 'bg/penthos/fireparticles', 800,550)
	addAnimationByPrefix('fireparticles4', 'burn', 'burn', 20, true)
	addLuaSprite('fireparticles4', true)
	scaleObject("fireparticles4", 4, 4)
	setProperty('fireparticles4.alpha', tonumber(0.4))

	makeAnimatedLuaSprite('fireparticles5', 'bg/penthos/fireparticles', -400,650)
	addAnimationByPrefix('fireparticles5', 'burn', 'burn', 20, true)
	addLuaSprite('fireparticles5', true)
	scaleObject("fireparticles5", 4, 4)
	setProperty('fireparticles5.alpha', tonumber(0.7))

	makeAnimatedLuaSprite('fireparticles6', 'bg/penthos/fireparticles', -900,530)
	addAnimationByPrefix('fireparticles6', 'burn', 'burn', 21, true)
	addLuaSprite('fireparticles6', true)
	scaleObject("fireparticles6", 4, 4)
	setProperty('fireparticles6.alpha', tonumber(0.7))



	makeAnimatedLuaSprite('statid2', 'bg/penthos/statid', -800,-750)
	addAnimationByPrefix('statid2', 'idle', 'idle', 22, true)
	addLuaSprite('statid2', true)
	scaleObject("statid2", 3.5, 3.5)
	setProperty('statid2.alpha', tonumber(0.04))
	setProperty('statid2.flipX', true) 

    makeLuaSprite("bar_upper", nil, 0, -thickness)
    makeGraphic("bar_upper", 1300, thickness, "000000")
    setObjectCamera("bar_upper", "hud")
    addLuaSprite("bar_upper", false)
    
    makeLuaSprite("bar_lower", nil, 0, 720)
    makeGraphic("bar_lower", 1300, thickness, "000000")
    setObjectCamera("bar_lower", "hud")
    addLuaSprite("bar_lower", false)
        

	

	setBlendMode('statid2', 'difference')
	setBlendMode('fireparticles4', 'screen')
	setBlendMode('fireparticles5', 'screen')
	setBlendMode('fireparticles6', 'screen')


end

function onStepHit()
    if curStep == 1 then
        setProperty('cameraSpeed', 0.8)
        doTweenZoom('f', 'camGame', 0.8, 2.5, 'backout')
    doTweenAlpha('ohmygodblack','bleck',0.01,3,'quartInOut')
    triggerEvent('Camera Follow Pos', '900', '75')

elseif curStep == 64 then
        doTweenY('pluhd!', 'camFollow', 160, 4.6, 'cubeInOut')
    
elseif curStep == 160 then
	setGlobalFromScript('scripts/neocam', 'freeze', false)
	triggerEvent('Camera Follow Pos', '', '')
	triggerEvent('defaultCamZoom', 0.6)
	
	elseif curStep == 175 then
		setProperty("camHUD.alpha", 10)
		doTweenAlpha('fade', 'red', 0, 0.7)
		doTweenY("bar_upper", "bar_upper", 0, 3, "quintout")
        doTweenY("bar_lower", "bar_lower", 720 - thickness, 3, "quintout")
	end
end

function onTweenCompleted(tag)
	if tag == 'fade' then
		doTweenAlpha('fade2', 'red', 1, 2)
    end

    if tag == 'fade2' then
		doTweenAlpha('fade', 'red', 0.2, 3)
    end
end


function onUpdate()
        if curStep > 175 then
	if mustHitSection then
		setProperty('defaultCamZoom', 0.74)
		doTweenAngle('tag', 'camGame', 3, 1, 10)

	else
		setProperty('defaultCamZoom', 0.53)
		doTweenAngle('tag', 'camGame', -2, 1, 10)
	end
	end
end

