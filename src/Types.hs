module Types where

import Hakyll

type Renderer =
  FeedConfiguration -> Context String -> [Item String] -> Compiler (Item String)
