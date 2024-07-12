function onCreate()
    makeLuaSprite("bg",'bg/mcdonalds/grim', 0,-250)
    scaleObject('bg', 1.3, 1.3);
    addLuaSprite("bg")
    
    setScrollFactor('gfGroup', 0, 0);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 3);

    makeAnimatedLuaSprite('shark', 'bg/mcdonalds/shark', 800, 300);
	addAnimationByPrefix('shark', 'idle', 'shark', 24, false);
	scaleObject('shark', 1, 1);
	setScrollFactor('shark', 1, 1);
	addLuaSprite('shark', false);

    makeAnimatedLuaSprite('beast', 'bg/mcdonalds/beast', 200, 425);
	addAnimationByPrefix('beast', 'idle', 'Beast', 24, false);
	scaleObject('beast', 1.2, 1.2);
	setScrollFactor('beast', 1, 1);
	addLuaSprite('beast', false);

    makeAnimatedLuaSprite('zeebs', 'bg/mcdonalds/zeebs', 1200, 700);
	addAnimationByPrefix('zeebs', 'idle', 'zeebs', 24, false);
	scaleObject('zeebs', 1.2, 1.2);
	setScrollFactor('zeebs', 1, 1);
	addLuaSprite('zeebs', false);

    makeAnimatedLuaSprite('why', 'bg/mcdonalds/why', 2100, 700);
	addAnimationByPrefix('why', 'idle', 'why', 6, true);
	scaleObject('why', 1.2, 1.2);
	setScrollFactor('why', 1, 1);
	addLuaSprite('why', false);
    playAnim('why', 'idle', true);


    makeLuaSprite("gwim",'bg/mcdonalds/gramace', 0,-250)
    scaleObject('gwim', 1, 1);
    screenCenter('gwim', 'XY')
    setProperty('gwim.alpha', 0)
    setObjectCamera('gwim', 'camOther')
    addLuaSprite("gwim")
end



function onBeatHit()
	playAnim('shark', 'idle', true);
    playAnim('beast', 'idle', true);
    playAnim('zeebs', 'idle', true);
    
end


