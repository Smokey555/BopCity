function onCreate()
    setProperty("skipCountdown", true)

    makeLuaSprite("bg", nil, -600, -300)
    makeGraphic("bg", 2500, 1400, "FFFFFF")
    addLuaSprite("bg", false)

    makeAnimatedLuaSprite('rain', 'bg/pibby/rain', -900, -200)
    addAnimationByPrefix('rain', 'rain', 'rain', 24, true)
	addLuaSprite('rain', true)
	scaleObject("rain", 5.5, 3.5)
	setProperty('rain.alpha', tonumber(0))
    setObjectCamera("rain", "other")

    makeAnimatedLuaSprite('crash', 'bg/pibby/crash', -5, 200)
	addAnimationByPrefix('crash', 'crash', 'crash', 24, true)
	addLuaSprite('crash', true)
	scaleObject("crash", 2.5, 2.5)
	setProperty('crash.alpha', tonumber(0))
    setObjectCamera("crash", "other")


end

function onStepHit()
    if curStep == 218 then
        doTweenAlpha('rain', 'rain', 0.2, 3)
    elseif curStep == 471 then
            doTweenAlpha('crash', 'crash', 1, 0.01)
            objectPlayAnimation('crash', 'crash', true)
    end
end
