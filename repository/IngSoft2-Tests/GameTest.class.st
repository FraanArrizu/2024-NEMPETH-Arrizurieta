Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
GameTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: anErrorBlock raise: anErrorClass withExceptionDo: [ :error | self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
GameTest >> test001WhenSpaceshipsMovesThreeBoxesOnAThreeBoxesBoardWithOneLapToWinThenTheSpaceshipWins [

	| dices aDie cards aDeck aBoxOne aWormholeOne aWormholeTwo aPath aBoard aGame winner |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aBoxOne := Box new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.

	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne.
	aBoard := Board createWith: aPath.

	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.

	winner := aGame checkWinner.

	self assert: winner id equals: 1
]

{ #category : 'tests' }
GameTest >> test002WhenGameIsCreatedWithLessThanOneLapToWinThenThrowError [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aPath aBoard |
	aDie := Die of: 4.
	dices := OrderedCollection with: aDie.
	
	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo.


	aBoard := Board createWith: aPath.
	
	cards := {
        1 -> Acceleration.
        2 -> Speed.
    } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	self
		should: [ Game createWithNumberOfSpaceships: 2 and: dices and: aDeck and: aBoard andLapsToWin: 0 ]
		raise: Error
		withMessage: 'Laps to win should be greater than zero'
]

{ #category : 'tests' }
GameTest >> test003WhenSpaceshipsCompleteTwoLapsOnATwoLapCompletedGameThenTheSpaceshipWins [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aWormholeOne aWormholeTwo aPath aBoard aGame winner |
	aDie := LoadedDie of: 5.
	aDie add: (OrderedCollection with: 4 with: 3 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aNormalBoxOne
		         with: aNormalBoxTwo.
	aBoard := Board createWith: aPath.

	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 2.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	winner := aGame checkWinner.

	self assert: winner id equals: 1
]

{ #category : 'tests' }
GameTest >> test006WhenASpaceshipIsOnSecondWormholeThenSpaceshipMovesToPositionOne [

	| spaceships aSpaceship anotherSpaceship aWormholeOne aWormholeTwo aBoxOne aPath aBoard aBoxTwo aBoxThree boxToCheck actualSpaceship modifier |
	
	modifier := NormalModifier new.
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.

	spaceships := OrderedCollection
		              with: aSpaceship
		              with: anotherSpaceship.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aBoxOne := Box new.
	aBoxTwo := Box new.
	aBoxThree := Box new.
	
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.

	aPath := OrderedCollection
		         with: aWormholeTwo
		         with: aBoxOne
		         with: aWormholeOne
		         with: aBoxTwo
		         with: aBoxThree.

	aBoard := Board createWith: aPath.
	actualSpaceship := spaceships removeFirst.
	
	aSpaceship move: 2.
	boxToCheck := aBoard findBoxIn: (aSpaceship position).
	boxToCheck applyEffect: spaceships and: actualSpaceship through: modifier.
	spaceships add: actualSpaceship.

	self assert: aSpaceship position equals: 1
]

{ #category : 'tests' }
GameTest >> test007WhenASpaceshipWinsThenPositionOfAnotherSpaceshipIsOne [

	| dices aDie cards aDeck aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aBoxOne := Box new.
	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne.
	aBoard := Board createWith: aPath.

	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : 'tests' }
GameTest >> test008WhenGameEndedThenReturnTheFinishSpaceshipPositionOnBoard [

	| dices aDie cards aDeck aWormholeOne aWormholeTwo aNormalBoxOne aPath aBoard aGame aNormalBoxTwo aNormalBoxThree |
	aDie := LoadedDie of: 5.
	aDie add: (OrderedCollection
			 with: 4
			 with: 3
			 with: 3
			 with: 3
			 with: 5).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.

	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aNormalBoxTwo
		         with: aNormalBoxThree.

	aBoard := Board createWith: aPath.

	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 2.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : 'tests' }
GameTest >> test009WhenGameIsCreatedWithLessThanTwoSpaceshipsThenThrowError [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aPath aBoard |
	aDie := Die of: 4.
	dices := OrderedCollection with: aDie.
	
	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.

	aPath := OrderedCollection with: aNormalBoxOne with: aNormalBoxTwo.

	aBoard := Board createWith: aPath.

	cards := {
        1 -> Acceleration.
        2 -> Speed.
    } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	self
		should: [ Game createWithNumberOfSpaceships: 0 and: dices and: aDeck and: aBoard andLapsToWin: 1 ]
		raise: Error
		withMessage: 'Game should have a least two spaceships'
]

{ #category : 'tests' }
GameTest >> test010WhenGameIsCreatedWithoutDicesThenThrowError [

	| dices cards aDeck aNormalBoxOne aNormalBoxTwo aPath aBoard |

	dices := OrderedCollection new.
	
	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.

	aPath := OrderedCollection with: aNormalBoxOne with: aNormalBoxTwo.

	aBoard := Board createWith: aPath.
	
	cards := {
        1 -> Acceleration.
        2 -> Speed.
    } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	self
		should: [ Game createWithNumberOfSpaceships: 2 and: dices and: aDeck and: aBoard andLapsToWin: 1 ]
		raise: Error
		withMessage: 'Game should have a least one die'
]

{ #category : 'tests' }
GameTest >> test011WhenSpaceshipsMoveThreeBoxesThenASpaceshipWins [

	| dices aDie cards aDeck aWormholeOne aWormholeTwo aBoxOne aPath aBoard aGame winner |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aBoxOne := Box new.
	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxOne.
	aBoard := Board createWith: aPath.

	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.

	winner := aGame checkWinner.

	self assert: winner id equals: 1
]

{ #category : 'tests' }
GameTest >> test014WhenSpaceshipMoveToAPositionWhereThereIsNotAnotherSpaceshipThenTheShieldIsNotAffected [

	| dices aDie cards aDeck aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 1).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aBoxOne := NormalBox new.
	aBoxTwo := NormalBox new.
	aBoxThree := NormalBox new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aPath := OrderedCollection
		         with: aBoxOne
		         with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxThree.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.

	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : 'tests' }
GameTest >> test015WhenTwoSpaceshipsBattleIfThereIsATieThenTheSecondSpaceshipLoseOneShieldAndRestartPositionOne [

	| dices aDie cards aDeck aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 1).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aBoxOne := NormalBox new.
	aBoxTwo := NormalBox new.
	aBoxThree := NormalBox new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aPath := OrderedCollection
		         with: aBoxOne
		         with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxThree.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : 'tests' }
GameTest >> test016WhenBothSpaceshipsAreInPositionOneThenTheSpaceshipsAreNotAffectedThisIsASafeZone [

	| dices aDie cards aDeck aBoxOne aBoxTwo aBoxThree aPath aBoard aGame |
	aDie := LoadedDie of: 3.
	aDie add: (OrderedCollection with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aBoxOne := NormalBox new.
	aBoxTwo := NormalBox new.
	aBoxThree := NormalBox new.

	aPath := OrderedCollection
		         with: aBoxOne
		         with: aBoxTwo
		         with: aBoxThree.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1).

	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : 'tests' }
GameTest >> test017WhenPassTurnThenTheSpaceshipRecoverAllShields [

	| dices aDie cards aDeck aBoxOne aBoxTwo aBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 1
			 with: 1
			 with: 2
			 with: 1
			 with: 2).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aBoxOne := NormalBox new.
	aBoxTwo := NormalBox new.
	aBoxThree := Box new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aPath := OrderedCollection
		         with: aBoxOne
		         with: aBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aBoxThree.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2).
	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 2 with: 3).

	aGame passTurn.

	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : 'tests' }
GameTest >> test018WhenPassTurnThenTheSpaceshipStaysOnTheSamePlace [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 1
			 with: 3
			 with: 1
			 with: 1).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aNormalBoxThree.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 1).
	aGame playTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 3).
	aGame playTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 3).
	aGame passTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 3).
	aGame playTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 5 with: 3)
]

