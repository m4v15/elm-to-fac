-- UPDATE


module Update exposing (..)

import Commands exposing (getTravelData)
import Models exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change newInput ->
            ( { model | postCode = newInput }, Cmd.none )

        NewTime (Ok journeys) ->
            ( { model | journeys = journeys }, Cmd.none )

        NewTime (Err travelTime) ->
            ( model, Cmd.none )

        GetTime ->
            ( model, getTravelData model.postCode )
