function onCreate()

    
    makeLuaSprite("bg",'bg/bop/blue', -745,-250)
    addLuaSprite("bg")
    setScrollFactor('bg', 1.5, 1);
    scaleObject('bg', 1.1, 1);
    makeLuaSprite("plane",'bg/bop/plane', 10000 , 200)
    addLuaSprite("plane")
    makeLuaSprite("birds",'bg/bop/birds',1000, 30)
    addLuaSprite("birds")
    setScrollFactor('birds', 1.2, 1);
    makeLuaSprite("sun",'bg/bop/sun', -300, 0)
    addLuaSprite("sun")

    makeLuaSprite("viginette",'bg/bop/viginette')
    addLuaSprite("viginette")
    setObjectCamera("viginette", "other")
    setProperty('viginette.alpha', tonumber(0))

    makeLuaSprite("city",'bg/bop/city',  -980,150)
    addLuaSprite("city")
    setScrollFactor('city', 1.3, 1);
    scaleObject('city', 1.5, 1);

    makeLuaSprite("grass",'bg/bop/grass',  -845,550)
    addLuaSprite("grass")
    scaleObject('grass', 1.2, 1);

    makeLuaSprite("cloud 1",'bg/bop/cloud 1',1000, -230)
    addLuaSprite("cloud 1")
    setScrollFactor('cloud 1', 1.21, 1);

    makeLuaSprite("cloud 2",'bg/bop/cloud 2', -450, 30)
    addLuaSprite("cloud 2")
    setScrollFactor('cloud 2', 1.2, 1);

    
    makeLuaSprite("black", nil)
    makeGraphic("black", 1280 , 720 , "000000")
    addLuaSprite("black", true)
    setObjectCamera("black", "other")
    setProperty('black.alpha', tonumber(0))

end


function onSectionHit()

    if getRandomBool(500) then
    plane()
    end
end

function plane()
    doTweenX('plane','plane',-2150,5.4,'sineOut')
end



function onStepHit()
    
    if curStep == 240 then
        doTweenAlpha('viginette','viginette',1,23)

    elseif curStep == 478 then
        doTweenAlpha('viginette','viginette',0,1.5)

    elseif curStep == 517 then
         doTweenAlpha('viginette','viginette',1,20)
     
    elseif curStep == 744 then
        doTweenAlpha('black','black',1,0.01)

    elseif curStep == 747 then
        doTweenAlpha('viginette','viginette',0,0.01)
        setProperty('dad.alpha', tonumber(0))

    elseif curStep == 768 then
        doTweenAlpha('black','black',0,0.01)
    end
end
