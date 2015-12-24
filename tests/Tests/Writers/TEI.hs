{-# LANGUAGE OverloadedStrings #-}
module Tests.Writers.TEI (tests) where

import Test.Framework
import Text.Pandoc.Builder
import Text.Pandoc
import Tests.Helpers
import Tests.Arbitrary()

{-
  "my test" =: X =?> Y

is shorthand for

  test html "my test" $ X =?> Y

which is in turn shorthand for

  test html "my test" (X,Y)
-}

infix 4 =:
(=:) :: (ToString a, ToPandoc a)
     => String -> (a, String) -> Test
(=:) = test (writeTEI def . toPandoc)

tests :: [Test]
tests = [ testGroup "block elements"
          ["para"          =: para "Lorem ipsum cetera."
                           =?> "<p>Lorem ipsum cetera.</p>" 
          ]
--        ]
--        , testGroup "lists"
--          [ 
--            ]
        , testGroup "inlines"
          [
            "Emphasis"      =: emph ("emphasized")
                            =?> "<hi rendition=\"simple:italic\">emphasized</hi>"
            ]
        ]
