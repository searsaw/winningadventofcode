module Main exposing (..)

import Html exposing (Html, program, div, text, form, label, input, select, option, button)
import Html.Attributes exposing (id, for, value, type_)
import Html.Events exposing (onInput, onSubmit)


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



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


init : ( Model, Cmd Msg )
init =
    ( { sessionToken = ""
      , leaderboard = ""
      , year = "2016"
      }
    , Cmd.none
    )



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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ form []
            [ label [ for "token" ] [ text "Session token" ]
            , input [ id "token", value model.sessionToken, onInput UpdateToken ] []
            , label [ for "leaderboard" ] [ text "Leaderboard Identification" ]
            , input [ id "leaderboard", value model.leaderboard, onInput UpdateLeaderboard ] []
            , label [ for "year" ] [ text "Year" ]
            , select [ id "year", value model.year, onInput UpdateYear ]
                [ option [ value "2015" ] [ text "2015" ]
                , option [ value "2016" ] [ text "2016" ]
                ]
            ]
        , button [ type_ "submit", onSubmit FormSubmitted ] [ text "Find the winners!" ]
        ]
