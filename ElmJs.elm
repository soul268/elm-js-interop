port module ElmJs exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  { word : String }

init : (Model, Cmd Msg)
init =
  (Model "123", Cmd.none)

-- UPDATE

type Msg
  = Change String
  | Check
  -- | Suggest (List String)

port check : String -> Cmd msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Change newWord ->
      ( Model newWord, Cmd.none )

    Check ->
      ( model, check model.word )

    -- Suggest newSuggestions ->
    --   ( Model model.word newSuggestions, Cmd.none )

port change : (String -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
  change Change

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [
      div [] [ (text model.word) ]
    ]
