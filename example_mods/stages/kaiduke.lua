

function onCreate() 
    makeLuaSprite('black', 'black', -1000, 0)
    addLuaSprite('black', true)
    scaleObject('black', 500, 500)
    setObjectCamera('black', 'camother')
end

function onCreatePost()
    setProperty('healthBarBG.visible', false)
    setProperty('healthBar.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('black.alpha', tonumber(0))

    for i = 0, 3 do
        setPropertyFromGroup('strumLineNotes', i, 'x', -330)
    end
end



function onBeatHit()
    if curBeat == 50 then  
        doTweenAlpha('black', 'black', 10, 0.7)
    end

    if curBeat == 56 then  
        doTweenAlpha('black', 'black', 0, 4)
    end
end
