{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified GI.Gtk as Gtk (init)
import GI.Gdk as Gdk
import GI.GdkPixbuf as GPxb
import Data.Text (pack)
import System.Environment (getArgs)
import Data.Time (getCurrentTime)
import Data.Time.ISO8601 (formatISO8601)

main :: IO()
main = do
  [fileName] <- getArgs
  Gtk.init (Just [pack fileName])
  screen <- screenGetDefault
  window <- screenGetRootWindow screen
  (x,y,w,h) <- windowGetGeometry window
  pxbuf <- pixbufGetFromWindow window x y w h
  pixbufSavev pxbuf (pack fileName) "jpeg" ["quality"] ["85"]

renderName :: String -> String -> String -> String
renderName prefix name suffix =
    prefix ++ "." ++ name ++ "." ++ suffix ++ ".png"
