module Trackee.Events.Processor (processEvents) where

import qualified Data.ByteString   as B (writeFile)
import           Data.String.Utils (join)
import           Data.Time         (getCurrentTime)
import           Data.Time.Format  (defaultTimeLocale, formatTime)

import Trackee.Agents.Screen as S
import Trackee.Types         as T

processEvents agents =
    let
        writeScreenshot time agent = do
            shot <- file $ event agent
            B.writeFile (renderName "shot" (renderTime time) "jpeg") shot
    in
    do
        time <- getCurrentTime
        mapM_ (writeScreenshot time) agents
        putStrLn $ ">" ++ renderTime time ++ "<" ++ " processed data from agents:" ++ join ", " (map name agents)

renderName :: String -> String -> String -> String
renderName prefix name suffix =
    prefix ++ "." ++ name ++ "." ++ suffix

renderTime =
  formatTime defaultTimeLocale "%Y%m%dT%H%M%S"
