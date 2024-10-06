module Pages.Home_ exposing (Model, Msg, page)

-- import Date

import Browser.Navigation exposing (Key)
import Dict
import Effect exposing (Effect)
import Html exposing (Html)
import Html.Attributes as Attr exposing (datetime)
import Html.Events
import Layouts
import Layouts.CommonHero
import Page exposing (Page)
import Route exposing (Route)
import Route.Path
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
        |> Page.withLayout layout


layout : Shared.Model -> Layouts.Layout Msg
layout model =
    Layouts.CommonHero
        { backgroundImageUrl = "https://picsum.photos/id/381/1920/1080"
        , position = "bottom"
        , size = "100%"
        , title = "Home"
        , subtitle = "Sweet home"
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
    | July2019ReadMoreClicked
    | SwiftBeginsUpskillReadMoreClicked
    | FunctionalProgrammingUpskillReadMoreClicked
    | GeometricAlgebraUpskillReadMoreClicked
    | MachineLearningUpskillReadMoreClicked
    | ComputerVisionAndAIUpskillReadMoreClicked
    | ReactAndElmUpskillReadMoreClicked
    | GoAndElmUpskillReadMoreClicked
    | Jan2023ToMay2024ReadMoreClicked
    | April2021ToDec2022ReadMoreClicked
    | May2020ToMar2021ReadMoreClicked
    | July2019ToMar2020ReadMoreClicked
    | May2024ReadMoreClicked
    | June2024ReadMoreClicked
    | AboutMeButtonClicked
    | Jan2017ToMar2019ReadMoreClicked
    | June2011ToMay2016ReadMoreClicked
    | Sept2008ToMay2011ReadMoreClicked


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Effect.none
            )

        July2019ReadMoreClicked ->
            ( model
            , Effect.pushRoute
                { path = Route.Path.Munich_diaries
                , query = Dict.empty
                , hash = Nothing
                }
            )

        SwiftBeginsUpskillReadMoreClicked ->
            ( model
            , Effect.pushRoute
                { path = Route.Path.LearningSwift
                , query = Dict.empty
                , hash = Nothing
                }
            )

        FunctionalProgrammingUpskillReadMoreClicked ->
            ( model
            , Effect.pushRoute
                { path = Route.Path.Functionalprogramming
                , query = Dict.empty
                , hash = Nothing
                }
            )

        GeometricAlgebraUpskillReadMoreClicked ->
            ( model
            , Effect.pushRoute
                { path = Route.Path.Geometricalgebra
                , query = Dict.empty
                , hash = Nothing
                }
            )

        ReactAndElmUpskillReadMoreClicked ->
            ( model
            , Effect.pushRoute
                { path = Route.Path.LearningElm
                , query = Dict.empty
                , hash = Nothing
                }
            )

        GoAndElmUpskillReadMoreClicked ->
            ( model
            , Effect.pushRoute
                { path = Route.Path.LearningGo
                , query = Dict.empty
                , hash = Nothing
                }
            )

        Jan2023ToMay2024ReadMoreClicked ->
            ( model
            , Effect.pushRoute
                -- TA
                { path = Route.Path.Featuredevelopment_traffic_assist
                , query = Dict.empty
                , hash = Nothing
                }
            )

        April2021ToDec2022ReadMoreClicked ->
            ( model
              -- Dspace
            , Effect.pushRoute
                { path = Route.Path.Dspace
                , query = Dict.empty
                , hash = Nothing
                }
            )

        May2020ToMar2021ReadMoreClicked ->
            ( model
            , Effect.pushRoute
                { path = Route.Path.DaiFeatureDevelopment
                , query = Dict.empty
                , hash = Nothing
                }
            )

        July2019ToMar2020ReadMoreClicked ->
            ( model
            , Effect.pushRoute
                { path = Route.Path.ProjectBMW
                , query = Dict.empty
                , hash = Nothing
                }
            )

        May2024ReadMoreClicked ->
            ( model, Effect.none )

        June2024ReadMoreClicked ->
            ( model
            , Effect.pushRoute
                { path = Route.Path.Techkunstler
                , query = Dict.empty
                , hash = Nothing
                }
            )

        AboutMeButtonClicked ->
            ( model
            , Effect.pushRoute
                { path = Route.Path.About
                , query = Dict.empty
                , hash = Nothing
                }
            )

        Jan2017ToMar2019ReadMoreClicked ->
            ( model
            , Effect.none
            )

        MachineLearningUpskillReadMoreClicked ->
            ( model
            , Effect.none
            )

        ComputerVisionAndAIUpskillReadMoreClicked ->
            ( model
            , Effect.none
            )

        June2011ToMay2016ReadMoreClicked ->
            ( model
            , Effect.none
            )

        Sept2008ToMay2011ReadMoreClicked ->
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
    { title = "Pages.Home_"
    , body =
        [ -- Html.text "/home_"
          aboutMe
        , Html.div [ Attr.style "border-top" "10px solid turquoise" ] []
        , timelineView model
        , Html.div [ Attr.style "border-top" "10px solid turquoise" ] []
        , footer model
        ]
    }


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
    , event : Msg
    , logo : String
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
    , event = June2024ReadMoreClicked
    , logo = "bengaluru.jpeg"
    }


