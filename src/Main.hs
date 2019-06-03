{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Concurrent.Suspend (mDelay, sDelay, suspend)
import           Control.Concurrent.Timer   (repeatedTimer)
import           Control.Monad              (forever)
import qualified Data.ByteString            as B (ByteString, writeFile)
import           Data.String.Utils          (join)
import           Data.Time                  (UTCTime, defaultTimeLocale, formatTime, getCurrentTime)
import           DBus                       (MethodCall (..), MethodReturn (..), Variant (..), methodCall, fromVariant)
import           DBus.Client                (call_, connectSession)
import qualified GI.Gdk                     as Gdk (init, pixbufGetFromWindow, screenGetDefault, screenGetRootWindow,
                                                    windowGetGeometry)
import qualified GI.GdkPixbuf               as Gdk.PB (pixbufSaveToBufferv)
import qualified GI.Wnck                    as Wnck (screenGetShowingDesktop)

main :: IO ()
main = do
  setupAgents
  setupRoutine
  forever $ suspend (sDelay 1) -- main loop

setupAgents = Gdk.init []

setupRoutine = do
  theRoutine -- collect data right after starting
  repeatedTimer theRoutine (mDelay 1) -- and repeat it. TODO: delay should be configurable
  where
    theRoutine = doRoutine

doRoutine :: IO ()
doRoutine = do
  skipIt <- isInhibited
  if skipIt
    then return ()
    else do
      now <- getCurrentTime
      bytes <- captureScreenshot
      writeScreenshot now bytes

isInhibited :: IO Bool
isInhibited = do
  client <- connectSession
  reply <-
    call_
      client
      (methodCall "/org/gnome/ScreenSaver" "org.gnome.ScreenSaver" "GetActive")
        {methodCallDestination = Just "org.gnome.ScreenSaver"}
  let Just ret = fromVariant $ head $ methodReturnBody reply
  return ret

writeScreenshot :: UTCTime -> B.ByteString -> IO ()
writeScreenshot now bytes = B.writeFile (renderName ["shot", renderTime now, "jpeg"]) bytes
  where
    renderName = join "."
    renderTime = formatTime defaultTimeLocale "%Y%m%dT%H%M%S"

captureScreenshot :: IO B.ByteString
captureScreenshot = do
  Just screen <- Gdk.screenGetDefault
  window <- Gdk.screenGetRootWindow screen
  (x, y, w, h) <- Gdk.windowGetGeometry window
  Just pxbuf <- Gdk.pixbufGetFromWindow window x y w h
  Gdk.PB.pixbufSaveToBufferv pxbuf "jpeg" ["quality"] ["75"]
