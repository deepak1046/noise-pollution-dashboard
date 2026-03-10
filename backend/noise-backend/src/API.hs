{-# LANGUAGE OverloadedStrings #-}

module API where

import Web.Scotty
import Network.Wai.Middleware.Cors
import Data.Aeson (ToJSON)
import System.Environment (lookupEnv)

startServer :: (ToJSON a, ToJSON b) => a -> b -> IO ()
startServer averages varianceVal = do
  envPort <- lookupEnv "PORT"
  let port = maybe 3000 read envPort
  putStrLn $ "Server running on port " ++ show port

  scotty port $ do

    middleware $ cors (const $ Just simpleCorsResourcePolicy)

    get "/noise/average" $ do
      json averages

    get "/noise/variance" $ do
      json varianceVal