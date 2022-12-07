import System.Environment   
import Data.List
top3 :: ([Int]) -> Int
top3 s = s!!0 + s!!1 + s!!2
wordsWhen     :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'
main = do
  inp <- getArgs
  print $ top3 $ reverse $ sort $ map(\x->sum $map(\y -> read y ::Int) x)$ map (\x -> wordsWhen (=='-') x) $wordsWhen (=='+') (inp!!0::String)
-- uses + and minus as seperators instead of \n\n and \n, sorry if that dissapoints you
