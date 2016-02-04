{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified GI.Gtk as Gtk (init)
import           GI.Gdk as Gdk (screenGetDefault, screenGetRootWindow, windowGetGeometry, pixbufGetFromWindow)
import           GI.GdkPixbuf as GPxb (pixbufSavev)
import           Data.Text (pack)
import           System.Environment (getArgs)
import           Data.Time (getCurrentTime)
import           Data.Time.Format (formatTime, defaultTimeLocale)
import           Control.Concurrent.Timer (repeatedTimer)
import           Control.Concurrent.Suspend (sDelay)

main :: IO()
main = do
  Gtk.init (Just [])
  repeatedTimer saveShot (sDelay 10)
  readLn

renderName :: String -> String -> String -> String
renderName prefix name suffix =
    prefix ++ "." ++ name ++ "." ++ suffix

renderTime =
  formatTime defaultTimeLocale "%Y%m%dT%H%M%S"

doShot = do
  screen <- screenGetDefault
  window <- screenGetRootWindow screen
  (x,y,w,h) <- windowGetGeometry window
  pixbufGetFromWindow window x y w h

saveShot = do
  pxbuf <- doShot
  time <- getCurrentTime
  putStr $ renderTime time
  putStrLn " tick"
  pixbufSavev pxbuf (pack $ renderName "shot" (renderTime time) "jpg") "jpeg" ["quality"] ["85"]
