module Pages.Contact exposing (Model, Msg, page)

import Effect exposing (Effect)
import Html exposing (Html)
import Html.Attributes as Attr
import Page exposing (Page)
import Route exposing (Route)
import Shared
import View exposing (View)


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
    {}


init : () -> ( Model, Effect Msg )
init () =
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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Pages.Contact"
    , body =
        [ -- Html.text "/contact"
          contact model
        ]
    }


socialMediaBtn : { link : String, icon : String } -> Html Msg
socialMediaBtn props =
    Html.a
        [ Attr.class "button is-light is-large"
        , Attr.href props.link
        ]
        [ Html.i [ Attr.class props.icon ] [] ]


lhsText : Model -> Html Msg
lhsText model =
    Html.div [ Attr.class "column is-two-thirds has-text-left" ]
        [ Html.p [ Attr.class "title is-1" ] [ Html.text "Contact" ]
        , Html.p [ Attr.class "is-size-4" ]
            [ Html.text "If you have any questions, please fill the form. I will get in touch with you soon..." ]
        , Html.div [ Attr.class "social-media" ]
            [ socialMediaBtn { link = "https://facebook.com", icon = "fab fa-facebook-square" }
            , socialMediaBtn { link = "https://instagram.com", icon = "fab fa-instagram" }
            , socialMediaBtn { link = "https://twitter.com", icon = "fab fa-twitter" }
            ]
        ]


textFields : { label : String, type_ : String } -> Html Msg
textFields props =
    Html.div [ Attr.class "field" ]
        [ Html.div [ Attr.class "label" ] [ Html.text props.label ]
        , Html.div [ Attr.class "control" ]
            [ Html.div
                [ Attr.class "input is-medium"
                , Attr.type_ props.type_
                ]
                []
            ]
        ]


textArea : { label : String } -> Html Msg
textArea props =
    Html.div [ Attr.class "field" ]
        [ Html.div [ Attr.class "label" ] [ Html.text props.label ]
        , Html.div [ Attr.class "control" ]
            [ Html.div
                [ Attr.class "textarea is-medium"
                ]
                []
            ]
        ]


sendBtn : { label : String } -> Html Msg
sendBtn props =
    Html.div [ Attr.class "control" ]
        [ Html.div
            [ Attr.class "button is-link is-fullwidth has-text-weight-medium is-medium"
            , Attr.type_ "submit"
            ]
            [ Html.text props.label ]
        ]


rhsForm : Model -> Html Msg
rhsForm model =
    Html.div [ Attr.class "column is-one-third has-text-left" ]
        [ Html.div [ Attr.class "field" ]
            [ textFields { label = "Name", type_ = "text" }
            , textFields { label = "Email", type_ = "text" }
            , textArea { label = "Message" }
            , sendBtn { label = "Send Message" }
            ]
        ]


contact : Model -> Html Msg
contact model =
    Html.div [ Attr.class "hero is-fullheight" ]
        [ Html.div [ Attr.class "hero-body" ]
            [ Html.div [ Attr.class "container has-text-centered" ]
                [ Html.div [ Attr.class "columns is-8 is-variable" ]
                    [ lhsText model
                    , rhsForm model
                    ]
                ]
            ]
        ]
