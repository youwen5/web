{-# LANGUAGE MultilineStrings #-}
{-# LANGUAGE OverloadedRecordDot #-}

-- a ridiculously badly written system lmfao
-- couldnt sleep until i got feed for photos so this was the compromise

module PhotoFeed where

import Data.Aeson (FromJSON, decode)
import Data.ByteString.Lazy qualified as LBS
import Data.List qualified
import Data.Maybe (fromMaybe)
import Data.Maybe qualified
import GHC.Generics
import Prelude hiding (id)

data Manifest = Manifest
  { photos :: [Photo]
  , updatedAt :: String
  }
  deriving (Generic, Show)

data Photo = Photo
  { uploadedAt :: String
  , altText :: String
  , originalUrl :: String
  , description :: Maybe String
  }
  deriving (Generic, Show)

defaultPhoto =
  Photo
    { uploadedAt = ""
    , altText = ""
    , originalUrl = ""
    , description = Nothing
    }
defaultManifest =
  Manifest
    { photos = [defaultPhoto]
    , updatedAt = ""
    }

instance FromJSON Photo
instance FromJSON Manifest

photoToEntry :: Photo -> String
photoToEntry photo =
  entry
    (fromMaybe photo.altText photo.description)
    photo.altText
    photo.originalUrl
    photo.uploadedAt

entry title alt url date =
  """
  <entry>
         <title>"""
    ++ title
    ++ """</title>
       <link href=
       \""""
    ++ url
    ++ """"
       />
       <id>"""
    ++ url
    ++ """</id>
       <published>"""
    ++ date
    ++ """</published>
       <updated>"""
    ++ date
    ++ """</updated>
       <summary type="html">
       &lt;img src=\""""
    ++ url
    ++ "\" alt=\""
    ++ alt
    ++ """"/&gt;</summary>
              <author>
                      <name>Youwen Wu</name>
                      <email>youwen@berkeley.edu</email>
              </author>
       </entry>
       """

atom updated entry =
  """
  <?xml version="1.0" encoding="utf-8"?>

  <feed xmlns="http://www.w3.org/2005/Atom">
        <title>Youwen's photos</title>
        <link href="https://web.youwen.dev/photos/feed.xml" rel="self" />
        <link
          href="https://web.youwen.dev/photos/gallery"
          rel="alternate"
          type="text/html"
        />
        <id>https://web.youwen.dev/photos/atom.xml</id>
    <updated>
  """
    ++ updated
    ++ """</updated>
       """
    ++ concat entry
    ++ """
       </feed>
       """
