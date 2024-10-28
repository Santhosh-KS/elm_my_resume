module Pages.Upload exposing (Model, Msg, page)

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
    { title = "Upload"
    , body =
        [ -- Html.text "/upload"
          uploadView
        ]
    }


uploadView : Html msg
uploadView =
    Html.form
        [ Attr.action "http://localhost:4000/v1/upload"
        , Attr.enctype "multipart/form-data"
        , Attr.method "post"
        ]
        [ Html.h1 [] [ Html.text "File upload example" ]
        , Html.input
            [ Attr.type_ "file"
            , Attr.name "myFile"
            ]
            []
        , Html.input
            [ Attr.type_ "submit"
            , Attr.value "Upload file.."
            ]
            []
        ]
