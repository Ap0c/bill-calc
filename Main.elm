module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


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


getTip : TipDecimal -> WithoutTip -> Tip
getTip tipDecimal withoutTip =
    tipDecimal * withoutTip


personTotal : Person -> WithoutTip
personTotal (Person _ charges) =
    List.sum charges


peopleTotals : List Person -> List WithoutTip
peopleTotals people =
    List.map personTotal people



-- View Components


viewPrice : String -> String -> Float -> Html Msg
viewPrice elementId labelText price =
    div []
        [ label [ for elementId ] [ text labelText ]
        , output [ id elementId ] [ text (toString price) ]
        ]



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
    let
        bill =
            List.sum (peopleTotals model.people)

        tip =
            getTip model.tipDecimal bill

        total =
            bill + tip
    in
        main_ []
            [ section []
                [ viewPrice "overall-price__bill" "Bill:" bill
                , viewPrice "overall-price__tip" "Tip:" tip
                , viewPrice "overall-price__total" "Total:" total
                ]
            ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( Model 10.0 [], Cmd.none )
