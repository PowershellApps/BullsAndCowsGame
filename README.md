# Bulls And Cows Game
A PowerShell implementation of the classic number guessing game Bulls and Cows.

## Parameters
- **numberLength**: Length of the number player will guess. Enter 0 to specify your own custom string.
- **hideHeader**: If specified, hides the initial header showing game introduction.

## Examples
- Start a game with default length of 4 for the secret number and default generic game introduction:
   ``Enter-BullsAndCowsGame``
- Start a game with default length of 4 for the secret number and hide generic game introduction:
   ``Enter-BullsAndCowsGame -hideBanner``
- Start a game with length 3 for the secret number and hide generic game introduction:
   ``Enter-BullsAndCowsGame -hideBanner -numberLength 3``
- Start a game with a custom secret by specifying length 0 for the secret number:
   ``Enter-BullsAndCowsGame -numberLength 0``

## Sample install and gameplay output
```
PS> Install-Module BullsAndCowsGame

Untrusted repository
You are installing the modules from an untrusted repository. If you trust this repository, change its
InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you want to install the modules from
'PSGallery'?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): y

PS> Enter-BullsAndCowsGame
Welcome to 'Bulls & Cows'! The classic number guessing game.
More info on https://github.com/PowershellApps/BullsAndCowsGame
Guess a sequence of 4 non-repeating digits. Enter 'x' to exit.
1       : 1234
                 BC
2       : 5678
                 BC
3       : 1256
                 CC
4       : 3478
                 CC
5       : 1357
                 CC
6       : 2468
                 CC
7       : 2378
                 C
8       : 2478
                 CC
9       : 1478
                 CCC
10      : 5174
                 BBB
11      : 5184
                 BBBB
Found after 11 guesses, congrats!
```