{ #category : 'tests' }
GameTest >> test019CheckTheRankingOfSpaceshipsInTheGame [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aWormholeOne aWormholeTwo aPath aBoard aGame |
	aDie := LoadedDie of: 5.
	aDie add: (OrderedCollection
			 with: 1
			 with: 3
			 with: 2
			 with: 1
			 with: 5).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aWormholeOne := Wormhole new.
	aWormholeTwo := Wormhole new.
	aWormholeOne associateWith: aWormholeTwo.
	aWormholeTwo associateWith: aWormholeOne.
	aPath := OrderedCollection
		         with: aWormholeOne
		         with: aWormholeTwo
		         with: aNormalBoxOne
		         with: aNormalBoxTwo.
	aBoard := Board createWith: aPath.

	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 2.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkRanking
		equals: (OrderedCollection with: 2 with: 3 with: 1)
]

{ #category : 'tests' }
GameTest >> test020CanNotBattleAfterASpaceshipHasWon [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : 'tests' }
GameTest >> test021WhenOnABattleTheSpaceshipsThrowTheSameThenTheOneWhichArrivedLastLose [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 2
			 with: 2
			 with: 3
			 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 1)
]

{ #category : 'tests' }
GameTest >> test022SpaceshipsStartWithTwoCardsWhenGameStarts [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 2
			 with: 2
			 with: 3
			 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 4
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection
				 with: 2
				 with: 2
				 with: 2
				 with: 2)
]

{ #category : 'tests' }
GameTest >> test023WhenGameStartsThenItHasNotPermanentCardsPlayed [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 2
			 with: 2
			 with: 3
			 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 4
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	self
		assert: aGame getPermanentCardPlayed
		equals: OrderedCollection new
]

{ #category : 'tests' }
GameTest >> test024WhenGameStartsThenThereIsNoLastCardPlay [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 2
			 with: 2
			 with: 3
			 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 4
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	self assert: aGame getLastCardPlayed isNil
]

{ #category : 'tests' }
GameTest >> test025WhenAnAccelerationCardIsPlayedThenAllThrowsIncreaseByOne [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Acceleration) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 1).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 4).

	self assert: aGame getPermanentCardPlayed size equals: 1
]

{ #category : 'tests' }
GameTest >> test026WhenAnSpeedCardIsPlayedThenTheAffectedSpaceshipThrowsIncreaseByOne [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 1).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 4).

	self assert: aGame getPermanentCardPlayed size equals: 1
]

