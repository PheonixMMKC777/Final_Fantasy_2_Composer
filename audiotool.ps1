Add-Type -AssemblyName System.windows.forms

$Path = Get-location
[byte[]] $Sequence = @() 
$LastOctave = 0x00 # if 0xF0 it reuses last octave in ram because 0xF0 always = 0xF0 as $LASTOCTAVE
$bytecount = 0
$GroupY = 120
$Script:groupYHint = $groupY - 20
#Cx are RESTS
$LoopPointSet
$allotedBytes = 255
$SongStart = 0x35E6F
function FindRom 
{

    #this thing has an eternal hatred for spaces
    $CheckRom = Test-Path -Path "$Path\Final_Fantasy_2_(Tr).nes"

    
    if ($CheckRom -eq $false) {
    Write-Host "No Rom"  -ForegroundColor Red
   
    } Else {
    
    LoadData
    }
    

}

Function LoadData {



<#$Header = [System.Convert]::ToString($Rom[0x35E67],16) 
$Ctrl = [System.Convert]::ToString($Rom[0x35E68],16) 
$VolumeEnvV = [System.Convert]::ToString($Rom[0x35E69],16) 
$volumeEnvW = [System.Convert]::ToString($Rom[0x35E6A],16) 
$PitchEnvP = [System.Convert]::ToString($Rom[0x35E6B],16) 
$PitchEnvQ = [System.Convert]::ToString($Rom[0x35E6C],16) 
$Tempo1 = [System.Convert]::ToString($Rom[0x35E6D],16) 
$Tempo2 = [System.Convert]::ToString($Rom[0x35E6E],16) 
$TrackHeaderInfoHex = "RawHeader: $header $ctrl $VolumeEnvV $VolumeEnvW $PitchEnvP $PitchEnvQ $tempo1 $tempo2"
#>
Main
}

Function Main {

    #icon but base64-ified
    $iconBase64      = 'iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsIAAA7CARUoSoAAAAGGSURBVHhe7dwxDoMwEABBnP//OUmRngKdHNiZJpRErCz5ZFjvr4Os1++XKAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4pwHuGit9buaMf14rABxAogTQJwA4gQQJ4A4AcQ9fg4wvU+fZg7AKAHECSBOAHECiBNAnADits8B7r5Pn2YOwCgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIE4AcQKIE0CcAOJufx5g8+2f+vf/ZwWIE0CcAOIEECeAOAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIM57ASd2f8fQewGMEkCcAOIEECeAOAHECSDu8hzg6ftkcwAeTQBxAogTQJwA4gQQJ4A4AcQJIE4AcQKIE0CcAOIEECeAOOcB4qwAcQKIE0CcAOIEECeAOAHEbf8+AHtZAeIEECeAOAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIE4AcQJIO44PEyxC1MO5ZhgAAAAASUVORK5CYII='
    $iconBytes       = [Convert]::FromBase64String($iconBase64)
    $stream          = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
    $stream.Write($iconBytes, 0, $iconBytes.Length)  
    
$mainWin = New-Object System.windows.forms.form
$mainWin.Text = "ff2 Music prelude"
$mainWin.Size = "800,650"
$mainwin.font = "Arial, 10"
$mainwin.BackColor = "lightgreen"
$mainWin.Font = "Arial Bold, 10"
$mainWin.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())

$ByteHint = New-Object System.Windows.Forms.Label
$ByteHint.Text = "$ByteCount / $allotedBytes"
$ByteHint.Location = "100,$groupYHint"
$ByteHint.Size = "340,20"

$noteHint = New-Object System.Windows.Forms.Label
$noteHint.Text = "Octave           Key               Length             Loop Points"
$noteHint.Location = "450,$groupYHint"
$noteHint.Size = "340,20"

$SaveButton = New-Object System.Windows.Forms.Button
$SaveButton.Text = "Save To ROM"
$SaveButton.Size = "100,45"
$SaveButton.Location = "670,20"
$SaveButton.BackColor = "pink"
$savebutton.ADD_CLICK({SaveMusic})

