{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Types where

import GHC.Generics
import Data.Csv
import Data.Text (Text)

data NoiseRecord = NoiseRecord
  { location :: Text
  , timestamp :: Text
  , noise :: Double
  } deriving (Show, Generic)

instance FromNamedRecord NoiseRecord where
  parseNamedRecord r =
    NoiseRecord <$> r .: "location"
                <*> r .: "timestamp"
                <*> r .: "noise"