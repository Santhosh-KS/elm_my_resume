module Layouts exposing (..)

import Layouts.CommonHero
import Layouts.Footer


type Layout msg
    = CommonHero Layouts.CommonHero.Props
    | Footer Layouts.Footer.Props


map : (msg1 -> msg2) -> Layout msg1 -> Layout msg2
map fn layout =
    case layout of
        CommonHero data ->
            CommonHero data

        Footer data ->
            Footer data