{ #category : 'tests' }
GameTest >> test027WhenAnCancelationCardIsPlayedAndTheAffectedCardIsSpeedThenTheAffectedSpaceshipsDecreaseHisThrowByOne [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Speed).
		         (2 -> Cancellation) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 1).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 4).

	self assert: aGame getPermanentCardPlayed size equals: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.
	cardArguments at: 'idTargetCard' put: 1.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 0 with: 2).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 4).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 2).

	self assert: aGame getPermanentCardPlayed size equals: 0
]

{ #category : 'tests' }
GameTest >> test028WhenAnCancelationCardIsPlayedAndTheAffectedCardIsAccelerationThenAllSpaceshipsDecreaseHisThrowByOne [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Cancellation) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 1).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 5).

	self assert: aGame getPermanentCardPlayed size equals: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.
	cardArguments at: 'idTargetCard' put: 1.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 0 with: 2).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 5).

	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 3).

	self assert: aGame getPermanentCardPlayed size equals: 0
]

{ #category : 'tests' }
GameTest >> test029WhenAnMercenaryCardIsPlayedThenAlliedSpaceshipsNotFight [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Mercenary) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2 with: 2).

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2 with: 1)
]

{ #category : 'tests' }
GameTest >> test030WhenAMercenaryCardIsPlayedSpaceshipAndHisAlliedLoseThenLoseOneShieldBoth [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 1
			 with: 2
			 with: 1
			 with: 3
			 with: 1
			 with: 1).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Mercenary) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2 with: 2).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 3 with: 2).

	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2 with: 3)
]

{ #category : 'tests' }
GameTest >> test031WhenAnCancelationCardIsPlayedAndTheAffectedCardIsMercenaryThenTheAffectedSpaceshipLoseHisMercenary [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection
			 with: 1
			 with: 2
			 with: 1
			 with: 3
			 with: 1
			 with: 1).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Mercenary).
		         (2 -> Cancellation) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 4.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2 with: 2).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 3 with: 2).

	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2 with: 3).

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 4.
	cardArguments at: 'idTargetCard' put: 1.

	aGame playCard: cardArguments.

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1 with: 2).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 1 with: 1).
	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2 with: 1)
]

{ #category : 'tests' }
GameTest >> test032WhenARepeatCardIsPlayAndLastBoxIsNormalBoxThenNoEffectApplied [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playTurn.
	aGame playTurn.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : 'tests' }
GameTest >> test033WhenARepeatCardIsPlayAndLastBoxIsBlackholeThenTheAffectedSpaceshipMoveFourBoxesBackwards [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aBlackHole aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 3 with: 5).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aBlackHole := BlackHole new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive
		         with: aBlackHole.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 3.
	cardArguments at: 'idTargetSpaceship' put: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 2)
]

{ #category : 'tests' }
GameTest >> test034WhenARepeatCardIsPlayAndLastBoxIsHyperSpaceJumpThenTheAffectedSpaceshipMoveFourBoxesForwardAndLoseOneShield [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aHyperSpaceJump aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 2 with: 1).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aHyperSpaceJump := HyperSpaceJump new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aHyperSpaceJump
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 3.
	cardArguments at: 'idTargetSpaceship' put: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 6).

	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2)
]

{ #category : 'tests' }
GameTest >> test035WhenARepeatCardIsPlayAndLastBoxIsMoonWalkThenTheAffectedSpaceshipMoveTwoBoxesBackWards [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aMoonWalk aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 4 with: 3).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aMoonWalk := MoonWalk createWith: 2.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aMoonWalk
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 2)
]

{ #category : 'tests' }
GameTest >> test036WhenARepeatCardIsPlayAndLastBoxIsAtomicbombThenAllSpaceshipLoseOneShieldAndReturnToPositionOne [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive anAtomicBomb aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 4 with: 3).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	anAtomicBomb := AtomicBomb new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: anAtomicBomb
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 1.

	aGame playTurn.
	aGame playTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1).
	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2).
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1).
	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : 'tests' }
GameTest >> test038WhenARedoCardIsPlayAndLastCardIsSpeedCardThenTheAffectedSpaceshipAddsOneToItsMove [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Speed).
		         (2 -> Redo) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.
	cardArguments at: 'idTargetSpaceship' put: 2.

	aGame playCard: cardArguments.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 4)
]

{ #category : 'tests' }
GameTest >> test039WhenARedoCardIsPlayAndLastCardIsAccelerationCardThenAllSpaceshipAddOneToTheirMove [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Acceleration).
		         (2 -> Redo) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.


	aGame playCard: cardArguments.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.

	aGame playCard: cardArguments.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 5).

	self assert: aGame getPermanentCardPlayed size equals: 2
]

{ #category : 'tests' }
GameTest >> test040WhenARedoCardIsPlayAndLastCardIsCancellationCardThenRemoveTheCardSelected [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 3).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Redo).
		         (2 -> Speed).
		         (3 -> Cancellation).
		         (4 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.
	cardArguments at: 'idTargetSpaceship' put: 1.
	aGame playCard: cardArguments.

	aGame playTurn.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 4.
	cardArguments at: 'idTargetSpaceship' put: 2.
	aGame playCard: cardArguments.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 3.
	cardArguments at: 'idTargetCard' put: 2.
	aGame playCard: cardArguments.

	aGame playTurn.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetCard' put: 4.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 5).

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 3).

	self assert: aGame getPermanentCardPlayed size equals: 0
]

