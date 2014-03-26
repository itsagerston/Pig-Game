########
#
# project.pl
# This program simulates a dice game called Pig.
# The premise of the game is established in the block of text at the game's start.
#
# This program was written in partial fulfillment of the course requirements,
# as a required "final project", for CPSC354 at Chapman University.
#
# Program written in full by Aaron Gerston
# Based on a similar program written in Python, also created by Aaron Gerston
#
###

$userTotalScore = 0;
$compTotalScore = 0;
$userCurrentScore = 0;
$compCurrentScore = 0;
$turn = 1;	# turn = 1 signifies it's the user's turn
$dieValue = 0;

game();

sub game() {
	print ("
Welcome to Pig.
You begin with 0 points.
So does your opponent.
First to 100 Wins.
Good luck.

How to play:
Roll the die to score points equal to the number on the die.
Rolling a 1 causes you to lose all points from that turn and end the turn.
Bank points from the current round to add them to your total score.
Type 'R' to roll, 'B' to bank.\n\n");
	
	print ("Type R to begin your turn. ");
	chomp ($play = <STDIN>);
	while ($userTotalScore < 100 && $compTotalScore < 100) {
		while ($turn == 1) {
			myTurn();
		}
		while ($turn == 2) {
			CPUTurn();
		}
	}
}

sub myTurn() {
	$compCurrentScore = 0;
	if (!($play eq "R" || $play eq "r") && $userCurrentScore == 0) {
		print ("Invalid command.\n");
		print ("Type R to begin your turn: ");
		chomp ($play = <STDIN>);
		print ("\n");
	}
	while ($play eq "R" || $play eq "r") {
		$dieValue = int(rand(6)+1);
		if ($dieValue == 1) {
			print ("You've rolled a 1. That means you've accumulated 0 points this round and your turn is over.\n");
			print ("Your total score is still $userTotalScore.\n");
			$turn = 2;
			print ("\n");
			last;
		}
		else {
			$userCurrentScore += $dieValue;
			print ("You've rolled a $dieValue, which means you've accumulated $userCurrentScore points this round.\n");
			if ($userCurrentScore + $userTotalScore >= 100) {
				$userTotalScore += $userCurrentScore;
				$turn != 1;
				print ("\n");
				finish();
			}
			else {
				print ("(R)oll or (B)ank current score? ");
				chomp ($play = <STDIN>);
				print ("\n");
				while (!($play eq "R" || $play eq "r" || $play eq "B" || $play eq "b")) {
					print ("Invalid command.\n");
					print ("(R)oll or (B)ank current score? ");
					chomp ($play = <STDIN>);
				}
				if ($play eq "B" || $play eq "b") {
					$userTotalScore += $userCurrentScore;
					$userCurrentScore = 0;
					$turn = 2;
					print ("Your total score is now $userTotalScore.\n\n");
				}
			}
		}
	}
}

sub CPUTurn() {
	$userCurrentScore = 0;
	while ($compCurrentScore < 20) {
		sleep(1);
		$dieValue = int(rand(6)+1);
		if ($dieValue == 1) {
			print ("Your opponent rolled a 1, thus accumulating 0 points this round.\n");
			print ("Your opponent's score is still $compTotalScore.\n\n");
			$turn = 1;
			print ("Type R to begin your turn. ");
			chomp ($play = <STDIN>);
			return;
		}
		else {
			$compCurrentScore += $dieValue;
			print ("Your opponent rolled a $dieValue and has thus far accumulated $compCurrentScore points.\n\n");
			if ($compTotalScore + $compCurrentScore >= 100) {
				$compTotalScore += $compCurrentScore;
				$turn != 2;
				print ("");
				finish();
			}
		}
	}
	$compTotalScore += $compCurrentScore;
	print ("Your opponent is ending its turn, with a total score of $compTotalScore.\n\n");
	$turn = 1;
	if ($compTotalScore >= 100) {
		finish();
	}
	else {
		print ("Type R to begin your turn. ");
		chomp ($play = <STDIN>);
		last;
	}
}

sub finish() {
	if ($compTotalScore >= 100) {
		print ("You lose. CPU wins.\n");
	}
	else {
		print ("Hooray, you win!\n");
	}
	print ("Your score: $userTotalScore.\n");
	print ("CPU score: $compTotalScore.\n\n");
	exit(0);
}
