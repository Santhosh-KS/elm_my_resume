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
    { title = "Upload Example"
    , body =
        [ -- Html.text "/nu"
          m model
        ]
    }


m : Model -> Html Msg
m model =
    Html.form []
        [ Html.div []
            [ {- Html.input
                     [ Attr.type_ "file"
                     , Html.Events.on "change" (D.map GotFiles filesDecoder)
                     ]
                     []
                 , Html.button
                     [ Attr.type_ "submit"
                     , Html.Events.onClick UploadButtonClicked
                     ]
                     [ Html.text "My New upload.." ]
              -}
              newUploadView model
            ]
        ]


filesDecoder : D.Decoder (List File)
filesDecoder =
    D.at [ "target", "files" ] (D.list File.decoder)


newUploadView : Model -> Html Msg
newUploadView model =
    let
        f =
            List.map File.name model |> String.join " "
    in
    Html.div [ Attr.class "container" ]
        [ Html.h1 [ Attr.class "title" ] [ Html.text "Upload File Example.." ]
        , Html.div [ Attr.class "file has-name" ]
            [ Html.label [ Attr.class "file-label" ]
                [ Html.input
                    [ Attr.class "file-input"
                    , Attr.type_ "file"
                    , Html.Events.on "change" (D.map GotFiles filesDecoder)
                    , Attr.name "SomeName"
                    ]
                    []
                , Html.span [ Attr.class "file-cta" ]
                    [ Html.i [ Attr.class "fas fa-upload" ] []
                    , Html.span [ Attr.class "file-label" ] [ Html.text "Choose a file" ]
                    ]
                , Html.span [ Attr.class "file-name" ] [ Html.text f ]
                ]
            ]
        , Html.button
            [ Attr.class "button is-primary"
            , Attr.type_ "submit"
            , Html.Events.onClick UploadButtonClicked
            ]
            [ Html.text "My New upload.." ]
        ]