{ #category : 'tests' }
GameTest >> test041WhenARedoCardIsPlayAndLastCardIsRepeatCardThenSpaceshipTargetApplyTheLastBoxPlayed [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aBlackhole aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 3 with: 5).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Redo).
		         (2 -> Repeat) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.
	aBlackhole := BlackHole new.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive
		         with: aBlackhole.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 4 with: 2).

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 4.
	cardArguments at: 'idTargetSpaceship' put: 1.
	aGame playCard: cardArguments.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 2.
	aGame playCard: cardArguments.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 1 with: 1).

	self assert: aGame getPermanentCardPlayed size equals: 0
]

{ #category : 'tests' }
GameTest >> test042WhenARedoCardIsPlayAndLastCardIsMercenaryCardThenSpaceshipGetAMercenary [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Redo).
		         (2 -> Mercenary) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aNormalBoxFive := NormalBox new.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour
		         with: aNormalBoxFive.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.


	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 2.
	cardArguments at: 'idTargetSpaceship' put: 2.
	aGame playCard: cardArguments.

	aGame playTurn.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 3.
	cardArguments at: 'idTargetSpaceship' put: 1.
	aGame playCard: cardArguments.

	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 2 with: 3).
	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3 with: 3).

	aGame playTurn.
	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 3 with: 2 with: 1).
	self
		assert: aGame checkShieldsOfSpaceships
		equals: (OrderedCollection with: 3 with: 3 with: 2).

	self assert: aGame getPermanentCardPlayed size equals: 2
]

