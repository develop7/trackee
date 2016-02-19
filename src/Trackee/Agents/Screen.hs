{-# LANGUAGE OverloadedStrings #-}
module Trackee.Agents.Screen (newAgent) where

import           Data.ByteString           as B
import           GI.Gdk                    as Gdk (pixbufGetFromWindow,
                                                   screenGetDefault,
                                                   screenGetRootWindow,
                                                   windowGetGeometry)
import           GI.GdkPixbuf              as GPxb (pixbufSaveToBufferv)

import           Trackee.Types             as T

newAgent :: T.Agent
newAgent = T.Agent {name = "screen", description = "Grabs screenshots", event = readEvent}

readEvent =
    T.File {mimeType = "image/jpeg", file = doShot}

doShot :: IO B.ByteString
doShot = do
         screen <- screenGetDefault
         window <- screenGetRootWindow screen
         (x,y,w,h) <- windowGetGeometry window
         pxbuf <- pixbufGetFromWindow window x y w h
         pixbufSaveToBufferv pxbuf "jpeg" ["quality"] ["85"]

{-
doShot =
    pixbufSaveToBufferv pixbuf "jpeg" ["quality"] ["85"]
    where
        theWindow = screenGetDefault >>= screenGetRootWindow
        geometry = (>>=) windowGetGeometry theWindow
        pixbuf' = windowGetGeometry theWindow >>= pixbufGetFromWindow
        pixbuf = uncurryN pixbuf' geometry
-}
