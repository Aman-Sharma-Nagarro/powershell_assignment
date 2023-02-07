param(
	[Parameter(Mandatory=$true)][string]$input_string
)

$splitted_string = $input_string -split " ";
$output_string = ""

foreach ($word in $splitted_string){
	$length = $word.Length;
	$reversed_word = "";
	for (($i = $length-1); $i -ge 0; $i-- ){
		$reversed_word = $reversed_word + $word[$i..$i];
	}
	$output_string += $reversed_word + " ";
}

Write-Output $output_string;