{ #category : 'tests' }
GameTest >> test043WhenASpaceshipIsInACardBoxThenGetsACard [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aCardBoxOne aCardBoxTwo aPath aBoard aGame |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2 with: 3).

	dices := OrderedCollection with: aDie.

	cards := {
		         (1 -> Redo).
		         (2 -> Mercenary) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aCardBoxOne := CardBox createWith: aDeck.
	aCardBoxTwo := CardBox createWith: aDeck.

	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aCardBoxOne
		         with: aNormalBoxTwo
		         with: aCardBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 3.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame checkPositionsOfSpaceships
		equals: (OrderedCollection with: 2 with: 3 with: 4).

	self
		assert: aGame checkAmountOfCardsOfSpaceships
		equals: (OrderedCollection with: 3 with: 2 with: 3)
]

{ #category : 'tests' }
GameTest >> test044WhenASpaceshipTriesToPlayAccelerationWhenItIsNotItsTurnThenThrowError [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Acceleration) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 3.

	self
		should: [ aGame playCard: cardArguments ]
		raise: Error
		withMessage: 'A spaceship is trying to play a permanent card and it is not its turn'
]

{ #category : 'tests' }
GameTest >> test045WhenASpaceshipTriesToPlayACardThatDoesNotHaveThenThrowError [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Acceleration) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 10000000.

	self
		should: [ aGame playCard: cardArguments ]
		raise: Error
		withMessage: 'A spaceship is trying to play a card that does not have'
]

{ #category : 'tests' }
GameTest >> test046WhenASpaceshipTriesToPlaySpeedWhenItIsNotItsTurnThenThrowError [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 3.
	cardArguments at: 'idTargetSpaceship' put: 2.

	self
		should: [ aGame playCard: cardArguments ]
		raise: Error
		withMessage: 'A spaceship is trying to play a permanent card and it is not its turn'
]

{ #category : 'tests' }
GameTest >> test047WhenASpaceshipTriesToPlayMercenaryWhenItIsNotItsTurnThenThrowError [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Mercenary) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 3.
	cardArguments at: 'idTargetSpaceship' put: 1.

	self
		should: [ aGame playCard: cardArguments ]
		raise: Error
		withMessage: 'A spaceship is trying to play a permanent card and it is not its turn'
]

{ #category : 'tests' }
GameTest >> test048WhenASpaceshipTriesToPlayMercenaryAndChooseItselfAsMercenaryThenThrowError [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Mercenary) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 1.

	self
		should: [ aGame playCard: cardArguments ]
		raise: Error
		withMessage: 'A spaceship can not choose itself as mercenary'
]

{ #category : 'tests' }
GameTest >> test049WhenASpaceshipTriesToPlayMercenaryAndChooseOneAlreadyChosenAsMercenaryThenThrowError [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Mercenary) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 3
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 3.
	aGame playCard: cardArguments.
	
	aGame playTurn.
	
	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 2.
	cardArguments at: 'idCardToUse' put: 3.
	cardArguments at: 'idTargetSpaceship' put: 3.

	self
		should: [ aGame playCard: cardArguments ]
		raise: Error
		withMessage: 'A spaceship chose a mercenary already chosen'
]

{ #category : 'tests' }
GameTest >> test050WhenASpaceshipThatDoesNotExistTriesToPlayACardThenThrowError [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Acceleration) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 50.
	cardArguments at: 'idCardToUse' put: 3.

	self
		should: [ aGame playCard: cardArguments ]
		raise: Error
		withMessage: 'The spaceship that wants to play the card does not exist'
]

{ #category : 'tests' }
GameTest >> test051WhenASpaceshipChooseATargetSpaceshipThatDoesNotExistThenThrowError [

	| dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aPath aBoard aGame cardArguments |
	aDie := LoadedDie of: 10.
	aDie add: (OrderedCollection with: 1 with: 2).
	dices := OrderedCollection with: aDie.

	cards := { (1 -> Speed) } asDictionary.
	aDeck := LoadedDeck createWith: cards.

	aNormalBoxOne := NormalBox new.
	aNormalBoxTwo := NormalBox new.
	aNormalBoxThree := NormalBox new.
	aNormalBoxFour := NormalBox new.
	aPath := OrderedCollection
		         with: aNormalBoxOne
		         with: aNormalBoxTwo
		         with: aNormalBoxThree
		         with: aNormalBoxFour.

	aBoard := Board createWith: aPath.
	aGame := Game
		         createWithNumberOfSpaceships: 2
		         and: dices
		         and: aDeck
		         and: aBoard
		         andLapsToWin: 1.

	cardArguments := Dictionary new.
	cardArguments at: 'idSpaceship' put: 1.
	cardArguments at: 'idCardToUse' put: 1.
	cardArguments at: 'idTargetSpaceship' put: 3.

	self
		should: [ aGame playCard: cardArguments ]
		raise: Error
		withMessage: 'The target spaceship does not exist'
]

{ #category : 'tests' }
GameTest >> test052WhenReversalCardIsPlayedThenPositionIsReversed [
    | dices aDie cards aDeck boxes aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    boxes := OrderedCollection 
        with: NormalBox new
        with: NormalBox new
        with: NormalBox new
        with: NormalBox new
        with: NormalBox new.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.

    self deny: (aGame isReversedAt: 3).

    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 3.
    
    aGame playCard: cardArguments.
    
    self assert: (aGame isReversedAt: 3).
]

{ #category : 'tests' }
GameTest >> test053ReversalCanOnlyBePlayedDuringSpaceshipTurn [
    | dices aDie cards aDeck boxes aBoard aGame cardArguments |

    aDie := LoadedDie of: 10.
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.

    "Spaceship 2 intenta jugar carta pero no es su turno (es turno de spaceship 1)"
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 2.
    cardArguments at: 'idCardToUse' put: 3.  "Spaceship 2 tiene cartas con id 3 y 4"
    cardArguments at: 'targetPosition' put: 3.

    self should: [ aGame playCard: cardArguments ] raise: Error.
]

{ #category : 'tests' }
GameTest >> test054ReversalCardOnlyAffectsTargetPosition [
    | dices aDie cards aDeck boxes aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    boxes := OrderedCollection 
        with: NormalBox new
        with: BlackHole new
        with: NormalBox new
        with: NormalBox new
        with: BlackHole new.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.

    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 5.
    
    aGame playCard: cardArguments.
    
    self assert: (aGame isReversedAt: 5).
    
    self deny: (aGame isReversedAt: 2).
    self deny: (aGame isReversedAt: 1).
    self deny: (aGame isReversedAt: 3).
]

{ #category : 'tests' }
GameTest >> test055MultipleReversalsToggleEffect [
    | dices aDie cards aDeck boxes aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    dices := OrderedCollection with: aDie.

    cards := { 
        (1 -> Reversal).
        (2 -> Reversal).
    } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    boxes := OrderedCollection 
        with: NormalBox new
        with: NormalBox new
        with: NormalBox new
        with: NormalBox new
        with: BlackHole new.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.

    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'targetPosition' put: 5.
    
    cardArguments at: 'idCardToUse' put: 1.
    aGame playCard: cardArguments.
    self assert: (aGame isReversedAt: 5).  "1 reversal = odd = revertido"
    
    cardArguments at: 'idCardToUse' put: 2.
    aGame playCard: cardArguments.
    self deny: (aGame isReversedAt: 5).  "2 reversals = even = normal"
]

{ #category : 'tests' }
GameTest >> test056ReversalIsAddedToPermanentCards [
    | dices aDie cards aDeck boxes aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.

    self assert: aGame getPermanentCardPlayed size equals: 0.
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 3.
    
    aGame playCard: cardArguments.
    
    self assert: aGame getPermanentCardPlayed size equals: 1.

    self assert: aGame getPermanentCardPlayed first class equals: Reversal.
]

{ #category : 'tests' }
GameTest >> test057CancellationRemovesReversal [
    | dices aDie cards aDeck boxes aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 3).
    dices := OrderedCollection with: aDie.

    cards := { 
        (1 -> Reversal).
        (2 -> Cancellation).
    } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        BlackHole new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.

    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 4.
    
    aGame playCard: cardArguments.
    
    self assert: (aGame isReversedAt: 4).
    self assert: aGame getPermanentCardPlayed size equals: 1.
    
    cardArguments at: 'idCardToUse' put: 2.
    cardArguments at: 'idTargetCard' put: 1.
    
    aGame playCard: cardArguments.
    
    self deny: (aGame isReversedAt: 4).
    self assert: aGame getPermanentCardPlayed size equals: 0.
    
    aGame playTurn.

    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 1 with: 1).
]

{ #category : 'tests' }
GameTest >> test058ReversalCardInvertsMoonWalkEffect [
    | dices aDie cards aDeck boxes aMoonWalk aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 1 with: 4).
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    aMoonWalk := MoonWalk createWith: 2.
    
    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        aMoonWalk.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 5.
    
    aGame playCard: cardArguments.
    
    aGame playTurn.
    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 2 with: 1).
    
    aGame playTurn.
    
    "MoonWalk revertido mueve a LOS DEMAS +2"
    "Nave 2: NO se mueve (es la que cayo) → pos 5"
    "Nave 1: SÍ se mueve +2 → 2 + 2 = 4"
    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 4 with: 5).
]

{ #category : 'tests' }
GameTest >> test059ReversalCardInvertsBlackHoleEffect [
    | dices aDie cards aDeck boxes aBlackHole aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 4).
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    aBlackHole := BlackHole new.
    
    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        aBlackHole.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 5.
    
    aGame playCard: cardArguments.
    
    self assert: (aGame isReversedAt: 5).
    
    aGame playTurn.
    
    "Nave 1: pos 9, Nave 2: pos 1"
    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 9 with: 1).
]

{ #category : 'tests' }
GameTest >> test060ReversalCardInvertsWormholeEffect [
    | dices aDie cards aDeck boxes wormholeStart wormholeEnd aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 7).
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    wormholeStart := Wormhole new.
    wormholeEnd := Wormhole new.
    wormholeStart associateWith: wormholeEnd.
    wormholeEnd associateWith: wormholeStart.
    
    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        wormholeStart.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        wormholeEnd.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    wormholeStart position: 8.
    wormholeEnd position: 13.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 8.
    
    aGame playCard: cardArguments.
    
    self assert: (aGame isReversedAt: 8).
    
    aGame playTurn.
    
    "Wormhole normal: pos 8 → 13 (move: 13-8 = +5 → pos 13)"
    "Wormhole revertido: pos 8 (move: 8-13 = -5 → pos 3)"
    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 3 with: 1).
]

{ #category : 'tests' }
GameTest >> test061ReversalCardInvertsHyperSpaceJumpEffect [
    | dices aDie cards aDeck aNormalBoxOne aNormalBoxTwo aNormalBoxThree aNormalBoxFour aNormalBoxFive aHyperSpaceJump aPath aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 1).
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    aNormalBoxOne := NormalBox new.
    aNormalBoxTwo := NormalBox new.
    aNormalBoxThree := NormalBox new.
    aNormalBoxFour := NormalBox new.
    aNormalBoxFive := NormalBox new.
    aHyperSpaceJump := HyperSpaceJump new.
    
    aPath := OrderedCollection
        with: aNormalBoxOne
        with: aHyperSpaceJump
        with: aNormalBoxTwo
        with: aNormalBoxThree
        with: aNormalBoxFour
        with: aNormalBoxFive.

    aBoard := Board createWith: aPath.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 3.

    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 1 with: 1).
    self assert: aGame checkShieldsOfSpaceships equals: (OrderedCollection with: 3 with: 3).

    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 2.
    
    aGame playCard: cardArguments.
    
    self assert: (aGame isReversedAt: 2).

    aGame playTurn.

    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 1 with: 1).
    self assert: aGame checkShieldsOfSpaceships equals: (OrderedCollection with: 4 with: 3).
]

{ #category : 'tests' }
GameTest >> test062ReversalCardInvertsHyperJumpEffect [
    | dices aDie cards aDeck boxes aHyperJump aBoard aGame cardArguments parsec |
    
    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 3).
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    aHyperJump := LoadedHyperJump createWith: 1 andParsecsToBoxesRatio: 1.
    parsec := Parsec createWith: 3.
    aHyperJump addParsecs: (OrderedCollection with: parsec).
    
    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        aHyperJump.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 4.
    
    aGame playCard: cardArguments.
    
    self assert: (aGame isReversedAt: 4).
    
    aGame playTurn.
    
    "HyperJump normal: 3 parsecs * ratio 1 = +3 boxes → pos 7"
    "HyperJump revertido: 3 parsecs * ratio 1 = -3 boxes → pos 1"
    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 1 with: 1).
]

