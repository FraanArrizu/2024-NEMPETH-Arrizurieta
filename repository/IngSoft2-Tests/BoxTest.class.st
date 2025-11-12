Class {
	#name : 'BoxTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoxTest >> test001WhenSpaceshipIsOnBlackHoleBoxThenSpaceshipMovesBackFourBoxes [
	
	|actualSpaceship aSpaceship anotherSpaceship spaceships aBlackHole modifier|
	
	modifier := NormalModifier new.
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.
	spaceships := OrderedCollection new.
	spaceships add: aSpaceship; add: anotherSpaceship.
	
	aBlackHole := BlackHole new.
	aSpaceship move: 4.
	actualSpaceship := spaceships removeFirst.
	
	self assert: aSpaceship position equals: 5.
	self assert: anotherSpaceship position equals: 1.
	
	aBlackHole applyEffect: spaceships and: actualSpaceship through: modifier.
	
	self assert: aSpaceship position equals: 1.
	self assert: anotherSpaceship position equals: 1.
	
]

{ #category : 'tests' }
BoxTest >> test002WhenSpaceshipIsOnHyperSpaceJumpBoxThenSpaceshipMovesFourBoxesAndLosesOneShield [
	
	|aSpaceship anotherSpaceship spaceships aHyperSpaceJump actualSpaceship modifier|
	
	modifier := NormalModifier new.
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.
	spaceships := OrderedCollection new.
	spaceships add: aSpaceship; add: anotherSpaceship.
	
	aHyperSpaceJump := HyperSpaceJump new.
	actualSpaceship := spaceships removeFirst.
	
	self assert: aSpaceship position equals: 1.
	self assert: aSpaceship shield equals: 3.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship shield equals: 3.
	
	aHyperSpaceJump applyEffect: spaceships and: actualSpaceship through: modifier.
	
	self assert: aSpaceship position equals: 5.
	self assert: aSpaceship shield equals: 2.
	self assert: anotherSpaceship position equals: 1.
	self assert: anotherSpaceship shield equals: 3.
	
]

{ #category : 'tests' }
BoxTest >> test003WhenSpaceshipIsOnAtomicBombBoxThenAllSpaceshipMoveToPositionOneAndLoseOneShield [
	
	|spaceshipOne spaceshipTwo spaceshipThree spaceships aAtomicBomb actualSpaceship modifier|
	
	modifier := NormalModifier new.
	spaceshipOne := Spaceship createWithId: 1.
	spaceshipTwo := Spaceship createWithId: 2.
	spaceshipThree := Spaceship createWithId: 3.
	
	spaceships := OrderedCollection new.
	spaceships add: spaceshipOne; add: spaceshipTwo;add:spaceshipThree.
	
	aAtomicBomb := AtomicBomb new.
	
	spaceshipOne move: 4.
	spaceshipTwo move: 2.
	
	self assert: spaceshipOne position equals: 5.
	self assert: spaceshipOne shield equals: 3.
	self assert: spaceshipTwo position equals: 3.
	self assert: spaceshipTwo shield equals: 3.
	self assert: spaceshipThree position equals: 1.
	self assert: spaceshipThree shield equals: 3.
	
	actualSpaceship := spaceships removeFirst.
	aAtomicBomb applyEffect: spaceships and: actualSpaceship through: modifier.
	
	self assert: spaceshipOne position equals: 1.
	self assert: spaceshipOne shield equals: 2.
	self assert: spaceshipTwo position equals: 1.
	self assert: spaceshipTwo shield equals: 2.
	self assert: spaceshipThree position equals: 1.
	self assert: spaceshipThree shield equals: 2.
	
]

{ #category : 'tests' }
BoxTest >> test004WhenSpaceshipIsOnMoonWalkThenTheOtherSpaceshipsMovesBackTwoPositionsExceptForTheOnesOnTheSafeZone [
	
	|spaceshipOne spaceshipTwo spaceshipThree spaceships aMoonWalk actualSpaceship modifier|
	
	modifier := NormalModifier new.
	spaceshipOne := Spaceship createWithId: 1.
	spaceshipTwo := Spaceship createWithId: 2.
	spaceshipThree := Spaceship createWithId: 3.
	
	spaceships := OrderedCollection new.
	spaceships add: spaceshipOne; add: spaceshipTwo;add:spaceshipThree.
	
	aMoonWalk := MoonWalk createWith: 2.
	actualSpaceship := spaceships removeFirst.
		
	spaceshipOne move: 4.
	spaceshipTwo move: 2.
	
	self assert: spaceshipOne position equals: 5.
	self assert: spaceshipTwo position equals: 3.
	self assert: spaceshipThree position equals: 1.

	aMoonWalk applyEffect: spaceships and: actualSpaceship through: modifier.
	
	self assert: spaceshipOne position equals: 5.
	self assert: spaceshipTwo position equals: 1.
	self assert: spaceshipThree position equals: 1.
	
]

{ #category : 'tests' }
BoxTest >> test005WhenASpaceshipIsOnHyperJumpThenSpaceshipMovesASelectedAmountOfParsecs [
	
	|spaceshipOne spaceshipTwo spaceshipThree spaceships aHyperJump parsecOne lightYearOne lightYearTwo modifier |
	
	modifier := NormalModifier new.
	spaceshipOne := Spaceship createWithId: 1.
	spaceshipTwo := Spaceship createWithId: 2.
	spaceshipThree := Spaceship createWithId: 3.
	
	spaceships := OrderedCollection new.
	spaceships add: spaceshipOne; add: spaceshipTwo;add:spaceshipThree.

	aHyperJump := LoadedHyperJump createWith: 3 andParsecsToBoxesRatio: 2.
	parsecOne := Parsec createWith: 6.
	lightYearOne := LightYear createWith: 12.
	lightYearTwo := LightYear createWith: 9.
	aHyperJump addParsecs: (OrderedCollection with: parsecOne with: lightYearOne with: lightYearTwo).

	spaceshipOne move: 4.
	spaceshipTwo move: 2.
	
	self assert: spaceshipOne position equals: 5.
	self assert: spaceshipTwo position equals: 3.

	aHyperJump applyNormalEffect: spaceships and: spaceshipOne.
	aHyperJump applyNormalEffect: spaceships and: spaceshipTwo.

	self assert: spaceshipOne position equals: 8.
	self assert: spaceshipTwo position equals: 5.
]

{ #category : 'tests' }
BoxTest >> test006WhenAmountOfEffectsAppliedAreMoreThanCollectionOfParsecsThenStartFromBeginning [
	
	|spaceshipOne spaceshipTwo spaceshipThree spaceships aHyperJump parsecOne lightYearOne |
	
	spaceshipOne := Spaceship createWithId: 1.
	spaceshipTwo := Spaceship createWithId: 2.
	spaceshipThree := Spaceship createWithId: 3.
	
	spaceships := OrderedCollection new.
	spaceships add: spaceshipOne; add: spaceshipTwo;add:spaceshipThree.

	aHyperJump := LoadedHyperJump createWith: 2 andParsecsToBoxesRatio: 2.
	parsecOne := Parsec createWith: 4.
	lightYearOne := LightYear createWith: 6.
	aHyperJump addParsecs: (OrderedCollection with: parsecOne with: lightYearOne).

	spaceshipOne move: 1.
	spaceshipTwo move: 1.
	spaceshipThree move: 1.
	
	self assert: spaceshipOne position equals: 2.
	self assert: spaceshipTwo position equals: 2.
	self assert: spaceshipThree position equals: 2.

	aHyperJump applyNormalEffect: spaceships and: spaceshipOne.
	aHyperJump applyNormalEffect: spaceships and: spaceshipTwo.
	aHyperJump applyNormalEffect: spaceships and: spaceshipThree.
	
	self assert: spaceshipOne position equals: 4.
	self assert: spaceshipTwo position equals: 3.
	self assert: spaceshipThree position equals: 4.
	
]

{ #category : 'tests' }
BoxTest >> test007VerifyCorrectCreationOfHyperJumpBox [

	| aHyperJump sortedColletion |
	
	aHyperJump := HyperJump createWith: 40 andParsecsToBoxesRatio: 2.

	self assert: aHyperJump units size <= 10.
	self assert: (aHyperJump units anySatisfy: [ :each | each toParsec <= (40 * 0.8) ]).

	sortedColletion := aHyperJump units sort: [ :a :b | a toParsec > b toParsec ].

	self assert: aHyperJump units equals: sortedColletion.
]

{ #category : 'tests' }
BoxTest >> test008WhenHyperJumpApplyEffectThenSpaceshipIsMoveBetweenOneAndTwentyBoxes [

	| aHyperJump spaceships aSpaceship anotherSpaceship actualSpaceship modifier|
	
	modifier := NormalModifier new.
	aSpaceship := Spaceship createWithId: 1.
	anotherSpaceship := Spaceship createWithId: 2.
	spaceships := OrderedCollection with: aSpaceship with: anotherSpaceship.
	actualSpaceship := spaceships removeFirst.
	
	aHyperJump := HyperJump createWith: 40 andParsecsToBoxesRatio: 2.
	
	aHyperJump applyEffect: spaceships and: actualSpaceship through: modifier. 

	self assert: ((aSpaceship position) between: 2 and: 21).
	self assert: anotherSpaceship position equals: 1.	
]

{ #category : 'tests' }
BoxTest >> test009WhenCardBoxApplyEffectThenSpaceshipAddACardOnItsPrivateDeck [
    
    | cards aDeck aCardBox spaceships aSpaceship anotherSpaceship actualSpaceship modifier |
    modifier := NormalModifier new.
    aSpaceship := Spaceship createWithId: 1.
    anotherSpaceship := Spaceship createWithId: 2.
    spaceships := OrderedCollection with: aSpaceship with: anotherSpaceship.
    actualSpaceship := spaceships removeFirst.

	cards := {
        1 -> Acceleration.
        2 -> Speed.
    } asDictionary.
	aDeck := LoadedDeck createWith: cards.
    
    aCardBox := CardBox createWith: aDeck.
    aCardBox applyEffect: spaceships and: actualSpaceship through: modifier. 
    
    self assert: (actualSpaceship cards size) equals: 1.
    
    aCardBox applyEffect: spaceships and: actualSpaceship through: modifier. 
    aCardBox applyEffect: spaceships and: actualSpaceship through: modifier. 
    
    self assert: (actualSpaceship cards size) equals: 3.
]

{ #category : 'tests' }
BoxTest >> test010HasApplyNormalEffectMethod [
    | box |
    
    box := NormalBox new.
    
    self assert: (box respondsTo: #applyNormalEffect:and:).
]

{ #category : 'tests' }
BoxTest >> test011BoxHasApplyReversedEffectDefault [
    | box modifier spaceships actualSpaceship |
    
    box := NormalBox new.
    modifier := ReversalModifier new.
    spaceships := OrderedCollection new.
    actualSpaceship := Spaceship createWithId: 1.
    
    "NormalBox no tiene efecto, ni normal ni revertido"
    box applyEffect: spaceships and: actualSpaceship through: modifier.
    
    self assert: actualSpaceship position equals: 1.
]

{ #category : 'tests' }
BoxTest >> test012BlackHoleReversedMovesForward [
    | blackHole modifier spaceships actualSpaceship |
    
    blackHole := BlackHole new.
    modifier := ReversalModifier new.
    spaceships := OrderedCollection new.
    actualSpaceship := Spaceship createWithId: 1.
    actualSpaceship move: 10.
    
    blackHole applyEffect: spaceships and: actualSpaceship through: modifier.
    
    "BlackHole revertido: mueve +4 en vez de -4"
    self assert: actualSpaceship position equals: 15.  "11 + 4"
]

{ #category : 'tests' }
BoxTest >> test013MoonWalkReversedMovesAllSpaceshipsForward [
    | moonWalk modifier spaceships spaceship1 spaceship2 actualSpaceship |
    
    moonWalk := MoonWalk createWith: 3.
    modifier := ReversalModifier new.
    
    spaceship1 := Spaceship createWithId: 1.
    spaceship2 := Spaceship createWithId: 2.
    actualSpaceship := Spaceship createWithId: 3.
    
    spaceship1 move: 5.
    spaceship2 move: 8.
    actualSpaceship move: 10.
    
    spaceships := OrderedCollection with: spaceship1 with: spaceship2.
    
    moonWalk applyEffect: spaceships and: actualSpaceship through: modifier.
    
    "MoonWalk revertido: mueve todas +3 en vez de -3"
    self assert: spaceship1 position equals: 9.   "6 + 3"
    self assert: spaceship2 position equals: 12.  "9 + 3"
]

{ #category : 'tests' }
BoxTest >> test014WormholeReversedMovesInOppositeDirection [
    | wormholeStart wormholeEnd modifier spaceships actualSpaceship |
    
    wormholeStart := Wormhole new.
    wormholeEnd := Wormhole new.
    wormholeStart associateWith: wormholeEnd.
    wormholeEnd associateWith: wormholeStart.
    
    "wormholeStart esta en pos 3 y wormholeEnd en pos 8"
    wormholeStart position: 3.
    wormholeEnd position: 8.
    
    modifier := ReversalModifier new.
    spaceships := OrderedCollection new.
    actualSpaceship := Spaceship createWithId: 1.
    actualSpaceship move: 2.  "pos 3 (donde esta wormholeStart)"
    
    wormholeStart applyEffect: spaceships and: actualSpaceship through: modifier.
    
    "Wormhole normal: 3 → 8 (move: 8-3 = +5)"
    "Wormhole revertido: 8 → 3 (move: 3-8 = -5)"
    "Desde pos 3, revertido deberia NO moverse (o ir a inicio)"
    
    "Ajustamos: revertido va en dirección opuesta"
    self assert: actualSpaceship position equals: -2.  "3 + (3-8) = 3 - 5 = -2"
]

{ #category : 'tests' }
BoxTest >> test015AtomicBombReversedBehavesLikeNormal [
    | atomicBomb normalModifier reversalModifier spaceships1 spaceships2 spaceship1 spaceship2 actualSpaceship1 actualSpaceship2 |
    
    spaceship1 := Spaceship createWithId: 1.
    spaceship1 move: 10.
    spaceship1 updateShield: 2.
    
    spaceship2 := Spaceship createWithId: 1.
    spaceship2 move: 10.
    spaceship2 updateShield: 2.
    
    actualSpaceship1 := Spaceship createWithId: 2.
    actualSpaceship2 := Spaceship createWithId: 2.
    
    spaceships1 := OrderedCollection with: spaceship1.
    spaceships2 := OrderedCollection with: spaceship2.
    
    atomicBomb := AtomicBomb new.
    normalModifier := NormalModifier new.
    reversalModifier := ReversalModifier new.
    
    atomicBomb applyEffect: spaceships1 and: actualSpaceship1 through: normalModifier.
    
    atomicBomb applyEffect: spaceships2 and: actualSpaceship2 through: reversalModifier.
    
    "AtomicBomb NO se revierte: mismo efecto"
    self assert: spaceship1 position equals: spaceship2 position.
    self assert: spaceship1 shield equals: spaceship2 shield.
    self assert: actualSpaceship1 position equals: actualSpaceship2 position.
    self assert: actualSpaceship1 shield equals: actualSpaceship2 shield.
]

{ #category : 'tests' }
BoxTest >> test016CardBoxReversedDiscardsRandomCard [
    | cards aDeck aCardBox spaceships aSpaceship anotherSpaceship actualSpaceship normalModifier reversalModifier |
    
    aSpaceship := Spaceship createWithId: 1.
    anotherSpaceship := Spaceship createWithId: 2.
    spaceships := OrderedCollection with: aSpaceship with: anotherSpaceship.
    actualSpaceship := spaceships removeFirst.

    cards := {
        1 -> Acceleration.
        2 -> Speed.
        3 -> Repeat.
    } asDictionary.
    aDeck := LoadedDeck createWith: cards.
    
    aCardBox := CardBox createWith: aDeck.
    normalModifier := NormalModifier new.
    reversalModifier := ReversalModifier new.
    
    aCardBox applyEffect: spaceships and: actualSpaceship through: normalModifier.
    aCardBox applyEffect: spaceships and: actualSpaceship through: normalModifier.
    aCardBox applyEffect: spaceships and: actualSpaceship through: normalModifier.
    
    self assert: actualSpaceship cards size equals: 3.
    
    aCardBox applyEffect: spaceships and: actualSpaceship through: reversalModifier.
    
    self assert: actualSpaceship cards size equals: 2.
]

{ #category : 'tests' }
BoxTest >> test017LoadedHyperJumpReversedMovesBackward [
    | hyperJump normalModifier reversalModifier actualSpaceship1 actualSpaceship2 parsec |
    
    parsec := Parsec createWith: 6.
    
    hyperJump := LoadedHyperJump createWith: 1 andParsecsToBoxesRatio: 2.
    hyperJump addParsecs: (OrderedCollection with: parsec).
    
    normalModifier := NormalModifier new.
    reversalModifier := ReversalModifier new.
    
    actualSpaceship1 := Spaceship createWithId: 1.
    actualSpaceship1 move: 4.
    
    actualSpaceship2 := Spaceship createWithId: 2.
    actualSpaceship2 move: 4.
    
    "Normal: 6 parsecs / 2 = 3 boxes → pos 8"
    hyperJump applyEffect: OrderedCollection new and: actualSpaceship1 through: normalModifier.
    self assert: actualSpaceship1 position equals: 8.
    
    "Revertido: -3 boxes → pos 2"
    hyperJump applyEffect: OrderedCollection new and: actualSpaceship2 through: reversalModifier.
    self assert: actualSpaceship2 position equals: 2.
]

{ #category : 'tests' }
BoxTest >> test018HyperSpaceJumpReversedMovesBackwardAndGainsShield [
    | hyperSpaceJump normalModifier reversalModifier actualSpaceship1 actualSpaceship2 |
    
    hyperSpaceJump := HyperSpaceJump new.
    normalModifier := NormalModifier new.
    reversalModifier := ReversalModifier new.
    
    actualSpaceship1 := Spaceship createWithId: 1.
    actualSpaceship1 move: 10.
    "Shield inicial: 3"
    
    actualSpaceship2 := Spaceship createWithId: 2.
    actualSpaceship2 move: 10.
    "Shield inicial: 3"
    
    "Normal: +4 movimiento, -1 shield → pos 15, shield 2 (3 - 1)"
    hyperSpaceJump applyEffect: OrderedCollection new and: actualSpaceship1 through: normalModifier.
    self assert: actualSpaceship1 position equals: 15.
    self assert: actualSpaceship1 shield equals: 2.
    
    "Revertido: -4 movimiento, +1 shield → pos 7, shield 4 (3 + 1)"
    hyperSpaceJump applyEffect: OrderedCollection new and: actualSpaceship2 through: reversalModifier.
    self assert: actualSpaceship2 position equals: 7.
    self assert: actualSpaceship2 shield equals: 4.
]
