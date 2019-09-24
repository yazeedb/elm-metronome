module Main exposing (main)

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
    , alsoKnownAs : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 60 20 260 "Largo - Lento - Adagio"
    , Cmd.none
    )


type Msg
    = Increment
    | Decrement
    | SetBpm String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        clampBpm =
            clamp model.minBpm model.maxBpm
    in
    case msg of
        Increment ->
            ( { model
                | bpm = clampBpm (model.bpm + 1)
              }
            , Cmd.none
            )

        Decrement ->
            ( { model | bpm = clampBpm (model.bpm - 1) }, Cmd.none )

        SetBpm value ->
            ( { model
                | bpm =
                    Maybe.withDefault
                        model.bpm
                        (String.toInt value)
              }
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
        , h4 [] [ text model.alsoKnownAs ]
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
            , button [ class "play" ]
                [ i [ class "fas fa-play" ] []
                ]
            ]
        ]
