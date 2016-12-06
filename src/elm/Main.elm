module Main exposing (..)

import Html exposing (Html, program, div)
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
    { form : Form.Model }


type Msg
    = FormMsg Form.Msg


init : ( Model, Cmd Msg )
init =
    ( { form = Form.init
      }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FormMsg formMsg ->
            let
                ( updatedFormModel, formCmd ) =
                    Form.update formMsg model.form
            in
                ( { model | form = updatedFormModel }, Cmd.map FormMsg formCmd )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.map FormMsg (Form.view model.form) ]
