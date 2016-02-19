module Trackee.Types ( Event(..), Agent(..) ) where

import qualified Data.ByteString as B

data Event = PlainText {content :: String} | File {mimeType :: String, file :: IO B.ByteString}

data Agent = Agent {
                   name        :: String,
                   description :: String,
                   event       :: Event
                   }
