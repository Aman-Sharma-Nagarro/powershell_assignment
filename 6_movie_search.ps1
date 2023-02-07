param(
	[Parameter(Mandatory=$true)][string]$movieTitle
)

Function GetIMDBLinks(){
    $movieTitle.replace(' ', '+')
    $url = "https://duckduckgo.com/html/?q=$movieTitle+imdb"
    $response = Invoke-WebRequest -Uri $url
    $regex = 'imdb\.com\/title[^\s]+\/'
    $matchesIMDB = Select-String -InputObject $response.Content -Pattern $regex -AllMatches
    return $matchesIMDB.Matches.Value
}

function ParseIMDBPage {
    param (
        $url
    )
    Write-Output "parsing the link: $url"
    $response = Invoke-WebRequest -Uri $url    
    $response.Content | Out-File 'imdb.html';
    $regex = 'application\/ld\+json'
    get-content 'imdb.html' -ReadCount 1000 |
        foreach { $_ -match $regex }
}
$IMDBLinks = GetIMDBLinks

Write-Output $IMDBLinks

for($i=0; $i -lt $IMDBLinks.length; $i++){
    ParseIMDBPage $IMDBLinks[$i]
}
