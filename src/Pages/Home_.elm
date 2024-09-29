module Pages.Home_ exposing (Model, Msg, page)

import Browser.Navigation exposing (Key)
import Effect exposing (Effect)
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events
import Page exposing (Page)
import Route exposing (Route)
import Shared
import View exposing (View)


type NavBarItems
    = Home


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
    { isBurgerIconActive : Bool
    }


init : () -> ( Model, Effect Msg )
init () =
    ( { isBurgerIconActive = False }
    , Effect.none
    )



-- UPDATE


type Msg
    = BurgerIconClicked


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        BurgerIconClicked ->
            ( { model | isBurgerIconActive = True }
            , Effect.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Pages.Home_"
    , body =
        [ -- Html.text "/home_"
          hero model
        , timelineView model
        ]
    }


hero : Model -> Html Msg
hero model =
    Html.section [ Attr.class "hero is-fullwidth has-background-primary-05 has-text-centered " ]
        [ Html.div
            [ Attr.class "hero-body" ]
            [ profilePicview model
            ]
        ]


iconsListView : Model -> Html Msg
iconsListView model =
    Html.div []
        [ Html.ul [ Attr.class "icons ml-0" ]
            [ Html.li [ Attr.class "is-inline is-size-4" ]
                [ Html.a
                    [ Attr.href "#contact"
                    , Attr.class "fa-solid fa-envelope has-text-white "
                    ]
                    []
                ]
            , Html.li [ Attr.class "is-inline is-size-4 ml-3" ]
                [ Html.a
                    [ Attr.href "#mobile"
                    , Attr.class "fas fa-mobile has-text-white"
                    ]
                    []
                ]
            , Html.li [ Attr.class "is-inline is-size-4 ml-3" ]
                [ Html.a
                    [ Attr.href "#github"
                    ]
                    [ Html.i
                        [ Attr.class "fab fa-github has-text-white"
                        ]
                        []
                    ]
                ]
            , Html.li [ Attr.class "is-inline is-size-4 ml-3" ]
                [ Html.a
                    [ Attr.href "#linkedin"
                    , Attr.class "fab fa-linkedin has-text-white"
                    ]
                    []
                ]
            ]
        ]


profilePicview : Model -> Html Msg
profilePicview model =
    Html.section [ Attr.class "section" ]
        [ Html.div [ Attr.class "content is-mobile is-centered" ]
            [ Html.div [ Attr.class "is-half has-text-centered" ]
                [ Html.figure [ Attr.class "image is-inline-block mb-0 mt-3" ]
                    [ Html.img
                        [ Attr.class "is-rounded is-128x128"
                        , Attr.src "./assets/man.webp"
                        ]
                        []
                    ]
                , Html.p [ Attr.class "is-size-2 has-text-white" ] [ Html.text "Santhosh K S" ]
                , Html.p [ Attr.class "is-size-4 " ] [ Html.text "Seasoned professional" ]
                , Html.p [ Attr.class "has-text-white" ] [ Html.text "C,C++,Matlab,Python,Go,Swift,Embedded systems,Fullstack developer" ]
                , iconsListView model
                ]
            ]
        ]


type alias KeyValPair =
    { key : String
    , value : String
    }


type alias TitleSubtitle =
    KeyValPair


type alias Role =
    KeyValPair


type alias Project =
    KeyValPair


type alias Description =
    KeyValPair


type alias Technologies =
    KeyValPair


type alias Icon =
    { icon : String
    }


type alias ItemContent =
    { content : TitleSubtitle
    , icon : Icon
    , projectDetails : List KeyValPair
    }


june2024 : ItemContent
june2024 =
    { content = { key = "Jun 2024 : Bangalore India", value = "Relocated back to India" }
    , icon = { icon = "fa-solid fa-plane-arrival" }
    , projectDetails =
        [ { key = "NewRole", value = "Self Employed / Entrepreneur" }
        , { key = "Company", value = "TechKunstler" }
        , { key = "Location", value = "Bengaluru, Karnataka, India" }
        ]
    }


