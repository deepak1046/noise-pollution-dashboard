module Sensitivity where

import qualified Data.Vector as V
import Statistics.Sample
import Types

noiseVariance :: V.Vector NoiseRecord -> Double
noiseVariance records =
  variance (V.map noise records)