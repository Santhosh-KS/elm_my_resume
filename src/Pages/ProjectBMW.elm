module Pages.ProjectBMW exposing (Model, Msg, page)

import Effect exposing (Effect)
import Html exposing (Html)
import Html.Attributes as Attr
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
        { backgroundImageUrl = "https://images.unsplash.com/photo-1703794451509-ea01f7e0cac1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
        , position = "left 30% bottom 55%"
        , size = "100%"
        , title = "BMW"
        , subtitle = "Automotive Journey begins.."
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
    { title = "BMW"
    , body =
        [ Html.div [ Attr.style "border-top" "30px solid turquoise" ] []
        , Html.div [ Attr.class "container" ]
            [ bodyHero
                { title = "BMW"
                , subtitle = "A dream come true moment.."
                }
            ]
        , Html.div [ Attr.style "border-top" "2px solid turquoise" ] []
        , colunmize
            { trios =
                { title = "Description", subtitle = "My role in the project", details = des2 }
            , details = projectDetails
            }
        , Html.div [ Attr.style "border-top" "2px solid turquoise" ] []
        , bulletPoints { elements = [ "One", "Two", "Three" ] }
        ]
    }


type RequiredField
    = Project
    | Period
    | Company
    | Client
    | Environment
    | TeamSize
    | Domain
    | Location
    | Skills
    | Tools


type alias KeyValPair =
    { key : RequiredField, value : String }


type alias Details =
    List KeyValPair


projectDetails : Details
projectDetails =
    [ { key = Project, value = "Autonomous Driving cars" }
    , { key = Period, value = "July 2019 – Jan 2020" }
    , { key = Company, value = "KPIT Technologies Gmbh." }
    , { key = Client, value = "BMW" }
    , { key = Environment, value = "Linux" }
    , { key = TeamSize, value = "8" }
    , { key = Domain, value = "Automotive" }
    , { key = Location, value = "Munich Germany" }
    ]


techSkillsList : List String
techSkillsList =
    [ "C++11"
    , "C++14"
    , "ROS"
    , "OpenCV"
    , "Python"
    , "Bash Scripting"
    , "Design Pattern"
    ]


softSkillsList : List String
softSkillsList =
    [ "Client Interactions"
    , "Requirements Gathering"
    , "Team building"
    , "Mentoring"
    , "Effective communication"
    , "Client Success"
    , "Business Requirements"
    , "Multicultural Team Leadership"
    ]


toolsList : List String
toolsList =
    [ "Git"
    , "Wireshark"
    , "Tcpdump"
    , "Uftrace"
    , "Gdb"
    , "Bazel"
    , "Gtest"
    , "Gmock"
    , "Zuul"
    , "Confluence"
    , "Jira"
    , "Large Scale Scrum"
    ]



{- Project = ""

      My Role: "The project involves developing software for Autonomous cars. My work is focused on evaluating the
   performance of the Cameras present in the car. This includes exploring possible Key performance Indexes (KPI’s) which
   affects the overall decision making capabilities of the self driving car."
-}


requiredFieldToString : RequiredField -> String
requiredFieldToString f =
    case f of
        Project ->
            "Project"

        Period ->
            "Period"

        Company ->
            "Company"

        Client ->
            "Client"

        Environment ->
            "Environment"

        TeamSize ->
            "Team Size"

        Domain ->
            "Domain"

        Location ->
            "Location"

        Skills ->
            "Skills"

        Tools ->
            "Tools"


field : KeyValPair -> Html Msg
field props =
    Html.div
        [ Attr.class "field is-horizontal"
        ]
        [ Html.div [ Attr.class "field-label " ]
            [ labelView (requiredFieldToString props.key)
            ]
        , fieldBodyView props.value
        ]


fields : List KeyValPair -> List (Html Msg)
fields kvps =
    List.map field kvps


labelView : String -> Html Msg
labelView v =
    Html.label [ Attr.class "label is-underlined is-size-5 has-text-weight-bold has-text-left" ] [ Html.text v ]


ncb : String -> Html Msg
ncb v =
    Html.div
        [ Attr.class "button is-small is-warning m-2" ]
        [ Html.text v ]


nonClickableButtons : List String -> List (Html Msg)
nonClickableButtons vals =
    List.map ncb vals


fieldBodyView : String -> Html Msg
fieldBodyView v =
    Html.div [ Attr.class "field-body has-text-right is-size-5 has-text-white" ]
        [ Html.div [ Attr.class "field" ]
            [ Html.p [ Attr.class "has-text-weight-semibold" ] [ Html.text (" : " ++ v) ]
            ]
        ]


bodyHero :
    { title : String
    , subtitle : String
    }
    -> Html Msg
bodyHero props =
    Html.section [ Attr.class "section has-text-centered" ]
        [ Html.h1 [ Attr.class "title is-size-1 " ] [ Html.text props.title ]
        , Html.h2 [ Attr.class "subtitle is-size-6" ] [ Html.text props.subtitle ]
        , Html.div [] (nonClickableButtons techSkillsList)
        , Html.div [] (nonClickableButtons toolsList)
        , Html.div [] (nonClickableButtons softSkillsList)
        ]


myrole : String
myrole =
    """The project involved interacting with a BMW team which was owning the 'Road' features. 'Road' features includes the following
    1. Lane marking
    2. Lane boundary 
    3. Lane Type
    4. Surface types of road
    5. Objects in and around vehicles
    6. Free space in and around vehicles. etc..
    I played the pivotal role of bridging the BMW team and the KPIT team to develop the C++ applications which will help BWM Autonomous vehicles Camrea and ML models validation. The C++ application I worked on evaluates the performance of the Cameras on the above mentioned lists. This application is very challenging as we will be doing what the AI algorithms will be doing. But also we will be validting the AI models so we need to wear an 'adversery' hat to think and beat it to get the real value out of this tool. This is needs both the system level understanding of the Embedded devices as well as the knowledge of AI models. Ofcourse on our normal job we did finish the project, but we as a team didn't stop there. The place where I made my team shine was, I helped the client in solving one more important problem they were having. That is, the image/video output of data were manually annotated by the third party vendors. Ofen when we were validating the results of our C++ application with the AI generated results, we used to get lot of anamolies, mainly becuause of poor quality of annotated data. Our evaluation was only as good as the quality of the annotated data we used to receive. Usually when we encounter such issues in the annotated data, it used to takes weeks togather to get those data re-annotated and shared with us. This was causing lot of downtime for our team and hence delaying the progress of our work. So, to address this problem, I built a another C++ tool using OpenCV libs, which will give instant validation for the third parties to validate the quality of their work. We did share these tool with the third party vendors and the turn around time reduced to couple of hours and the quality of the data we received improved dramatically. This tool was well appreciated inside the BMW team and helped the client to get the project delivered in the stipulated time."""


des1 =
    """
    I developed a C++ application focused on evaluating the performance of cameras equipped with built-in AI by adopting an adversarial approach. This innovative system is designed to intentionally challenge and exploit the weaknesses of the AI, simulating scenarios that push the boundaries of its capabilities. By creating a variety of adversarial inputs and conditions, I rigorously tested how the cameras respond to atypical or deceptive situations. This application not only highlights my programming expertise but also underscores my strategic thinking in assessing AI resilience, ultimately aiming to enhance the robustness and reliability of these cameras used in ADAS (Advanced Driver Assistance Systems).
    I played a key role of bridging the gap of understanding the system level requirements and also utilized my past experiance in using ML and AI in solving this problem. The team consisted of C++ engineers worked in different domains such as Finance and Avionics, so there was a technical gap which I had to fill in to make sure the team understands the requirements and deliver the quality code to the customer. 
    """


des2 =
    """
       I played a key role of bridging the gap of understanding the system level requirements and also utilized my past experiance in using ML and AI in solving this problem. The team consisted of C++ engineers worked in different domains such as Finance and Avionics, so there was a technical gap which I had to fill in to make sure the team understands the requirements and deliver the quality code to the customer. 
    """


colunmize : { trios : Trios, details : Details } -> Html Msg
colunmize props =
    Html.div [ Attr.class "columns" ]
        [ Html.div [ Attr.class "column is-one-fifth" ] []
        , Html.div [ Attr.class "column" ]
            [ Html.section [ Attr.class "section " ] (fields props.details)
            ]
        , Html.div [ Attr.class "column is-half" ]
            [ description props.trios
            ]
        ]


stringToLi : String -> Html Msg
stringToLi v =
    Html.div [ Attr.class "list-item" ]
        [ Html.li [] [ Html.text v ]
        ]


bulletPoints : { elements : List String } -> Html Msg
bulletPoints props =
    Html.div [ Attr.class "list" ]
        [ Html.ul [ Attr.class "has-text-white" ]
            (List.map stringToLi props.elements)
        ]


type alias Trios =
    { title : String
    , subtitle : String
    , details : String
    }


description : Trios -> Html Msg
description props =
    Html.section [ Attr.class "section " ]
        [ Html.h1 [ Attr.class "title is-size-4 " ] [ Html.text props.title ]
        , Html.h2 [ Attr.class "subtitle is-size-6" ] [ Html.text props.subtitle ]
        , Html.p [ Attr.class "has-text-white is-size-5" ] [ Html.text props.details ]
        ]
