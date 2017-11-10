-- VIEW


module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Models exposing (..)


view : Model -> Html Msg
view model =
    div [ class "w-80-ns center" ]
        [ headerCustom
        , postCodeInput model
        , div []
            [ ul [ class "bg-black-70 list pl0 ml0 center mw7 ba b--light-silver br3" ]
                (model.journeys
                    |> List.sortBy .duration
                    |> List.map eachJourney
                )
            ]
        ]


headerCustom : Html Msg
headerCustom =
    header [ class "tc pv2 pv5-ns" ]
        [ img [ src "https://cdn4.iconfinder.com/data/icons/auto-icons-6/100/3-512.png", class "br-100 pa1 ba b--black-10 h3 w3" ] []
        , h1
            [ class "f5 f4-ns fw6 mid-gray" ]
            [ text "How To Get to FAC" ]
        , h2
            [ class "f6 gray fw2 ttu tracked" ]
            [ text "Welcome to elm Travel to FAC London planner - enter your (London) postcode below and find out how long it would take to get to FAC. Go nuts." ]
        ]


postCodeInput : Model -> Html Msg
postCodeInput model =
    div [ class "pa4-1 border-box" ]
        [ Html.form
            [ class
                "bg-light-red mw7 center pa4 br2-ns ba b--black-10"
            , onWithOptions "submit" { stopPropagation = False, preventDefault = True } (Json.succeed GetTime)
            ]
            [ fieldset [ class "ttu cf bn ma0 pa0" ]
                [ div [ class "cf tc" ]
                    [ label [ class "clip", for "postcode" ] [ text "Postcode" ]
                    , input [ class "ttu f6 tc input-reset bn pa3 black-80 bg-white lh-solid w-90", placeholder "Postcode", onInput Change ] []
                    , input [ class "ttu f6 button-reset tc bn pa3 bg-animate bg-black-70 hover-bg-black white pointer w-100", type_ "submit", value "Get routes!" ] []
                    ]
                ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


eachJourney : Journey -> Html Msg
eachJourney journey =
    li [ class "white ph3 f2 pv2 bb b--light-silver ttu tc" ]
        [ text (toString journey.duration ++ " minutes")
        , ul
            [ class "hover-bg-black bg-light-red list pl0 ml0 center mw7 ba b--light-silver br3" ]
            (List.map eachLeg (List.indexedMap (,) journey.legs))
        ]


eachLeg : ( Int, Leg ) -> Html Msg
eachLeg leg =
    li [ class "ph3 f5 pv2 bb b--light-silver ttu tc center" ] [ div [ class "tc w-50 dib tl" ] [ text (Tuple.second leg) ] ]
