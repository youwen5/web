{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Utils where

import Constants
import Types

import Control.Applicative (optional)
import Data.List (intercalate)
import Data.Maybe (catMaybes, mapMaybe)
import Hakyll
import System.FilePath (
  dropExtension,
  dropFileName,
  dropTrailingPathSeparator,
  joinPath,
  splitDirectories,
  takeBaseName,
  takeDirectory,
  takeExtension,
  takeFileName,
  (</>),
 )

data ListData = forall a. ListData (Context a) [Item a]

postContext :: Context String
postContext = dateField "date" "%B %e, %Y" <> rednoiseContext

-- | Replace the default `url` context with a canonicalized form, available at `key`
canonicalUrl :: String -> Context String
canonicalUrl key = field key $ \item -> do
  maybeRoute <- getRoute (itemIdentifier item)
  pure $
    maybe
      ""
      (toUrl . dropTrailingPathSeparator . canonicalizeUrl)
      maybeRoute

canonicalizeUrl :: String -> String
canonicalizeUrl url
  | takeFileName url == "index.html" = dropFileName url
  | takeExtension url == "html" = dropExtension url
  | otherwise = url

rednoiseContext :: Context String
rednoiseContext = canonicalUrl "url" <> Hakyll.defaultContext

archiveContext :: [Item String] -> Context String
archiveContext posts = listField "posts" postContext (return posts) <> rednoiseContext

makeFeed :: Renderer -> Rules ()
makeFeed renderer = do
  route idRoute
  compile $ do
    let feedCtx = postContext <> bodyField "description"
    posts <-
      fmap (take 10) . recentFirst
        =<< loadAllSnapshots "posts/**" snapshotDir
    renderer feed feedCtx posts

-- | dir/foo/bar/whatever -> /foo/bar/whatever/index.html
toRootHTML :: FilePath -> FilePath
toRootHTML =
  dropFirstParent
    . (</> "index.html")
    . dropExtension

sameRoute :: Rules ()
sameRoute = route idRoute

reroute :: (FilePath -> FilePath) -> Rules ()
reroute f = route $ customRoute $ f . toFilePath

-- drop the first parent dir of a path, if it exists
dropFirstParent :: FilePath -> FilePath
dropFirstParent = joinPath . drop 1 . splitDirectories

-- take e.g. dir/abc.md -> dir/abc/index.html
expandRoute :: FilePath -> FilePath
expandRoute p = takeDirectory p </> takeBaseName p </> "index.html"

-- Helper function to extract fields from a Context a, given a corresponding Item a and key.
getStringField :: Context a -> Item a -> String -> Compiler (Maybe String)
getStringField ctx item key = optional $ do
  -- unContext looks up the key. The [] is for arguments (usually empty for simple fields)
  field <- unContext ctx key [] item
  -- todo: handle other types of fields
  case field of
    StringField s -> return s
    _ -> fail $ "Field " ++ key ++ " is not a string"

getList :: Context a -> Item a -> String -> Compiler ListData
getList ctx item key = do
  field <- unContext ctx key [] item
  case field of
    ListField innerCtx items -> return $ ListData innerCtx items
    _ -> fail $ "Field " ++ key ++ " is not a list"

{- | A generic function that decides how to turn a list of items into a String.
  We need RankNTypes because we don't know what type 'b' the list holds.
-}
type ListHandler = forall b. Context b -> [Item b] -> Compiler String

flattenContext ::
  ListHandler ->
  [String] ->
  Context a ->
  Item a ->
  Compiler [(String, String)]
flattenContext listHandler keys ctx item = do
  pairs <- mapM extract keys
  return $ catMaybes pairs
 where
  extract key = do
    field <- optional $ unContext ctx key [] item
    case field of
      Just (StringField s) -> return $ Just (key, s)
      Just (ListField innerCtx items) -> do
        s <- listHandler innerCtx items
        return $ Just (key, s)
      _ -> return Nothing

-- | JSON List Handler
jsonListHandler :: [String] -> ListHandler
jsonListHandler subKeys = go
 where
  -- We define a helper 'go' with an explicit signature.
  -- This brings 'b' into scope so 'processItem' can see it.
  go :: forall b. Context b -> [Item b] -> Compiler String
  go innerCtx items = do
    itemStrings <- mapM processItem items
    return $ "[" ++ intercalate "," itemStrings ++ "]"
   where
    -- Now 'b' refers to the SAME 'b' as in 'go'
    processItem :: Item b -> Compiler String
    processItem itm = do
      -- We pass a dummy handler (\_ _ -> return "[]") for nested lists
      fields <- flattenContext (\_ _ -> return "[]") subKeys innerCtx itm
      let jsonFields = map formatPair fields
      return $ "{" ++ intercalate "," jsonFields ++ "}"

  formatPair (k, v) = show k ++ ":" ++ show v
