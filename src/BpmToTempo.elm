module BpmToTempo exposing (bpmToTempo)


isBetween : Int -> Int -> Int -> Bool
isBetween min max num =
    num >= min && num <= max


bpmToTempo : Int -> String
bpmToTempo bpm =
    if bpm <= 39 then
        "Larghissimo"

    else if isBetween 40 51 bpm then
        "Largo"

    else if isBetween 51 59 bpm then
        "Largo - Lento"

    else if bpm == 60 then
        "Largo - Lento - Adagio"

    else if isBetween 61 68 bpm then
        "Lento - Adagio"

    else if isBetween 69 75 bpm then
        "Adagio"

    else if isBetween 76 80 bpm then
        "Adagio - Andante"

    else if isBetween 81 87 bpm then
        "Andante"

    else if isBetween 88 99 bpm then
        "Andante - Moderato"

    else if bpm == 100 then
        "Andante - Moderato - Allegretto"

    else if isBetween 101 111 bpm then
        "Moderato - Allegretto"

    else if bpm == 112 then
        "Moderato - Allegretto - Allegro"

    else if isBetween 113 128 bpm then
        "Allegretto - Allegro"

    else if isBetween 129 137 bpm then
        "Allegro"

    else if isBetween 138 139 bpm then
        "Allegro - Vivace"

    else if isBetween 140 142 bpm then
        "Allegro - Vivace - Presto"

    else if isBetween 144 160 bpm then
        "Allegro - Presto"

    else if isBetween 161 187 bpm then
        "Presto"

    else if isBetween 188 200 bpm then
        "Presto - Prestissimo"

    else
        "Prestissimo"
