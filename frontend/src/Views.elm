module Views exposing (toDomList)

import Html exposing (Html, ul, li)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Msg exposing (..)
import Models exposing (Content)


toDomList : List Content -> (Content -> String) -> Html Msg
toDomList entry key =
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
