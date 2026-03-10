module Analysis where

import qualified Data.Vector as V
import qualified Data.Map.Strict as M
import Data.Text (Text)
import Types

avg :: [Double] -> Double
avg xs = sum xs / fromIntegral (length xs)

averageByLocation :: V.Vector NoiseRecord -> M.Map Text Double
averageByLocation records =
  let grouped =
        V.foldl
          (\m r -> M.insertWith (++) (location r) [noise r] m)
          M.empty
          records
  in fmap avg grouped