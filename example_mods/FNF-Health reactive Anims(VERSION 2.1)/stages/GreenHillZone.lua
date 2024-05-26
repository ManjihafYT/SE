bfX = {200, 1200, 300, 2600, 1800}
bfY = {650, 200, 800, 10, 240}

gfX = {600, 800, 600, 3000, 1500}
gfY = {850, 900, 230, 250, 470}

dadX = {2300, 100, 1600, 1500, 800}
dadY = {400, -400, 600, 600, 0}

camBfX = {1100, 1100, 1100, 2300, 1700}
camBfY = {800, 700, 900, 600, 550}

camDadX = {2200, 1100, 1300, 2200, 1300}
camDadY = {900, 100, 900, 900, 500}

function onCreate()
    stageNumber = getRandomInt(0, 5)

    --SelfExplanatory
    if stageNumber == 2 then
        makeLuaSprite('Background', 'GreenHillZoneBackground', 0, -500)
    elseif stageNumber == 5 then
        makeLuaSprite('Background', 'GreenHillZoneBackground', 0, -400)
    else
        makeLuaSprite('Background', 'GreenHillZoneBackground', 0, 0)
    end
    scaleObject('Background', 3.4, 3.4, true)
    addLuaSprite('Background', false)

    makeLuaText('seed', 'seed = '..stageNumber, 1250, 0, 500)
    setTextSize('seed', 50)
    addLuaText('seed')

    StageSelector()
end

function onCreatePost()
    setProperty('gf.x', defaultGirlfriendX)
    setProperty('gf.y', defaultGirlfriendY)

    setProperty('dad.x', defaultOpponentX)
    setProperty('dad.y', defaultOpponentY)

    if stageNumber == 1 then
        if middlescroll == false then
            makeLuaText('INFOP', ('    YOU PLAY AS THE LEFT SIDE'), 1250, 0, 480)
            setTextAlignment('INFOP', 'Left')
            addLuaText('INFOP')
            setTextSize('INFOP', 30)
        end

        triggerEvent('Change Character', 'Bf', getProperty('boyfriend.curCharacter')..'flipped')
    elseif stageNumber == 3 then
        if middlescroll == false then
            makeLuaText('INFOP', ('    YOU PLAY AS THE LEFT SIDE'), 1250, 0, 480)
            setTextAlignment('INFOP', 'Left')
            addLuaText('INFOP')
            setTextSize('INFOP', 30)
        end
        
        triggerEvent('Change Character', 'Bf', getProperty('boyfriend.curCharacter')..'flipped')
    end

    setProperty('boyfriend.x', defaultBoyfriendX)
    setProperty('boyfriend.y', defaultBoyfriendY)
    if middlescroll == false then
        if stageNumber == 1 then
            noteTweenX('defaultPlayerStrumX0', 4, 120 , 0.001)
            noteTweenX('defaultPlayerStrumX1', 5, 120+110 , 0.001)
            noteTweenX('defaultPlayerStrumX2', 6, 120+110+110 , 0.001)
            noteTweenX('defaultPlayerStrumX3', 7, 120+110+110+110 , 0.001)

            noteTweenX('defaultOpponentStrumX0', 0, 95+650 , 0.001)
            noteTweenX('defaultOpponentStrumX1', 1, 95+110+650 , 0.001)
            noteTweenX('defaultOpponentStrumX2', 2, 95+110+110+650 , 0.001)
            noteTweenX('defaultOpponentStrumX3', 3, 95+110+110+110+650 , 0.001)
        elseif stageNumber == 3 then
            noteTweenX('defaultPlayerStrumX0', 4, 120 , 0.001)
            noteTweenX('defaultPlayerStrumX1', 5, 120+110 , 0.001)
            noteTweenX('defaultPlayerStrumX2', 6, 120+110+110 , 0.001)
            noteTweenX('defaultPlayerStrumX3', 7, 120+110+110+110 , 0.001)

            noteTweenX('defaultOpponentStrumX0', 0, 95+650 , 0.001)
            noteTweenX('defaultOpponentStrumX1', 1, 95+110+650 , 0.001)
            noteTweenX('defaultOpponentStrumX2', 2, 95+110+110+650 , 0.001)
            noteTweenX('defaultOpponentStrumX3', 3, 95+110+110+110+650 , 0.001)
        end
    end
end

function onSongStart()
    setTimeBarColors('0158b9', '000000')
    setTextSize('seed', 20)
    doTweenY('seedMoveUp', 'seed', 0, 0.5)
end

