Class {
	#name : 'Protector',
	#superclass : 'PermanentCard',
	#instVars : [
		'idOfProtectedSpaceship',
		'idOfProtectorSpaceship'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Protector >> applyCardEffect: aCardArguments and: aGame [
    | idOfSpaceshipAtTurn |
    
    idOfProtectedSpaceship := aCardArguments at: 'idSpaceship'.
    idOfProtectorSpaceship := aCardArguments at: 'idProtectorSpaceship'.
    idOfSpaceshipAtTurn := aGame getIdOfSpaceshipAtTurn.
    
    "Validación: no auto-protección"
    idOfProtectedSpaceship = idOfProtectorSpaceship ifTrue: [ 
        Error signal: 'A spaceship cannot protect itself'
    ].
    
    self permanentCardValidationWith: idOfProtectedSpaceship and: idOfSpaceshipAtTurn.
    
    aGame applyProtector: idOfProtectorSpaceship to: idOfProtectedSpaceship.
    aGame addPermanentCardPlayed: self
]

{ #category : 'as yet unclassified' }
Protector >> removeCardEffect: aCardCollection and: aGame [

    aGame removeProtector: idOfProtectorSpaceship from: idOfProtectedSpaceship.
    aGame removePermanentCardPlayed: self.
]