may2024 : ItemContent
may2024 =
    { content = { key = "May 2024 : Munich Germany", value = "Completed 5 years at KPIT Gmbh Munich as Senior Solution Architect" }
    , icon = { icon = "fa-solid fa-pen-nib" }
    , projectDetails = [ { key = "Role", value = "Senior Solution Architecht" } ]
    , event = May2024ReadMoreClicked
    , logo = "kpit.png"
    }


joinedKPIT : ItemContent
joinedKPIT =
    { content = { key = "July2019: Joined KPIT GmbH", value = "Solution Architecht" }
    , icon = { icon = "fa-solid fa-pen-nib" }
    , projectDetails = [ { key = "Role", value = "Started working as Solution Architecht" } ]
    , event = NoOp
    , logo = "kpit.png"
    }


july2019ToMar2020 : ItemContent
july2019ToMar2020 =
    { content = { key = "Juy 2019 to Mar 2020 ", value = "Started leading a team of 8 people as C++ developer and Bridge head." }
    , icon = { icon = "fa-solid fa-handshake-angle" }
    , projectDetails =
        [ { key = "Role", value = "C++ Developer and Bridge head" }
        , { key = "Project", value = "Built C++ Applications to validate the performance of the camers used in the ADAS systems" }
        , { key = "Client", value = "BMW" }
        , { key = "Location", value = "Munich Germany" }
        , { key = "Domain", value = "Automotive" }
        , { key = "Technologies", value = "C++11, Bazel, OpenCV, Python, Shell Scripting, Large scale SCRUM" }

        {- , { key = "TeamName", value = "Ramanujan" }
           , { key = "Soft skills", value = "Leadership, Team management, Customer interactions, , Project delivery" }
        -}
        ]
    , event = July2019ToMar2020ReadMoreClicked
    , logo = "bmw.jpeg"
    }


may2020ToMar2021 : ItemContent
may2020ToMar2021 =
    { content = { key = "May 2020 To Mar 2021", value = "Started Building a solid team of 8 people as C++ developer and Scrum Master." }
    , icon = { icon = "fa-solid fa-handshake-angle" }
    , projectDetails =
        [ { key = "Role", value = "C++ Developer and Scrum Master" }
        , { key = "Project", value = "Drive away information (DAI) feature for ADAS" }
        , { key = "Client", value = "Volvo / Veoneer / Arriver GmbH" }
        , { key = "Location", value = "Munich Germany" }
        , { key = "Domain", value = "Automotive" }
        , { key = "Technologies", value = "C++11, Python, Shell scripting, SCRUM" }
        , { key = "Tools", value = "Confluence, JIRA, Codebeamer, Github, ZUUL, CI-CD, Jenkins" }

        {- , { key = "TeamName", value = "Vikings" }
           , { key = "Soft skills", value = "Leadership, Team management, Customer interactions, Project delivery" }
        -}
        ]
    , event = May2020ToMar2021ReadMoreClicked
    , logo = "volvo.png"
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
        , { key = "Technologies", value = "Dspace, Synect, Matlab, m-script, python" }
        , { key = "Tools", value = "Confluence, Codebeamer, JIRA, Github, ZUUL, CI-CD, Jenkins" }

        {- , { key = "TeamName", value = "Vikings" }
           , { key = "Soft skills", value = "Leadership, Team management, Customer interactions, Project delivery" }
        -}
        ]
    , event = April2021ToDec2022ReadMoreClicked
    , logo = "qualcomm.png"
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
        , { key = "Technologies", value = "Matlab, C++, m-script, python, shell scripting" }
        , { key = "Tools", value = "Confluence, Codebeamer, JIRA, Github, ZUUL, CI-CD, Jenkins" }

        {- , { key = "TeamName", value = "Vikings" }
           , { key = "Soft skills", value = "Leadership, Team management, Customer interactions, Project delivery" }
        -}
        ]
    , event = Jan2023ToMay2024ReadMoreClicked
    , logo = "qualcomm.png"
    }


