module Data.Command
    ( CommandF(..)
    , Command
    , resolve
    , exec
    , inspect
    )
where

import           Data.Source
import           Control.Monad.Free            as Free

data CommandF r
    = Resolve Source (String -> r)
    | Exec String (Bool -> r)
    deriving (Functor)

type Command = Free CommandF

resolve :: Source -> Command String
resolve source = liftF $ Resolve source id

exec :: String -> Command Bool
exec code = liftF $ Exec code id

inspect :: Command () -> [String]
inspect (Pure ()) = []
inspect (Free (Resolve src r)) =
    ("Resolve (" ++ show src ++ ")") : inspect (r "__resolve_result__")
inspect (Free (Exec code r)) = ("Exec '" ++ code ++ "'") : inspect (r True)