{ #category : 'tests' }
GameTest >> test063ReversalCardInvertsCardBoxEffect [
    | dices aDie cards aDeck boxes aCardBox aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 3 with: 3).
    dices := OrderedCollection with: aDie.

    cards := { 
        (1 -> Reversal).
        (2 -> Speed).
        (3 -> Speed).
        (4 -> Acceleration).
    } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    aCardBox := CardBox createWith: aDeck.
    
    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        aCardBox.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.
    
    self assert: aGame checkAmountOfCardsOfSpaceships equals: (OrderedCollection with: 2 with: 2).
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 4.
    
    aGame playCard: cardArguments.
    
    self assert: aGame checkAmountOfCardsOfSpaceships equals: (OrderedCollection with: 1 with: 2).
    
    self assert: (aGame isReversedAt: 4).
    
    aGame playTurn.
    
    self assert: aGame checkAmountOfCardsOfSpaceships equals: (OrderedCollection with: 0 with: 2).
    
    aGame playTurn.
    
    self assert: aGame checkAmountOfCardsOfSpaceships equals: (OrderedCollection with: 0 with: 1).
]

{ #category : 'tests' }
GameTest >> test064ReversalPersistsBetweenTurns [
    | dices aDie cards aDeck boxes aBlackHole aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 3 with: 1 with: 3).
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    aBlackHole := BlackHole new.
    
    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        aBlackHole.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 4.
    
    aGame playCard: cardArguments.
    
    self assert: (aGame isReversedAt: 4).
    self assert: aGame getPermanentCardPlayed size equals: 1.
    
    aGame playTurn.
    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 8 with: 1).
    
    aGame playTurn.
    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 8 with: 2).
    
    self assert: (aGame isReversedAt: 4).
    self assert: aGame getPermanentCardPlayed size equals: 1.
    
    aGame playTurn.
    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 3 with: 2).
    
    self assert: (aGame isReversedAt: 4).
    self assert: aGame getPermanentCardPlayed size equals: 1.
]

