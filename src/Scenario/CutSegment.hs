module Scenario.CutSegment
    ( cutSegment
    )
where

import           Data.Source
import           Data.Command

data Options = Options
    { fromTime :: String
    , toTime :: String
    , audioOnly :: Bool
    , includeSubtitles :: Bool
    }

cutSegment :: Options -> Source -> Command Source resolvedSource media ()
cutSegment Options {..} source = do
    resolvedSource <- resolve source
    if
        | audioOnly -> do
            audio <- cutAudioSegment resolvedSource
            persist audio
        | otherwise -> do
            video <- cutVideoSegment resolvedSource
            if
                | includeSubtitles -> do
                    subtitles <- cutSubtitlesSegment resolvedSource
                    result    <- combineSubtitlesAndVideo subtitles video
                    persist result
                | otherwise -> do
                    persist video
