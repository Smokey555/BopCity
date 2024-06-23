function onEvent(name,value1,value2)
if name == "crabs" then 
        if value1 == 'yeah' then
			addLuaSprite('crabs', true)
			objectPlayAnimation('crabs', 'crabs')
			setObjectOrder("crabs", 2)
        end
    end
end