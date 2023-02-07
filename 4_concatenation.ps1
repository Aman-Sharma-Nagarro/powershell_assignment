param(
	[Parameter(Mandatory)]
	[string[]]$input_array
)

function Swap([string[]] $array, $index1, $index2) {
  $temp = $array[$index1]
  $array[$index1] = $array[$index2]
  $array[$index2] = $temp
  return $array
}


Function Permutations{
  Param(
    [Parameter(Mandatory)]
    [string[]]$input_array,

    [Parameter(Mandatory)]
    [int]$k
    )

  if ($k -eq 1){
    Write-Output ($input_array -join '')
  } else {
    Permutations $input_array $($k-1)

    for ($i=0; $i -lt $k-1; $i++){
      if ($k%2 -eq 0){
        $input_array = Swap $input_array $i $($k-1)
      } else {
        $input_array = Swap $input_array 0 $($k-1)
      }
      Permutations $input_array $($k-1)
    }
  }
}

Permutations $input_array $input_array.Length

