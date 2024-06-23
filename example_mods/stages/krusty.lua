function onCreate()
	makeLuaSprite('whitepixel', 'bg/krusty-krab/bg1', -70, -200);
	scaleObject('whitepixel', 1.2, 1.2);
	setScrollFactor('whitepixel', 1, 1);
	setProperty('whitepixel.antialiasing', true);
	setObjectOrder('whitepixel', 1);

	setScrollFactor('gfGroup', 1, 1);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 2);

	setScrollFactor('dadGroup', 0, 0);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 3);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 4);
	
	makeAnimatedLuaSprite('crabs','characters/crabs', 1200, -100)
	addAnimationByPrefix('crabs', 'crabs', 'crabs', 24, false)

	close(true);
end
function onCreatePost()
    setProperty('healthBarBG.visible', false)
    setProperty('healthBar.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
end