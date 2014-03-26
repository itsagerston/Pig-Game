#Step1: Import random module
#Step2: Define initial variables
#Step3: Introduce game
#Step4: Define parameters for the game (game continues only while both scores are less than 100)
#Step5: Begin turn with user's input of "R" or "r"; re-prompt user if given anything else
#Step6: End turn if die roll is 1; provide option to re-roll or hold if die roll is greater than 1; continuously tally and display points as round progresses
#Step7: Repeat Step6 for computer (without user inputs) until 20 points achieved during the round, or a 100-point total
#Step8: Congratulate the winner after 100 total points have been reached

import random

userscore=0
compscore=0
unowscore=0
cnowscore=0
turn=1

print'''
Welcome to Pig.
You begin with 0 points.
So does your opponent.
First to 100 wins.
'''

play=raw_input("Type R to begin your turn. ")
while compscore<100 and userscore<100:
	while turn==1:
		if userscore+unowscore>=100:
			userscore+=unowscore
			turn!=1
			print"\r"
			break
		cnowscore=0
		if play!="R" and play!="r" and unowscore==0:
			print"Invalid command."
			play=raw_input("Type R to begin your turn. ")
			continue
		while play=="R" or play=="r":
			roll=random.randint(1,6)
			if roll==1:
				print"You've rolled a 1. That means you've accumulated 0 points this round and your turn is over."
				print"Your total score is still",userscore
				turn=2
				print"\r"
				break
			else:
				unowscore+=roll
				print"You've rolled a",roll,", which means you've accumulated",unowscore,"points this round."
				if userscore+unowscore>=100:
					break
				else:
					play=raw_input("(R)oll or (H)old? ")
					while play!="R" and play!="r" and play!="h" and play!="H":
						print"Invalid command..."
						play=raw_input("(R)oll or (H)old? ")
						continue
					if play=="H" or play=="h":
						userscore+=unowscore
						turn=2
						unowscore=0
						print"Your total score is now",userscore,"."
						print"\r"
						break
					else:
						continue
	while turn==2:
		if compscore+cnowscore>=100:
			compscore+=cnowscore
			turn!=2
			print"\r"
			break
		unowscore=0
		while cnowscore<20:
			roll=random.randint(1,6)
			if roll==1:
				print"Your opponent rolled a 1, thus accumulating 0 points this round."
				print"Your opponent's total score is still",compscore
				turn=1
				print"\r"
				play=raw_input("Type R to begin your turn. ")
				break
			else:
				cnowscore+=roll
				print"Your opponent rolled a",roll,"and has thus far accumulated",cnowscore,"points."
				if compscore+cnowscore>=100:
					break
		else:
			compscore+=cnowscore
			print"Your opponent is ending its turn, with a total score of",compscore
			turn=1
			print"\r"
			if compscore>=100:
				break
			else:
				play=raw_input("Type R to begin your turn. ")
else:
	if compscore>=100:
		print"You lose. CPU wins.",compscore,"-",userscore,"\n"
	elif userscore>=100:
		print"Hooray, you win!",userscore,"-",compscore,"\n"
