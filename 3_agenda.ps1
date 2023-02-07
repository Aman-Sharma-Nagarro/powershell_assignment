param(
	[Parameter(Mandatory=$true)][string]$file_name
)

$file_data = Get-Content $file_name;
$current_key = "";
$meeting = @{}

foreach($line in $file_data){

    #(\d{1,2}[-/ ]\d{1,2}[-/ ]\d{4}) matches dates with format dd-mm-yyyy, dd/mm/yyyy, or dd mm yyyy.
    #\d{1,2} [A-Za-z]{3,9} \d{4} matches dates with format dd Month yyyy
    #(\d{1,2}) matches 1 or 2 digits (the day)
    #([A-Z][a-z]{2}) matches 3 characters where the first character is uppercase and the next two are lowercase (the abbreviation of the month).
    if (([regex]'(\d{1,2}[-/ ]\d{1,2}[-/ ]\d{4}|\d{1,2} [A-Za-z]{3,9} \d{4}|Today|Tomorrow|(\d{1,2}) ([A-Z][a-z]{2}))').Match($line).Value) {
        $current_key = $line;
    } else {
        if($meeting.Contains($current_key)) {
            $meeting[$current_key] += ", ";
            $meeting[$current_key] += $line;
        } else {
            $meeting.Add($current_key, $line);
        }
    }
}

Write-Output $meeting;
