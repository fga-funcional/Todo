module App exposing (init, main, update, viewTasks)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (decodeString, list, string)
import Http
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Button as Button
import Bootstrap.Navbar as Navbar


main =
    Browser.element
        { view = viewTasks
        , update = update
        , init = init
        , subscriptions = subscriptions
        }

-- MODEL --------------------------------------------------

type alias Model =
    { todos : List String, current : String }


init : () -> (Model, Cmd Msg)
init = update GetTasks

-- MESSAGES ----------------------------------------------


type Msg
    = Clear
    | Add
    | Current String
    | GotTasks (Result Http.Error List String)
    | GetTasks
    | NoOp

update : Msg -> Model -> (Model, Cmd Msg)
update msg m =
    case msg of
        NoOp ->
          (m, Cmd.none )
        GetTasks ->
          ( m, Http.send GotTasks getTasks )
        Clear ->
            (m, Cmd.none )

        Add ->
            (m, Cmd.none )

        Current st ->
            (m, Cmd.none )

        GotTasks result ->
          case result of
            Ok url ->
              (m, Cmd.none )
            Err _ ->
              (m, Cmd.none )

-- VIEW --------------------------------------------------


viewTasks : Model -> Html Msg
viewTasks m =
    div []
        [ h1 [] [ text "TODOS" ]
        , showTodos m.todos
        , inputElem m
        , button [ onClick Add ] [ text "Add" ]
        , button [ onClick Clear ] [ text "Clear" ]
        ]


showTodos m =
    ul [] (List.map showTodo m)


showTodo st =
    li [] [ text st ]


inputElem m =
    input
        [ placeholder "What to do?"
        , onInput Current
        , value m.current
        ]
        []

-- Http Requests --------------------------------------------------

getTasks : Cmd Msg
getTasks =
  Http.get
    { url = "http://localhost:3000/tasks/2018-01-01"
    , expect = Http.expectJson GotTasks (list string)
    }

-- listDecoder : String -> List String
-- listDecoder result =
--   decodeString(list string) result |> Result.withDefault []


-- SUBSCRIPTIONS --------------------------------------------------


subscriptions : Model -> Sub Msg
subscriptions m =
  Sub.none
