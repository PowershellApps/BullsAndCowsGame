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
   # Start a game with default length of 4 for the secret number and default generic game introduction.
   Enter-BullsAndCowsGame

 .Example
   # Start a game with default length of 4 for the secret number and hide generic game introduction.
   Enter-BullsAndCowsGame -hideBanner

 .Example
   # Start a game with length 3 for the secret number and hide generic game introduction.
   Enter-BullsAndCowsGame -hideBanner -numberLength 3
 .Example
   # Start a game with a custom secret by specifying length 0 for the secret number.
   Enter-BullsAndCowsGame -numberLength 0
#>

function Test-StringsMatch([string]$s, [string]$g)
{
    $r=''
    $numberLength=$s.Length
    if($g.Length -ne $numberLength)
    {
        throw 'Length mismatch'
    }

    $i=0;
    while($i -lt $numberLength)
    {
        if($g[$i] -eq $s[$i])
        {
            $r+='B';
            $s=$s.remove($i,1);
            $g=$g.remove($i,1);
            $numberLength--
        }
        else
        {
            $i++
        }
    }

    $i=0;
    while($i -lt $numberLength)
    {
        if($s.contains($g[$i]))
        {
            $r+='C';
            $s=$s.remove($s.IndexOf($g[$i]),1);
            $g=$g.remove($i,1);
            $numberLength--
        }
        else
        {
            $i++
        }
    }

    return $r
}

function Get-SecretNumber($numberLength)
{
    $max = 9;
    if ($numberLength -gt 10)
    {
        $max = $numberLength
    }

    $na=Get-Random -Count $numberLength -InputObject $(0..$max)
    $s = $na -join ''
    return $s
}

function Enter-BullsAndCowsGame([byte]$numberLength = 4, [switch] $hideHeader = $false)
{
    if ($numberLength -eq 0)
    {
        $s = read-host "You specified numberLength of 0, please manually enter number to guess, this will also clear the screen once you press <Enter>"
        cls
        $numberLength = $s.Length
    }
    else
    {
        $s=Get-SecretNumber $numberLength
    }

    $nonRepeating = ''
    if ($numberLength -le 10)
    {
        $nonRepeating = ' non-repeating'
    }

    if (!$hideHeader)
    {
        "Welcome to 'Bulls & Cows'! The classic number guessing game."
        "More info on https://github.com/PowershellApps/BullsAndCowsGame"
        "Guess a sequence of $numberLength$nonRepeating digits. Enter 'x' to exit."
    }
    
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
        "`t`t $r"
        if ($r.Length -eq $numberLength -and $r.IndexOf('C') -eq -1)
        {
            "Found after $n guesses, congrats!";
            $gameOn=$false
        }
    }
}

