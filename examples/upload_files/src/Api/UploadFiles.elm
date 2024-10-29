module Api.UploadFiles exposing (post)

import Effect exposing (Effect)
import File exposing (File)
import Http


serverEndPoint : String
serverEndPoint =
    "http://localhost:4000/v1/upload"


nameFile : String -> File -> Http.Part
nameFile name file =
    Http.filePart name file


nameFiles : String -> List File -> List Http.Part
nameFiles name files =
    List.map (nameFile name) files


post :
    { onResponse : Result Http.Error String -> msg
    , files : List File
    }
    -> Effect msg
post options =
    let
        body =
            nameFiles "myFile" options.files

        cmd =
            Http.post
                { url = serverEndPoint
                , body = Http.multipartBody body
                , expect = Http.expectString options.onResponse
                }
    in
    Effect.sendCmd cmd
