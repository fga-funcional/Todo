module App exposing (init, main, update, view)

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
    Browser.sandbox
        { view = view
        , update = update
        , init = init
        }



-- MODEL --------------------------------------------------


type alias Model =
    { todos : List String, current : String }


init : Model
init =
      { todos = listDecoder """["first", "second", "third"]""", current = "" }


-- MESSAGES ----------------------------------------------


type Msg
    = Clear
    | Add
    | Current String
    -- | GotTasks (Result Http.Error (List String))

update : Msg -> Model -> Model
update msg m =
    case msg of
        Clear ->
            { todos = []
            , current = ""
            }

        Add ->
            { todos = m.current :: m.todos
            , current = ""
            }

        Current st ->
            { m | current = st }

        -- GotTasks result ->
        --     { todos = result
        --     , current = ""
        --     }
-- VIEW --------------------------------------------------


view : Model -> Html Msg
view m =
    div []
        [ h1 [] [ text "TODOS" ]
        , showTodos m.todos
        , inputElem m
        , button [ onClick Add ] [ text "Add" ]
        , button [ onClick Clear ] [ text "Clear" ]
        -- , button [ onClick GotTasks ] [ text "GotTasks" ]
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

-- getTasks : Cmd Msg
-- getTasks =
--   Http.get
--     { url = "http://localhost:3000/tasks/2018-01-01"
--     , expect = Http.expectJson GotTasks (list string)
--     }
--
listDecoder : String -> List String
listDecoder result =
  decodeString(list string) result |> Result.withDefault []
