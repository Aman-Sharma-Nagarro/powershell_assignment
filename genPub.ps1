# Create a new RSA key pair
$rsa = New-Object System.Security.Cryptography.RSACryptoServiceProvider

# Export the public key to a .pub file
$publicKey = $rsa.ToXmlString($false)
$publicKey = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($publicKey))
$publicKey = "-----BEGIN RSA PUBLIC KEY-----`n$publicKey`n-----END RSA PUBLIC KEY-----"
[System.IO.File]::WriteAllText("pw_assignment.pub", $publicKey)
