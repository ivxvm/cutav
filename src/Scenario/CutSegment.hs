module Scenario.CutSegment
    ( cutSegment
    )
where

import           Data.Source
import           Data.Command

cutSegment :: Source -> String -> String -> Command ()
cutSegment source from to = do
    input <- resolve source
    exec $ "ffmpeg -i " ++ input
    return ()
