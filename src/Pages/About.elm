module Pages.About exposing (Model, Msg, page)

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
        { backgroundImageUrl = "https://picsum.photos/id/381/1920/1080"
        , position = "center"
        , size = "100%"
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
    { title = "Pages.About"
    , body =
        [ -- Html.text "/about"
          aboutMe
        ]
    }


section1 =
    "With 17 years of experience in the software engineering industry, I am passionate about building innovative solutions that drive technology forward. My journey has taken me through a diverse range of technologies, including C, C++, Go, Python, Swift, and Matlab. I have a strong background in embedded systems and the networking domain, which has allowed me to tackle complex challenges and deliver robust, scalable applications."


section2 =
    "I thrive in collaborative environments, where I can share my expertise and learn from others. My focus is on leveraging best practices and cutting-edge tools to optimize performance and enhance user experiences. Whether I’m working on system-level programming or developing high-level applications, I am dedicated to continuous learning and improvement."


section3 =
    "I’m particularly passionate about the intersection of software and hardware, which has driven my interest in embedded systems. Working on projects that involve real-time data processing and networking has deepened my appreciation for the intricacies of system design and optimization.\n\n"


section4 =
    "My work ethic is driven by a commitment to quality and excellence. I prioritize writing clean, maintainable code and am always on the lookout for ways to improve processes and efficiencies. I enjoy code reviews and collaborative problem-solving sessions, as they foster an environment of shared learning and innovation."


section5 =
    "When I’m not coding, you can find me experimenting with new programming languages, diving into tech podcasts, or working on personal projects that push my skills further. I also enjoy giving back to the community through mentoring, where I can share insights and foster the growth of aspiring engineers."


section6 =
    "I’m excited about the future of technology and look forward to new challenges and opportunities that lie ahead. Let’s connect to discuss how my experience and passion can add value to your team or project!"


aboutMe : Html Msg
aboutMe =
    Html.div [ Attr.class "container" ]
        [ Html.div [ Attr.class "section" ]
            [ Html.div [ Attr.class "card" ]
                [ Html.div [ Attr.class "card-content" ]
                    [ Html.div [ Attr.class "content" ]
                        [ Html.div [ Attr.class "title has-text-centered" ]
                            [ Html.text "About Me" ]
                        , Html.p [] [ Html.text section1 ]
                        , Html.p [] [ Html.text section2 ]
                        , Html.p [] [ Html.text section3 ]
                        , Html.p [] [ Html.text section4 ]
                        , Html.p [] [ Html.text section5 ]
                        , Html.p [] [ Html.text section6 ]
                        ]
                    ]
                ]
            ]
        ]
