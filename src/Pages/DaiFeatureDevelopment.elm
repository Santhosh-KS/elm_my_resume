module Pages.DaiFeatureDevelopment exposing (Model, Msg, page)

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
        { backgroundImageUrl = "https://cdn.pixabay.com/photo/2021/11/20/05/15/car-6810885_1280.jpg"
        , position = "bottom"
        , size = "100%"
        , title = "Drive Away Information"
        , subtitle = "ADAS feature for distracted drivers"
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
    { title = "Pages.DaiFeatureDevelopment"
    , body = [ Html.text "/daiFeatureDevelopment" ]
    }
