module Main exposing (Model, Msg(..), update, view)

import Html exposing (..)


type alias Model =
    {}


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html Msg
view model =
    div [] [ text "Hello World!" ]
