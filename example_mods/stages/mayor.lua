local enabled = true

if enabled and not lowQuality then
	local thickness = 75

function onCreate()
    makeLuaSprite("bg",'bg/mayor/basement')
    addLuaSprite("bg")

    makeLuaSprite("bar_upper", nil, 0, -thickness)
    makeGraphic("bar_upper", 1300, thickness, "000000")
    setObjectCamera("bar_upper", "hud")
    addLuaSprite("bar_upper", false)
    
    makeLuaSprite("bar_lower", nil, 0, 720)
    makeGraphic("bar_lower", 1300, thickness, "000000")
    setObjectCamera("bar_lower", "hud")
    addLuaSprite("bar_lower", false)

end
	function onSongStart()
		doTweenY("bar_upper", "bar_upper", 0, 2, "quintout")
		doTweenY("bar_lower", "bar_lower", 720 - thickness, 2, "quintout")
	end
end

local farthestLeft = -500
local farthestRight = 1000
local runY = 350

local running = {false};
function onCreatePost()

    for i = 1,5 do
        makeAnimatedLuaSprite('run'..i,'bg/mayor/run'..i,farthestRight,runY)
        addAnimationByPrefix("run"..i, "run", "run")
        objectPlayAnimation("run"..i, "run")
        addLuaSprite("run"..i)
        setProperty('run'..i..'.alpha',0)
        setObjectOrder('run'..i,getObjectOrder("boyfriendGroup")-1)
    end


end
function onStepHit()
    if curStep == 502 then  
    doTweenAngle('angle', 'dad', 680, 1.5, 'quadOut')
    doTweenX('right', 'dad', 400, 1.5, 'linear')
    doTweenY('up', 'dad', -1, 0.4, 'quadOut')
    end
end
function onTweenCompleted(t)

	if t == 'up' then
		doTweenY('down', 'dad', 800, 0.8, 'quadIn')
	end

end


function onSectionHit()
    if getRandomBool(50) then
        startRun()
    end
end


function startRun()
    for i = 1,5 do
        layer = getRandomInt(1,3)
        if layer == 1 then
            setObjectOrder('run'..i,getObjectOrder("boyfriendGroup")-1)
        end
        if layer == 2 then
            setObjectOrder('run'..i,getObjectOrder("dadGroup")-1)
        end
        if layer == 3 then
            setObjectOrder('run'..i,getObjectOrder("gfGroup")-1)
        end
    
        setProperty('run'..i..'.alpha',1)
        setProperty('run'..i..'.y',runY + getRandomInt(-200,200))
        --if not running then
            flipX = getRandomBool()
            speed = 300
            if getRandomBool(80) then
                speed = 1000
            end
            if getRandomBool(10) then
                speed = 10000
            end
    
            if flipX then
                setProperty('run'..i..'.flipX', true)  
                setProperty('run'..i..'.velocity.x', speed)  
                setProperty('run'..i..'.x', farthestLeft - getProperty('run'..i..'.width'))  
            else
                setProperty('run'..i..'.flipX', false)  
                setProperty('run'..i..'.velocity.x', -speed)  
                setProperty('run'..i..'.x', farthestRight + getProperty('run'..i..'.width'))  
            end
    
            --running = true;
        --end
        
    end

end


function onUpdate(elapsed)
    --if getProperty('run.x') > farthestRight + getProperty('run.width') or getProperty('run.x') < farthestLeft - getProperty("run.width") then running = false end
end