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
    if curStep == 48 then  
    doTweenY('hefloats', 'dad', 900, 1, 'quadInOut')

    elseif curStep == 60 then  
        doTweenY('fart', 'dad', 400, 0.1, '')
    end
end
function onTweenCompleted(tag)
	if tag == 'fart' then
    doTweenY('hefloats2', 'dad', 500, 1, 'quadInOut')
    end

    if tag == 'hefloats2' then
    doTweenY('hefloats', 'dad', 400, 1, 'quadInOut')
    end
end