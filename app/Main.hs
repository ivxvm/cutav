module Main where

import           Lib
import qualified Options

main :: IO ()
main = do
    opts <- Options.parseFromCommandLine
    print opts
    return ()
