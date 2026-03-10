module DataLoader where

import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V
import Data.Csv
import Types

loadNoiseData :: FilePath -> IO (V.Vector NoiseRecord)
loadNoiseData file = do
  csvData <- BL.readFile file
  case decodeByName csvData of
    Left err -> error err
    Right (_, v) -> return v