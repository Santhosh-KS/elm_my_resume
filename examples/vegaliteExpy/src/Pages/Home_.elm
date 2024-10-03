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


myUrl : String -> Encode.Value
myUrl v =
    Encode.object
        [ ( "url", Encode.string v ) ]


myPath : String -> Encode.Value
myPath p =
    Encode.object
        [ ( "path", Encode.string p ) ]


view : Model -> View Msg
view model =
    { title = "Pages.Home_"
    , body =
        [ Html.div [ Attr.id "vis" ] []
        , Html.div [ Attr.id "vis1" ] []
        , Html.div [ Attr.id "imdbDisp" ] []
        , Html.node "vega-demo"
            [ Attr.property "spec" <| myUrl "https://raw.githubusercontent.com/vega/vega/master/docs/examples/bar-chart.vg.json"
            , Attr.property "path" <| myPath "data/movies.json"
            , Attr.property "carPlot" <| myPath "https://cdn.jsdelivr.net/npm/vega-datasets@1.31.1/data/cars.json"

            -- , Attr.property "path" <| myPath "a,b,c\n1,2,3\n4,5,6\n7,8,9\n6,5,4\n3,2,1"
            ]
            []
        , Html.text "/home_"
        ]
    }