$MusicHeaderLabel = New-Object System.Windows.Forms.Label
$MusicHeaderLabel.Text = "$TrackHeaderInfoHex"
$MusicHeaderLabel.Location = "20,20"
$MusicHeaderLabel.Size = "220,20"

$ByteBox = New-Object System.Windows.Forms.Label
$ByteBox.Text = "$Sequence"
$ByteBox.Size = "400,150"
$ByteBox.Location = "20,$GroupY "
$ByteBox.BackColor = "White"

$TrackList = New-Object System.Windows.Forms.ComboBox
$TrackList.Size = "200,20"
$TrackList.Location = "450,40 "


$TrackList.Items.Add('Prelude SQ1')
$TrackList.Items.Add('Prelude SQ2')

$TrackList.Items.Add('Chocobo Theme SQ1')
$TrackList.Items.Add('Chocobo Theme SQ2')
$TrackList.Items.Add('Chocobo Theme Triangle')

$TrackList.Items.Add('Main Theme SQ1')
$TrackList.Items.Add('Main Theme SQ2')
$TrackList.Items.Add('Main Theme Triangle')

$TrackList.Items.Add('Fanfare Theme SQ1')
$TrackList.Items.Add('Fanfare Theme SQ2')
$TrackList.Items.Add('Fanfare Theme Triangle')

$TrackList.Items.Add('Joins The Party Theme SQ1')
$TrackList.Items.Add('Joins The Party Theme SQ2')
$TrackList.Items.Add('Joins The Party Theme Triangle')

$TrackList.Items.Add('Castle Pandemonium Theme SQ1')
$TrackList.Items.Add('Castle Pandemonium SQ2')
$TrackList.Items.Add('Castle Pandemonium Triangle')

$TrackList.Items.Add('Ancient Castle Theme SQ1')
$TrackList.Items.Add('Ancient Castle Theme SQ2')
$TrackList.Items.Add('Ancient Castle Theme Triangle')

$TrackList.SelectedIndex = 0




$TrackList.Add_SelectedIndexChanged({
    If ($TrackList.SelectedIndex -eq 0) {$Script:SongStart = 0x35E6F;$Script:allotedBytes = 255;$ByteHint.Text = "$ByteCount / $allotedBytes"}
    If ($TrackList.SelectedIndex -eq 1) {$Script:SongStart = 0x35F6F;$Script:allotedBytes = 255;$ByteHint.Text = "$ByteCount / $allotedBytes"}

    If ($TrackList.SelectedIndex -eq 2) {$Script:allotedBytes = 0;$ByteHint.Text = "$ByteCount / $allotedBytes"; $Script:c = 0x35FA5}
    If ($TrackList.SelectedIndex -eq 3) {$Script:allotedBytes = 0;$ByteHint.Text = "$ByteCount / $allotedBytes"; $Script:SongStart = 0x35FE4}
    If ($TrackList.SelectedIndex -eq 4) {$Script:allotedBytes = 0;$ByteHint.Text = "$ByteCount / $allotedBytes"; $Script:SongStart = 0x35FF1} #Bass weird

    If ($TrackList.SelectedIndex -eq 5) {$Script:allotedBytes = 55;$ByteHint.Text = "$ByteCount / $allotedBytes"; $Script:SongStart = 0x36010}
    If ($TrackList.SelectedIndex -eq 6) {$Script:allotedBytes = 4;  $ByteHint.Text = "$ByteCount / $allotedBytes"; $Script:SongStart = 0x36062} #Main theme Echo in SQ2
    If ($TrackList.SelectedIndex -eq 7) {$Script:allotedBytes = 272;$ByteHint.Text = "$ByteCount / $allotedBytes"; $Script:SongStart = 0x3606C}

    })



$KeyList = New-Object System.Windows.Forms.ListBox
$KeyList.Size = "50,200"
$KeyList.Location = "520,$GroupY "

