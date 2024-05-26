local NoteSkin = 'Green_Notes';
local NoteSplashes = 'Green_Splashes';
function onCreate()
    if songName == 'white-flags' then
        NoteSkin = 'Red_Notes'
        NoteSplashes = 'Red_Splashes'
    elseif songName == 'sky-waltz' then
        NoteSkin = 'Green_Notes';
        NoteSplashes = 'Green_Splashes';
    end
end

--botPlayOn = false

local stopAnimTimer = 0;
local targetTime = 0;
function onCreate()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '3rd Player Sing' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', NoteSkin); --Change NoteSkin/style
            setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', NoteSplashes); --Change NoteSplashes             
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); --Stops original animations

            if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
                setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
            end
        end
    end

    if getProperty('cpuControlled') == true then
    botPlayOn = true;
    else
    botPlayOn = false;
    end
end



function opponentNoteHit(id, direction, noteType, isSustainNote)
    if noteType == '3rd Player Sing' then
        anim = ''
        if direction == 0 then
            anim = 'singLEFT'
        elseif direction == 1 then
            anim = 'singDOWN'
        elseif direction == 2 then
            anim = 'singUP'
        elseif direction == 3 then
            anim = 'singRIGHT'
        end
        triggerEvent('Play Animation', anim, 'gf');
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if noteType == '3rd Player Sing' then
        anim = ''
        if direction == 0 then
            anim = 'singLEFT'
        elseif direction == 1 then
            anim = 'singDOWN'
        elseif direction == 2 then
            anim = 'singUP'
        elseif direction == 3 then
            anim = 'singRIGHT'
        end
        triggerEvent('Play Animation', anim, 'gf');
        if getProperty('health') < 2 then
            setProperty('health', getProperty('health')+0.023)
        end
    end
end

function onUpdatePost(elapsed)
	setProperty('gf.specialAnim',true)
    elapsedd = 0.016/elapsed
    for i=0, getProperty('notes.length') do
        if getSongPosition() > getPropertyFromGroup('notes',i,'strumTime') and getPropertyFromGroup('notes',i,'noteType') == '3rd Player Sing' then --or getSongPosition() > getPropertyFromGroup('notes',i,'strumTime') and getPropertyFromGroup('notes',i,'noteType') == 'GF Sing Alt' then
            noteData = getPropertyFromGroup('notes',i,'noteData')
            anim = ''
            if noteData == 0 then
                anim = 'singLEFT'
                if getProperty('health') < 2 then
                    setProperty('health', getProperty('health')+0.023)
                end
            elseif noteData == 1 then
                if getProperty('health') < 2 then
                    setProperty('health', getProperty('health')+0.023)
                end
                anim = 'singDOWN'
            elseif noteData == 2 then
                if getProperty('health') < 2 then
                    setProperty('health', getProperty('health')+0.023)
                end
                anim = 'singUP'
            elseif noteData == 3 then
                if getProperty('health') < 2 then
                    setProperty('health', getProperty('health')+0.023)
                end
                anim = 'singRIGHT'
            end
            triggerEvent('Play Animation', anim, 'gf');
            removeFromGroup('notes', i);
        end
    end
end

function onTimerCompleted(t,l,ll)
    if t == 'gotoidle' then
        characterPlayAnim('gf', 'idle');
    end
end


