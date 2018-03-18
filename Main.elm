module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- Types


type alias Charge =
    Float


type alias Name =
    String


type alias TipDecimal =
    Float


type alias Bill =
    Float


type alias Tip =
    Float


type alias Total =
    Float


type Amounts
    = Amounts Bill Tip Total


type Person
    = Person Name (List Charge)


type alias Model =
    { tipDecimal : Float
    , people : List Person
    }


type Msg
    = Msg1



-- Functions


getTip : TipDecimal -> Bill -> Tip
getTip tipDecimal bill =
    tipDecimal * bill


chargesPerPerson : List Person -> List Charge
chargesPerPerson =
    List.map (\(Person _ charges) -> List.sum charges)


toTwoDp : Float -> Float
toTwoDp =
    (*) 100
        >> round
        >> toFloat
        >> flip (/) 100


getAmounts : TipDecimal -> List Charge -> Amounts
getAmounts tipDecimal charges =
    let
        bill =
            List.sum charges

        tip =
            getTip tipDecimal bill

        total =
            bill + tip
    in
        Amounts bill tip total



-- View Components


viewAmount : String -> String -> Float -> Html Msg
viewAmount elementId labelText amount =
    div []
        [ label [ for elementId ] [ text labelText ]
        , output [ id elementId ] [ text (toString <| toTwoDp amount) ]
        ]


viewPerson : TipDecimal -> Person -> Html Msg
viewPerson tipDecimal (Person name charges) =
    let
        (Amounts _ _ total) = getAmounts tipDecimal charges
    in
        viewAmount ("person-" ++ name) name total



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
        (Amounts bill tip total) = getAmounts model.tipDecimal <| chargesPerPerson model.people
    in
        main_ []
            [ section []
                [ viewAmount "overall-price-bill" "Bill:" bill
                , viewAmount "overall-price-tip" "Tip:" tip
                , viewAmount "overall-price-total" "Total:" total
                ]
            , section [] <| List.map (viewPerson model.tipDecimal) model.people
            ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( Model 0.1 [ Person "Ford" [ 2.45, 6.49 ], Person "Arthur" [ 8.9 ] ], Cmd.none )
