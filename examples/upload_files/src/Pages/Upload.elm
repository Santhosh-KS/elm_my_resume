module Pages.Upload exposing (Model, Msg, page)

import Api.UploadFiles
import Effect exposing (Effect)
import File exposing (File)
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events
import Http
import Json.Decode as D
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
    List File


init : () -> ( Model, Effect Msg )
init () =
    ( []
    , Effect.none
    )



-- UPDATE


type Msg
    = GotFiles (List File)
    | UploadButtonClicked
    | UploadApiResponded (Result Http.Error String)


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        GotFiles files ->
            let
                a =
                    Http.post

                _ =
                    Debug.log "TEST" files
            in
            ( files, Effect.none )

        UploadButtonClicked ->
            let
                _ =
                    Debug.log "UploadButtonClicked" "calling post"
            in
            ( model
            , Api.UploadFiles.post
                { onResponse = UploadApiResponded
                , files = model
                }
            )

        UploadApiResponded (Ok value) ->
            let
                _ =
                    Debug.log "UploadApiResponded OK" "OK"
            in
            ( model, Effect.none )

        UploadApiResponded (Err httpErr) ->
            let
                _ =
                    Debug.log "UploadApiResponded ERR" "ERR"
            in
            ( model, Effect.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Pages.Nu"
    , body =
        [ -- Html.text "/nu"
          m
        ]
    }


m : Html Msg
m =
    Html.form []
        [ Html.div []
            [ Html.input
                [ Attr.type_ "file"

                -- , Attr.multiple True
                , Html.Events.on "change" (D.map GotFiles filesDecoder)
                ]
                []
            , Html.button
                [ Attr.type_ "submit"
                , Html.Events.onClick UploadButtonClicked
                ]
                [ Html.text "My New upload.." ]
            ]
        ]


filesDecoder : D.Decoder (List File)
filesDecoder =
    D.at [ "target", "files" ] (D.list File.decoder)
