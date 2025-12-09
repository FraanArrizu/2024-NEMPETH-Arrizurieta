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
    self permanentCardValidationWith: idOfProtectedSpaceship and: idOfSpaceshipAtTurn.
    
    aGame applyProtector: idOfProtectorSpaceship to: idOfProtectedSpaceship.
    aGame addPermanentCardPlayed: self.
]