jan2017ToMar2019 : ItemContent
jan2017ToMar2019 =
    { content = { key = "Jan 2017 To Mar 2019", value = "Principal Engineer at Anovadata" }
    , icon = { icon = "fa-solid fa-handshake-angle" }
    , projectDetails =
        [ { key = "Role", value = "Principal Engineer" }
        , { key = "Project", value = "DPDK based network monitoring platform development" }
        , { key = "Client", value = " Anovadata / Ribbon Communication" }
        , { key = "Location", value = "Bengaluru, India" }
        , { key = "Domain", value = "Telecom and Networking" }
        , { key = "Technologies", value = "C++, python, shell scripting, DPDK" }
        , { key = "Tools", value = "Confluence, JIRA, Github, CI-CD, Jenkins" }

        {- , { key = "TeamName", value = "Vikings" }
           , { key = "Soft skills", value = "Leadership, Team management, Customer interactions, Project delivery" }
        -}
        ]
    , event = Jan2017ToMar2019ReadMoreClicked
    , logo = "ribbon.svg"
    }


june2011ToMay2016 : ItemContent
june2011ToMay2016 =
    { content = { key = "June 2011 To May 2016", value = "Senior Software Engineer at Motorola" }
    , icon = { icon = "fa-solid fa-handshake-angle" }
    , projectDetails =
        [ { key = "Role", value = "Senior Software Engineer" }
        , { key = "Project", value = "Set top box and Cable modem features development" }
        , { key = "Client", value = "Verizon" }
        , { key = "Location", value = "Bengaluru, India" }
        , { key = "Domain", value = "Embedded systems and Networking" }
        , { key = "Technologies", value = "C, C++, python, shell scripting" }
        , { key = "Tools", value = "JIRA, svn, CI-CD, Jenkins" }

        {- , { key = "TeamName", value = "Vikings" }
           , { key = "Soft skills", value = "Leadership, Team management, Customer interactions, Project delivery" }
        -}
        ]
    , event = June2011ToMay2016ReadMoreClicked
    , logo = "motorola.jpeg"
    }


sept2008ToMay2011 : ItemContent
sept2008ToMay2011 =
    { content = { key = "Sept 2008 To May 2011", value = "Senior Software Engineer at Mindtree" }
    , icon = { icon = "fa-solid fa-handshake-angle" }
    , projectDetails =
        [ { key = "Role", value = "Senior Software Engineer" }
        , { key = "Project", value = "Set top box Conditional access features development" }
        , { key = "Client", value = "Dish TV" }
        , { key = "Location", value = "Chennai/Bengaluru, India" }
        , { key = "Domain", value = "Embedded systems" }
        , { key = "Technologies", value = "C, python, shell scripting" }
        , { key = "Tools", value = "JIRA, svn, CI-CD, Jenkins, Conax Conditional Access" }

        {- , { key = "TeamName", value = "Vikings" }
           , { key = "Soft skills", value = "Leadership, Team management, Customer interactions, Project delivery" }
        -}
        ]
    , event = Sept2008ToMay2011ReadMoreClicked
    , logo = "mindtree.jpeg"
    }



{- { content = { key = "", value = "" }
   , icon = { icon = "" }
   , projectDetails = [ { key = "Role", value = "" } ]
   }
-}


goAndElm : ItemContent
goAndElm =
    { content = { key = "Backend", value = "Upskill" }
    , icon = { icon = " fa-solid fa-book" }
    , projectDetails =
        [ { key = "Learn", value = "Started building full stack applications using go and Elm" }
        ]
    , event = GoAndElmUpskillReadMoreClicked
    , logo = ""
    }


