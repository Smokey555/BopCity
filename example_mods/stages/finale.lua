
local stopTweens = false
local startUpdate = false




function onCreate()
    makeLuaSprite("bg",'bg/finale/galaxy', -500,-250)
    addLuaSprite("bg")
    setScrollFactor('bg', 1, 1);
    scaleObject('bg', 1, 1);

    makeLuaSprite("bgrocks",'bg/finale/kaicenatBGrocks',  -180,550)
    addLuaSprite("bgrocks")
    setScrollFactor('bgrocks', 1, 0.8);
    scaleObject('bgrocks', 1, 1);

    makeLuaSprite("platform",'bg/finale/kaicenatrocks',  -145,250)
    addLuaSprite("platform")
    scaleObject('platform', 1.2, 1.2);

    makeLuaSprite("memes",'bg/finale/meme',  800,550)
    addLuaSprite("memes")
    scaleObject('memes', 0.3, 0.3);

    makeLuaSprite("overlay",'bg/finale/topgrad', -500,-250)
    addLuaSprite("overlay", true)
    setScrollFactor('overlay', 1, 1);
    scaleObject('overlay', 1, 1);
    setBlendMode('overlay', 'add')






end

function onCreatePost()
    doTweenAngle('memespin', 'memes', 50000, 1000, 'linear')
    setProperty('scoreTxt.visible', false)

    for i = 0, 3 do
        setPropertyFromGroup('strumLineNotes', i, 'x', -330)
    end

end

function onStepHit()
    if curStep >= 591 and curStep <= 719 then
        stopTweens = true
    else
        stopTweens = false
    end

    if curStep == 48 then  
        doTweenY('hefloats', 'dad', 900, 1, 'quadInOut')
    elseif curStep == 60 then  
        doTweenY('fart', 'dad', 400, 0.1, '')
    elseif curStep == 592 then  
        doTweenY('bart', 'dad', 200, 0.01, '')
    elseif curStep >= 719 then
            startUpdate = true
    end 
end

function onUpdate(elapsed)
    if not startUpdate then
        return
    end

    songPos = getSongPosition()
    local currentBeat = (songPos / 1000) * (bpm / 80)

    local radius = 110
    local angle = currentBeat * math.pi * 0.5
    local xOffset = radius * math.sin(angle)
    local yOffset = radius * math.sin(angle) * math.cos(angle)

    doTweenY('dadTweenY', 'dad', 300 + yOffset, 0.001)

    doTweenX('dadTweenX', 'dad', 400 + xOffset, 0.001)
end

function onTweenCompleted(tag)
    if stopTweens then
        return
    end

    if tag == 'hefloats' then
        doTweenY('hefloats2', 'dad', 500, 2, 'quadInOut')
    end

    if tag == 'hefloats2' then
        doTweenY('hefloats', 'dad', 400, 2, 'quadInOut')
    end
end