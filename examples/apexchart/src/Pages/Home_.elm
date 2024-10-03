module Pages.Home_ exposing (Model, Msg, page)

import Effect exposing (Effect)
import Html exposing (Html)
import Html.Attributes as Attr
import Json.Encode as Encode
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


intEncoding : Int -> Encode.Value
intEncoding v =
    Encode.int v


myData : List Int -> Encode.Value
myData vs =
    Encode.object
        [ ( "data", Encode.list intEncoding vs ) ]


view : Model -> View Msg
view model =
    { title = "Pages.Home_"
    , body =
        [ Html.text "/home_"
        , Html.div [ Attr.id "chart" ] []
        , Html.node "chart-demo" [ Attr.property "data" <| myData [ 10, 41, 35, 51, 49, 62, 69, 91, 148 ] ] []
        , Html.div [ Attr.id "multichart" ] []
        , Html.node "multi-chart-demo" [] []
        ]
    }
