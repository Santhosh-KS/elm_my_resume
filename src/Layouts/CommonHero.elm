module Layouts.CommonHero exposing (Model, Msg, Props, layout)

import Dict
import Effect exposing (Effect)
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events
import Layout exposing (Layout)
import Route exposing (Route)
import Route.Path
import Shared
import View exposing (View)


type alias Props =
    { backgroundImageUrl : String
    , position : String
    , size : String
    , title : String
    , subtitle : String
    }


layout : Props -> Shared.Model -> Route () -> Layout () Model Msg contentMsg
layout props shared route =
    Layout.new
        { init = init
        , update = update
        , view = view props route
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    {}


init : () -> ( Model, Effect Msg )
init _ =
    ( {}
    , Effect.none
    )



-- UPDATE


type Msg
    = HomeButtonClicked


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        HomeButtonClicked ->
            ( model
            , Effect.pushRoute
                { path = Route.Path.Home_
                , query = Dict.empty
                , hash = Nothing
                }
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW
{- applyOnlyToHome : Route () -> Html Msg
   applyOnlyToHome route =
-}


view : Props -> Route () -> { toContentMsg : Msg -> contentMsg, content : View contentMsg, model : Model } -> View contentMsg
view props route { toContentMsg, model, content } =
    let
        hidden =
            Attr.hidden
                (route.path
                    /= Route.Path.Home_
                )
    in
    { title = content.title

    {- , body =
       [ Html.text "Profile Hero"
       , Html.div [ Attr.class "page" ] content.body
       ]
    -}
    , body =
        [ Html.div []
            [ Html.div
                [ Attr.style "border-top" "10px solid coral"
                , hidden
                ]
                []
            , hero props route
            , Html.div [ Attr.style "border-top" "10px solid coral", hidden ] []
            ]
            |> Html.map toContentMsg
        , viewMainContent
            { title = ""
            , content = content
            }
        ]
    }


navBarBurger : Html Msg
navBarBurger =
    Html.div [ Attr.class "navbar-burger burger" ]
        [ Html.span [] []
        , Html.span [] []
        , Html.span [] []
        , Html.span [] []
        ]


navBar : Html Msg
navBar =
    Html.div [ Attr.class "navbar" ]
        [ Html.div [ Attr.class "container" ]
            [ navBarBurger
            , navBarEnd
            ]
        ]


navBarEnd : Html Msg
navBarEnd =
    Html.div [ Attr.class "navbar-end" ]
        [ Html.div
            [ Attr.class "navbar-item is-active"
            ]
            [ Html.a [] [ Html.text "Home" ] ]
        ]


heroBodyTitleAndSubtitle : Props -> Route () -> Html Msg
heroBodyTitleAndSubtitle props route =
    Html.div [ Attr.hidden (route.path == Route.Path.Home_) ]
        [ Html.div [ Attr.class "title is-size-1", Attr.id "fancy" ] [ Html.text props.title ]
        , Html.div [ Attr.class "subtitle is-size-5 ", Attr.id "fancysubtitle" ] [ Html.text props.subtitle ]
        ]


hero : Props -> Route () -> Html Msg
hero props route =
    let
        url : String
        url =
            "url(" ++ props.backgroundImageUrl ++ ")"
    in
    Html.section
        [ Attr.class "hero is-fullwidth has-background-primary-05 has-text-centered "
        , Attr.style "background-image" url
        , Attr.style "background-repeat" "no-repeat"
        , Attr.style "background-position" props.position
        , Attr.style "background-size" props.size
        ]
        [ Html.div
            [ Attr.class "hero-body"
            ]
            [ profilePicview props route
            , heroBodyTitleAndSubtitle props route
            ]
        , Html.div
            [ Attr.hidden
                (route.path
                    == Route.Path.Home_
                )
            ]
            [ homeButton { icon = "fa-solid fa-house" } ]
        ]


programmingList : List String
programmingList =
    [ "C"
    , "C++"
    , "Python"
    , "Go"
    , "Swift"
    , "Matlab"
    , "Elm"
    , "Javascript"
    , "Fullstack"
    , "PostgreSQL"
    , "Functional programming"
    ]


profilePicview : Props -> Route () -> Html Msg
profilePicview props route =
    Html.section [ Attr.class "section" ]
        [ Html.div [ Attr.class "content is-mobile is-centered" ]
            [ Html.div
                [ Attr.class "is-half has-text-centered"
                , Attr.hidden
                    (route.path
                        /= Route.Path.Home_
                    )
                ]
                [ Html.figure
                    [ Attr.class "image is-inline-block mb-0 mt-3"
                    ]
                    [ Html.img
                        [ Attr.class "is-rounded is-128x128"
                        , Attr.src "/meSmall.png"
                        ]
                        []
                    ]
                , Html.p [ Attr.class "title is-size-2", Attr.id "fancy" ] [ Html.text "Santhosh K S" ]
                , Html.p [ Attr.class "subtitle" ] [ Html.text "Seasoned professional" ]
                , Html.p [ Attr.class "has-text-white" ]
                    (nonClickableButtons programmingList)
                , iconsListView props
                ]
            ]
        ]


iconsListView : Props -> Html Msg
iconsListView props =
    Html.div []
        [ Html.ul [ Attr.class "icons" ]
            [ Html.li [ Attr.class "is-inline is-size-3 m-3" ]
                [ Html.a
                    [ Attr.href "#contact"
                    , Attr.class "fa-solid fa-envelope has-text-white "
                    ]
                    []
                ]
            , Html.li [ Attr.class "is-inline is-size-3 m-3" ]
                [ Html.a
                    [ Attr.href "#mobile"
                    , Attr.class "fas fa-mobile has-text-white"
                    ]
                    []
                ]
            , Html.li [ Attr.class "is-inline is-size-3 m-1" ]
                [ Html.a
                    [ Attr.href "https://github.com/Santhosh-KS"

                    -- Attr.href "#github"
                    ]
                    [ Html.i
                        [ Attr.class "fab fa-github has-text-white"
                        ]
                        []
                    ]
                ]
            , Html.li [ Attr.class "is-inline is-size-2 m-1" ]
                [ Html.a
                    [ Attr.href "https://www.linkedin.com/in/santhosh-k-s-07542623/"
                    , Attr.class "fab fa-linkedin has-text-white"
                    ]
                    []
                ]
            ]
        ]


homeButton : { icon : String } -> Html Msg
homeButton props =
    Html.a
        [ Attr.class "button is-text is-large is-fullwidth  is-radiusless"
        , Html.Events.onClick HomeButtonClicked
        ]
        [ Html.i [ Attr.class props.icon ] [] ]


ncb : String -> Html Msg
ncb v =
    Html.div
        [ Attr.class "button is-small" ]
        [ Html.text v ]


nonClickableButtons : List String -> List (Html Msg)
nonClickableButtons vals =
    List.map ncb vals


viewMainContent : { title : String, content : View msg } -> Html msg
viewMainContent { title, content } =
    Html.main_ [ Attr.class "is-flex is-flex-direction-column is-flex-grow-1" ]
        [ {- Html.section [ Attr.class "hero is-info" ]
             [ Html.div [ Attr.class "hero-body" ]
                 [ Html.h1 [ Attr.class "title" ] [ Html.text title ]
                 ]
             ]
          -}
          Html.div [ Attr.class "p-4" ] content.body
        ]