reactAndElm : ItemContent
reactAndElm =
    { content = { key = "Frontend", value = "Upskill" }
    , icon = { icon = " fa-solid fa-book" }
    , projectDetails =
        [ { key = "Learn", value = "Started building React Native applications and Elm Applications" }
        ]
    , event = ReactAndElmUpskillReadMoreClicked
    , logo = ""
    }


geometricAlgebra : ItemContent
geometricAlgebra =
    { content = { key = "Geometric Algebra", value = "Upskill" }
    , icon = { icon = " fa-solid fa-book" }
    , projectDetails =
        [ { key = "Learn", value = "Started learning about 3D graphics using Geometric Algebra" }
        ]
    , event = GeometricAlgebraUpskillReadMoreClicked
    , logo = ""
    }


functionalProgramming : ItemContent
functionalProgramming =
    { content = { key = "Functional Programming", value = "Upskill" }
    , icon = { icon = " fa-solid fa-book" }
    , projectDetails =
        [ { key = "Learn", value = "Started learning about Functional Programming" }
        ]
    , event = FunctionalProgrammingUpskillReadMoreClicked
    , logo = ""
    }


swiftBegins : ItemContent
swiftBegins =
    { content = { key = "Swift", value = "Upskill" }
    , icon = { icon = " fa-solid fa-book" }
    , projectDetails =
        [ { key = "Learn", value = "Started learning about Swift programming language" }
        ]
    , event = SwiftBeginsUpskillReadMoreClicked
    , logo = ""
    }


machineLearning : ItemContent
machineLearning =
    { content = { key = "Machine Learning", value = "Upskill" }
    , icon = { icon = " fa-solid fa-book" }
    , projectDetails =
        [ { key = "Learn", value = "Started learning about ML and AI" }
        ]
    , event = MachineLearningUpskillReadMoreClicked
    , logo = ""
    }


computerVisionAndAI : ItemContent
computerVisionAndAI =
    { content = { key = "Computer vision and AI", value = "Upskill" }
    , icon = { icon = " fa-solid fa-book" }
    , projectDetails =
        [ { key = "Learn", value = "Started learning Computer vision and AI" }
        ]
    , event = MachineLearningUpskillReadMoreClicked
    , logo = ""
    }


jul2019 : ItemContent
jul2019 =
    { content = { key = "July 2019", value = "Moved to Munich Germany." }
    , icon = { icon = " fa-solid fa-plane-arrival" }
    , projectDetails =
        [ { key = "NewJob", value = "Solution Architecht @KPIT GmbH" }
        , { key = "Location", value = "Munich, Germany" }
        ]
    , event = July2019ReadMoreClicked
    , logo = "munich.png"
    }


graduation : ItemContent
graduation =
    { content = { key = "July 2008", value = "Graduated with a degree in Telecommunications Engineering from VTU, Belgaum, Karnataka, India" }
    , icon = { icon = " fa-solid fa-graduation-cap" }
    , projectDetails =
        [ { key = "Graduation", value = "Successfuly completed my graduation." }
        , { key = "University", value = "Visvesvaraya Technological University, Belgaum, Karnataka, India" }
        , { key = "Collage", value = "Bangalore Institute of Technology" }
        , { key = "Location", value = "Bengaluru, India" }
        ]
    , event = NoOp
    , logo = "BIT.jpeg"
    }


opencvAward : ItemContent
opencvAward =
    { content = { key = "Sept 2018", value = "Won an award for the Best project in CV4Faces competition" }
    , icon = { icon = " fa-solid fa-award" }
    , projectDetails =
        [ { key = "CV4Faces Contest Award", value = "Won 2nd prize" }
        , { key = "OpenCV", value = "Won 2nd place in an international competition where more than 200 teams were competing." }
        , { key = "Learnings", value = "OpenCV, AI and ML" }
        , { key = "Location", value = "Bengaluru, India" }
        ]
    , event = NoOp
    , logo = ""
    }


section1 =
    "With 17 years of experience in the software engineering industry, I am passionate about building innovative solutions that drive technology forward. My journey has taken me through a diverse range of technologies, including C, C++, Go, Python, Swift, and Matlab. I have a strong background in embedded systems and the networking domain, which has allowed me to tackle complex challenges and deliver robust, scalable applications in multiple domains such as Automotive, Telecommunications etc.."


