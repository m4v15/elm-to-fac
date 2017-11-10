-- VIEW


module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (..)


view : Model -> Html Msg
view model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "hello" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "Welcome to elm Travel to FAC London planner - enter your (London) postcode below and find out how long it would take to get to FAC. Go nuts." ]
        , input [ class "f3 w30 pa1 center db ba", onInput Change, value model.postCode ] []
        , button [ class "f3 w30 pa1 center db ba", onClick GetTime ] [ text "Submit" ]
        , h1 [] [ text ("post code: " ++ model.postCode) ]
        , div []
            [ h1 []
                [ text "Journeys: " ]
            , div []
                (model.journeys
                    |> List.sortBy .duration
                    |> List.map eachJourney
                )
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


eachJourney : Journey -> Html Msg
eachJourney journey =
    div [ class "f2" ]
        [ text ("Time to FAC: " ++ toString journey.duration ++ " minutes")
        , div
            []
            (List.map eachLeg (List.indexedMap (,) journey.legs))
        ]


eachLeg : ( Int, Leg ) -> Html Msg
eachLeg leg =
    div [ class "f3 pa3 tc" ] [ div [ class "w-50 dib tl" ] [ text (toString (Tuple.first leg) ++ ". " ++ Tuple.second leg) ] ]
