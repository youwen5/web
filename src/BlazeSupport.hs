module BlazeSupport where

import Text.Blaze.Internal (Attribute, AttributeValue, attribute)

-- blaze-html's attributes are not exhaustive, so we need to define a few of our own

dataLoading
  , dataLang
  , dataTheme
  , dataInputPosition
  , dataEmitMetadata
  , dataReactionsEnabled
  , dataStrict
  , dataMapping
  , dataCategoryId
  , dataCategory
  , dataRepoId
  , dataRepo
  , as
  , crossorigin
  , dataLucide
  , dataCollectDnt
  , lazy ::
    AttributeValue -> Attribute
as = attribute "as" " as=\""
crossorigin = attribute "crossorigin" " crossorigin=\""
lazy = attribute "lazy" " lazy=\""
dataRepo = attribute "data-repo" " data-repo=\""
dataRepoId = attribute "data-repo-id" " data-repo-id=\""
dataCategory = attribute "data-category" " data-category=\""
dataCategoryId = attribute "data-category-id" " data-category-id=\""
dataMapping = attribute "data-mapping" " data-mapping=\""
dataStrict = attribute "data-strict" " data-strict=\""
dataReactionsEnabled = attribute "data-reactions-enabled" " data-reactions-enabled=\""
dataEmitMetadata = attribute "data-emit-metadata" " data-emit-metadata=\""
dataInputPosition = attribute "data-input-position" " data-input-position=\""
dataTheme = attribute "data-theme" " data-theme=\""
dataLang = attribute "data-lang" " data-lang=\""
dataLoading = attribute "data-loading" " data-loading=\""
dataLucide = attribute "data-lucide" " data-lucide=\""
dataCollectDnt = attribute "data-collect-dnt" " data-collect-dnt=\""
