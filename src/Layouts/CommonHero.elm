module Layouts.CommonHero exposing (Model, Msg, Props, layout)

import Effect exposing (Effect)
import Html exposing (Html)
import Html.Attributes as Attr
import Layout exposing (Layout)
import Route exposing (Route)
import Route.Path
import Shared
import View exposing (View)


type alias Props =
    { backgroundImageUrl : String
    , position : String
    , size : String

    {- , title : String
       , subtitle: String
    -}
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
    = NoOp


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Effect.none
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
            ]
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
                        , Attr.src "./assets/meSmall.png"
                        ]
                        []
                    ]
                , Html.p [ Attr.class "title is-size-2", Attr.id "fancy" ] [ Html.text "Santhosh K S" ]
                , Html.p [ Attr.class "subtitle" ] [ Html.text "Seasoned professional" ]
                , Html.p [ Attr.class "has-text-white" ] [ Html.text "C,C++,Python,Go,Swift,Matlab,Embedded systems,Fullstack developer" ]
                , iconsListView props
                ]
            ]
        ]


iconsListView : Props -> Html Msg
iconsListView props =
    Html.div []
        [ Html.ul [ Attr.class "icons ml-0" ]
            [ Html.li [ Attr.class "is-inline is-size-4" ]
                [ Html.a
                    [ Attr.href "#contact"
                    , Attr.class "fa-solid fa-envelope has-text-white "
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
                    [ Attr.href "https://github.com/Santhosh-KS"

                    -- Attr.href "#github"
                    ]
                    [ Html.i
                        [ Attr.class "fab fa-github has-text-white"
                        ]
                        []
                    ]
                ]
            , Html.li [ Attr.class "is-inline is-size-4 ml-3" ]
                [ Html.a
                    [ Attr.href "https://www.linkedin.com/in/santhosh-k-s-07542623/"
                    , Attr.class "fab fa-linkedin has-text-white"
                    ]
                    []
                ]
            ]
        ]


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
