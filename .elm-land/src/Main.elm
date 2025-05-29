module Main exposing (..)

import Auth
import Auth.Action
import Browser
import Browser.Navigation
import Effect exposing (Effect)
import Html exposing (Html)
import Json.Decode
import Layout
import Layouts
import Layouts.CommonHero
import Layouts.Footer
import Main.Layouts.Model
import Main.Layouts.Msg
import Main.Pages.Model
import Main.Pages.Msg
import Page
import Pages.Home_
import Pages.About
import Pages.Contact
import Pages.DaiFeatureDevelopment
import Pages.Dspace
import Pages.Featuredevelopment_traffic_assist
import Pages.Functionalprogramming
import Pages.Geometricalgebra
import Pages.LearningElm
import Pages.LearningGo
import Pages.LearningSwift
import Pages.Munich_diaries
import Pages.ProjectBMW
import Pages.Register
import Pages.Techkunstler
import Pages.NotFound_
import Pages.NotFound_
import Route exposing (Route)
import Route.Path
import Shared
import Task
import Url exposing (Url)
import View exposing (View)


main : Program Json.Decode.Value Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlRequested
        }



-- INIT


type alias Model =
    { key : Browser.Navigation.Key
    , url : Url
    , page : Main.Pages.Model.Model
    , layout : Maybe Main.Layouts.Model.Model
    , shared : Shared.Model
    }


init : Json.Decode.Value -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init json url key =
    let
        flagsResult : Result Json.Decode.Error Shared.Flags
        flagsResult =
            Json.Decode.decodeValue Shared.decoder json

        ( sharedModel, sharedEffect ) =
            Shared.init flagsResult (Route.fromUrl () url)

        { page, layout } =
            initPageAndLayout { key = key, url = url, shared = sharedModel, layout = Nothing }
    in
    ( { url = url
      , key = key
      , page = Tuple.first page
      , layout = layout |> Maybe.map Tuple.first
      , shared = sharedModel
      }
    , Cmd.batch
          [ Tuple.second page
          , layout |> Maybe.map Tuple.second |> Maybe.withDefault Cmd.none
          , fromSharedEffect { key = key, url = url, shared = sharedModel } sharedEffect
          ]
    )


initLayout : { key : Browser.Navigation.Key, url : Url, shared : Shared.Model, layout : Maybe Main.Layouts.Model.Model } -> Layouts.Layout Msg -> ( Main.Layouts.Model.Model, Cmd Msg )
initLayout model layout =
    case ( layout, model.layout ) of
        ( Layouts.CommonHero props, Just (Main.Layouts.Model.CommonHero existing) ) ->
            ( Main.Layouts.Model.CommonHero existing
            , Cmd.none
            )

        ( Layouts.CommonHero props, _ ) ->
            let
                route : Route ()
                route =
                    Route.fromUrl () model.url

                commonHeroLayout =
                    Layouts.CommonHero.layout props model.shared route

                ( commonHeroLayoutModel, commonHeroLayoutEffect ) =
                    Layout.init commonHeroLayout ()
            in
            ( Main.Layouts.Model.CommonHero { commonHero = commonHeroLayoutModel }
            , fromLayoutEffect model (Effect.map Main.Layouts.Msg.CommonHero commonHeroLayoutEffect)
            )

        ( Layouts.Footer props, Just (Main.Layouts.Model.Footer existing) ) ->
            ( Main.Layouts.Model.Footer existing
            , Cmd.none
            )

        ( Layouts.Footer props, _ ) ->
            let
                route : Route ()
                route =
                    Route.fromUrl () model.url

                footerLayout =
                    Layouts.Footer.layout props model.shared route

                ( footerLayoutModel, footerLayoutEffect ) =
                    Layout.init footerLayout ()
            in
            ( Main.Layouts.Model.Footer { footer = footerLayoutModel }
            , fromLayoutEffect model (Effect.map Main.Layouts.Msg.Footer footerLayoutEffect)
            )