{ #category : 'tests' }
GameTest >> test065ReversalInInvalidPositionRaisesError [
    | dices aDie cards aDeck boxes aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.
    
    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 10.
    
    self should: [ aGame playCard: cardArguments ] raise: Error.
]

{ #category : 'tests' }
GameTest >> test066ReversalInZeroOrNegativePositionRaisesError [
    | dices aDie cards aDeck boxes aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    dices := OrderedCollection with: aDie.

    cards := { 
        (1 -> Reversal).
        (2 -> Reversal).
    } asDictionary.
    aDeck := LoadedDeck createWith: cards.
    
    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 0.
    
    self should: [ aGame playCard: cardArguments ] raise: Error.
    
    cardArguments at: 'idSpaceship' put: 2.
    cardArguments at: 'idCardToUse' put: 2.
    cardArguments at: 'targetPosition' put: -5.
    
    self should: [ aGame playCard: cardArguments ] raise: Error.
]

{ #category : 'tests' }
GameTest >> test067CancellationWithNoReversalRaisesError [
    | dices aDie cards aDeck boxes aBoard aGame cardArguments |
    
    aDie := LoadedDie of: 10.
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Cancellation) } asDictionary.
    aDeck := LoadedDeck createWith: cards.
    
    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.
    
    self assert: aGame getPermanentCardPlayed size equals: 0.
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'idTargetCard' put: 999.
    
    self should: [ aGame playCard: cardArguments ] raise: Error.
]

{ #category : 'tests' }
GameTest >> test068ReversedWormholeGoesToPreviousLapFromStart [
    | dices aDie cards aDeck boxes wormholeStart wormholeEnd aBoard aGame cardArguments spaceship1 |
    
    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 10 with: 0 with: 2).
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    wormholeStart := Wormhole new.
    wormholeEnd := Wormhole new.
    wormholeStart associateWith: wormholeEnd.
    wormholeEnd associateWith: wormholeStart.
    
    boxes := {
        NormalBox new.
        NormalBox new.
        wormholeStart.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        wormholeEnd.
    } asOrderedCollection.

    wormholeStart position: 3.
    wormholeEnd position: 10.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 3.
    
    spaceship1 := aGame getSpaceships first.
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 3.
    
    aGame playCard: cardArguments.
    self assert: (aGame isReversedAt: 3).
    
    aGame playTurn.
    self assert: spaceship1 position equals: 1.
    self assert: spaceship1 lapsCompleted equals: 1.
    
    aGame playTurn.
    
    aGame playTurn.
    
    self assert: spaceship1 position equals: 10.
    self assert: spaceship1 lapsCompleted equals: 0.
]

{ #category : 'tests' }
GameTest >> test073ReversedWormholeBackwardGoesToNextLap [
    | dices aDie cards aDeck boxes wormholeStart wormholeEnd aBoard aGame cardArguments spaceship1 |
    
    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 9).
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    wormholeStart := Wormhole new.
    wormholeEnd := Wormhole new.
    wormholeStart associateWith: wormholeEnd.
    wormholeEnd associateWith: wormholeStart.
    
    boxes := {
        NormalBox new.
        NormalBox new.
        wormholeEnd.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        wormholeStart.
    } asOrderedCollection.

    wormholeStart position: 10.
    wormholeEnd position: 3.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 3.
    
    spaceship1 := aGame getSpaceships first.
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 10.
    
    aGame playCard: cardArguments.
    self assert: (aGame isReversedAt: 10).

    aGame playTurn.
    
    self assert: spaceship1 position equals: 3.
    self assert: spaceship1 lapsCompleted equals: 1.
]

{ #category : 'tests' }
GameTest >> test075MultipleReversalsOnDifferentPositions [
    | dices aDie cards aDeck boxes moonWalk blackHole aBoard aGame cardArguments spaceship1 spaceship2 |
    
    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 3 with: 0).
    dices := OrderedCollection with: aDie.

    cards := { 
        (1 -> Reversal).
        (2 -> Reversal).
    } asDictionary.
    aDeck := LoadedDeck createWith: cards.

	 moonWalk := MoonWalk createWith: 4.
    
    blackHole := BlackHole new.
    
    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        moonWalk.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        blackHole.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    moonWalk position: 4.
    blackHole position: 8.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 3.
    
    spaceship1 := aGame getSpaceships first.
    spaceship2 := aGame getSpaceships second.
    
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 4.
    aGame playCard: cardArguments.
    
    cardArguments at: 'idCardToUse' put: 2.
    cardArguments at: 'targetPosition' put: 8.
    aGame playCard: cardArguments.
    
    self assert: (aGame isReversedAt: 4).
    self assert: (aGame isReversedAt: 8).
    
    aGame playTurn.
    
    self assert: spaceship1 position equals: 4.
    
    self assert: spaceship2 position equals: 5.
    
    aGame playTurn.
    
    self assert: spaceship2 position equals: 5.
    
    self assert: (aGame isReversedAt: 4).
    self assert: (aGame isReversedAt: 8).
]

{ #category : 'tests' }
GameTest >> test076ReversedCardBoxWithNoCardsDoesNotFail [
    | dices aDie cards aDeck boxes aCardBox aBoard aGame cardArguments spaceship1 |

    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 3).
    dices := OrderedCollection with: aDie.

    cards := { (1 -> Reversal) } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    aCardBox := CardBox createWith: aDeck.

    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        aCardBox.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 1.

    spaceship1 := aGame getSpaceships first.

    "Spaceship1 inicia con 2 cartas (id 1 y 2)"
    self assert: spaceship1 cards size equals: 2.

    "Primero jugamos la carta Reversal"
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 4.

    aGame playCard: cardArguments.

    self assert: (aGame isReversedAt: 4).
    self assert: spaceship1 cards size equals: 1.

    "Ahora removemos todas las cartas restantes"
    spaceship1 cards removeAll.
    self assert: spaceship1 cards size equals: 0.

    "Al caer en CardBox revertido sin cartas, no debe fallar"
    aGame playTurn.

    self assert: spaceship1 position equals: 4.
    self assert: spaceship1 cards size equals: 0.
]

{ #category : 'tests' }
GameTest >> test077RedoCanRepeatReversalEffect [
    | dices aDie cards aDeck boxes aBlackHole aBoard aGame cardArguments |

    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 3 with: 2).
    dices := OrderedCollection with: aDie.

    cards := {
        (1 -> Reversal).
        (2 -> Redo).
    } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    aBlackHole := BlackHole new.

    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        aBlackHole.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 2.

    "Spaceship 1 juega Reversal en posición 4"
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 4.

    aGame playCard: cardArguments.
    self assert: (aGame isReversedAt: 4).

    "Spaceship 1 tira 3, va a pos 4 (BlackHole revertido +4), termina en pos 8"
    aGame playTurn.
    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 8 with: 1).

    "Spaceship 2 juega Redo (repite Reversal en posición 7)"
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 2.
    cardArguments at: 'idCardToUse' put: 4.
    cardArguments at: 'targetPosition' put: 7.

    aGame playCard: cardArguments.
    self assert: (aGame isReversedAt: 4).
    self assert: (aGame isReversedAt: 7).

    "Spaceship 2 tira 2, va de pos 1 a pos 3"
    aGame playTurn.

    "Resultado final: Spaceship 1 en pos 8, Spaceship 2 en pos 3"
    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 8 with: 3).
]

