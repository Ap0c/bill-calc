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


toTwoDp : Float -> Float
toTwoDp =
    (*) 100
        >> round
        >> toFloat
        >> flip (/) 100



-- View Components


viewPrice : String -> String -> Float -> Html Msg
viewPrice elementId labelText price =
    div []
        [ label [ for elementId ] [ text labelText ]
        , output [ id elementId ] [ text (toString <| toTwoDp price) ]
        ]


viewPerson : TipDecimal -> Person -> Html Msg
viewPerson tipDecimal ((Person name _) as person) =
    let
        withoutTip =
            personTotal person

        tip =
            getTip tipDecimal withoutTip

        total =
            withoutTip + tip
    in
        viewPrice ("person-" ++ name) name total



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
                [ viewPrice "overall-price-bill" "Bill:" bill
                , viewPrice "overall-price-tip" "Tip:" tip
                , viewPrice "overall-price-total" "Total:" total
                ]
            , section [] <| List.map (viewPerson model.tipDecimal) model.people
            ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( Model 0.1 [ Person "Ford" [ 2.45, 6.49 ], Person "Arthur" [ 8.9 ] ], Cmd.none )