aboutMe : Html Msg
aboutMe =
    Html.div [ Attr.class "container" ]
        [ Html.div [ Attr.class "section" ]
            [ Html.div [ Attr.class "card" ]
                [ Html.div [ Attr.class "card-content" ]
                    [ Html.div [ Attr.class "content" ]
                        [ Html.div [ Attr.class "title has-text-centered" ]
                            [ Html.text "About Me" ]
                        , Html.p [ Attr.class "is-size-4" ] [ Html.text section1 ]
                        , Html.a
                            [ Attr.class "buttom is-light is-right"
                            , Html.Events.onClick AboutMeButtonClicked
                            ]
                            [ Html.text "Read More.." ]
                        ]
                    ]
                ]
            ]
        ]


timelineView : Model -> Html Msg
timelineView model =
    Html.div [ Attr.class "timeline is-centered" ]
        [ {- Html.header [ Attr.class "timeline-header is-centered" ]
             [ Html.span [ Attr.class "tag is-medium is-primary is-centered" ] [ Html.text "Start" ]
             ]
          -}
          timeLineItemView june2024
        , timeLineItemView may2024
        , timeLineItemView goAndElm
        , timeLineItemView reactAndElm
        , timeLineItemView jan2023ToMay2024
        , timeLineItemView geometricAlgebra
        , timeLineItemView april2021ToDec2022
        , timeLineItemView functionalProgramming
        , timeLineItemView may2020ToMar2021
        , timeLineItemView swiftBegins
        , timeLineItemView july2019ToMar2020
        , timeLineItemView joinedKPIT
        , timeLineItemView jul2019
        , timeLineItemView opencvAward
        , timeLineItemView computerVisionAndAI
        , timeLineItemView jan2017ToMar2019
        , timeLineItemView machineLearning
        , timeLineItemView june2011ToMay2016
        , timeLineItemView sept2008ToMay2011
        , timeLineItemView graduation
        , Html.header
            [ Attr.class "timeline-header is-centered mb-1 pb-1" ]
            [ Html.span [ Attr.class "tag is-medium is-warning is-centered" ] [ Html.text "Start" ]
            ]

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
        , Html.div [ Attr.class "timeline-content has-text-white" ]
            [ Html.div
                [ Attr.hidden (String.isEmpty props.logo)
                ]
                [ Html.figure
                    [ Attr.class "image is-48x48"
                    ]
                    [ Html.img
                        [ -- Attr.class "is-rounded 48"k
                          Attr.src ("/" ++ props.logo)
                        ]
                        []
                    ]
                ]
            , Html.p [ Attr.class "heading mt-5" ] [ Html.text props.content.key ]
            , Html.p [] [ Html.text props.content.value ]
            , sideCardNotificationDetailsView props.projectDetails

            {- , Html.a
               [ Attr.class "button is-dark "
               , Html.Events.onClick props.event
               ]
               [ Html.text "Read More..." ]
            -}
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
    Html.div
        [ Attr.class "field is-horizontal"
        ]
        [ Html.div [ Attr.class "field-label" ]
            [ labelView props.key
            ]
        , fieldBodyView props.value
        ]


footer : Model -> Html Msg
footer model =
    Html.section
        [ Attr.class "section pt-6 mb-6"
        , Attr.id "contact"
        ]
        [ Html.div [ Attr.class "columns" ]
            [ Html.div [ Attr.class "column" ]
                [ footerText
                    { key = " Email"
                    , value = "santhosh@techkunstler.com"
                    , icon = "fa-solid fa-at"
                    , id = "mobile"
                    }
                ]
            , Html.div [ Attr.class "column is-two-fifth" ]
                [ footerText
                    { key = " Mobile"
                    , value = "+91 9739317879"
                    , icon = "fa-solid fa-phone"
                    , id = "contact"
                    }
                ]
            ]
        ]


footerText : { key : String, value : String, icon : String, id : String } -> Html Msg
footerText props =
    Html.section [ Attr.class "section" ]
        [ Html.div
            [ Attr.class "field is-inline"
            , Attr.id props.id
            ]
            [ Html.label [ Attr.class (props.icon ++ " label has-text-white") ]
                [ Html.text props.key ]
            , Html.div [ Attr.class "has-text-white icons" ]
                [ Html.p [ Attr.class "is-size-3" ] [ Html.text props.value ]
                ]
            ]
        ]