function onUpdate(elapsed)

    if curStep == 40 then
        doTweenAlpha('infoTWEEN', 'INFOP', 0, 0.5, linear);
    end
    if stageNumber == 4 then
        platformFloat()
    end

    if mustHitSection == false then
        triggerEvent('Camera Follow Pos', camDadX[stageNumber], camDadY[stageNumber])
    elseif mustHitSection == true then
        triggerEvent('Camera Follow Pos', camBfX[stageNumber], camBfY[stageNumber])
    end

    if curStep == 760 then
        setTimeBarColors('ff000a', '000000')

        removeLuaSprite('Background', true)
        removeLuaSprite('Stage', true)
        removeLuaSprite('FloatinPlatform', true)

        if stageNumber == 2 then
            makeLuaSprite('EvilBackground', 'EvilGreenHillZoneBackground', 0, -500)
        elseif stageNumber == 5 then
            makeLuaSprite('EvilBackground', 'EvilGreenHillZoneBackground', 0, -400)
        else
            makeLuaSprite('EvilBackground', 'EvilGreenHillZoneBackground', 0, 0)
        end
        scaleObject('EvilBackground', 3.4, 3.4, true)
        addLuaSprite('EvilBackground', false)

        makeLuaSprite('EvilStage', 'EvilGreenHillZoneStage'..stageNumber, 0, 0)
        scaleObject('EvilStage', 3.4, 3.4, true)
        addLuaSprite('EvilStage', false)

        if stageNumber == 4 then
            makeLuaSprite('EvilFloatinPlatform', 'EvilFloatingPlatform', 2500, 500)
            scaleObject('EvilFloatinPlatform', 4.5, 4, true)
            addLuaSprite('EvilFloatinPlatform', false)
        end

        triggerEvent('Change Scroll Speed', 2, 0)

        cameraFlash('game', 'red', 0.2)
        triggerEvent('Change Character', 'Dad', 'EXE')
    end

    if curStep == 761 then
        if stageNumber == 1 then
            triggerEvent('Change Character', 'Dad', 'EXEflipped')

            setProperty('dad.x', defaultOpponentX)
            setProperty('dad.y', defaultOpponentY)
        elseif stageNumber == 3 then
            triggerEvent('Change Character', 'Dad', 'EXEflipped')

            setProperty('dad.x', defaultOpponentX)
            setProperty('dad.y', defaultOpponentY)
        end
    end
end

function StageSelector()
    makeLuaSprite('Stage', 'GreenHillZoneStage'..stageNumber, 0, 0)
    scaleObject('Stage', 3.4, 3.4, true)
    addLuaSprite('Stage', false)

    if stageNumber == 4 then
        makeLuaSprite('FloatinPlatform', 'FloatingPlatform', 2500, 500)
        scaleObject('FloatinPlatform', 4.5, 4, true)
        addLuaSprite('FloatinPlatform', false)
    end

    defaultBoyfriendX = bfX[stageNumber]
    defaultBoyfriendY = bfY[stageNumber]

    defaultGirlfriendX = gfX[stageNumber]
    defaultGirlfriendY = gfY[stageNumber]

    defaultOpponentX = dadX[stageNumber]
    defaultOpponentY = dadY[stageNumber]
end

-- I copied this code from https://gamebanana.com/tuts/14588 and it won't work if i set it to onSongStart() instead of onUpdate() sooooooooooooooooooooooooooooo
function platformFloat(elapsed)
    if curStep == 0 then
        started = true
    end
    
    songPos = getSongPosition()
    local currentBeat = (songPos/5000)*(curBpm/60)

    if curStep < 760 then
        doTweenY('platformMove', 'FloatinPlatform', 500 - 150*math.sin((currentBeat+12*12)*math.pi), 1)
        doTweenX('disruptor2', 'disruptor2.scale', 500 - 50*math.sin((currentBeat+1*0.1)*math.pi), 1)
        doTweenY('disruptor2', 'disruptor2.scale', 800 - 31*math.sin((currentBeat+1*1)*math.pi), 1)
    else
        doTweenY('EvilPlatformMove', 'EvilFloatinPlatform', 500 - 150*math.sin((currentBeat+12*12)*math.pi), 1)
        doTweenX('Evildisruptor2', 'disruptor2.scale', 500 - 50*math.sin((currentBeat+1*0.1)*math.pi), 1)
        doTweenY('Evildisruptor2', 'disruptor2.scale', 800 - 31*math.sin((currentBeat+1*1)*math.pi), 1)
    end
    
    --I have no fuckin clue how this works don't touch it or it'll break
    doTweenY('gfMove', 'gf', 250 - 150*math.sin((currentBeat+12*12)*math.pi), 1)
    doTweenX('gfdisruptor2', 'disruptor2.scale', 250 - 50*math.sin((currentBeat+1*0.1)*math.pi), 1)
    doTweenY('gfdisruptor2', 'disruptor2.scale', 800 - 31*math.sin((currentBeat+1*1)*math.pi), 1)

    --I have no fuckin clue how this works don't touch it or it'll break
    doTweenY('bfMove', 'boyfriend', 0 - 150*math.sin((currentBeat+12*12)*math.pi), 1)
    doTweenX('bfdisruptor2', 'disruptor2.scale', 0 - 50*math.sin((currentBeat+1*0.1)*math.pi), 1)
    doTweenY('bfdisruptor2', 'disruptor2.scale', 800 - 31*math.sin((currentBeat+1*1)*math.pi), 1)
end