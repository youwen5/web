module Constants where

import Hakyll
import System.FilePath ((</>))

feed :: FeedConfiguration
feed =
  FeedConfiguration
    { feedTitle = "web.youwen.dev"
    , feedDescription = "Youwen’s website and blog"
    , feedAuthorName = "Youwen Wu"
    , feedAuthorEmail = "youwen@functor.systems"
    , feedRoot = "https://web.youwen.dev"
    }

snapshotDir :: FilePath
snapshotDir = "content"
