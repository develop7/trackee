{-# LANGUAGE OverloadedStrings #-}
module Main where

import Graphics.UI.Gtk
import Graphics.UI.Gtk.Gdk.Screen
import System.Environment
import Data.Text

main :: IO()
main = do
  [fileName] <- getArgs
  initGUI
  Just screen <- screenGetDefault
  window <- screenGetRootWindow screen
  size <- drawableGetSize window
  origin <- drawWindowGetOrigin window
  Just pxbuf <- pixbufGetFromDrawable window ((uncurry . uncurry Rectangle) origin size)
  pixbufSave pxbuf fileName "png" ([] :: [(Text, Text)])
