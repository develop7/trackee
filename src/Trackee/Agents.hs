{-# LANGUAGE OverloadedStrings #-}
module Trackee.Agents ( Screen(..) ) where

import qualified Data.ByteString as B
import qualified GI.Gdk          as Gdk (init, pixbufGetFromWindow, screenGetDefault, screenGetRootWindow,
                                         windowGetGeometry)
import qualified GI.GdkPixbuf    as GPxb (pixbufSaveToBufferv)

import Trackee.Types as T

-- | An screen-shooting agent.
-- | Makes screenshots with GDK, saves them in JPEG and returns @T.File@ with them
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
     screen <- Gdk.screenGetDefault
     window <- Gdk.screenGetRootWindow screen
     (x,y,w,h) <- Gdk.windowGetGeometry window
     pxbuf <- Gdk.pixbufGetFromWindow window x y w h
     GPxb.pixbufSaveToBufferv pxbuf "jpeg" ["quality"] ["85"]

