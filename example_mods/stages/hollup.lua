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
end


function onSectionHit()

    if getRandomBool(500) then
    plane()
    end
end

function plane()
    doTweenX('plane','plane',-2150,5.4,'sineOut')
end

function onBeatHit()
    if curBeat == 157 then  
    runHaxeCode([[
        game.gf.cameras = [game.camOther];
        ]]) 
    elseif curBeat == 158 then  
        doTweenX('ben', 'gf', 5, 1.4, 'sineOut')

    elseif curBeat == 224 then  
        doTweenX('ben', 'gf', -420, 2, 'sineOut')
    end 
end 