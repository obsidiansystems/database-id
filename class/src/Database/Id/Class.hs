{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
module Database.Id.Class where

import Data.Aeson
import Data.Int
import Data.Typeable

-- | Class for types that have a database ID column
class HasId a where
  type IdData a :: *
  type IdData a = Int64

newtype Id a = Id { unId :: IdData a } deriving Typeable

deriving instance Read (IdData a) => Read (Id a)
deriving instance Show (IdData a) => Show (Id a)
deriving instance Eq (IdData a) => Eq (Id a)
deriving instance Ord (IdData a) => Ord (Id a)
deriving instance FromJSON (IdData a) => FromJSON (Id a)
deriving instance ToJSON (IdData a) => ToJSON (Id a)
deriving instance FromJSONKey (IdData a) => FromJSONKey (Id a)
deriving instance ToJSONKey (IdData a) => ToJSONKey (Id a)

data IdValue a = IdValue (Id a) a deriving Typeable
