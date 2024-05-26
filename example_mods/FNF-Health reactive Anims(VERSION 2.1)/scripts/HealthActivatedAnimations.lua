--Should work with every character as long as it has the same names (except characters in Gfs place need to have the same anim names as gf)
local Alts = {'singLEFT-alt', 'singDOWN-alt', 'singUP-alt', 'singRIGHT-alt'}
local ScaredAnims = {'singLEFT-scared', 'singDOWN-scared', 'singUP-scared', 'singRIGHT-scared'}
local NormalAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
local MissAnims = {'singLEFTmiss', 'singDOWNmiss', 'singUPmiss', 'singRIGHTmiss'}
local gfISonOPPONENTSside = false --change this if you want the character in the gf slot to do scared and alts based on the same calcs of opponent scripts
canHEY = true
heyCounter = 0 -- you can use this for things like idk achievements, special text, special images, endings??????

function noteMiss(id, direction, noteType, isSustainNote)
	--Should fix miss animations??????
	characterPlayAnim('boyfriend', MissAnims[direction + 1]);
	
	if noteType == 'GF Sing' then
		characterPlayAnim('gf', MissAnims[direction + 1]);
	elseif noteType == '3rd Player Sing' then
		characterPlayAnim('gf', MissAnims[direction + 1]);
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	--Should fix miss animations??????
	characterPlayAnim('boyfriend', MissAnims[direction + 1]);
	
	if t == 'GF Sing' then
		characterPlayAnim('gf', MissAnims[direction + 1]);
	elseif t == '3rd Player Sing' then
		characterPlayAnim('gf', MissAnims[direction + 1]);
	end
end

--opponent scared and scared anims
function opponentNoteHitPost(i, direction, t, s)
	if getProperty('health') > 1.5 then
	   characterPlayAnim('dad', ScaredAnims[direction + 1]);
	elseif getProperty('health') < 0.7 then
		characterPlayAnim('dad', Alts[direction + 1]);
	end
end

function goodNoteHitPost(i, direction, t, s)
	--should prevent the hey animation while singing
	canHEY = false
	runTimer('HeyTimer', 1)

	--boyfriend's alt anims
	if getProperty('health') > 1.5 then
	   characterPlayAnim('boyfriend', Alts[direction + 1]);
	elseif getProperty('health') < 0.7 then
		characterPlayAnim('boyfriend', ScaredAnims[direction + 1], true);
	end

	--gf isn't on the opponents side and is playing scared anims
	if gfISonOPPONENTside == false then
		if getProperty('health') < 0.7 then
			if t == 'GF Sing' then
	        	characterPlayAnim('gf', ScaredAnims[direction + 1]);
			elseif t == '3rd Player Sing' then
				characterPlayAnim('gf', ScaredAnims[direction + 1]);
			end
	    end

		--gf isnt on the opponents side and is playing alt anims
		if getProperty('health') > 1.5 then
	        characterPlayAnim('gf', Alts[direction + 1]);
	    end
	--gf is on the opponents side and is playing scared anims
	elseif gfISonOPPONENTside == true then
		if getProperty('health') > 1.5 then
			if t == 'GF Sing' then
	        	characterPlayAnim('gf', ScaredAnims[direction + 1]);
			elseif t == '3rd Player Sing' then
				characterPlayAnim('gf', ScaredAnims[direction + 1]);
			end
		end

		--gf is on the opponents side and is playing alt anims
		if getProperty('health') < 0.7 then
			characterPlayAnim('gf', Alts[direction + 1]);
		end
	end
end

function onUpdate()
	--'Hey'/'Cheer' animation handler right here (Removed the 'hey-scared' animation)
	if getProperty('health') > 1.5 then
        --Custom Keybind, change the 'SPACE' to whatever key on the keyboard you want it to be(MAKE SURE TO LEAVE IT CAPITAL)                                                        
	    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and canHEY == true then                                                                                    
		    playSound("YEAH!");                                                        
		    characterPlayAnim('boyfriend', 'hey-alt', false);
			canHEY = false
			runTimer('HeyTimer', 1)
			heyCounter = heyCounter+1
            if gfISonOPPONENTSside == false then
			    characterPlayAnim('gf', 'cheer-alt', true);
            end                                       
	    end
    elseif getProperty('health') < 1.5 then
	    if getProperty('health') > 0.7 then                                                 
	        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and canHEY == true then                                                                                    
		        playSound("YEAH!");                                                          
		        characterPlayAnim('boyfriend', 'hey', false);
				canHEY = false
				runTimer('HeyTimer', 1)
				heyCounter = heyCounter+1
				if gfISonOPPONENTSside == false then
			        characterPlayAnim('gf', 'cheer', true);
                end     
            end
		end
	end

	--New scared and alt idle animation handler (boyfriend)
	if getProperty('health') < 0.7  and getProperty('boyfriend.animation.curAnim.name') == 'idle' then
		characterPlayAnim('boyfriend', 'idle-scared', true);
	elseif getProperty('health') > 1.5 and getProperty('boyfriend.animation.curAnim.name') == 'idle' then
		characterPlayAnim('boyfriend', 'idle-alt', true);
	end

	--New scared and alt animation animation handler (dad)
	if getProperty('health') < 0.7  and getProperty('dad.animation.curAnim.name') == 'idle' then
		characterPlayAnim('dad', 'idle-alt', true);
	elseif getProperty('health') > 1.5 and getProperty('dad.animation.curAnim.name') == 'idle' then
		characterPlayAnim('dad', 'idle-scared', true);
	end

	--New scared and alt animation animation handler (girlfriend)
	if getProperty('health') < 0.7  and getProperty('gf.animation.curAnim.name') == 'danceLeft' or getProperty('gf.animation.curAnim.name') == 'danceRight' then
		if gfISonOPPONENTside == true then
			characterPlayAnim('gf', 'sad')
		elseif gfISonOPPONENTside == false then
			characterPlayAnim('gf', 'cheer', true);
		end
	elseif getProperty('health') > 1.5 and getProperty('gf.animation.curAnim.name') == 'danceLeft' or getProperty('gf.animation.curAnim.name') == 'danceRight' then
		if gfISonOPPONENTside == false then
			characterPlayAnim('gf', 'cheer')
		elseif gfISonOPPONENTside == true then
			characterPlayAnim('gf', 'sad', true);
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'HeyTimer' then
		canHEY = true
	end
end