function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if getPropertyFromClass('backend.ClientPrefs', 'guitarHeroSustains') == false then
        if isSustainNote == true then
            setHealth(getHealth()-0.011)
        end
    end
end