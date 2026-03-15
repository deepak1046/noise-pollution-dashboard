module DataLoader where

import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString.Lazy.Char8 as BLC
import qualified Data.Vector as V
import Data.Csv
import Types

-- Strip blank lines that cassava cannot handle (the CSV has blank lines between
-- city groups which cause a parse error).
removeBlankLines :: BL.ByteString -> BL.ByteString
removeBlankLines = BLC.unlines . filter (not . BLC.null) . BLC.lines

loadNoiseData :: FilePath -> IO (V.Vector NoiseRecord)
loadNoiseData file = do
  rawCsv <- BL.readFile file
  let csvData = removeBlankLines rawCsv
  case decodeByName csvData of
    Left err  -> error $ "CSV parse error: " ++ err
    Right (_, v) -> return v