module Trackee.Types ( Event(..), Plug(..), Agent(..), Inhibitor(..) ) where

import qualified Data.ByteString as B

data Event = PlainText {content :: IO String} | File {mimeType :: String, file :: IO B.ByteString} | Nothing

-- | Class representing a "plugin" (source-level for now)
class Plug a where
    -- | plugin name, e.g. "waste_time", goes to activity database, and everywhere else
    name :: a -> String
    -- | plugin description, e.g. "Plugin that wastes time, space and reality itself", goes to verbose "plugin" list
    description :: a -> String
    -- | Set up plugin
    setup :: a -> IO()

-- | "Agents" do collect actual data
class Agent a where
    -- | An event to be collected
    event :: a -> Event

-- | "Inhibitors" decide if collection should be suspended
class Inhibitor i where
    -- | Inhibit collection or not
    shouldInhibit :: i -> Bool
