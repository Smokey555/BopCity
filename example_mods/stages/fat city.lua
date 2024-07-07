local ongay = false

function onCreate()
    makeLuaSprite("bg",'bg/fat/blue', -745,-250)
    addLuaSprite("bg")
    setScrollFactor('bg', 1.5, 1);
    scaleObject('bg', 1.1, 1);
    makeLuaSprite("plane",'bg/fat/plane', 10000 , 200)
    addLuaSprite("plane")
    makeLuaSprite("birds",'bg/fat/birds',1000, 30)
    addLuaSprite("birds")
    setScrollFactor('birds', 1.2, 1);
    makeLuaSprite("sun",'bg/fat/sun', -300, 0)
    addLuaSprite("sun")

    makeLuaSprite("city",'bg/fat/city',  -980,150)
    addLuaSprite("city")
    setScrollFactor('city', 1.3, 1);
    scaleObject('city', 1.5, 1);

    makeLuaSprite("grass",'bg/fat/grass',  -845,550)
    addLuaSprite("grass")
    scaleObject('grass', 1.2, 1);

    makeLuaSprite("cloud 1",'bg/fat/cloud 1',1000, -230)
    addLuaSprite("cloud 1")
    setScrollFactor('cloud 1', 1.21, 1);

    makeLuaSprite("cloud 2",'bg/fat/cloud 2', -450, 30)
    addLuaSprite("cloud 2")
    setScrollFactor('cloud 2', 1.2, 1);
end

function onCreatePost()
    setProperty("showRating", false)
	setProperty("showCombo", false)
	setProperty('comboGroup.visible', false)
end


function onSectionHit()

    if getRandomBool(500) then
    plane()
    end
end

function plane()
    doTweenX('plane','plane',-2150,5.4,'sineOut')
end

---
--- @param elapsed float
---
function onUpdate(elapsed)

    if ongay == true then
        triggerEvent("Camera Follow Pos", 0, 280)
        setProperty('defaultCamZoom', 3)
        setProperty('camGame.zoom', 3)
    else
        triggerEvent("Camera Follow Pos", 640, 480)
        setProperty('defaultCamZoom', 0.58)
        setProperty('camGame.zoom', 0.58)
    end

    setProperty('camZooming', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('healthBar.alpha', 0)
    setProperty('iconP1.alpha', 0)
    setProperty('iconP2.alpha', 0)
    setProperty('timeBar.alpha', 0)
    setProperty('timeTxt.alpha', 0)    
end

---
--- @param eventName string
--- @param value1 string
--- @param value2 string
--- @param strumTime float
---
function onEvent(eventName, value1, value2, strumTime)
    if eventName == "fly" then
        makeLuaSprite("fly",'mothersday', 0, 0)
        addLuaSprite("fly", true)
        scaleLuaSprite("fly", 3, 3)
        updateHitbox("fly")
        screenCenter("fly", "xy")
        setScrollFactor('fly', 0, 0);
        doTweenAlpha("flyTwe", "fly", 0,0.5, "")
    end

    if eventName == "fatgaze" then
        ongay = true
    end
end




