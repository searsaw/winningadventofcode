module Form exposing (..)

import Html exposing (Html, text, form, label, input, select, option, button)
import Html.Attributes exposing (id, for, value, type_)
import Html.Events exposing (onInput, onSubmit)


-- INIT


type alias Model =
    { sessionToken : String
    , leaderboard : String
    , year : String
    }


type Msg
    = UpdateToken String
    | UpdateLeaderboard String
    | UpdateYear String
    | FormSubmitted


init : Model
init =
    { sessionToken = ""
    , leaderboard = ""
    , year = "2016"
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateToken token ->
            ( { model | sessionToken = token }, Cmd.none )

        UpdateLeaderboard leaderboard ->
            ( { model | leaderboard = leaderboard }, Cmd.none )

        UpdateYear year ->
            ( { model | year = year }, Cmd.none )

        FormSubmitted ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    form [ onSubmit FormSubmitted ]
        [ label [ for "token" ] [ text "Session token" ]
        , input [ id "token", value model.sessionToken, onInput UpdateToken ] []
        , label [ for "leaderboard" ] [ text "Leaderboard ID" ]
        , input [ id "leaderboard", value model.leaderboard, onInput UpdateLeaderboard ] []
        , label [ for "year" ] [ text "Year" ]
        , select [ id "year", value model.year, onInput UpdateYear ]
            [ option [ value "2016" ] [ text "2016" ]
            , option [ value "2015" ] [ text "2015" ]
            ]
        , button [ type_ "submit" ] [ text "Find the winners!" ]
        ]
