{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Database.Id.Groundhog.TH where

import Data.Int
import Database.Id.Groundhog
import Database.Groundhog.Core
import Language.Haskell.TH

makeDefaultKeyIdInt64 :: Name -> Name -> Q [Dec]
makeDefaultKeyIdInt64 n k = do
  pv <- newName "pv"
  [d|
    instance IdDataIs $(conT n) Int64 => DefaultKeyId $(conT n) where
      toIdData _ dk = case $(lamE [conP k [varP pv]] (varE pv)) dk of
        PersistInt64 x -> x
        _ -> error "makeDefaultKeyIdInt64: pattern match failure (this should be impossible)"
      fromIdData _ = $(conE k) . PersistInt64
    |]

makeDefaultKeyIdSimple :: Name -> Name -> Q [Dec]
makeDefaultKeyIdSimple n k = do
  pv <- newName "pv"
  [d|
    instance DefaultKeyId $(conT n) where
      toIdData _ = $(lamE [conP k [varP pv]] (varE pv))
      fromIdData _ = $(conE k)
    |]
