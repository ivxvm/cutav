module Data.Source
    ( Source(..)
    , parse
    )
where

import           System.FilePath               as P
import           Data.List
import           Text.Regex.TDFA

data Source
    = FileSource String
    | YoutubeSource String
    | SoundCloudSource String
    deriving (Show, Eq)

parse :: String -> Maybe Source
parse s | isFilePath s      = Just $ FileSource s
        | isYoutubeUrl s    = Just $ YoutubeSource s
        | isSoundCloudUrl s = Just $ SoundCloudSource s
        | otherwise         = Nothing

isFilePath :: String -> Bool
isFilePath = P.isValid

isYoutubeUrl :: String -> Bool
isYoutubeUrl s = s =~ "^(https?://)?(www\\.)?youtube\\.com/watch\\?v="

isSoundCloudUrl :: String -> Bool
isSoundCloudUrl s = s =~ "^(https?://)?(www\\.)?soundcloud\\.com/"
