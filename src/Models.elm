module Models exposing (..)

-- MODEL
--type alias TravelDuration =
--    { time : Int
--    }

import Http exposing (..)


type alias Leg =
    String


type alias Journey =
    { duration : Int
    , legs : List Leg
    }


type alias Model =
    { postCode : String
    , journeys : List Journey
    }


model : Model
model =
    { journeys =
        [ { duration = 32
          , legs =
                [ "Walk to Bow Church DLR"
                , "25 bus or 205 bus to Mile End Station"
                , "Get off at Mile End Station / Mile End Rd"
                , "339 bus to St Barnabas Church (E3)"
                , "Walk to E2 0SY"
                ]
          }
        ]
    , postCode = "e3 3hr"
    }


type Msg
    = Change String
    | NewTime (Result Http.Error (List Journey))
    | GetTime
