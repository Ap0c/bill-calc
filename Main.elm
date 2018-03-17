module Main exposing (..)

import Html exposing (..)


-- Types


type alias Charge =
    Float


type alias Name =
    String


type alias WithoutTip =
    Float


type alias WithTip =
    Float


type Total
    = Total WithoutTip WithTip


type Person
    = Person Name (List Charge)


type alias Model =
    { tipMultiplier : Float
    , people : List Person
    }


type Msg
    = Msg1



-- Functions


personTotal : Float -> Person -> Total
personTotal tipMultiplier (Person _ charges) =
    let
        withoutTip =
            List.sum charges

        withTip =
            withoutTip * tipMultiplier
    in
        Total withoutTip withTip


totalAdd : Total -> Total -> Total
totalAdd (Total a b) (Total c d) = Total (a+c) (b+d)


peopleTotal : Float -> List Person -> Total
peopleTotal tipMultiplier people =
    List.foldl ((personTotal tipMultiplier) >> totalAdd) (Total 0 0) people


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