$KeyList.Items.Add('C')
$KeyList.Items.Add('C#')
$KeyList.Items.Add('D')
$KeyList.Items.Add('D#')
$KeyList.Items.Add('E')
$KeyList.Items.Add('F')
$KeyList.Items.Add('F#')
$KeyList.Items.Add('G')
$KeyList.Items.Add('G#')
$KeyList.Items.Add('A')
$KeyList.Items.Add('A#')
$KeyList.Items.Add('B')

$SustainList = New-Object System.Windows.Forms.ListBox
$SustainList.Size = "90,200"
$SustainList.Location = "590,$GroupY "

$SustainList.Items.Add('Whole')
$SustainList.Items.Add('Half')
$SustainList.Items.Add('Dot Half')
$SustainList.Items.Add('Tri Half')
$SustainList.Items.Add('4th')
$SustainList.Items.Add('Dot 4th')
$SustainList.Items.Add('Tri 4th')
$SustainList.Items.Add('8th')
$SustainList.Items.Add('Dot 8th')
$SustainList.Items.Add('Tri 8th')
$SustainList.Items.Add('16th')
$SustainList.Items.Add('Dot 16th')
$SustainList.Items.Add('Tri 16th')
$SustainList.Items.Add('32nd')
$SustainList.Items.Add('Dot 32nd')
$SustainList.Items.Add('64th')



$OctaveList = New-Object System.Windows.Forms.listbox
$OctaveList.Size = "50,100"
$OctaveList.Location = "450,$GroupY "

$OctaveList.Items.Add('C2')
$OctaveList.Items.Add('C3')
$OctaveList.Items.Add('C4')
$OctaveList.Items.Add('C5')
$OctaveList.Items.Add('C6')
$OctaveList.Items.Add('C7')

$AddSelectedNote = New-Object System.Windows.Forms.Button
$AddSelectedNote.Text = "Add"
$AddSelectedNote.Size = "60,40 "
$AddSelectedNote.Location = "445,225"
$AddSelectedNote.ADD_CLICK({AddToSheet})
$AddSelectedNote.BackColor = "yellow"

$AddSelectedRest = New-Object System.Windows.Forms.Button
$AddSelectedRest.Text = "Add `nRest"
$AddSelectedRest.Size = "60,40 "
$AddSelectedRest.Location = "445,275"
$AddSelectedRest.ADD_CLICK({AddRestToSheet})
$AddSelectedRest.BackColor = "Orange"

$BeginLoopx2 = New-Object System.Windows.Forms.Button
$BeginLoopx2.Text = "Set Point + Loop (x2)"
$BeginLoopx2.Size = "80,40"
$BeginLoopx2.Location = "690,120"
$beginLoopx2.BackColor = "lightblue"
$BeginLoopx2.ADD_CLICK({$SCript:Sequence += 0xf8
                        $ByteBox.Text = "$Sequence" 

                        Byteupdate})

$BeginLoopx3 = New-Object System.Windows.Forms.Button
$BeginLoopx3.Text = "Set Point + Loop (x3)"
$BeginLoopx3.Size = "80,40"
$BeginLoopx3.Location = "690,170"
$beginLoopx3.BackColor = "lightblue"
$BeginLoopx3.ADD_CLICK({$SCript:Sequence += 0xf9
                        $ByteBox.Text = "$Sequence"
                        Byteupdate})

$BeginLoopx4 = New-Object System.Windows.Forms.Button
$BeginLoopx4.Text = "Set Point + Loop (x4)"
$BeginLoopx4.Size = "80,40"
$BeginLoopx4.Location = "690,220"
$beginLoopx4.BackColor = "lightblue"
$BeginLoopx4.ADD_CLICK({$SCript:Sequence += 0xfA
                        $ByteBox.Text = "$Sequence"
                        Byteupdate})

$BeginLoopx5 = New-Object System.Windows.Forms.Button
$BeginLoopx5.Text = "Set Point + Loop (x5)"
$BeginLoopx5.Size = "80,40"
$BeginLoopx5.Location = "690,270"
$beginLoopx5.BackColor = "lightblue"
$BeginLoopx5.ADD_CLICK({$SCript:Sequence += 0xfB
                        $ByteBox.Text = "$Sequence"
                        Byteupdate })

