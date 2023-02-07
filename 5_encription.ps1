param(
    [Parameter(Mandatory=$true)]
    [string]$algo,
    [Parameter(Mandatory=$true)]
    [string]$text
);

Function CaesarCipher {
    Param ($text) 
    $Value = Read-Host "Enter a number between 1 and 10"
    $encryptedText = ""
    for ($i=0; $i -lt $text.length; $i++){
        [int]$asciiCode = [char]$text[$i]
        $asciiCode += $Value
        if ($asciiCode -gt 122) {
            $asciiCode = 97 + $asciiCode - 122
        }
        $encryptedText += [char]$asciiCode
    }
    Write-Output "CaesarCipher $text"
    Write-Output "Encrypted password: $encryptedText" 
}


Function MD5 {
    Param ($text)
    $md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
    $utf8 = New-Object -TypeName System.Text.UTF8Encoding
    $encryptedText = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($text)))
    $encryptedText = $encryptedText.Replace("-", "")
    Write-Output "MD5 $text"
    Write-Output "Encrypted password: $encryptedText"
}

Function SHA1 {
    Param ($text)
    $sha1 = New-Object System.Security.Cryptography.SHA1CryptoServiceProvider
    $utf8 = New-Object System.Text.UTF8Encoding
    $encryptedText = [System.BitConverter]::ToString($sha1.ComputeHash($utf8.GetBytes($text)))
    $encryptedText = $encryptedText.Replace("-", "")
    Write-Output "SHA1 $text"
    Write-Output "Encrypted password: $encryptedText" 
}

Function AES {
    Param ($text)
    $key = Read-Host "Enter a Key for AES (eg 'mykey', 'password', etc)"
    $iv = Read-Host "Enter a Initialization Vector (IV) for AES (eg 'mykey', 'password', etc)"
    $aes = New-Object System.Security.Cryptography.AesCryptoServiceProvider
    $aes.BlockSize = 128
    $aes.KeySize = 256
    try {
        $aes.Key = [System.Text.Encoding]::UTF8.GetBytes($key)        
    }
    catch {
        Write-Output "error with key, continuing the program"
    }
    try {
        $aes.IV = [System.Text.Encoding]::UTF8.GetBytes($iv)        
    }
    catch {
        Write-Output "error with IV, continuing the program"
    }
    $aes.Padding = [System.Security.Cryptography.PaddingMode]::Zeros
    $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $encryptor = $aes.CreateEncryptor()
    $textBytes = [System.Text.Encoding]::UTF8.GetBytes($text)
    $encryptedBytes = $encryptor.TransformFinalBlock($textBytes, 0, $textBytes.Length)
    $encryptedText = [Convert]::ToBase64String($encryptedBytes)
    Write-Output "AES $text"
    Write-Output "Encrypted password: $encryptedText"
}

Function RSA {
    Param (
      [string]$text
    )
    $PublicKeyFileName = Read-Host "PublicKey filename for RSA (eg pw_assignment.pub (PS: located in this folder only)): "
    $PublicKey = Get-Content $PublicKeyFileName | Out-String
    $RSA = New-Object System.Security.Cryptography.RSACryptoServiceProvider
    $Data = [System.Text.Encoding]::UTF8.GetBytes($text)
    $encryptedText = $RSA.Encrypt($Data, $false)
    [Convert]::ToBase64String($encryptedText)
    Write-Output "RSA $text"
    Write-Output "Encrypted password: $encryptedText"
}
  

switch ($algo) {
    {$_ -eq  'caesar-cipher'}{ CaesarCipher $text }
    {$_ -eq  'md5'} { MD5 $text }
    {$_ -eq  'sha1'} { SHA1 $text }
    {$_ -eq  'aes'} { AES $text }
    {$_ -eq  'rsa'} { RSA $text }
    default {Write-Output "Invalid input"}
}

