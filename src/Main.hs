{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Concurrent.Suspend (mDelay, sDelay, suspend)
import           Control.Concurrent.Timer   (repeatedTimer)
import           Control.Monad              (forever)
import qualified GI.Gdk                     as Gdk (init)

import qualified Trackee.Agents           as A (Screen (..))
import qualified Trackee.Events.Processor as E (processEvents)
import qualified Trackee.Types            as T (Agent (..))

main :: IO()
main = do
    initAgents
    initRoutine
    forever $ suspend (sDelay 1) -- main loop

agents = [A.Screen]

initAgents =
    mapM_ T.agentSetup agents

initRoutine = do
    theRoutine -- collect data right after starting
    repeatedTimer theRoutine (mDelay 1) -- and repeat it
    where
        theRoutine = E.processEvents agents