$EndLoop = New-Object System.Windows.Forms.Button
$EndLoop.Text = "End Loop"
$EndLoop.Size = "80,40"
$EndLoop.Location = "690,320"
$EndLoop.BackColor = "lightblue"
$EndLoop.ADD_CLICK({$SCript:Sequence += 0xfC
                        $ByteBox.Text = "$Sequence"
                        Byteupdate })

#elems
$mainwin.controls.add($MusicHeaderLabel)
$mainwin.controls.add($KeyList)
$mainwin.controls.add($KeyList)
$mainwin.controls.add($OctaveList)
$mainwin.controls.add($AddSelectedNote)
$mainwin.controls.add($ByteBox)
$mainwin.controls.add($SustainList)
$mainwin.controls.add($Notehint)
$mainwin.controls.add($BeginLoopx2)
$mainwin.controls.add($BeginLoopx3)
$mainwin.controls.add($BeginLoopx4)
$mainwin.controls.add($BeginLoopx5)
$mainwin.controls.add($EnDLoop)
$mainwin.controls.add($Bytehint)
$mainwin.controls.add($savebutton)
$mainwin.controls.add($tracklist)
$mainwin.controls.add($addselectedrest)

#draw
$mainWin.ShowDialog()

}


Function AddToSheet {

If ($OctaveList.SelectedIndex -eq 0) {$OctaveByte = 0xF0}
If ($OctaveList.SelectedIndex -eq 1) {$OctaveByte = 0xF1}
If ($OctaveList.SelectedIndex -eq 2) {$OctaveByte = 0xF2}
If ($OctaveList.SelectedIndex -eq 3) {$OctaveByte = 0xF3}
If ($OctaveList.SelectedIndex -eq 4) {$OctaveByte = 0xF4}       
If ($OctaveList.SelectedIndex -eq 5) {$OctaveByte = 0xF5}

If ($KeyList.SelectedIndex -eq 0) {$NoteHiByte = 0x00} # c
If ($KeyList.SelectedIndex -eq 1) {$NoteHiByte = 0x10} # c#
If ($KeyList.SelectedIndex -eq 2) {$NoteHiByte = 0x20} # d
If ($KeyList.SelectedIndex -eq 3) {$NoteHiByte = 0x30} # D#
If ($KeyList.SelectedIndex -eq 4) {$NoteHiByte = 0x40} # e
If ($KeyList.SelectedIndex -eq 5) {$NoteHiByte = 0x50} # f 
If ($KeyList.SelectedIndex -eq 6) {$NoteHiByte = 0x60} # F#
If ($KeyList.SelectedIndex -eq 7) {$NoteHiByte = 0x70} # G
If ($KeyList.SelectedIndex -eq 8) {$NoteHiByte = 0x80} # G#
If ($KeyList.SelectedIndex -eq 9) {$NoteHiByte = 0x90} # a
If ($KeyList.SelectedIndex -eq 10) {$NoteHiByte = 0xa0} # A#
If ($KeyList.SelectedIndex -eq 11) {$NoteHiByte = 0xb0} # B

If ($SustainList.SelectedIndex -eq 0) {$NoteLoByte = 0x00} #Whole 
If ($SustainList.SelectedIndex -eq 1) {$NoteLoByte = 0x02} #Half
If ($SustainList.SelectedIndex -eq 2) {$NoteLoByte = 0x01} #D half 
If ($SustainList.SelectedIndex -eq 3) {$NoteLoByte = 0x04} #T Half 
If ($SustainList.SelectedIndex -eq 4) {$NoteLoByte = 0x05} #4th 
If ($SustainList.SelectedIndex -eq 5) {$NoteLoByte = 0x03} #D 4th 
If ($SustainList.SelectedIndex -eq 6) {$NoteLoByte = 0x07} #T 4th 
If ($SustainList.SelectedIndex -eq 7) {$NoteLoByte = 0x08} #8th 
If ($SustainList.SelectedIndex -eq 8) {$NoteLoByte = 0x06} #D 8th 
If ($SustainList.SelectedIndex -eq 9) {$NoteLoByte = 0x0A} #T 8th
If ($SustainList.SelectedIndex -eq 10) {$NoteLoByte = 0x0B} #16th 
If ($SustainList.SelectedIndex -eq 11) {$NoteLoByte = 0x09} #D 16th 
If ($SustainList.SelectedIndex -eq 12) {$NoteLoByte = 0x0C} #T 16th
If ($SustainList.SelectedIndex -eq 13) {$NoteLoByte = 0x0D} #32nd
If ($SustainList.SelectedIndex -eq 14) {$NoteLoByte = 0x0E} #T 32nd 
If ($SustainList.SelectedIndex -eq 15) {$NoteLoByte = 0x0F} #64th

$NoteByte = $NoteHiByte + $NoteLoByte
Write-Host $Octavebyte, $LastOctave -ForegroundColor red
Write-Host $Notebyte -ForegroundColor Green
If ($LastOctave -eq $OctaveByte) {
    $Script:Sequence += $NoteByte
    Byteupdate
    }

If ($LastOctave -ne $OctaveByte) {
    $Script:Sequence += $OctaveByte
    $Script:Sequence += $NoteByte
    $Script:byteCount++
    $Script:byteCount++
    $Bytehint.text = "$byteCount/ 255 Bytes"
    }
$Script:LastOctave = $OctaveByte
$ByteBox.Text = "$Sequence"

}

