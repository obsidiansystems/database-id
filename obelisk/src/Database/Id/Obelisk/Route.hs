{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
module Database.Id.Obelisk.Route where

import Prelude hiding ((.))
import Control.Category
import Control.Monad.Except
import Data.Text as T
import Database.Id.Class
import Obelisk.Route

idPathSegmentEncoder
  :: forall a check parse.
  (MonadError Text parse, Applicative check, Show (IdData a), Read (IdData a))
  => Encoder check parse (Id a) PageName
idPathSegmentEncoder = idEncoder >>> singlePathSegmentEncoder

idEncoder
  :: forall a check parse.
  (MonadError Text parse, Applicative check, Show (IdData a), Read (IdData a))
  => Encoder check parse (Id a) Text
idEncoder = unsafeMkEncoder EncoderImpl
  { _encoderImpl_encode = T.pack . show . unId
  , _encoderImpl_decode = fmap Id . tryDecode unsafeTshowEncoder
  }
