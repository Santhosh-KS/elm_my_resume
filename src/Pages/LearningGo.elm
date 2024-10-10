module Pages.LearningGo exposing (Model, Msg, page)

import Effect exposing (Effect)
import Html
import Layouts
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
        |> Page.withLayout layout


layout : Shared.Model -> Layouts.Layout Msg
layout model =
    Layouts.CommonHero
        { backgroundImageUrl = "https://go.dev/blog/go-brand/Go-Logo/PNG/Go-Logo_Blue.png"

        -- , position = "right 1% bottom 2%"
        , position = "center"
        , size = "60%"
        , title = "Go"
        , subtitle = "Lets Go!"
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
    { title = "Learning Go"
    , body = [ Html.text "/learningGo" ]
    }