Function AddRestToSheet {

If ($SustainList.SelectedIndex -eq 0) {$SCript:RestByte = 0xC0} #Whole 
If ($SustainList.SelectedIndex -eq 1) {$SCript:RestByte = 0xC2} #Half
If ($SustainList.SelectedIndex -eq 2) {$SCript:RestByte = 0xC1} #D half 
If ($SustainList.SelectedIndex -eq 3) {$SCript:RestByte = 0xC4} #T Half 
If ($SustainList.SelectedIndex -eq 4) {$SCript:RestByte = 0xC5} #4th 
If ($SustainList.SelectedIndex -eq 5) {$SCript:RestByte = 0xC3} #D 4th 
If ($SustainList.SelectedIndex -eq 6) {$SCript:RestByte = 0xC7} #T 4th 
If ($SustainList.SelectedIndex -eq 7) {$SCript:RestByte = 0xC8} #8th 
If ($SustainList.SelectedIndex -eq 8) {$SCript:RestByte = 0xC6} #D 8th 
If ($SustainList.SelectedIndex -eq 9) {$SCript:RestByte = 0xCA} #T 8th
If ($SustainList.SelectedIndex -eq 10) {$SCript:RestByte = 0xCB} #16th 
If ($SustainList.SelectedIndex -eq 11) {$SCript:RestByte = 0xC9} #D 16th 
If ($SustainList.SelectedIndex -eq 12) {$SCript:RestByte = 0xCC} #T 16th
If ($SustainList.SelectedIndex -eq 13) {$SCript:RestByte = 0xCE} #32nd
If ($SustainList.SelectedIndex -eq 14) {$SCript:RestByte = 0xCE} #T 32nd 
If ($SustainList.SelectedIndex -eq 15) {$SCript:RestByte = 0xCF} #64th
$Script:Sequence += $RestByte
$ByteBox.Text = "$Sequence"
Byteupdate
}






Function Byteupdate{

$SCript:byteCount++
$Bytehint.text = "$byteCount/ 255 Bytes"
Write-Host $byteCount -ForegroundColor Yellow
}

Function SaveMusic {

$Rom = [System.IO.File]::ReadAllBytes("$Path\Final_Fantasy_2_(Tr).NES")  

$i = 0
While ($i -lt $bytecount){
    $val = $Sequence[$i]
    $ROM[$SongStart+$i] = $Val
    $i++
    }

[System.IO.File]::WriteAllBytes("$Path\Final_Fantasy_2_(Tr).NES", $Rom)
Write-host "Dec SEQ:$Sequence" -foregroundcolor yellow
}





Findrom