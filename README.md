
xwing-rank
==========

App for calculating xwing ranking based in ELO system


## ELO Ranking system

This information was extracted from  Wikipedia: http://en.wikipedia.org/wiki/Elo_rating_system

Ea = 1 / (1 + 10 ^ ((Rb - Ra) / 400))
Eb = 1 / (1 + 10 ^ ((Rc - Rb) / 400))

Ex is the expected probability that X will win the match, i.e. Ea + Eb = 1.

Rx is the rating of X, which changes after every match, according to the formula (Rx )n = (Rx )n-1 + 32 (W - Ex ) where W = 1 if X wins and W = 0 if X loses.

Everyone starts with an Rx = 1400.

## Data Model

Entities:
- Tourney
	state: open or closed. Open while editing, once closed only the last tourney can be reopened.
	created_at:
- Round
	order:
	tourney_id:
- Match
	player1_id:
	player2_id:
	winner: 1 or 2 for player1_id or player2_id
	round_id:
- Player
	name:
	uniqueid: optional, but recommended
	ranking:



## Great link for doing nested resources
https://gist.github.com/jhjguxin/3074080

