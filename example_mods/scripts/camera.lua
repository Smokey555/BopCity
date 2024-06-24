-- SCRIPT BY ADA_FUNNI
-- Do not remove this watermark, or you have zero rights to use this script.

local dadOffset = 20
local bfOffset = 20
local gfOffset = 20

local holdTime = 0.1

function onUpdatePost()
    if mustHitSection and getProperty('boyfriend.animation.curAnim') == 'idle' then
        runTimer('move it back', holdTime)
    elseif not mustHitSection and getProperty('dad.animation.curAnim') == 'idle' then
        runTimer('move it back', holdTime)
    end
end

function gfFunction(noteData) -- Can't focus it on GF most of the time, kinda not too good with LUA.
    cameraSetTarget('gf')
    if noteData == 0 then
        setProperty('camFollow.x', getProperty('camFollow.x') - gfOffset)
    elseif noteData == 1 then
        setProperty('camFollow.y', getProperty('camFollow.y') + gfOffset)
    elseif noteData == 2 then
        setProperty('camFollow.y', getProperty('camFollow.y') - gfOffset)
    elseif noteData == 3 then
        setProperty('camFollow.x', getProperty('camFollow.x') + gfOffset)
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if mustHitSection then
        if not gfSection then
        cameraSetTarget('boyfriend')
        if noteData == 0 then
            setProperty('camFollow.x', getProperty('camFollow.x') - bfOffset)
        elseif noteData == 1 then
            setProperty('camFollow.y', getProperty('camFollow.y') + bfOffset)
        elseif noteData == 2 then
            setProperty('camFollow.y', getProperty('camFollow.y') - bfOffset)
        elseif noteData == 3 then
            setProperty('camFollow.x', getProperty('camFollow.x') + bfOffset)
        end
        else
        gfFunction(noteData)
        end
    end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if not mustHitSection then
        if not gfSection then
        cameraSetTarget('dad')
        if noteData == 0 then
            setProperty('camFollow.x', getProperty('camFollow.x') - dadOffset)
        elseif noteData == 1 then
            setProperty('camFollow.y', getProperty('camFollow.y') + dadOffset)
        elseif noteData == 2 then
            setProperty('camFollow.y', getProperty('camFollow.y') - dadOffset)
        elseif noteData == 3 then
            setProperty('camFollow.x', getProperty('camFollow.x') + dadOffset)
        end
        else
        gfFunction(noteData)
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'move it back' then
        if mustHitSection then
            if gfSection then
                cameraSetTarget('gf')
            else
                cameraSetTarget('boyfriend')
            end
        else
            cameraSetTarget('dad')
        end
    end
end