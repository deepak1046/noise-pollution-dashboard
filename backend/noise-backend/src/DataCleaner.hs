module DataCleaner where

import qualified Data.Vector as V
import Types

cleanData :: V.Vector NoiseRecord -> V.Vector NoiseRecord
cleanData =
  V.filter (\r -> noise r > 0 && noise r < 200)