module Pages.Home_ exposing (page)

import Html exposing (Html)
import Html.Attributes as Attr exposing (wrap)
import View exposing (View)


page : View msg
page =
    { title = "Homepage"
    , body =
        [ -- Html.text "Hello, world!"
          content
        ]
    }


defaultLink : String
defaultLink =
    "https://example.com"


aTag :
    { href : String
    , src : String
    , alt : String
    , title : String
    , class : String
    }
    -> Html msg
aTag props =
    Html.div [ Attr.class props.class ]
        [ Html.a
            [ Attr.href props.href
            , Attr.target "_blank"
            ]
            [ Html.img
                [ Attr.src props.src
                , Attr.alt props.alt
                , Attr.title props.title
                ]
                []
            ]
        ]


aTagText :
    { href : String
    , src : String
    , text : String
    }
    -> Html msg
aTagText props =
    Html.div []
        [ Html.a
            [ Attr.href props.href
            , Attr.target "_blank"
            ]
            [ Html.text props.text
            ]
        ]


wrapper : Html msg
wrapper =
    Html.div [ Attr.class "wrapper" ]
        [ -- Html.text "Hello world!"
          aTag
            { class = "logo"
            , href = defaultLink
            , src = "https://i.ibb.co/JtckNqn/logo.png"
            , title = "HTML5 Logo"
            , alt = "HTML5 Logo"
            }
        , aTag
            { class = "banner"
            , href = defaultLink
            , src = "https://i.ibb.co/zQ558kP/banner.png"
            , title = "Banner"
            , alt = "Banner"
            }
        , threeColumns
            { imgSrc = "https://i.ibb.co/tHQy3gL/mouse.png"
            , imgTitle = "Mouse"
            , imgAlt = "Mouse"
            , h1Text = "Email Development"
            , pText = "Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat."
            , btnText = "Learn More"
            }
        , threeColumns
            { imgSrc = "https://i.ibb.co/42MJn1V/phone.png"
            , imgTitle = "Phone"
            , imgAlt = "Phone"
            , h1Text = "Mobile Friendly"
            , pText = "Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat."
            , btnText = "HTML Email"
            }
        , threeColumns
            { imgSrc = "https://i.ibb.co/RD0sR6V/computer.png"
            , imgTitle = "Computer"
            , imgAlt = "Computer"
            , h1Text = "Desktop Clients"
            , pText = "Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat."
            , btnText = "Development"
            }
        , hoirzontalLine
        , twoColumnFirst
            { imgSrc = "https://i.ibb.co/NKdYy92/pie-chart.png"
            , imgTitle = "Pie chart"
            , imgAlt = "Pie chart"
            }
        , twoColumnSecond
            { h1Text = "Latest Email Design"
            , pText = " Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat."
            , btnText = "Email Design course"
            }
        , hoirzontalLine
        , footer
        , footerContact
        ]


hoirzontalLine : Html msg
hoirzontalLine =
    Html.hr [ Attr.class "orange" ] []


footer : Html msg
footer =
    Html.ul [ Attr.class "social" ]
        [ liTag
            { imgSrc = "https://i.ibb.co/5cp6Gtb/facebook.png"
            , imgAlt = "Facebook"
            , imgTitle = "Facebook"
            }
        , liTag
            { imgSrc = "https://i.ibb.co/m4PgXq6/twitter.png"
            , imgAlt = "Twitter"
            , imgTitle = "Twitter"
            }
        , liTag
            { imgSrc = "https://i.ibb.co/Ttf0YmH/youtube.png"
            , imgAlt = "YouTube"
            , imgTitle = "YouTube"
            }
        , liTag
            { imgSrc = "https://i.ibb.co/8brZJJt/instagram.png"
            , imgAlt = "Instagram"
            , imgTitle = "Instagram"
            }
        , liTag
            { imgSrc = "https://i.ibb.co/3zn6mW3/linkedin.png"
            , imgAlt = "LinkedIn"
            , imgTitle = "LinkedIn"
            }
        ]


footerContact : Html msg
footerContact =
    Html.p [ Attr.class "contact" ]
        [ aTagText
            { href = defaultLink
            , src = ""
            , text = "www.myportfolio.com"
            }
        , aTagText
            { href = "tel:+1800555555"
            , src = ""
            , text = "1-800-555-5555"
            }
        , aTagText
            { href = "mailto:mail@myportfolio.com"
            , src = ""
            , text = "mail@myportfolio.com"
            }
        , Html.text "2 Town Road - City -State - 99999"
        , aTagText
            { href = defaultLink
            , src = ""
            , text = "Unsubscribe | Preferences"
            }

        {- , Html.text " | "
           , aTagText
               { href = defaultLink
               , src = ""
               , text = "Preferences"
               }
        -}
        ]


liTag :
    { imgSrc : String
    , imgAlt : String
    , imgTitle : String
    }
    -> Html msg
liTag props =
    Html.li []
        [ Html.a
            [ Attr.href defaultLink
            , Attr.target "_blank"
            ]
            [ Html.img
                [ Attr.src props.imgSrc
                , Attr.alt props.imgAlt
                , Attr.title props.imgTitle
                ]
                []
            ]
        ]


btn :
    { href : String
    , class : String
    , text : String
    }
    -> Html msg
btn props =
    Html.a
        [ Attr.href props.href
        , Attr.target "_blank"
        , Attr.class props.class
        ]
        [ Html.text props.text ]


threeColumns :
    { imgSrc : String
    , imgTitle : String
    , imgAlt : String
    , h1Text : String
    , pText : String
    , btnText : String
    }
    -> Html msg
threeColumns props =
    Html.div [ Attr.class "three-columns" ]
        [ aTag
            { class = ""
            , href = defaultLink
            , src = props.imgSrc
            , title = props.imgTitle
            , alt = props.imgAlt
            }
        , Html.h2 [] [ Html.text props.h1Text ]
        , Html.p [] [ Html.text props.pText ]
        , btn
            { class = "btn"
            , text = props.btnText
            , href = defaultLink
            }
        ]


twoColumnFirst :
    { imgSrc : String
    , imgTitle : String
    , imgAlt : String
    }
    -> Html msg
twoColumnFirst props =
    Html.div [ Attr.class "two-columns" ]
        [ aTag
            { class = ""
            , href = defaultLink
            , src = props.imgSrc
            , title = props.imgTitle
            , alt = props.imgAlt
            }
        ]


twoColumnSecond : { h1Text : String, pText : String, btnText : String } -> Html msg
twoColumnSecond props =
    Html.div [ Attr.class "two-columns second" ]
        [ Html.h2 [] [ Html.text props.h1Text ]
        , Html.p [] [ Html.text props.pText ]
        , btn
            { class = "btn"
            , text = props.btnText
            , href = defaultLink
            }
        ]


column : Html msg
column =
    Html.div []
        []


content : Html msg
content =
    wrapper



-- Html.text "Hello world!"
