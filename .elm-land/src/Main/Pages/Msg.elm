module Main.Pages.Msg exposing (Msg(..))

import Pages.Home_
import Pages.About
import Pages.Contact
import Pages.DaiFeatureDevelopment
import Pages.Dspace
import Pages.Featuredevelopment_traffic_assist
import Pages.Functionalprogramming
import Pages.Geometricalgebra
import Pages.LearningElm
import Pages.LearningGo
import Pages.LearningSwift
import Pages.Munich_diaries
import Pages.ProjectBMW
import Pages.Register
import Pages.Techkunstler
import Pages.NotFound_


type Msg
    = Home_ Pages.Home_.Msg
    | About Pages.About.Msg
    | Contact Pages.Contact.Msg
    | DaiFeatureDevelopment Pages.DaiFeatureDevelopment.Msg
    | Dspace Pages.Dspace.Msg
    | Featuredevelopment_traffic_assist Pages.Featuredevelopment_traffic_assist.Msg
    | Functionalprogramming Pages.Functionalprogramming.Msg
    | Geometricalgebra Pages.Geometricalgebra.Msg
    | LearningElm Pages.LearningElm.Msg
    | LearningGo Pages.LearningGo.Msg
    | LearningSwift Pages.LearningSwift.Msg
    | Munich_diaries Pages.Munich_diaries.Msg
    | ProjectBMW Pages.ProjectBMW.Msg
    | Register Pages.Register.Msg
    | Techkunstler Pages.Techkunstler.Msg
    | NotFound_ Pages.NotFound_.Msg
