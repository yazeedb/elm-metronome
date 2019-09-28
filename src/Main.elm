port module Main exposing (Model, Msg(..), getPlayButtonClassName, init, main, subscriptions, update, view)

import BpmToTempo exposing (bpmToTempo)
import Browser
import Html exposing (..)
import Html.Attributes as A exposing (..)
import Html.Events exposing (onClick, onInput)
import Json.Encode as E
import Task
import Time


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
    , timesTicked : Int
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
        0
    , Cmd.none
    )


type Msg
    = Increment
    | Decrement
    | SetBpm String
    | TogglePlay
    | Tick Time.Posix


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
            ( { model | isPlaying = not model.isPlaying, timesTicked = 0 }
            , Cmd.none
            )

        Tick time ->
            let
                newTimesTicked =
                    model.timesTicked + 1
            in
            ( { model
                | timesTicked = newTimesTicked
              }
            , tick newTimesTicked
            )


port tick : Int -> Cmd msg


bpmToMs : Int -> Float
bpmToMs bpm =
    Basics.toFloat (60000 // bpm)


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.isPlaying == False then
        Sub.none

    else
        Time.every (bpmToMs model.bpm) Tick


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
        , footer []
            [ p []
                [ text "A metronome built in Elm - "
                , a [ href "https://github.com/yazeedb/elm-metronome" ] [ text "View source code" ]
                ]
            ]
        ]


getPlayButtonClassName : Bool -> String
getPlayButtonClassName isPlaying =
    if isPlaying == True then
        "fas fa-pause"

    else
        "fas fa-play"