initPageAndLayout : { key : Browser.Navigation.Key, url : Url, shared : Shared.Model, layout : Maybe Main.Layouts.Model.Model } -> { page : ( Main.Pages.Model.Model, Cmd Msg ), layout : Maybe ( Main.Layouts.Model.Model, Cmd Msg ) }
initPageAndLayout model =
    case Route.Path.fromUrl model.url of
        Route.Path.Home_ ->
            let
                page : Page.Page Pages.Home_.Model Pages.Home_.Msg
                page =
                    Pages.Home_.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.Home_
                    (Effect.map Main.Pages.Msg.Home_ >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.Home_ >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.About ->
            let
                page : Page.Page Pages.About.Model Pages.About.Msg
                page =
                    Pages.About.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.About
                    (Effect.map Main.Pages.Msg.About >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.About >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.Contact ->
            let
                page : Page.Page Pages.Contact.Model Pages.Contact.Msg
                page =
                    Pages.Contact.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.Contact
                    (Effect.map Main.Pages.Msg.Contact >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.Contact >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.DaiFeatureDevelopment ->
            let
                page : Page.Page Pages.DaiFeatureDevelopment.Model Pages.DaiFeatureDevelopment.Msg
                page =
                    Pages.DaiFeatureDevelopment.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.DaiFeatureDevelopment
                    (Effect.map Main.Pages.Msg.DaiFeatureDevelopment >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.DaiFeatureDevelopment >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.Dspace ->
            let
                page : Page.Page Pages.Dspace.Model Pages.Dspace.Msg
                page =
                    Pages.Dspace.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.Dspace
                    (Effect.map Main.Pages.Msg.Dspace >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.Dspace >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.Featuredevelopment_traffic_assist ->
            let
                page : Page.Page Pages.Featuredevelopment_traffic_assist.Model Pages.Featuredevelopment_traffic_assist.Msg
                page =
                    Pages.Featuredevelopment_traffic_assist.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.Featuredevelopment_traffic_assist
                    (Effect.map Main.Pages.Msg.Featuredevelopment_traffic_assist >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.Featuredevelopment_traffic_assist >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.Functionalprogramming ->
            let
                page : Page.Page Pages.Functionalprogramming.Model Pages.Functionalprogramming.Msg
                page =
                    Pages.Functionalprogramming.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.Functionalprogramming
                    (Effect.map Main.Pages.Msg.Functionalprogramming >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.Functionalprogramming >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.Geometricalgebra ->
            let
                page : Page.Page Pages.Geometricalgebra.Model Pages.Geometricalgebra.Msg
                page =
                    Pages.Geometricalgebra.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.Geometricalgebra
                    (Effect.map Main.Pages.Msg.Geometricalgebra >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.Geometricalgebra >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.LearningElm ->
            let
                page : Page.Page Pages.LearningElm.Model Pages.LearningElm.Msg
                page =
                    Pages.LearningElm.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.LearningElm
                    (Effect.map Main.Pages.Msg.LearningElm >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.LearningElm >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.LearningGo ->
            let
                page : Page.Page Pages.LearningGo.Model Pages.LearningGo.Msg
                page =
                    Pages.LearningGo.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.LearningGo
                    (Effect.map Main.Pages.Msg.LearningGo >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.LearningGo >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.LearningSwift ->
            let
                page : Page.Page Pages.LearningSwift.Model Pages.LearningSwift.Msg
                page =
                    Pages.LearningSwift.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.LearningSwift
                    (Effect.map Main.Pages.Msg.LearningSwift >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.LearningSwift >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.Munich_diaries ->
            let
                page : Page.Page Pages.Munich_diaries.Model Pages.Munich_diaries.Msg
                page =
                    Pages.Munich_diaries.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.Munich_diaries
                    (Effect.map Main.Pages.Msg.Munich_diaries >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.Munich_diaries >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.ProjectBMW ->
            let
                page : Page.Page Pages.ProjectBMW.Model Pages.ProjectBMW.Msg
                page =
                    Pages.ProjectBMW.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.ProjectBMW
                    (Effect.map Main.Pages.Msg.ProjectBMW >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.ProjectBMW >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.Register ->
            let
                page : Page.Page Pages.Register.Model Pages.Register.Msg
                page =
                    Pages.Register.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.Register
                    (Effect.map Main.Pages.Msg.Register >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.Register >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.Techkunstler ->
            let
                page : Page.Page Pages.Techkunstler.Model Pages.Techkunstler.Msg
                page =
                    Pages.Techkunstler.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.Techkunstler
                    (Effect.map Main.Pages.Msg.Techkunstler >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.Techkunstler >> Page))
                    |> Maybe.map (initLayout model)
            }

        Route.Path.NotFound_ ->
            let
                page : Page.Page Pages.NotFound_.Model Pages.NotFound_.Msg
                page =
                    Pages.NotFound_.page model.shared (Route.fromUrl () model.url)

                ( pageModel, pageEffect ) =
                    Page.init page ()
            in
            { page = 
                Tuple.mapBoth
                    Main.Pages.Model.NotFound_
                    (Effect.map Main.Pages.Msg.NotFound_ >> fromPageEffect model)
                    ( pageModel, pageEffect )
            , layout = 
                Page.layout pageModel page
                    |> Maybe.map (Layouts.map (Main.Pages.Msg.NotFound_ >> Page))
                    |> Maybe.map (initLayout model)
            }


runWhenAuthenticated : { model | shared : Shared.Model, url : Url, key : Browser.Navigation.Key } -> (Auth.User -> ( Main.Pages.Model.Model, Cmd Msg )) -> ( Main.Pages.Model.Model, Cmd Msg )
runWhenAuthenticated model toTuple =
    let
        record =
            runWhenAuthenticatedWithLayout model (\user -> { page = toTuple user, layout = Nothing })
    in
    record.page


runWhenAuthenticatedWithLayout : { model | shared : Shared.Model, url : Url, key : Browser.Navigation.Key } -> (Auth.User -> { page : ( Main.Pages.Model.Model, Cmd Msg ), layout : Maybe ( Main.Layouts.Model.Model, Cmd Msg ) }) -> { page : ( Main.Pages.Model.Model, Cmd Msg ), layout : Maybe ( Main.Layouts.Model.Model, Cmd Msg ) }
runWhenAuthenticatedWithLayout model toRecord =
    let
        authAction : Auth.Action.Action Auth.User
        authAction =
            Auth.onPageLoad model.shared (Route.fromUrl () model.url)

        toCmd : Effect Msg -> Cmd Msg
        toCmd =
            Effect.toCmd
                { key = model.key
                , url = model.url
                , shared = model.shared
                , fromSharedMsg = Shared
                , batch = Batch
                , toCmd = Task.succeed >> Task.perform identity
                }
    in
    case authAction of
        Auth.Action.LoadPageWithUser user ->
            toRecord user

        Auth.Action.LoadCustomPage ->
            { page = 
                ( Main.Pages.Model.Loading_
                , Cmd.none
                )
            , layout = Nothing
            }

        Auth.Action.ReplaceRoute options ->
            { page = 
                ( Main.Pages.Model.Redirecting_
                , toCmd (Effect.replaceRoute options)
                )
            , layout = Nothing
            }

        Auth.Action.PushRoute options ->
            { page = 
                ( Main.Pages.Model.Redirecting_
                , toCmd (Effect.pushRoute options)
                )
            , layout = Nothing
            }

        Auth.Action.LoadExternalUrl externalUrl ->
            { page = 
                ( Main.Pages.Model.Redirecting_
                , Browser.Navigation.load externalUrl
                )
            , layout = Nothing
            }



-- UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url
    | Page Main.Pages.Msg.Msg
    | Layout Main.Layouts.Msg.Msg
    | Shared Shared.Msg
    | Batch (List Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequested (Browser.Internal url) ->
            ( model
            , Browser.Navigation.pushUrl model.key (Url.toString url)
            )

        UrlRequested (Browser.External url) ->
            if String.isEmpty (String.trim url) then
                ( model, Cmd.none )

            else
                ( model
                , Browser.Navigation.load url
                )

        UrlChanged url ->
            if Route.Path.fromUrl url == Route.Path.fromUrl model.url then
                let
                    newModel : Model
                    newModel =
                        { model | url = url }
                in
                ( newModel
                , Cmd.batch
                      [ toPageUrlHookCmd newModel
                            { from = Route.fromUrl () model.url
                            , to = Route.fromUrl () newModel.url
                            }
                      , toLayoutUrlHookCmd model newModel
                            { from = Route.fromUrl () model.url
                            , to = Route.fromUrl () newModel.url
                            }
                      ]
                )

            else
                let
                    { page, layout } =
                        initPageAndLayout { key = model.key, shared = model.shared, layout = model.layout, url = url }

                    ( pageModel, pageCmd ) =
                        page

                    ( layoutModel, layoutCmd ) =
                        case layout of
                            Just ( layoutModel_, layoutCmd_ ) ->
                                ( Just layoutModel_, layoutCmd_ )

                            Nothing ->
                                ( Nothing, Cmd.none )

                    newModel =
                        { model | url = url, page = pageModel, layout = layoutModel }
                in
                ( newModel
                , Cmd.batch
                      [ pageCmd
                      , layoutCmd
                      , toLayoutUrlHookCmd model newModel
                            { from = Route.fromUrl () model.url
                            , to = Route.fromUrl () newModel.url
                            }
                      ]
                )

        Page pageMsg ->
            let
                ( pageModel, pageCmd ) =
                    updateFromPage pageMsg model
            in
            ( { model | page = pageModel }
            , pageCmd
            )

        Layout layoutMsg ->
            let
                ( layoutModel, layoutCmd ) =
                    updateFromLayout layoutMsg model
            in
            ( { model | layout = layoutModel }
            , layoutCmd
            )

        Shared sharedMsg ->
            let
                ( sharedModel, sharedEffect ) =
                    Shared.update (Route.fromUrl () model.url) sharedMsg model.shared

                ( oldAction, newAction ) =
                    ( Auth.onPageLoad model.shared (Route.fromUrl () model.url)
                    , Auth.onPageLoad sharedModel (Route.fromUrl () model.url)
                    )
            in
            if isAuthProtected (Route.fromUrl () model.url).path && (hasActionTypeChanged oldAction newAction) then
                let
                    { layout, page } =
                        initPageAndLayout { key = model.key, shared = sharedModel, url = model.url, layout = model.layout }

                    ( pageModel, pageCmd ) =
                        page

                    ( layoutModel, layoutCmd ) =
                        ( layout |> Maybe.map Tuple.first
                        , layout |> Maybe.map Tuple.second |> Maybe.withDefault Cmd.none
                        )
                in
                ( { model | shared = sharedModel, page = pageModel, layout = layoutModel }
                , Cmd.batch
                      [ pageCmd
                      , layoutCmd
                      , fromSharedEffect { model | shared = sharedModel } sharedEffect
                      ]
                )

            else
                ( { model | shared = sharedModel }
                , fromSharedEffect { model | shared = sharedModel } sharedEffect
                )

        Batch messages ->
            ( model
            , messages
                  |> List.map (Task.succeed >> Task.perform identity)
                  |> Cmd.batch
            )


updateFromPage : Main.Pages.Msg.Msg -> Model -> ( Main.Pages.Model.Model, Cmd Msg )
updateFromPage msg model =
    case ( msg, model.page ) of
        ( Main.Pages.Msg.Home_ pageMsg, Main.Pages.Model.Home_ pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.Home_
                (Effect.map Main.Pages.Msg.Home_ >> fromPageEffect model)
                (Page.update (Pages.Home_.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.About pageMsg, Main.Pages.Model.About pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.About
                (Effect.map Main.Pages.Msg.About >> fromPageEffect model)
                (Page.update (Pages.About.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.Contact pageMsg, Main.Pages.Model.Contact pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.Contact
                (Effect.map Main.Pages.Msg.Contact >> fromPageEffect model)
                (Page.update (Pages.Contact.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.DaiFeatureDevelopment pageMsg, Main.Pages.Model.DaiFeatureDevelopment pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.DaiFeatureDevelopment
                (Effect.map Main.Pages.Msg.DaiFeatureDevelopment >> fromPageEffect model)
                (Page.update (Pages.DaiFeatureDevelopment.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.Dspace pageMsg, Main.Pages.Model.Dspace pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.Dspace
                (Effect.map Main.Pages.Msg.Dspace >> fromPageEffect model)
                (Page.update (Pages.Dspace.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.Featuredevelopment_traffic_assist pageMsg, Main.Pages.Model.Featuredevelopment_traffic_assist pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.Featuredevelopment_traffic_assist
                (Effect.map Main.Pages.Msg.Featuredevelopment_traffic_assist >> fromPageEffect model)
                (Page.update (Pages.Featuredevelopment_traffic_assist.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.Functionalprogramming pageMsg, Main.Pages.Model.Functionalprogramming pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.Functionalprogramming
                (Effect.map Main.Pages.Msg.Functionalprogramming >> fromPageEffect model)
                (Page.update (Pages.Functionalprogramming.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.Geometricalgebra pageMsg, Main.Pages.Model.Geometricalgebra pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.Geometricalgebra
                (Effect.map Main.Pages.Msg.Geometricalgebra >> fromPageEffect model)
                (Page.update (Pages.Geometricalgebra.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.LearningElm pageMsg, Main.Pages.Model.LearningElm pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.LearningElm
                (Effect.map Main.Pages.Msg.LearningElm >> fromPageEffect model)
                (Page.update (Pages.LearningElm.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.LearningGo pageMsg, Main.Pages.Model.LearningGo pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.LearningGo
                (Effect.map Main.Pages.Msg.LearningGo >> fromPageEffect model)
                (Page.update (Pages.LearningGo.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.LearningSwift pageMsg, Main.Pages.Model.LearningSwift pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.LearningSwift
                (Effect.map Main.Pages.Msg.LearningSwift >> fromPageEffect model)
                (Page.update (Pages.LearningSwift.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.Munich_diaries pageMsg, Main.Pages.Model.Munich_diaries pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.Munich_diaries
                (Effect.map Main.Pages.Msg.Munich_diaries >> fromPageEffect model)
                (Page.update (Pages.Munich_diaries.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.ProjectBMW pageMsg, Main.Pages.Model.ProjectBMW pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.ProjectBMW
                (Effect.map Main.Pages.Msg.ProjectBMW >> fromPageEffect model)
                (Page.update (Pages.ProjectBMW.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.Register pageMsg, Main.Pages.Model.Register pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.Register
                (Effect.map Main.Pages.Msg.Register >> fromPageEffect model)
                (Page.update (Pages.Register.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.Techkunstler pageMsg, Main.Pages.Model.Techkunstler pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.Techkunstler
                (Effect.map Main.Pages.Msg.Techkunstler >> fromPageEffect model)
                (Page.update (Pages.Techkunstler.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        ( Main.Pages.Msg.NotFound_ pageMsg, Main.Pages.Model.NotFound_ pageModel ) ->
            Tuple.mapBoth
                Main.Pages.Model.NotFound_
                (Effect.map Main.Pages.Msg.NotFound_ >> fromPageEffect model)
                (Page.update (Pages.NotFound_.page model.shared (Route.fromUrl () model.url)) pageMsg pageModel)

        _ ->
            ( model.page
            , Cmd.none
            )


updateFromLayout : Main.Layouts.Msg.Msg -> Model -> ( Maybe Main.Layouts.Model.Model, Cmd Msg )
updateFromLayout msg model =
    let
        route : Route ()
        route =
            Route.fromUrl () model.url
    in
    case ( toLayoutFromPage model, model.layout, msg ) of
        ( Just (Layouts.CommonHero props), Just (Main.Layouts.Model.CommonHero layoutModel), Main.Layouts.Msg.CommonHero layoutMsg ) ->
            Tuple.mapBoth
                (\newModel -> Just (Main.Layouts.Model.CommonHero { layoutModel | commonHero = newModel }))
                (Effect.map Main.Layouts.Msg.CommonHero >> fromLayoutEffect model)
                (Layout.update (Layouts.CommonHero.layout props model.shared route) layoutMsg layoutModel.commonHero)

        ( Just (Layouts.Footer props), Just (Main.Layouts.Model.Footer layoutModel), Main.Layouts.Msg.Footer layoutMsg ) ->
            Tuple.mapBoth
                (\newModel -> Just (Main.Layouts.Model.Footer { layoutModel | footer = newModel }))
                (Effect.map Main.Layouts.Msg.Footer >> fromLayoutEffect model)
                (Layout.update (Layouts.Footer.layout props model.shared route) layoutMsg layoutModel.footer)

        _ ->
            ( model.layout
            , Cmd.none
            )


toLayoutFromPage : Model -> Maybe (Layouts.Layout Msg)
toLayoutFromPage model =
    case model.page of
        Main.Pages.Model.Home_ pageModel ->
            Route.fromUrl () model.url
                |> Pages.Home_.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.Home_ >> Page))

        Main.Pages.Model.About pageModel ->
            Route.fromUrl () model.url
                |> Pages.About.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.About >> Page))

        Main.Pages.Model.Contact pageModel ->
            Route.fromUrl () model.url
                |> Pages.Contact.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.Contact >> Page))

        Main.Pages.Model.DaiFeatureDevelopment pageModel ->
            Route.fromUrl () model.url
                |> Pages.DaiFeatureDevelopment.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.DaiFeatureDevelopment >> Page))

        Main.Pages.Model.Dspace pageModel ->
            Route.fromUrl () model.url
                |> Pages.Dspace.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.Dspace >> Page))

        Main.Pages.Model.Featuredevelopment_traffic_assist pageModel ->
            Route.fromUrl () model.url
                |> Pages.Featuredevelopment_traffic_assist.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.Featuredevelopment_traffic_assist >> Page))

        Main.Pages.Model.Functionalprogramming pageModel ->
            Route.fromUrl () model.url
                |> Pages.Functionalprogramming.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.Functionalprogramming >> Page))

        Main.Pages.Model.Geometricalgebra pageModel ->
            Route.fromUrl () model.url
                |> Pages.Geometricalgebra.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.Geometricalgebra >> Page))

        Main.Pages.Model.LearningElm pageModel ->
            Route.fromUrl () model.url
                |> Pages.LearningElm.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.LearningElm >> Page))

        Main.Pages.Model.LearningGo pageModel ->
            Route.fromUrl () model.url
                |> Pages.LearningGo.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.LearningGo >> Page))

        Main.Pages.Model.LearningSwift pageModel ->
            Route.fromUrl () model.url
                |> Pages.LearningSwift.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.LearningSwift >> Page))

        Main.Pages.Model.Munich_diaries pageModel ->
            Route.fromUrl () model.url
                |> Pages.Munich_diaries.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.Munich_diaries >> Page))

        Main.Pages.Model.ProjectBMW pageModel ->
            Route.fromUrl () model.url
                |> Pages.ProjectBMW.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.ProjectBMW >> Page))

        Main.Pages.Model.Register pageModel ->
            Route.fromUrl () model.url
                |> Pages.Register.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.Register >> Page))

        Main.Pages.Model.Techkunstler pageModel ->
            Route.fromUrl () model.url
                |> Pages.Techkunstler.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.Techkunstler >> Page))

        Main.Pages.Model.NotFound_ pageModel ->
            Route.fromUrl () model.url
                |> Pages.NotFound_.page model.shared
                |> Page.layout pageModel
                |> Maybe.map (Layouts.map (Main.Pages.Msg.NotFound_ >> Page))

        Main.Pages.Model.Redirecting_ ->
            Nothing

        Main.Pages.Model.Loading_ ->
            Nothing


toAuthProtectedPage : Model -> (Auth.User -> Shared.Model -> Route params -> Page.Page model msg) -> Route params -> Maybe (Page.Page model msg)
toAuthProtectedPage model toPage route =
    case Auth.onPageLoad model.shared (Route.fromUrl () model.url) of
        Auth.Action.LoadPageWithUser user ->
            Just (toPage user model.shared route)

        _ ->
            Nothing


hasActionTypeChanged : Auth.Action.Action user -> Auth.Action.Action user -> Bool
hasActionTypeChanged oldAction newAction =
    case ( newAction, oldAction ) of
        ( Auth.Action.LoadPageWithUser _, Auth.Action.LoadPageWithUser _ ) ->
            False

        ( Auth.Action.LoadCustomPage, Auth.Action.LoadCustomPage ) ->
            False

        ( Auth.Action.ReplaceRoute _, Auth.Action.ReplaceRoute _ ) ->
            False

        ( Auth.Action.PushRoute _, Auth.Action.PushRoute _ ) ->
            False

        ( Auth.Action.LoadExternalUrl _, Auth.Action.LoadExternalUrl _ ) ->
            False

        ( _,  _ ) ->
            True


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        subscriptionsFromPage : Sub Msg
        subscriptionsFromPage =
            case model.page of
                Main.Pages.Model.Home_ pageModel ->
                    Page.subscriptions (Pages.Home_.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.Home_
                        |> Sub.map Page

                Main.Pages.Model.About pageModel ->
                    Page.subscriptions (Pages.About.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.About
                        |> Sub.map Page

                Main.Pages.Model.Contact pageModel ->
                    Page.subscriptions (Pages.Contact.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.Contact
                        |> Sub.map Page

                Main.Pages.Model.DaiFeatureDevelopment pageModel ->
                    Page.subscriptions (Pages.DaiFeatureDevelopment.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.DaiFeatureDevelopment
                        |> Sub.map Page

                Main.Pages.Model.Dspace pageModel ->
                    Page.subscriptions (Pages.Dspace.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.Dspace
                        |> Sub.map Page

                Main.Pages.Model.Featuredevelopment_traffic_assist pageModel ->
                    Page.subscriptions (Pages.Featuredevelopment_traffic_assist.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.Featuredevelopment_traffic_assist
                        |> Sub.map Page

                Main.Pages.Model.Functionalprogramming pageModel ->
                    Page.subscriptions (Pages.Functionalprogramming.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.Functionalprogramming
                        |> Sub.map Page

                Main.Pages.Model.Geometricalgebra pageModel ->
                    Page.subscriptions (Pages.Geometricalgebra.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.Geometricalgebra
                        |> Sub.map Page

                Main.Pages.Model.LearningElm pageModel ->
                    Page.subscriptions (Pages.LearningElm.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.LearningElm
                        |> Sub.map Page

                Main.Pages.Model.LearningGo pageModel ->
                    Page.subscriptions (Pages.LearningGo.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.LearningGo
                        |> Sub.map Page

                Main.Pages.Model.LearningSwift pageModel ->
                    Page.subscriptions (Pages.LearningSwift.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.LearningSwift
                        |> Sub.map Page

                Main.Pages.Model.Munich_diaries pageModel ->
                    Page.subscriptions (Pages.Munich_diaries.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.Munich_diaries
                        |> Sub.map Page

                Main.Pages.Model.ProjectBMW pageModel ->
                    Page.subscriptions (Pages.ProjectBMW.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.ProjectBMW
                        |> Sub.map Page

                Main.Pages.Model.Register pageModel ->
                    Page.subscriptions (Pages.Register.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.Register
                        |> Sub.map Page

                Main.Pages.Model.Techkunstler pageModel ->
                    Page.subscriptions (Pages.Techkunstler.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.Techkunstler
                        |> Sub.map Page

                Main.Pages.Model.NotFound_ pageModel ->
                    Page.subscriptions (Pages.NotFound_.page model.shared (Route.fromUrl () model.url)) pageModel
                        |> Sub.map Main.Pages.Msg.NotFound_
                        |> Sub.map Page

                Main.Pages.Model.Redirecting_ ->
                    Sub.none

                Main.Pages.Model.Loading_ ->
                    Sub.none

        maybeLayout : Maybe (Layouts.Layout Msg)
        maybeLayout =
            toLayoutFromPage model

        route : Route ()
        route =
            Route.fromUrl () model.url

        subscriptionsFromLayout : Sub Msg
        subscriptionsFromLayout =
            case ( maybeLayout, model.layout ) of
                ( Just (Layouts.CommonHero props), Just (Main.Layouts.Model.CommonHero layoutModel) ) ->
                    Layout.subscriptions (Layouts.CommonHero.layout props model.shared route) layoutModel.commonHero
                        |> Sub.map Main.Layouts.Msg.CommonHero
                        |> Sub.map Layout

                ( Just (Layouts.Footer props), Just (Main.Layouts.Model.Footer layoutModel) ) ->
                    Layout.subscriptions (Layouts.Footer.layout props model.shared route) layoutModel.footer
                        |> Sub.map Main.Layouts.Msg.Footer
                        |> Sub.map Layout

                _ ->
                    Sub.none
    in
    Sub.batch
        [ Shared.subscriptions route model.shared
              |> Sub.map Shared
        , subscriptionsFromPage
        , subscriptionsFromLayout
        ]



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        view_ : View Msg
        view_ =
            toView model
    in
    View.toBrowserDocument
        { shared = model.shared
        , route = Route.fromUrl () model.url
        , view = view_
        }


toView : Model -> View Msg
toView model =
    let
        route : Route ()
        route =
            Route.fromUrl () model.url
    in
    case ( toLayoutFromPage model, model.layout ) of
        ( Just (Layouts.CommonHero props), Just (Main.Layouts.Model.CommonHero layoutModel) ) ->
            Layout.view
                (Layouts.CommonHero.layout props model.shared route)
                { model = layoutModel.commonHero
                , toContentMsg = Main.Layouts.Msg.CommonHero >> Layout
                , content = viewPage model
                }

        ( Just (Layouts.Footer props), Just (Main.Layouts.Model.Footer layoutModel) ) ->
            Layout.view
                (Layouts.Footer.layout props model.shared route)
                { model = layoutModel.footer
                , toContentMsg = Main.Layouts.Msg.Footer >> Layout
                , content = viewPage model
                }

        _ ->
            viewPage model


viewPage : Model -> View Msg
viewPage model =
    case model.page of
        Main.Pages.Model.Home_ pageModel ->
            Page.view (Pages.Home_.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.Home_
                |> View.map Page

        Main.Pages.Model.About pageModel ->
            Page.view (Pages.About.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.About
                |> View.map Page

        Main.Pages.Model.Contact pageModel ->
            Page.view (Pages.Contact.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.Contact
                |> View.map Page

        Main.Pages.Model.DaiFeatureDevelopment pageModel ->
            Page.view (Pages.DaiFeatureDevelopment.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.DaiFeatureDevelopment
                |> View.map Page

        Main.Pages.Model.Dspace pageModel ->
            Page.view (Pages.Dspace.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.Dspace
                |> View.map Page

        Main.Pages.Model.Featuredevelopment_traffic_assist pageModel ->
            Page.view (Pages.Featuredevelopment_traffic_assist.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.Featuredevelopment_traffic_assist
                |> View.map Page

        Main.Pages.Model.Functionalprogramming pageModel ->
            Page.view (Pages.Functionalprogramming.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.Functionalprogramming
                |> View.map Page

        Main.Pages.Model.Geometricalgebra pageModel ->
            Page.view (Pages.Geometricalgebra.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.Geometricalgebra
                |> View.map Page

        Main.Pages.Model.LearningElm pageModel ->
            Page.view (Pages.LearningElm.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.LearningElm
                |> View.map Page

        Main.Pages.Model.LearningGo pageModel ->
            Page.view (Pages.LearningGo.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.LearningGo
                |> View.map Page

        Main.Pages.Model.LearningSwift pageModel ->
            Page.view (Pages.LearningSwift.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.LearningSwift
                |> View.map Page

        Main.Pages.Model.Munich_diaries pageModel ->
            Page.view (Pages.Munich_diaries.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.Munich_diaries
                |> View.map Page

        Main.Pages.Model.ProjectBMW pageModel ->
            Page.view (Pages.ProjectBMW.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.ProjectBMW
                |> View.map Page

        Main.Pages.Model.Register pageModel ->
            Page.view (Pages.Register.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.Register
                |> View.map Page

        Main.Pages.Model.Techkunstler pageModel ->
            Page.view (Pages.Techkunstler.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.Techkunstler
                |> View.map Page

        Main.Pages.Model.NotFound_ pageModel ->
            Page.view (Pages.NotFound_.page model.shared (Route.fromUrl () model.url)) pageModel
                |> View.map Main.Pages.Msg.NotFound_
                |> View.map Page

        Main.Pages.Model.Redirecting_ ->
            View.none

        Main.Pages.Model.Loading_ ->
            Auth.viewCustomPage model.shared (Route.fromUrl () model.url)
                |> View.map never



-- INTERNALS


fromPageEffect : { model | key : Browser.Navigation.Key, url : Url, shared : Shared.Model } -> Effect Main.Pages.Msg.Msg -> Cmd Msg
fromPageEffect model effect =
    Effect.toCmd
        { key = model.key
        , url = model.url
        , shared = model.shared
        , fromSharedMsg = Shared
        , batch = Batch
        , toCmd = Task.succeed >> Task.perform identity
        }
        (Effect.map Page effect)


fromLayoutEffect : { model | key : Browser.Navigation.Key, url : Url, shared : Shared.Model } -> Effect Main.Layouts.Msg.Msg -> Cmd Msg
fromLayoutEffect model effect =
    Effect.toCmd
        { key = model.key
        , url = model.url
        , shared = model.shared
        , fromSharedMsg = Shared
        , batch = Batch
        , toCmd = Task.succeed >> Task.perform identity
        }
        (Effect.map Layout effect)


fromSharedEffect : { model | key : Browser.Navigation.Key, url : Url, shared : Shared.Model } -> Effect Shared.Msg -> Cmd Msg
fromSharedEffect model effect =
    Effect.toCmd
        { key = model.key
        , url = model.url
        , shared = model.shared
        , fromSharedMsg = Shared
        , batch = Batch
        , toCmd = Task.succeed >> Task.perform identity
        }
        (Effect.map Shared effect)



-- URL HOOKS FOR PAGES


toPageUrlHookCmd : Model -> { from : Route (), to : Route () } -> Cmd Msg
toPageUrlHookCmd model routes =
    let
        toCommands messages =
            messages
                |> List.map (Task.succeed >> Task.perform identity)
                |> Cmd.batch
    in
    case model.page of
        Main.Pages.Model.Home_ pageModel ->
            Page.toUrlMessages routes (Pages.Home_.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.Home_
                |> List.map Page
                |> toCommands

        Main.Pages.Model.About pageModel ->
            Page.toUrlMessages routes (Pages.About.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.About
                |> List.map Page
                |> toCommands

        Main.Pages.Model.Contact pageModel ->
            Page.toUrlMessages routes (Pages.Contact.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.Contact
                |> List.map Page
                |> toCommands

        Main.Pages.Model.DaiFeatureDevelopment pageModel ->
            Page.toUrlMessages routes (Pages.DaiFeatureDevelopment.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.DaiFeatureDevelopment
                |> List.map Page
                |> toCommands

        Main.Pages.Model.Dspace pageModel ->
            Page.toUrlMessages routes (Pages.Dspace.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.Dspace
                |> List.map Page
                |> toCommands

        Main.Pages.Model.Featuredevelopment_traffic_assist pageModel ->
            Page.toUrlMessages routes (Pages.Featuredevelopment_traffic_assist.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.Featuredevelopment_traffic_assist
                |> List.map Page
                |> toCommands

        Main.Pages.Model.Functionalprogramming pageModel ->
            Page.toUrlMessages routes (Pages.Functionalprogramming.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.Functionalprogramming
                |> List.map Page
                |> toCommands

        Main.Pages.Model.Geometricalgebra pageModel ->
            Page.toUrlMessages routes (Pages.Geometricalgebra.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.Geometricalgebra
                |> List.map Page
                |> toCommands

        Main.Pages.Model.LearningElm pageModel ->
            Page.toUrlMessages routes (Pages.LearningElm.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.LearningElm
                |> List.map Page
                |> toCommands

        Main.Pages.Model.LearningGo pageModel ->
            Page.toUrlMessages routes (Pages.LearningGo.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.LearningGo
                |> List.map Page
                |> toCommands

        Main.Pages.Model.LearningSwift pageModel ->
            Page.toUrlMessages routes (Pages.LearningSwift.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.LearningSwift
                |> List.map Page
                |> toCommands

        Main.Pages.Model.Munich_diaries pageModel ->
            Page.toUrlMessages routes (Pages.Munich_diaries.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.Munich_diaries
                |> List.map Page
                |> toCommands

        Main.Pages.Model.ProjectBMW pageModel ->
            Page.toUrlMessages routes (Pages.ProjectBMW.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.ProjectBMW
                |> List.map Page
                |> toCommands

        Main.Pages.Model.Register pageModel ->
            Page.toUrlMessages routes (Pages.Register.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.Register
                |> List.map Page
                |> toCommands

        Main.Pages.Model.Techkunstler pageModel ->
            Page.toUrlMessages routes (Pages.Techkunstler.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.Techkunstler
                |> List.map Page
                |> toCommands

        Main.Pages.Model.NotFound_ pageModel ->
            Page.toUrlMessages routes (Pages.NotFound_.page model.shared (Route.fromUrl () model.url)) 
                |> List.map Main.Pages.Msg.NotFound_
                |> List.map Page
                |> toCommands

        Main.Pages.Model.Redirecting_ ->
            Cmd.none

        Main.Pages.Model.Loading_ ->
            Cmd.none


toLayoutUrlHookCmd : Model -> Model -> { from : Route (), to : Route () } -> Cmd Msg
toLayoutUrlHookCmd oldModel model routes =
    let
        toCommands messages =
            if shouldFireUrlChangedEvents then
                messages
                    |> List.map (Task.succeed >> Task.perform identity)
                    |> Cmd.batch

            else
                Cmd.none

        shouldFireUrlChangedEvents =
            hasNavigatedWithinNewLayout
                { from = toLayoutFromPage oldModel
                , to = toLayoutFromPage model
                }

        route =
            Route.fromUrl () model.url
    in
    case ( toLayoutFromPage model, model.layout ) of
        ( Just (Layouts.CommonHero props), Just (Main.Layouts.Model.CommonHero layoutModel) ) ->
            Layout.toUrlMessages routes (Layouts.CommonHero.layout props model.shared route)
                |> List.map Main.Layouts.Msg.CommonHero
                |> List.map Layout
                |> toCommands

        ( Just (Layouts.Footer props), Just (Main.Layouts.Model.Footer layoutModel) ) ->
            Layout.toUrlMessages routes (Layouts.Footer.layout props model.shared route)
                |> List.map Main.Layouts.Msg.Footer
                |> List.map Layout
                |> toCommands

        _ ->
            Cmd.none


hasNavigatedWithinNewLayout : { from : Maybe (Layouts.Layout msg), to : Maybe (Layouts.Layout msg) } -> Bool
hasNavigatedWithinNewLayout { from, to } =
    let
        isRelated maybePair =
            case maybePair of
                Just ( Layouts.CommonHero _, Layouts.CommonHero _ ) ->
                    True

                Just ( Layouts.Footer _, Layouts.Footer _ ) ->
                    True

                _ ->
                    False
    in
    List.any isRelated
        [ Maybe.map2 Tuple.pair from to
        , Maybe.map2 Tuple.pair to from
        ]


isAuthProtected : Route.Path.Path -> Bool
isAuthProtected routePath =
    case routePath of
        Route.Path.Home_ ->
            False

        Route.Path.About ->
            False

        Route.Path.Contact ->
            False

        Route.Path.DaiFeatureDevelopment ->
            False

        Route.Path.Dspace ->
            False

        Route.Path.Featuredevelopment_traffic_assist ->
            False

        Route.Path.Functionalprogramming ->
            False

        Route.Path.Geometricalgebra ->
            False

        Route.Path.LearningElm ->
            False

        Route.Path.LearningGo ->
            False

        Route.Path.LearningSwift ->
            False

        Route.Path.Munich_diaries ->
            False

        Route.Path.ProjectBMW ->
            False

        Route.Path.Register ->
            False

        Route.Path.Techkunstler ->
            False

        Route.Path.NotFound_ ->
            False
