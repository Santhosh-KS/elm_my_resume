module Main.Layouts.Model exposing (..)

import Layouts.CommonHero
import Layouts.Footer


type Model
    = CommonHero { commonHero : Layouts.CommonHero.Model }
    | Footer { footer : Layouts.Footer.Model }
