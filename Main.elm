module Main exposing (..)

import Html exposing (..)


-- Types


type alias Charge =
    Float


type alias Name =
    String


type Person
    = Person Name (List Charge)


type alias Model =
    { tip : Float
    , people : List Person
    }


type Msg
    = Msg1



-- Functions
-- Main


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        msg1 ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ text "New Html Program" ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( Model 10.0 [], Cmd.none )
