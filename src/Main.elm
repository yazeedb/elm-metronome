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
    , alsoKnownAs : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 60 "Largo - Lento - Adagio"
    , Cmd.none
    )


type Msg
    = Increment
    | Decrement
    | SetBpm String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | bpm = model.bpm + 1 }, Cmd.none )

        Decrement ->
            ( { model | bpm = model.bpm - 1 }, Cmd.none )

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
                    , A.min "20"
                    , A.max "260"
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
