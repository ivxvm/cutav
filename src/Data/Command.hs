module Data.Command
    ( CommandF(..)
    , Command
    , resolve
    , cutAudioSegment
    , cutVideoSegment
    , cutSubtitlesSegment
    , combineAudioAndVideo
    , combineSubtitlesAndVideo
    , persist
    )
where

import           Data.Source
import           Control.Monad.Free            as Free

data CommandF source resolvedSource media r
    = Resolve source (resolvedSource -> r)
    | CutAudioSegment resolvedSource (media -> r)
    | CutVideoSegment resolvedSource (media -> r)
    | CutSubtitlesSegment resolvedSource (media -> r)
    | CombineAudioAndVideo media media (media -> r)
    | CombineSubtitlesAndVideo media media (media -> r)
    | Persist media
    deriving (Functor)

type Command source resolvedSource media = Free (CommandF source resolvedSource media)

resolve :: source -> Command source resolvedSource media resolvedSource
resolve source = liftF $ Resolve source id

cutAudioSegment :: resolvedSource -> Command source resolvedSource media media
cutAudioSegment resolvedSource = liftF $ CutAudioSegment resolvedSource id

cutVideoSegment :: resolvedSource -> Command source resolvedSource media media
cutVideoSegment resolvedSource = liftF $ CutVideoSegment resolvedSource id

cutSubtitlesSegment :: resolvedSource -> Command source resolvedSource media media
cutSubtitlesSegment resolvedSource = liftF $ CutSubtitlesSegment resolvedSource id

combineAudioAndVideo :: media -> media -> Command source resolvedSource media media
combineAudioAndVideo audio video = liftF $ CombineAudioAndVideo audio video id

combineSubtitlesAndVideo :: media -> media -> Command source resolvedSource media media
combineSubtitlesAndVideo subtitles video = liftF $ CombineSubtitlesAndVideo subtitles video id

persist :: media -> Command source resolvedSource media ()
persist media = liftF $ Persist media
