module Main exposing (..)

import Html exposing (Html, program, div)
import Http exposing (request, header, send, expectJson, emptyBody)
import Json.Decode exposing (Decoder, field)
import Form


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
    { form : Form.Model
    , members : List Member
    }


type Msg
    = FormMsg Form.Msg
    | LeaderboardData (Result Http.Error (List ( String, Member )))


init : ( Model, Cmd Msg )
init =
    ( { form = Form.init
      , members = []
      }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FormMsg formMsg ->
            let
                ( updatedFormModel, formCmd, possibleInfo ) =
                    Form.update formMsg model.form
            in
                case possibleInfo of
                    Just ( url, token ) ->
                        ( model, getLeaderBoardData url token )

                    Nothing ->
                        ( { model | form = updatedFormModel }, Cmd.map FormMsg formCmd )

        LeaderboardData (Ok membersWithIds) ->
            let
                members =
                    List.map (\( id, member ) -> member) membersWithIds
            in
                ( { model | members = members }, Cmd.none )

        LeaderboardData (Err _) ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.map FormMsg (Form.view model.form) ]



-- LEADERBOARD REQUEST


type alias Member =
    { name : String
    , stars : Int
    , globalScore : Int
    , localScore : Int
    }


getLeaderBoardData : String -> String -> Cmd Msg
getLeaderBoardData url token =
    request
        { method = "GET"
        , headers = [ header "Cookie" ("session=" ++ token ++ ";") ]
        , url = url
        , body = emptyBody
        , expect = expectJson leaderboardDecoder
        , timeout = Nothing
        , withCredentials = False
        }
        |> send LeaderboardData


leaderboardDecoder : Decoder (List ( String, Member ))
leaderboardDecoder =
    Json.Decode.at [ "members" ] membersDecoder


membersDecoder : Decoder (List ( String, Member ))
membersDecoder =
    Json.Decode.keyValuePairs memberDecoder


memberDecoder : Decoder Member
memberDecoder =
    Json.Decode.map4
        Member
        (field "name" Json.Decode.string)
        (field "stars" Json.Decode.int)
        (field "global_score" Json.Decode.int)
        (field "local_score" Json.Decode.int)
