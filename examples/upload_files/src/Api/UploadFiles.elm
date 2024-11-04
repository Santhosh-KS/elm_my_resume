module Api.UploadFiles exposing (post)

import Effect exposing (Effect)
import File exposing (File)
import Http


serverEndPoint : String
serverEndPoint =
    "http://localhost:4000/v1/upload"



-- "https://discourse.vbuntu.in/v1/upload"
-- "http://localhost:4000/v1/upload"
{- pair : (Result Http.Error String -> msg) -> File -> ( File, Result Http.Error String -> msg )
   pair f1 f2 =
       ( f2, f1 )


   pairs : List File -> (Result Http.Error String -> msg) -> List ( File, Result Http.Error String -> msg )
   pairs fs r =
       List.map (pair r) fs


   cmdGen : ( File, Result Http.Error String -> msg ) -> Effect msg
   cmdGen ( file, response ) =
       let
           cmd =
               Http.post
                   { url = serverEndPoint
                   , body = Http.fileBody file

                   -- , body = Http.multipartBody file
                   , expect = Http.expectString response
                   }
       in
       Effect.sendCmd cmd


   cmds : List ( File, Result Http.Error String -> msg ) -> List (Effect msg)
   cmds l =
       List.map cmdGen l
-}


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



{- let
       batchCmds =
           pairs options.files options.onResponse
               |> cmds
   in
   Effect.batch batchCmds
-}
