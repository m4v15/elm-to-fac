module Commands exposing (..)

-- HTTP

import Http exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (..)


getTravelData : String -> Cmd Msg
getTravelData postCode =
    let
        url =
            "https://api.tfl.gov.uk/Journey/JourneyResults/" ++ postCode ++ "/to/e2%200sy?app_id=7a8655c0&app_key=b72beb96030088c7fa91c12f555f8f78"
    in
    Http.get url decodeJourneys |> Http.send NewTime


decodeJourneys : Decode.Decoder (List Journey)
decodeJourneys =
    Decode.at [ "journeys" ] (Decode.list journeyDecoder)


journeyDecoder : Decode.Decoder Journey
journeyDecoder =
    decode Journey
        |> required "duration" Decode.int
        |> required "legs" (Decode.list legDecoder)


legDecoder : Decode.Decoder Leg
legDecoder =
    Decode.at [ "instruction", "summary" ] Decode.string



--(Decode.field "duration" Decode.int)
