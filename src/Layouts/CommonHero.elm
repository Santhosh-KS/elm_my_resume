module Layouts.CommonHero exposing (Model, Msg, Props, layout)

import Effect exposing (Effect)
import Html exposing (Html)
import Html.Attributes as Attr
import Layout exposing (Layout)
import Route exposing (Route)
import Shared
import View exposing (View)


type alias Props =
    {}


layout : Props -> Shared.Model -> Route () -> Layout () Model Msg contentMsg
layout props shared route =
    Layout.new
        { init = init
        , update = update
        , view = view
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


view : { toContentMsg : Msg -> contentMsg, content : View contentMsg, model : Model } -> View contentMsg
view { toContentMsg, model, content } =
    { title = content.title

    {- , body =
       [ Html.text "Profile Hero"
       , Html.div [ Attr.class "page" ] content.body
       ]
    -}
    , body =
        [ Html.div []
            [ hero model
            ]
            |> Html.map toContentMsg
        , viewMainContent
            { title = ""
            , content = content
            }
        ]
    }



{- .hero {
     background-image: url(https://picsum.photos/id/381/1920/1080);
     background: linear-gradient(rgba(31, 44, 108, 0.65), rgba(31, 44, 108, 0.65)), rgba(0, 0, 0, 0.55) url("https://picsum.photos/id/381/1920/1080") no-repeat;
     background-attachment: fixed;
     background-size: cover;
     color: white;
     box-shadow: inset 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23);
     font-family: 'Poppins', sans-serif;
   }
-}


hero : Model -> Html Msg
hero model =
    Html.section
        [ Attr.class "hero is-fullwidth has-background-primary-05 has-text-centered "

        -- , Attr.style "background-image" "/assets/man.webp"
        -- , Attr.style "background-image" "url(https://picsum.photos/id/381/1920/1080)"
        , Attr.style "background-image" "url(https://www.munich.travel/var/ger_muc/storage/images/_aliases/stage_large/3/9/5/8/78593-1-ger-DE/olympiapark-olympiaturm-75080341-500px-sanjin-kusan-3000.jpg)"

        -- , Attr.style "background-image" "url(https://plus.unsplash.com/premium_photo-1661963646444-ea17cd77c212?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)"
        -- , Attr.style "background-image" "url(https://images.pexels.com/photos/2127024/pexels-photo-2127024.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1)"
        , Attr.style "background-repeat" "no-repeat"
        , Attr.style "background-position" "bottom"
        ]
        [ Html.div
            [ Attr.class "hero-body"

            -- , Attr.style "background-image" "https://picsum.photos/id/381/1920/1080"
            ]
            [ profilePicview model
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
                , Html.p [ Attr.class "is-size-2 has-text-white" ] [ Html.text "Santhosh K S" ]
                , Html.p [ Attr.class "is-size-4 " ] [ Html.text "Seasoned professional" ]
                , Html.p [ Attr.class "has-text-white" ] [ Html.text "C,C++,Matlab,Python,Go,Swift,Embedded systems,Fullstack developer" ]
                , iconsListView model
                ]
            ]
        ]


iconsListView : Model -> Html Msg
iconsListView model =
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
