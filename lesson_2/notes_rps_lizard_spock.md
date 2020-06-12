RPS BONUS FEATURES
1. Add lizard and spock to options
  New rules of the game:
  Every choice has 2 win options, 2 lose options, 1 tie option (when both choices are the same)
            Win       Lose
  Rock      Scissors  Paper   
            Lizard    Spock
  Paper     Rock      Scissors
            Spock     Lizard
  Scissors  Paper     Rock
            Lizard    Spock
  Lizard    Paper     Scissors
            Spock     Rock
  Spock     Scissors  Paper
            Rock      Lizard

  - Need to add spock and lizard to VALID_CHOICES
    - Need to adjust win? to account for new combinations
    - Hash or array for each choice that contains the opposite choices for win?

2. Allow options to be selected based on first character
  Need to account for scissors and spock having same character (first two characters)
  - Maybe use map on VALID_CHOICES to get array of first/first two characters only

3. Keep score of computer and player's wins.  5 wins = match over.
  A match is a set of games played until a player wins 5 times or a player exits, which ever comes first.  
  - Need two variables for each player's score (and a third for overall # of games played?)
  - Need to encase game in new loop for match
    - Structure is as follows:
        Begin program
          Method definition and constant assignment
          Game welcome and explanation
          Match loop begin
            Game loop begin
              Main game code
              Continue playing match? (play another game?)> exit game loop if 'n' or 'no'
            Play new match? > exit match loop if 'n' or 'no'
          'Thank you for playing!'
        End program
  
  - Explain rules at beginning "The first to win 5 games is the match's grand winner!"
  - "Would you like to continue playing this match?"
    - Exit loop if 'no' or 'n'
  - "Would you like to play a new match?"
    - Exit loop if 'no' or 'n'
