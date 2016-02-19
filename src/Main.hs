{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Concurrent.Suspend (sDelay)
import           Control.Concurrent.Timer   (repeatedTimer)
import qualified Data.ByteString            as B (writeFile)
import           Data.String.Utils          (join)
import           Data.Time                  (getCurrentTime)
import           Data.Time.Format           (defaultTimeLocale, formatTime)
import qualified GI.Gdk                     as Gdk (init)

import           Trackee.Agents.Screen      as S
import           Trackee.Types              as T

main :: IO()
main = do
  Gdk.init []
  repeatedTimer processEvents (sDelay 10)
  readLn

renderName :: String -> String -> String -> String
renderName prefix name suffix =
    prefix ++ "." ++ name ++ "." ++ suffix

renderTime =
  formatTime defaultTimeLocale "%Y%m%dT%H%M%S"

agents = [S.newAgent]

processEvents = do
    time <- getCurrentTime
    mapM_ (\agent -> do
                    shot <- file $ event agent
                    B.writeFile (renderName "shot" (renderTime time) "jpeg") shot
                ) agents
    putStrLn $ ">" ++ renderTime time ++ "<" ++ " processed data from agents:" ++ join ", " (map name agents)

