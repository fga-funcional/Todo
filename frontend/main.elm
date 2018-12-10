module App exposing (init, main, update, view)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox
    { view = view
    , update = update
      , init = init
    }

-- MODEL --------------------------------------------------

type alias Content =
    { id : Int
    , title : String
    }


type alias Model =
    { content : List Content
    , titleInput : String
    }


model : Model
model =
    { content = []
    , titleInput = ""
    }

init : Model
init =
      { content = []
      , titleInput = "" }

-- MESSAGES ----------------------------------------------

type Msg
    = Add String
    | ChangeInputText String
    | Remove Int



update : Msg -> Model -> Model
update msg m =
    case msg of
        Add title ->
            { m
                | content =
                    [ { id = (List.length m.content)
                      , title = title
                      }
                    ]
                        ++ m.content
                , titleInput = ""
            }

        Remove id ->
            { model
                | content = List.filter (\item -> item.id /= id) model.content
            }

        ChangeInputText text ->
            { model
                | titleInput = text
            }


toUlList : List Content -> (Content -> String) -> Html Msg
toUlList entry key =
    ul []
        (List.map
            (\item ->
                li
                    [ onClick <| Remove item.id
                    ]
                    [ Html.text (key item) ]
            )
            entry
        )


view : Model -> Html Msg
view m =
    div [ ]
        [ input
            [ placeholder "Enter a todo"
            , onInput ChangeInputText
            , value m.titleInput
            ]
            []
        , button
            [ onClick (Add m.titleInput)
            , disabled (String.length m.titleInput == 0)
            ]
            [ Html.text "Add Todo" ]
        , div [] [ toUlList m.content .title ]
        ]
