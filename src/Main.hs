{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Concurrent.Suspend (mDelay, sDelay, suspend)
import           Control.Concurrent.Timer   (repeatedTimer)
import           Control.Monad              (forever)
import qualified GI.Gdk                     as Gdk (init)

import Trackee.Agents.Screen    as S (newAgent)
import Trackee.Events.Processor as E (processEvents)

main :: IO()
main = do
    Gdk.init []
    repeatedTimer (E.processEvents agents) (mDelay 1)
    forever (suspend (sDelay 1)) -- main loop

agents = [S.newAgent]
