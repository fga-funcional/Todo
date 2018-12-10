module App exposing (init, main, update, view)
import Browser

import Html exposing (Html, input, text, button, div, ul, li)
import Html.Attributes exposing (disabled, placeholder, value, style)
import Html.Events exposing (onClick, onInput)
import Msg exposing (..)
import Models exposing (Model, Content)
import Views exposing (..)


main =
    Browser.sandbox
    { view = view
    , update = update
    , init = init
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

update : Msg -> Model -> Model
update msg m =
    case msg of
        Add title ->
            { m
                | content =
                    { id = (List.length m.content)
                    , title = title
                    }
                        :: m.content
                , titleInput = ""
            }

        Remove id ->
            { m
                | content = List.filter (\item -> item.id /= id) m.content
            }

        ChangeInputText text ->
            { m
                | titleInput = text
            }

        Clear ->
            { content = []
            , titleInput = "" }


view : Model -> Html Msg
view m =
    div [ ]
        [ input
            [ placeholder "Escreva sua tarefa"
            , onInput ChangeInputText
            , value m.titleInput
            ]
            []
        , button
            [ onClick (Add m.titleInput)
            , disabled (String.length m.titleInput == 0)
            ]
            [ Html.text "Adicionar Tarefa" ]
        , button
            [ onClick (Clear)
            ]
            [ Html.text "Limpar Lista" ]
        , div [] [ toDomList m.content .title ]
        ]
