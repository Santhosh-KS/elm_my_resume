module Pages.Home_ exposing (Model, Msg, page)

import Effect exposing (Effect)
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events
import Page exposing (Page)
import Route exposing (Route)
import Shared
import View exposing (View)


type NavBarItems
    = Home


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- INIT


type alias Model =
    { isBurgerIconActive : Bool
    }


init : () -> ( Model, Effect Msg )
init () =
    ( { isBurgerIconActive = False }
    , Effect.none
    )



-- UPDATE


type Msg
    = BurgerIconClicked


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        BurgerIconClicked ->
            ( { model | isBurgerIconActive = True }
            , Effect.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Pages.Home_"
    , body =
        [ -- Html.text "/home_"
          hero model
        , timelineView model
        ]
    }


navbarMenu : Model -> Html Msg
navbarMenu model =
    Html.div
        [ Attr.class "navbar-menu"
        , Attr.classList
            [ ( "is-active", model.isBurgerIconActive )
            ]
        ]
        []


navbarBurger : Bool -> Html Msg
navbarBurger f =
    Html.a
        [ Attr.class "navbar-burger"
        , Html.Events.onClick BurgerIconClicked
        ]
        [ Html.span [] []
        , Html.span [] []
        , Html.span [] []
        , Html.span [] []
        , Html.span [] []
        ]


navbarBrandImage : Model -> Html Msg
navbarBrandImage model =
    Html.a [ Attr.class "navbar-item " ]
        [ Html.img
            [ Attr.src "./assets/ms.jpg"
            , Attr.class "py-2 px-2"
            , Attr.style "max-height" "70px"
            ]
            []
        ]


navbarBrand : Model -> Html Msg
navbarBrand model =
    Html.div [ Attr.class "navbar-brand" ]
        [ -- navbarBrandImage model
          navbarBurger model.isBurgerIconActive
        ]


navbar : Model -> Html Msg
navbar model =
    Html.nav
        [ Attr.class "navbar  is-warning is-fixed-top"
        ]
        [ navbarBrand model
        , navbarMenu model
        , navbarEnd model
        ]


navbarEnd : Model -> Html Msg
navbarEnd model =
    Html.div [ Attr.class "navbar-end" ]
        [ Html.div [ Attr.class "navbar-item" ]
            [ Html.div [ Attr.class "buttons" ]
                [ Html.div [ Attr.class "button is-link" ] [ Html.strong [] [ Html.text "Sign up" ] ]

                -- , Html.div [ Attr.class "button is-light" ] [ Html.strong [] [ Html.text "Log in" ] ]
                ]
            ]
        ]


hero : Model -> Html Msg
hero model =
    Html.section [ Attr.class "hero is-fullwidth has-background-primary-05 has-text-centered " ]
        [ Html.div [ Attr.class "hero-head " ]
            [ navbar model
            ]
        , Html.div
            [ Attr.class "hero-body" ]
            [ {- Html.p [ Attr.class "title" ] [ Html.text "Santhosh" ]
                 , Html.p [ Attr.class "subtitle" ] [ Html.text "Entreprenur" ]
              -}
              profilePicview model
            ]
        ]


iconsListView : Model -> Html Msg
iconsListView model =
    Html.div []
        [ Html.ul [ Attr.class "icons ml-0" ]
            [ Html.li [ Attr.class "is-inline is-size-4" ]
                [ Html.a
                    [ Attr.href "#contact"
                    , Attr.class "fas fa-envelope has-text-white "
                    ]
                    []
                ]
            , Html.li [ Attr.class "is-inline is-size-4 ml-3" ]
                [ Html.a
                    [ Attr.href "#mobile"
                    , Attr.class "fas fa-mobile has-text-white"
                    ]
                    []
                ]
            , Html.li [ Attr.class "is-inline is-size-4 ml-3" ]
                [ Html.a
                    [ Attr.href "#github"
                    ]
                    [ Html.i
                        [ Attr.class "fab fa-github has-text-white"
                        ]
                        []
                    ]
                ]
            , Html.li [ Attr.class "is-inline is-size-4 ml-3" ]
                [ Html.a
                    [ Attr.href "#linkedin"
                    , Attr.class "fab fa-linkedin has-text-white"
                    ]
                    []
                ]
            ]
        ]


profilePicview : Model -> Html Msg
profilePicview model =
    Html.section [ Attr.class "section" ]
        [ Html.div [ Attr.class "content is-mobile is-centered" ]
            [ Html.div [ Attr.class "is-half has-text-centered" ]
                [ Html.figure [ Attr.class "image is-inline-block mb-0 mt-3" ]
                    [ Html.img
                        [ Attr.class "is-rounded is-128x128"
                        , Attr.src "./assets/man.webp"
                        ]
                        []
                    ]
                , Html.img [ Attr.class "is-size-2 has-text-white" ] [ Html.text "John Doe" ]
                , Html.p [ Attr.class "has-text-white" ] [ Html.text "Senior bakend developer" ]
                , iconsListView model
                ]
            ]
        ]


timelineView : Model -> Html Msg
timelineView model =
    Html.div [ Attr.class "timeline is-centered" ]
        [ Html.header [ Attr.class "timeline-header is-centered" ]
            [ Html.span [ Attr.class "tag is-medium is-primary is-centered" ] [ Html.text "Start" ]
            ]
        , Html.div [ Attr.class "timeline-item" ]
            [ Html.div [ Attr.class "timeline-marker" ] []
            , Html.div [ Attr.class "timeline-content" ]
                [ Html.p [ Attr.class "heading" ] [ Html.text "Jan 2016" ]
                , Html.p [] [ Html.text "Timeline contnet can include my HTML element" ]
                ]
            ]
        , Html.div [ Attr.class "timeline-header" ]
            [ Html.span [ Attr.class "tag is-medium is-primary" ] [ Html.text "End" ]
            ]
        ]
