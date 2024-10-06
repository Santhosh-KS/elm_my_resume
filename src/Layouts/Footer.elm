module Layouts.Footer exposing (Model, Msg, Props, layout)

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
    = ReplaceMe


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        ReplaceMe ->
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
    , body =
        [ viewMainContent
            { title = ""
            , content = content
            }
        , footer
            { domainName = "vbuntu.org"
            , name = "Santhosh K S"
            , websiteLink = "https://vbuntu.org"
            , license = "CC XX YY ZZ "
            , licenseLink = ""
            }
            |> Html.map toContentMsg
        ]
    }


footer :
    { domainName : String
    , name : String
    , websiteLink : String
    , license : String
    , licenseLink : String
    }
    -> Html Msg
footer props =
    Html.footer [ Attr.class "footer" ]
        [ Html.div [ Attr.class "content has-text-centered" ]
            [ Html.p []
                [ Html.strong [] [ Html.text props.domainName ]
                , Html.text " by "
                , Html.a [ Attr.href props.websiteLink ] [ Html.text props.name ]
                , Html.text "Website content is licensed"
                , Html.a [ Attr.href props.licenseLink ] [ Html.text props.license ]
                ]
            ]
        ]


viewMainContent : { title : String, content : View msg } -> Html msg
viewMainContent { title, content } =
    Html.main_ [ Attr.class "is-flex is-flex-direction-column is-flex-grow-1" ]
        [ Html.div [ Attr.class "p-4" ] content.body
        ]
