module Pages.Register exposing (Model, Msg, page)

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
    { title = "Pages.Register"
    , body =
        [ containerView model
        ]
    }



-- https://bulmatemplates.github.io/bulma-templates/templates/register.html
-- columnLeftDetails model


columnLeftDetails : Model -> Html Msg
columnLeftDetails model =
    Html.div [ Attr.class "column left" ]
        [ Html.h1 [ Attr.class "title is-1" ] [ Html.text "Vbuntu" ]
        , Html.h1 [ Attr.class "subtitle is-4" ] [ Html.text "Newsletter subscription" ]
        , Html.p [] [ Html.text "Lorem ipsum dolor sit amet, officia excepteur ex fugiat reprehenderit enim labore culpa sint ad nisi Lorem pariatur mollit ex esse exercitation amet." ]
        ]


columnRightDetails : Model -> Html Msg
columnRightDetails model =
    Html.div [ Attr.class "column right has-text-centered" ]
        [ Html.h1 [ Attr.class "title is-4" ] [ Html.text "Sign up today" ]
        , Html.p [ Attr.class "description" ] [ Html.text "Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat." ]
        , Html.form [ Attr.class "form" ]
            [ formInputField "Name"
            , formInputField "Email"
            , submitButton "Submit"
            , smallText "Lorem ipsum dolor sit amet consectetur."
            ]
        ]


smallText : String -> Html Msg
smallText val =
    Html.small []
        [ Html.em [] [ Html.text val ]
        ]


submitButton : String -> Html Msg
submitButton v =
    Html.button [ Attr.class "button is-block is-primary is-fullwidth is-medium" ]
        [ Html.text v ]


formInputField : String -> Html Msg
formInputField val =
    Html.form [ Attr.class "field" ]
        [ Html.div [ Attr.class "control" ]
            [ Html.input
                [ Attr.class "input is-medium"
                , Attr.type_ "text"
                , Attr.placeholder val
                ]
                []
            ]
        ]


containerView : Model -> Html Msg
containerView model =
    Html.div [ Attr.class "container" ]
        [ Html.div [ Attr.class "columns is-multiline" ]
            [ Html.div [ Attr.class "column is-8 is-offset-2 register" ]
                [ Html.div [ Attr.class "columns" ]
                    [ columnLeftDetails model
                    , columnRightDetails model
                    ]
                ]

            {- columnLeft model
               , columnRight model
            -}
            ]
        ]
