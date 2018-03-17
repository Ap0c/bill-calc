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


type alias TipDecimal =
    Float


type alias Tip =
    Float


type Total
    = Total WithoutTip WithTip


type Person
    = Person Name (List Charge)


type alias Model =
    { tipDecimal : Float
    , people : List Person
    }


type Msg
    = Msg1



-- Functions


tip : TipDecimal -> WithoutTip -> Tip
tip tipDecimal withoutTip =
    tipDecimal * withoutTip


totalWithTip : TipDecimal -> WithoutTip -> WithTip
totalWithTip tipDecimal withoutTip =
    withoutTip + (tip tipDecimal withoutTip)


personTotal : Person -> WithoutTip
personTotal (Person _ charges) =
    List.sum charges


peopleTotal : List Person -> WithoutTip
peopleTotal people =
    List.foldl (personTotal >> (+)) 0 people



-- View Components
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
