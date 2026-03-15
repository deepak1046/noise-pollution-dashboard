{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Types where

import GHC.Generics
import Data.Aeson (ToJSON)
import Data.Csv
import Data.Text (Text)

data NoiseRecord = NoiseRecord
  { location :: Text
  , timestamp :: Text
  , noise :: Double
  } deriving (Show, Generic, ToJSON)

instance FromNamedRecord NoiseRecord where
  parseNamedRecord r =
    NoiseRecord <$> r .: "location"
                <*> r .: "timestamp"
                <*> r .: "noise"