{-# LANGUAGE OverloadedStrings #-}
module Trackee.Agents ( Screen(..) ) where

import Data.ByteString as B
import GI.Gdk          as Gdk (pixbufGetFromWindow, screenGetDefault, screenGetRootWindow, windowGetGeometry, init)
import GI.GdkPixbuf    as GPxb (pixbufSaveToBufferv)

import Trackee.Types as T

data Screen = Screen

instance T.Agent Screen where
    agentName Screen = "screen"
    agentDesc Screen = "Grabs screenshots"
    agentEvent Screen =  T.File {mimeType = "image/jpeg", file = doScreenshot}
    agentSetup Screen = do
        Gdk.init []
        return ()

doScreenshot :: IO B.ByteString
doScreenshot = do
     screen <- screenGetDefault
     window <- screenGetRootWindow screen
     (x,y,w,h) <- windowGetGeometry window
     pxbuf <- pixbufGetFromWindow window x y w h
     pixbufSaveToBufferv pxbuf "jpeg" ["quality"] ["85"]

