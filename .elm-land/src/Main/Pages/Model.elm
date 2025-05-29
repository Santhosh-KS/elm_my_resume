module Main.Pages.Model exposing (Model(..))

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
import View exposing (View)


type Model
    = Home_ Pages.Home_.Model
    | About Pages.About.Model
    | Contact Pages.Contact.Model
    | DaiFeatureDevelopment Pages.DaiFeatureDevelopment.Model
    | Dspace Pages.Dspace.Model
    | Featuredevelopment_traffic_assist Pages.Featuredevelopment_traffic_assist.Model
    | Functionalprogramming Pages.Functionalprogramming.Model
    | Geometricalgebra Pages.Geometricalgebra.Model
    | LearningElm Pages.LearningElm.Model
    | LearningGo Pages.LearningGo.Model
    | LearningSwift Pages.LearningSwift.Model
    | Munich_diaries Pages.Munich_diaries.Model
    | ProjectBMW Pages.ProjectBMW.Model
    | Register Pages.Register.Model
    | Techkunstler Pages.Techkunstler.Model
    | NotFound_ Pages.NotFound_.Model
    | Redirecting_
    | Loading_
