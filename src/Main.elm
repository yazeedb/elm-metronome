module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)


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
    = Tick


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick ->
            ( model, Cmd.none )


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
        ]
