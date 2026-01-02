module Compilers where

import Data.ByteString qualified as LBS
import Data.List (intersperse)
import Data.Maybe (fromMaybe)
import GHC.IO.Handle (hClose)
import Hakyll
import System.FilePath (takeDirectory)
import System.IO.Temp (withSystemTempFile)
import System.Process (callProcess, proc, readCreateProcess, readProcess)
import System.Process.Internals
import Text.Blaze.Html.Renderer.String (renderHtml)
import Text.Blaze.Html5 (Html)
import Utils

-- | Converts `("foo", "bar")` to `--input foo=bar`, which can be passed as args to Typst CLI, to make `sys.inputs.foo` available in the document, with value `bar.`
kvsToTypstArgs :: [(String, String)] -> [String]
kvsToTypstArgs [] = []
kvsToTypstArgs xs =
  (["--input"] ++)
    . intersperse "--input"
    . map (\x -> fst x ++ "=" ++ snd x)
    $ xs

typstProcessor :: FilePath -> String -> [(String, String)] -> IO String
typstProcessor fp content kv = do
  let dir = takeDirectory fp
  let processSpec =
        (proc "typst-html-wrapper" $ kvsToTypstArgs kv)
          { cwd = Just dir
          }
  readCreateProcess processSpec content

keys :: [String]
keys = ["title", "date", "url"]

typstIndexCompiler :: Context String -> Compiler (Item String)
typstIndexCompiler ctx = do
  filePath <- getResourceFilePath
  body <- getResourceBody
  title <- getStringField ctx body "title"
  posts <- loadAll "posts/**"
  sortedPosts <- recentFirst posts
  pairs <- flattenContext (jsonListHandler keys) ["posts"] (archiveContext sortedPosts) body
  transformed <-
    unsafeCompiler $ typstProcessor filePath (itemBody body) pairs
  makeItem transformed

typstHtmlCompiler :: Context t -> Compiler (Item String)
typstHtmlCompiler ctx = do
  filePath <- getResourceFilePath
  body <- getResourceBody
  transformed <- unsafeCompiler $ typstProcessor filePath (itemBody body) []
  makeItem transformed

typstPdfCompiler :: Compiler (Item LBS.ByteString)
typstPdfCompiler = do
  sourcePath <- getResourceFilePath
  pdfContent <- unsafeCompiler $ withSystemTempFile "hakyll-typst.pdf" $ \tempPath handle -> do
    hClose handle
    callProcess "typst" ["compile", sourcePath, tempPath, "--features", "html"]
    LBS.readFile tempPath
  makeItem pdfContent

blazeTemplater ::
  forall t.
  (Context t -> Item t -> Compiler Html) -> Context t -> Item t -> Compiler (Item String)
blazeTemplater template ctx item = do
  compiledHtml <- template ctx item
  makeItem $ renderHtml compiledHtml

tailwindProcessor :: String -> IO String
tailwindProcessor = readProcess "tailwindcss" ["-i", "-", "-o", "-"]

makeCompiler :: (String -> IO String) -> Compiler (Item String)
makeCompiler f = do
  body <- getResourceBody
  transformed <- unsafeCompiler $ f (itemBody body)
  makeItem transformed

makeCompiler' :: (FilePath -> String -> IO String) -> Compiler (Item String)
makeCompiler' f = do
  filePath <- getResourceFilePath
  body <- getResourceBody
  transformed <- unsafeCompiler $ f filePath (itemBody body)
  makeItem transformed
