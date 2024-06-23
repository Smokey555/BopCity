charGameOverJSON = 'bfBopCityDead'
DeathSound = ''
DeathMusic = ''
DeathEnd = ''
function onCreatePost()
    --YESSS IT FUCKIN WORKS LESSS GOOOOOOO
    charGameOverJSON = getPropertyFromClass('GameOverSubstate','characterName');
    DeathSound = getPropertyFromClass('GameOverSubstate','deathSoundName');
    DeathMusic = getPropertyFromClass('GameOverSubstate','loopSoundName');
    DeathEnd = getPropertyFromClass('GameOverSubstate','endSoundName');
    --debugPrint(charGameOverJSON)
    --debugPrint(DeathSound)
    --debugPrint(DeathMusic)
    --debugPrint(DeathEnd)
end

function onGameOver()
    return Function_Stop;
end

function onPause()
    --return Function_Stop;
end

stopFunction = false;
function onUpdate(elapsed)
    if getHealth() <= 0.0001 and not stopFunction and not practice then
        openCustomSubstate('NEW_gameOver',true);
        --debugPrint('hello world') -- this was a test
        stopFunction = true;
    end
end

function onCustomSubstateCreatePost(name)
    if name == 'NEW_gameOver' then
        setProperty('camHUD.visible',false);
        triggerEvent('Change Character','bf',charGameOverJSON);
        playAnim('boyfriend','firstDeath');
        if songName == 'Tutorial' then
            playAnim('dad','sad');
        else
            setProperty('dad.visible',false);
            playAnim('gf','sad');
        end

        playSound(DeathSound);
        runTimer('gameOverMusic',3);
        -- this haxe code is from gameOverState.hx of course
        --runHaxeCode([[Conductor.changeBPM(100);]]);
        -- ITS NO USE!!!!!

        makeLuaSprite('black','',-1000,-1000);
        makeGraphic('black',9999,9999,'000000');
        setScrollFactor('black',0,0);
        addLuaSprite('black');
        setProperty('black.alpha',0.5);

        makeAnimatedLuaSprite('loseSprite','lose',25,-100);
        addAnimationByPrefix('loseSprite','lose','lose',24,false);
        setObjectCamera('loseSprite','other');
        addLuaSprite('loseSprite');
        playAnim('loseSprite','lose');

        makeLuaText('totalJudge',
            'Total Score: '..score..' | Total Misses: '..misses..
            '\n\n\nSicks: '..getProperty('sicks')..
            '\nGoods: '..getProperty('goods')..
            '\nBads: '..getProperty('bads')..
            '\nShits: '..getProperty('shits')
        ,0,5,150);
        setTextSize('totalJudge',25);
        setTextAlignment('totalJudge','left');
        setObjectCamera('totalJudge','other');
        addLuaText('totalJudge');

        makeLuaSprite('blackRESET','',0,0);
        makeGraphic('blackRESET',9999,9999,'000000');
        setScrollFactor('blackRESET',0,0);
        addLuaSprite('blackRESET',true);
        setObjectCamera('blackRESET','other');
        setProperty('blackRESET.alpha',0);

        setProperty('camGame.zoom',1);
        setProperty('camFollowPos.x',getGraphicMidpointX('boyfriend') - 100)
        setProperty('camFollowPos.y',getGraphicMidpointY('boyfriend') - 100)
    end
end

stopTimer = false
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'gameOverMusic' then
        if not stopTimer then
            playMusic(DeathMusic,1,true);
            frameBF = 0
            frameGF = 0
            runTimer('resetBF',1.46);
            runTimer('resetGF',0.24);
            playAnim('boyfriend','deathLoop');
        end
    end
    if tag == 'resetBF' then
        if not stopTimer then
            frameBF = 0
            runTimer('resetBF',1.46);
        end
    end
    if tag == 'resetBF' then
        if not stopTimer then
            frameGF = 0
            runTimer('resetGF',0.24);
        end
    end

    if tag == 'reset' then
        doTweenAlpha('blackRESET_tween','blackRESET',1,3);
    end
end

frameBF = 0
frameGF = 0
frameLose = 0
function onCustomSubstateUpdate(name,elapsed)
    if name == 'NEW_gameOver' then
        frameBF = frameBF + (elapsed*20)
        frameGF = frameGF + (elapsed*20)
        frameLose = frameLose + (elapsed*20)
        --debugPrint(frame)
        setProperty('boyfriend.animation.curAnim.curFrame',frameBF);
        setProperty('loseSprite.animation.curAnim.curFrame',frameLose);
        if songName == 'Tutorial' then
            setProperty('dad.animation.curAnim.curFrame',frameGF);
        else
            setProperty('gf.animation.curAnim.curFrame',frameGF);
        end
    end
end

fuckBugs = false
function onCustomSubstateUpdatePost(name,elapsed)
    if name == 'NEW_gameOver' then
        if keyboardJustPressed('ENTER') or keyboardJustPressed('SPACE') then
            stopSound(DeathMusic)
            stopTimer = true;
            if not fuckBugs then
                fuckBugs = true;
                frameBF = 0
                frameGF = 0
                playAnim('boyfriend','deathConfirm');
                if songName == 'Tutorial' then
                    playAnim('dad','cheer');
                else
                    playAnim('gf','cheer');
                end
                playMusic(DeathEnd,1,false);
                doTweenZoom('zoomIn','camGame',1.2,5,'circOut');
                runTimer('reset',2);
            end
        end

        if keyboardJustPressed('ESCAPE') then
            exitSong(false)
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'blackRESET_tween' then
        restartSong(false);
    end
end