{ #category : 'tests' }
GameTest >> test078RepeatWorksWithReversedBoxEffects [
    | dices aDie cards aDeck boxes aBlackHole aBoard aGame cardArguments |

    aDie := LoadedDie of: 10.
    aDie add: (OrderedCollection with: 3 with: 2).
    dices := OrderedCollection with: aDie.

    cards := {
        (1 -> Reversal).
        (2 -> Repeat).
    } asDictionary.
    aDeck := LoadedDeck createWith: cards.

    aBlackHole := BlackHole new.

    boxes := {
        NormalBox new.
        NormalBox new.
        NormalBox new.
        aBlackHole.
        NormalBox new.
        NormalBox new.
        NormalBox new.
        NormalBox new.
    } asOrderedCollection.

    aBoard := Board createWith: boxes.
    aGame := Game
        createWithNumberOfSpaceships: 2
        and: dices
        and: aDeck
        and: aBoard
        andLapsToWin: 2.

    "Spaceship 1 juega Reversal en posición 4"
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 1.
    cardArguments at: 'idCardToUse' put: 1.
    cardArguments at: 'targetPosition' put: 4.

    aGame playCard: cardArguments.
    self assert: (aGame isReversedAt: 4).

    "Spaceship 1 tira 3, cae en pos 4 (BlackHole revertido +4), termina en pos 8"
    aGame playTurn.
    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 8 with: 1).

    "Spaceship 2 juega Repeat para repetir el efecto del BlackHole revertido sobre sí mismo"
    cardArguments := Dictionary new.
    cardArguments at: 'idSpaceship' put: 2.
    cardArguments at: 'idCardToUse' put: 4.
    cardArguments at: 'idTargetSpaceship' put: 2.

    aGame playCard: cardArguments.

    "Spaceship 2 debe haber recibido el efecto de BlackHole revertido (+4)"
    self assert: aGame checkPositionsOfSpaceships equals: (OrderedCollection with: 8 with: 5).
]
