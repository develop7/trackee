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
    initAgents
    initRoutine
    forever (suspend (sDelay 1)) -- main loop

agents = [S.newAgent]

initAgents =
    Gdk.init []

initRoutine = do
    theRoutine -- collect data right after starting
    repeatedTimer theRoutine (mDelay 1) -- and repeat it
    where
        theRoutine = E.processEvents agents
