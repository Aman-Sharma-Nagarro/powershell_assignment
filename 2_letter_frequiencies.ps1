param(
	[Parameter(Mandatory=$true)][string]$file_name
)

$file_data = Get-Content $file_name
$file_content = $file_data -split " ";
$word_count = @{}

foreach ($word in $file_content){
    $word = $word -replace "[`~!@#$%^&*()_|+\-=?;:'`",.<>\{\}\[\]\\\/]+"
    $word = $word.Trim();
    $word = $word.ToLower();

    if ($word){
        if($word_count.Contains($word)) {
            $word_count[$word] += 1;
        } else {
            $word_count.Add($word, 1);
        }
    }
}

$word_count.getenumerator() | Sort-Object -Property Value -Descending;