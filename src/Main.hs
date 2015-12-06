{-# LANGUAGE OverloadedStrings #-}
module Main where

import Graphics.UI.Gtk
import Graphics.UI.Gtk.Gdk.Screen
import System.Environment
import Data.Text
import Data.Time (getCurrentTime)
import Data.Time.ISO8601 (formatISO8601)

main :: IO()
main = do
  [fileName] <- getArgs
  initGUI
  now <- getCurrentTime
  pxb <- getScreenBuf
  pixbufSave pxb (renderName fileName (formatISO8601 now) "" ) "png" ([] :: [(Text, Text)])

getScreenBuf :: IO Pixbuf
getScreenBuf = do
  Just screen <- screenGetDefault
  window <- screenGetRootWindow screen
  size <- drawableGetSize window
  origin <- drawWindowGetOrigin window
  Just pxbuf <- pixbufGetFromDrawable window ((uncurry . uncurry Rectangle) origin size)
  return pxbuf

renderName :: String -> String -> String -> String
renderName prefix name suffix =
    prefix ++ "." ++ name ++ "." ++ suffix ++ ".png"
