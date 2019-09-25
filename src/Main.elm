module Main exposing (main)

import BpmToTempo exposing (bpmToTempo)
import Browser
import Html exposing (..)
import Html.Attributes as A exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { bpm : Int
    , minBpm : Int
    , maxBpm : Int
    , tempo : String
    , isPlaying : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        initialBpm =
            60
    in
    ( Model
        initialBpm
        20
        260
        (bpmToTempo initialBpm)
        False
    , Cmd.none
    )


type Msg
    = Increment
    | Decrement
    | SetBpm String
    | TogglePlay


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        clampBpm =
            clamp model.minBpm model.maxBpm
    in
    case msg of
        Increment ->
            let
                newBpm =
                    clampBpm (model.bpm + 1)
            in
            ( { model
                | bpm = newBpm
                , tempo = bpmToTempo newBpm
              }
            , Cmd.none
            )

        Decrement ->
            let
                newBpm =
                    clampBpm (model.bpm - 1)
            in
            ( { model
                | bpm = newBpm
                , tempo = bpmToTempo newBpm
              }
            , Cmd.none
            )

        SetBpm value ->
            let
                newBpm =
                    Maybe.withDefault model.bpm (String.toInt value)
            in
            ( { model
                | bpm = newBpm
                , tempo = bpmToTempo newBpm
              }
            , Cmd.none
            )

        TogglePlay ->
            ( { model | isPlaying = not model.isPlaying }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view model =
    div [ class "metronome" ]
        [ h1 []
            [ text (String.fromInt model.bpm)
            , span [] [ text "BPM" ]
            ]
        , h4 [] [ text model.tempo ]
        , div [ class "controls" ]
            [ div
                [ class "slider-container" ]
                [ button [ onClick Decrement ] [ text "-" ]
                , input
                    [ type_ "range"
                    , step "1"
                    , A.min (String.fromInt model.minBpm)
                    , A.max (String.fromInt model.maxBpm)
                    , value (String.fromInt model.bpm)
                    , onInput SetBpm
                    ]
                    []
                , button [ onClick Increment ] [ text "+" ]
                ]
            , button [ class "play", onClick TogglePlay ]
                [ i [ class (getPlayButtonClassName model.isPlaying) ] []
                ]
            ]
        ]


getPlayButtonClassName : Bool -> String
getPlayButtonClassName isPlaying =
    if isPlaying == True then
        "fas fa-pause"

    else
        "fas fa-play"
