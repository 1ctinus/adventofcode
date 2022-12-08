param(
[string]$data
)
$squaresize = [Math]::Sqrt($data.length)
function score($i, $j){
  $val = [int]($data.Substring($i+$j*$squaresize, 1))
  $outp = 0
  for($k = $i-1; $k -ge 0; $k--){
    $outp++
    if([int]$data.Substring($k+$j*$squaresize, 1) -ge $val){
    break 
   }
  }
    $cache = 0
    for($k = $i+1; $k -lt $squaresize; $k++){
      $cache++
      if([int]$data.Substring($k+$j*$squaresize, 1) -ge $val){
       break
      }
    }
    $outp = $outp * $cache
    $cache = 0
    for($k = $j-1; $k -ge 0; $k--){
    $cache++
      if([int]$data.Substring($i+$k*$squaresize, 1) -ge $val){
        break
      }
    }
    $outp = $outp * $cache
    $cache = 0
    for($k = $j+1; $k -lt $squaresize; $k++){
    $cache++
      if([int]$data.Substring($i+$k*$squaresize, 1) -ge $val){
        break
      }
    }
  $outp = $outp * $cache
  return $outp
}
$out = 0
for($i = 0; $i -lt $data.length; $i++){
  $out = ([Math]::Max($out, (score ($i % $squaresize) ([Math]::floor($i/$squaresize))))) 
}
Write-Host $out
