module Main where

import Compilers
import Constants
import Templates
import Utils

import Data.Maybe (fromMaybe)
import Data.UnixTime (UnixTime (..), formatUnixTime, webDateFormat)
import Data.Version (showVersion)
import Hakyll
import System.Environment.Blank (getEnvDefault)
import System.FilePath (
  dropExtension,
  replaceBaseName,
  replaceExtension,
  takeBaseName,
  takeDirectory,
  takeFileName,
  (</>),
 )
import System.Info
import Text.Blaze.Html.Renderer.String
import Text.Pandoc.UTF8 (toString)
import Text.Read (readMaybe)

main :: IO ()
main = generateSite

data EnvData = EnvData {gitHash :: IO String, ghcVersion :: String, lastCommitTimestamp :: IO UnixTime}

envData :: EnvData
envData =
  EnvData
    { gitHash = getEnvDefault "GIT_COMMIT_HASH" "PLACEHOLDER_HASH"
    , ghcVersion = showVersion compilerVersion
    , lastCommitTimestamp = do
        x <- getEnvDefault "LAST_COMMIT_TIMESTAMP" "0"
        pure $ UnixTime (fromMaybe 0 $ readMaybe x) 0
    }

generateSite :: IO ()
generateSite = do
  gitHash' <- gitHash envData
  lastCommitTimestamp' <- lastCommitTimestamp envData
  formattedTime <- formatUnixTime webDateFormat lastCommitTimestamp'
  let extraContext =
        constField "commit-hash" gitHash'
          <> constField "ghc-version" (ghcVersion envData)
          <> constField "last-commit-timestamp" (toString formattedTime)
  let defaultContext =
        extraContext
          <> rednoiseContext
  let postContext = extraContext <> Utils.postContext
  hakyll $ do
    match "images/*" $ do
      sameRoute
      compile copyFileCompiler

    match "static/**" $ do
      sameRoute
      compile copyFileCompiler

    match "fonts/*" $ do
      sameRoute
      compile copyFileCompiler

    match "root/favicon.ico" $ do
      reroute takeFileName
      compile copyFileCompiler

    match "css/main.css" $ do
      sameRoute
      compile $ do
        makeCompiler tailwindProcessor

    match "css/*.css" $ do
      sameRoute
      compile compressCssCompiler

    match "posts/**.typ" $ do
      reroute toRootHTML

      compile $
        typstHtmlCompiler postContext
          >>= saveSnapshot snapshotDir
          >>= blazeTemplater Templates.postTemplate postContext

    create ["archive.html"] $ do
      reroute expandRoute
      compile $ do
        posts <- loadAll "posts/**"
        let archiveCtx =
              listField "posts" postContext (return posts)
                <> constField "title" "Archives"
                <> defaultContext
        makeItem ""
          >>= blazeTemplater Templates.archivePage archiveCtx
          >>= blazeTemplater Templates.wideTemplate archiveCtx

    create ["explore.html"] $ do
      reroute expandRoute
      compile $ do
        posts <- loadAll "posts/**"
        let exploreCtx =
              listField "posts" postContext (return posts)
                <> constField "title" "Explore"
                <> defaultContext
        makeItem ""
          >>= blazeTemplater Templates.explorePage exploreCtx
          >>= blazeTemplater Templates.defaultTemplate exploreCtx

    match "root/index.typ" $ do
      reroute $ takeFileName . flip replaceExtension "html"
      compile $
        typstIndexCompiler defaultContext
          >>= blazeTemplater indexTemplate defaultContext

    match ("cv/index.typ" .||. "cv/short.typ") $ do
      route $ setExtension "html"
      compile $
        typstHtmlCompiler defaultContext
          >>= blazeTemplater Templates.defaultTemplate defaultContext

    match "cv/index.typ" $ version "pdf" $ do
      reroute $ \p ->
        takeDirectory p
          </> ( (takeFileName . flip replaceBaseName "youwen-wu-cv-full")
                  . (takeFileName . flip replaceExtension "pdf")
              )
            p
      compile typstPdfCompiler

    match "cv/short.typ" $ version "pdf" $ do
      reroute $ \p ->
        takeDirectory p
          </> ( (takeFileName . flip replaceBaseName "youwen-wu-cv-short")
                  . (takeFileName . flip replaceExtension "pdf")
              )
            p
      compile typstPdfCompiler

    match "root/**.typ" $ do
      reroute toRootHTML

      compile $
        typstHtmlCompiler defaultContext
          >>= blazeTemplater Templates.defaultTemplate defaultContext

    match "templates/*" $ compile templateBodyCompiler

    create ["atom.xml"] $ makeFeed renderAtom
    create ["feed.xml"] $ makeFeed renderRss
    create ["feed.json"] $ makeFeed renderJson
