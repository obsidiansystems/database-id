{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}
module Database.Id.Groundhog where

import Data.Proxy
import Database.Groundhog.Core
import Database.Id.Class

class HasId a => DefaultKeyId a where
  toIdData :: Proxy a -> DefaultKey a -> IdData a
  fromIdData :: Proxy a -> IdData a -> DefaultKey a

toId :: forall a. DefaultKeyId a => DefaultKey a -> Id a
toId = Id . toIdData (Proxy :: Proxy a)

fromId :: forall a. DefaultKeyId a => Id a -> DefaultKey a
fromId = fromIdData (Proxy :: Proxy a) . unId

deriving instance NeverNull (IdData a) => NeverNull (Id a) -- A redundant constraint warning is expected here

instance (PersistField (DefaultKey a), DefaultKeyId a) => PersistField (Id a) where
  persistName = persistName
  toPersistValues = toPersistValues . fromId
  fromPersistValues vs = do
    (a, vs') <- fromPersistValues vs
    return (toId a, vs')
  dbType p _ = dbType p (undefined :: DefaultKey a)

instance (PrimitivePersistField (DefaultKey a), DefaultKeyId a) => PrimitivePersistField (Id a) where
  toPrimitivePersistValue p = toPrimitivePersistValue p . fromId
  fromPrimitivePersistValue p = toId . fromPrimitivePersistValue p

type IdDataIs a b = IdData a ~ b
