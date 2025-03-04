<#
 .Synopsis
  Bulls and Cows Number Guessing Game.

 .Description
  A PowerShell implementation of the classic number guessing game Bulls and Cows.

 .Parameter numberLength
  Length of the number player will guess.

 .Parameter hideHeader
  If specified, hides the initial header showing game introduction.

 .Example
   # Start a game with default length of 4 for the secret number and generic game introduction.
   Enter-BullsAndCowsGame

 .Example
   # Start a game with default length of 4 for the secret number and hide generic game introduction.
   Enter-BullsAndCowsGame -hideBanner

 .Example
   # Start a game with length 3 for the secret number and hide generic game introduction.
   Enter-BullsAndCowsGame -hideBanner -numberLength 3
#>

function Test-StringsMatch($s,$g)
{
    $r=''
    $numberLength=$s.Length
    if($g.Length -ne $numberLength)
    {
        throw 'Length mismatch'
    }
    $i=0;while($i -lt $numberLength){if($g[$i] -eq $s[$i]){$r+='B';$s=$s.remove($i,1);$g=$g.remove($i,1);$numberLength--}else{$i++}}

    $i=0;while($i -lt $numberLength){if($s.contains($g[$i])){$r+='C';$s=$s.remove($s.IndexOf($g[$i]),1);$g=$g.remove($i,1);$numberLength--}else{$i++}}
    $r
}

function Get-SecretNumber($numberLength)
{
    $na=Get-Random -Count $numberLength -InputObject $(0..9)
    $s = $na -join ''
    $s
}

function Enter-BullsAndCowsGame($numberLength = 4, [switch] $hideHeader = $false)
{
    if (!$hideHeader)
    {
        "Welcome to 'Bulls & Cows'! The classic number guessing game."
        "More info on https://github.com/PowershellApps/BullsAndCowsGame"
        "Guess a sequence of $numberLength non-repeating digits. Enter 'x' to exit."
    }
    $s=Get-SecretNumber $numberLength
    $gameOn=$true
    $n=0
    while ($gameOn)
    {
        $n++
        $g = read-host "$n`t"
        if($g.ToUpperInvariant() -in @('Q', 'QUIT', 'EXIT', 'X'))
        {
            "The number was '$s'. Goodbye!"
            return
        }
        elseif($g.Length -ne $numberLength)
        {
            "Invalid string, please enter exactly $numberLength digits"
            continue
        }

        $r=Test-StringsMatch $s $g
        if ($r -eq 'BBBB') {"Found after $n guesses, congrats!";$gameOn=$false}
        else {"`t`t $r"}
    }
}

Export-ModuleMember -Function Enter-BullsAndCowsGame
