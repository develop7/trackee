module Trackee.Types ( Event(..), Agent(..), Inhibitor(..) ) where

import qualified Data.ByteString as B

data Event = PlainText {content :: String} | File {mimeType :: String, file :: IO B.ByteString} | Nothing

class Agent a where
    agentName :: a -> String
    agentDesc :: a -> String
    agentEvent :: a -> Event
    agentSetup :: a -> IO()

class Inhibitor i where
    inhName :: i -> String
    shouldInhibit :: i -> Bool
    inhSetup :: i -> IO()
