module Options
    ( Options(..)
    , parseFromCommandLine
    )
where

import           Options.Applicative
import           Data.Semigroup                 ( (<>) )

data Options = Options
  { source :: String
  , start :: String
  , end :: String
  }
  deriving (Show)

sourceArgumentParser :: Parser String
sourceArgumentParser = strArgument
    (metavar "SOURCE" <> help "Media source (usually filepath or url)")

startOptionParser :: Parser String
startOptionParser = strOption
    (long "start" <> short 's' <> metavar "START" <> help "Start timestamp")

endOptionParser :: Parser String
endOptionParser =
    strOption (long "end" <> short 'e' <> metavar "END" <> help "End timestamp")

optionsParser :: Parser Options
optionsParser = do
    source <- sourceArgumentParser
    start  <- startOptionParser
    end    <- endOptionParser
    pure Options { .. }

parseFromCommandLine :: IO Options
parseFromCommandLine = execParser $ info
    (optionsParser <**> helper)
    (  fullDesc
    <> progDesc "Cut a segment of audio or video from file or url"
    <> header "cutav - an ultimate video and audio cutting solution"
    )
