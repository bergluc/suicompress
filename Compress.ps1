#region whole script
[system.reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
$folderForm = New-Object System.Windows.Forms.Form
$pathTextBox = New-Object System.Windows.Forms.TextBox
$resolutionTextBox = New-Object System.Windows.Forms.TextBox
$outputFileTextBox = New-Object System.Windows.Forms.TextBox
$labelFile = New-Object System.Windows.Forms.Label
$labelResol = New-Object System.Windows.Forms.Label
$labelOutput = New-Object System.Windows.Forms.Label
$labelMessage = New-Object System.Windows.Forms.Label
$labelParam = New-Object System.Windows.Forms.Label
$labelExt = New-Object System.Windows.Forms.Label
$labelInst = New-Object System.Windows.Forms.Label

$param = ':-1'
$ext = '.mp4'

$selectButton = New-Object System.Windows.Forms.Button
$fileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }

$compressButton = New-Object System.Windows.Forms.Button
$cancelButton = New-Object System.Windows.Forms.Button

$labelFile.Location = '23,8'
$labelFile.Size = '150,20'
$labelFile.Text = 'Fichier à compresser'

$pathTextBox.Location = '23,30'
$pathTextBox.Size = '550,23'
$pathTextBox.ReadOnly = $true

$selectButton.Text = 'Sélectionner'
$selectButton.Location = '585,28'
$selectButton.Add_Click({
    $fileBrowser.ShowDialog()
    $pathTextBox.Text = $fileBrowser.FileNames
})

$labelResol.Location = '23,75'
$labelResol.Size = '150,20'
$labelResol.Text = 'Largeur de trame'

$resolutionTextBox.Location = '23,97'
$resolutionTextBox.Size = '50,23'

$labelParam.Location = '75,99'
$labelParam.Size = '50,23'
$labelParam.Text = ':-1'

$labelInst.Location = '100,99'
$labelInst.Size = '450,23'
$labelInst.ForeColor = '#0000FF'
$labelInst.Text = 'Pour trouver la largeur de trame : bouton droit sur le vidéo / Propriétés / Onglet Détails'

$labelOutput.Location = '23,140'
$labelOutput.Size = '250,20'
$labelOutput.Text = 'Nom du fichier compressé'

$outputFileTextBox.Location = '23,162'
$outputFileTextBox.Size = '550,23'

$labelExt.Location = '575,164'
$labelExt.Size = '30,23'
$labelExt.Text = '.mp4'

$labelMessage.Location = '23,215'
$labelMessage.Size = '250,20'
$labelMessage.ForeColor = '#FF0000'
$labelMessage.Text = ''
$compressButton.Location = '23,255'
$compressButton.Text = 'Compresser'
$compressButton.Add_Click({
$labelMessage.Text = '--> Compression en cours (long processus)'
$trame = 'scale=' + $resolutionTextBox.Text + $param
$fds = $outputFileTextBox.Text + $ext
C:\ffmpeg\ffmpeg.exe -i $pathTextBox.Text -vf $trame -c:v libx264 -preset veryslow -crf 24 $fds
})

$cancelButton.Text = 'Fermer'
$cancelButton.Location = "153,255"

$folderForm.CancelButton = $cancelButton
$folderForm.Text = 'Compression d''un vidéo'
$folderForm.Size = '700,350'

$folderForm.Controls.Add($labelInst)
$folderForm.Controls.Add($labelParam)
$folderForm.Controls.Add($labelExt)
$folderForm.Controls.Add($labelFile)
$folderForm.Controls.Add($labelResol)
$folderForm.Controls.Add($labelOutput)
$folderForm.Controls.Add($labelMessage)
$folderForm.Controls.Add($pathTextBox)
$folderForm.Controls.Add($selectButton)
$folderForm.Controls.Add($resolutionTextBox)
$folderForm.Controls.Add($outputFileTextBox)
$folderForm.Controls.Add($compressButton)
$folderForm.controls.Add($cancelButton)

$folderForm.ShowDialog()