may2024 : ItemContent
may2024 =
    { content = { key = "May 2024 : Munich Germany", value = "Completed 5 years at KPIT Gmbh Munich as Senior Solution Architect" }
    , icon = { icon = "fa-solid fa-pen-nib" }
    , projectDetails = [ { key = "Role", value = "Senior Solution Architecht" } ]
    }


july2019ToMar2020 : ItemContent
july2019ToMar2020 =
    { content = { key = "Juy 2019 to Mar 2020 ", value = "Started leading a team of 8 people as C++ developer and Bridge head." }
    , icon = { icon = "fa-solid fa-handshake-angle" }
    , projectDetails =
        [ { key = "Role", value = "C++ Developer and Bridge head" }
        , { key = "Project", value = "Built C++ Applications to validate the performance of the camers used in the ADAS systems" }
        , { key = "Client", value = "BMW" }
        , { key = "TeamName", value = "Ramanujan" }
        , { key = "Location", value = "Munich Germany" }
        , { key = "Domain", value = "Automotive" }
        , { key = "Technologies", value = "C++11, Bazel, OpenCV, Python, Shell Scripting, Large scale SCRUM" }
        , { key = "Soft skills", value = "Leadership, Team management, Customer interactions, , Project delivery" }
        ]
    }


may2020ToMar2021 : ItemContent
may2020ToMar2021 =
    { content = { key = "May 2020 To Mar 2021", value = "Started Building a solid team of 8 people as C++ developer and Scrum Master." }
    , icon = { icon = "fa-solid fa-handshake-angle" }
    , projectDetails =
        [ { key = "Role", value = "C++ Developer and Scrum Master" }
        , { key = "Project", value = "Drive away information (DAI) feature for ADAS" }
        , { key = "Client", value = "Volvo cars / Veoneer / Arriver GmbH" }
        , { key = "Location", value = "Munich Germany" }
        , { key = "Domain", value = "Automotive" }
        , { key = "TeamName", value = "Vikings" }
        , { key = "Technologies", value = "C++11, Python, Shell scripting, SCRUM" }
        , { key = "Tools", value = "Confluence, JIRA, Codebeamer, Github, ZUUL, CI-CD, Jenkins" }
        , { key = "Soft skills", value = "Leadership, Team management, Customer interactions, Project delivery" }
        ]
    }


april2021ToDec2022 : ItemContent
april2021ToDec2022 =
    { content = { key = "April 2021 To Dec 2022", value = "ASPICE SYS.2 and SYS.5 verification and validation using DSpace." }
    , icon = { icon = "fa-solid fa-handshake-angle" }
    , projectDetails =
        [ { key = "Role", value = "Developer and Scrum Master" }
        , { key = "Project", value = "ASPICE SYS.2 and SYS.5 : Requirements Validation using Dspace" }
        , { key = "Client", value = " Arriver GmbH / Qualcomm " }
        , { key = "Location", value = "Munich Germany" }
        , { key = "Domain", value = "Automotive" }
        , { key = "TeamName", value = "Vikings" }
        , { key = "Technologies", value = "Dspace, Synect, Matlab, m-script, python" }
        , { key = "Tools", value = "Confluence, Codebeamer, JIRA, Github, ZUUL, CI-CD, Jenkins" }
        , { key = "Soft skills", value = "Leadership, Team management, Customer interactions, Project delivery" }
        ]
    }


jan2023ToMay2024 : ItemContent
jan2023ToMay2024 =
    { content = { key = "Jan 2023 To May 2024", value = "Feature owner, Traffic Assists / Highway pilot" }
    , icon = { icon = "fa-solid fa-handshake-angle" }
    , projectDetails =
        [ { key = "Role", value = "Developer and Scrum Master" }
        , { key = "Project", value = "Traffic Assists (Backbone of ADAS feature)" }
        , { key = "Client", value = " Qualcomm " }
        , { key = "Location", value = "Munich Germany" }
        , { key = "Domain", value = "Automotive" }
        , { key = "TeamName", value = "Vikings" }
        , { key = "Technologies", value = "Matlab, C++, m-script, python, shell scripting" }
        , { key = "Tools", value = "Confluence, Codebeamer, JIRA, Github, ZUUL, CI-CD, Jenkins" }
        , { key = "Soft skills", value = "Leadership, Team management, Customer interactions, Project delivery" }
        ]
    }



