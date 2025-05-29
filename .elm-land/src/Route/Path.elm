module Route.Path exposing (Path(..), fromString, fromUrl, href, toString)

import Html
import Html.Attributes
import Url exposing (Url)
import Url.Parser exposing ((</>))


type Path
    = Home_
    | About
    | Contact
    | DaiFeatureDevelopment
    | Dspace
    | Featuredevelopment_traffic_assist
    | Functionalprogramming
    | Geometricalgebra
    | LearningElm
    | LearningGo
    | LearningSwift
    | Munich_diaries
    | ProjectBMW
    | Register
    | Techkunstler
    | NotFound_


fromUrl : Url -> Path
fromUrl url =
    fromString url.path
        |> Maybe.withDefault NotFound_


fromString : String -> Maybe Path
fromString urlPath =
    let
        urlPathSegments : List String
        urlPathSegments =
            urlPath
                |> String.split "/"
                |> List.filter (String.trim >> String.isEmpty >> Basics.not)
    in
    case urlPathSegments of
        [] ->
            Just Home_

        "about" :: [] ->
            Just About

        "contact" :: [] ->
            Just Contact

        "dai-feature-development" :: [] ->
            Just DaiFeatureDevelopment

        "dspace" :: [] ->
            Just Dspace

        "featuredevelopment_traffic_assist" :: [] ->
            Just Featuredevelopment_traffic_assist

        "functionalprogramming" :: [] ->
            Just Functionalprogramming

        "geometricalgebra" :: [] ->
            Just Geometricalgebra

        "learning-elm" :: [] ->
            Just LearningElm

        "learning-go" :: [] ->
            Just LearningGo

        "learning-swift" :: [] ->
            Just LearningSwift

        "munich_diaries" :: [] ->
            Just Munich_diaries

        "project-b-m-w" :: [] ->
            Just ProjectBMW

        "register" :: [] ->
            Just Register

        "techkunstler" :: [] ->
            Just Techkunstler

        _ ->
            Nothing


href : Path -> Html.Attribute msg
href path =
    Html.Attributes.href (toString path)


toString : Path -> String
toString path =
    let
        pieces : List String
        pieces =
            case path of
                Home_ ->
                    []

                About ->
                    [ "about" ]

                Contact ->
                    [ "contact" ]

                DaiFeatureDevelopment ->
                    [ "dai-feature-development" ]

                Dspace ->
                    [ "dspace" ]

                Featuredevelopment_traffic_assist ->
                    [ "featuredevelopment_traffic_assist" ]

                Functionalprogramming ->
                    [ "functionalprogramming" ]

                Geometricalgebra ->
                    [ "geometricalgebra" ]

                LearningElm ->
                    [ "learning-elm" ]

                LearningGo ->
                    [ "learning-go" ]

                LearningSwift ->
                    [ "learning-swift" ]

                Munich_diaries ->
                    [ "munich_diaries" ]

                ProjectBMW ->
                    [ "project-b-m-w" ]

                Register ->
                    [ "register" ]

                Techkunstler ->
                    [ "techkunstler" ]

                NotFound_ ->
                    [ "404" ]
    in
    pieces
        |> String.join "/"
        |> String.append "/"
