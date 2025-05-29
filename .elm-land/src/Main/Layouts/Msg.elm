module Main.Layouts.Msg exposing (..)

import Layouts.CommonHero
import Layouts.Footer


type Msg
    = CommonHero Layouts.CommonHero.Msg
    | Footer Layouts.Footer.Msg