{- { content = { key = "", value = "" }
   , icon = { icon = "" }
   , projectDetails = [ { key = "Role", value = "" } ]
   }
-}


jul2019 : ItemContent
jul2019 =
    { content = { key = "July 2019", value = "Moved to Munich Germany." }
    , icon = { icon = " fa-solid fa-plane-arrival" }
    , projectDetails =
        [ { key = "NewJob", value = "Solution Architecht @KPIT GmbH" }
        , { key = "Location", value = "Munich, Germany" }
        ]
    }


timelineView : Model -> Html Msg
timelineView model =
    Html.div [ Attr.class "timeline is-centered" ]
        [ Html.header [ Attr.class "timeline-header is-centered" ]
            [-- Html.span [ Attr.class "tag is-medium is-primary is-centered" ] [ Html.text "Start" ]
            ]
        , timeLineItemView june2024
        , timeLineItemView may2024
        , timeLineItemView jan2023ToMay2024
        , timeLineItemView april2021ToDec2022
        , timeLineItemView may2020ToMar2021
        , timeLineItemView july2019ToMar2020
        , timeLineItemView jul2019

        -- , timelineNotificationInfoView { companyName = "TechKunstler", location = "Bangalore India" }
        , Html.div [ Attr.class "timeline-header" ]
            [-- Html.span [ Attr.class "tag is-medium is-primary" ] [ Html.text "End" ]
            ]
        ]


timeLineItemView : ItemContent -> Html Msg
timeLineItemView props =
    Html.div [ Attr.class "timeline-item" ]
        [ Html.div [ Attr.class "timeline-marker" ] []
        , timelineInfoIconView props.icon.icon --"fa-solid fa-truck-plane" --"fab fa-linkedin has-text-white"
        , Html.div [ Attr.class "timeline-content" ]
            [ Html.p [ Attr.class "heading" ] [ Html.text props.content.key ]
            , Html.p [] [ Html.text props.content.value ]
            , sideCardNotificationDetailsView props.projectDetails
            , Html.a [ Attr.class "button has-background-primary-10" ] [ Html.text "Read More..." ]
            ]
        ]


timelineNotificationInfoView : { companyName : String, location : String } -> Html Msg
timelineNotificationInfoView props =
    Html.div [ Attr.class "timeline-item" ]
        [ Html.div [ Attr.class "timeline-content" ]
            [ Html.div [ Attr.class "notification is-info" ]
                [ Html.p [ Attr.class "is-size-5" ] [ Html.text props.companyName ]
                , Html.p [ Attr.class "has-text-weight-semibold" ] [ Html.text props.location ]
                ]
            ]
        ]


timelineInfoIconView : String -> Html Msg
timelineInfoIconView v =
    Html.div [ Attr.class "timeline-marker is-info is-icon" ]
        [ Html.i [ Attr.class v ] []
        ]


labelView : String -> Html Msg
labelView v =
    Html.label [ Attr.class "label is-underlined has-text-weight-bold has-text-left" ] [ Html.text v ]


fieldBodyView : String -> Html Msg
fieldBodyView v =
    Html.div [ Attr.class "field-body has-text-left" ]
        [ Html.div [ Attr.class "field" ]
            [ Html.p [ Attr.class "has-text-weight-semibold" ] [ Html.text v ]
            ]
        ]


sideCardNotificationDetailsView : List KeyValPair -> Html Msg
sideCardNotificationDetailsView props =
    Html.div [ Attr.class "notification " ]
        (List.map fields props)


fields : { key : String, value : String } -> Html Msg
fields props =
    Html.div [ Attr.class "field is-horizontal" ]
        [ Html.div [ Attr.class "field-label" ]
            [ labelView props.key
            ]
        , fieldBodyView props.value
        ]
