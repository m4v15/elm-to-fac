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
        [ { duration = 0
          , legs =
                [ "" ]
          }
        ]
    , postCode = "e3 3hr"
    }


type Msg
    = Change String
    | NewTime (Result Http.Error (List Journey))
    | GetTime
