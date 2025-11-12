Class {
	#name : 'Reversal',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Reversal >> applyCardEffect: aCardArguments and: aGame [
    | targetPosition |
    targetPosition := aCardArguments at: 'targetPosition'.
    
    (targetPosition < 1 or: [ targetPosition > aGame getBoardSize ]) ifTrue: [
        Error signal: 'Invalid position for Reversal card' ].
    
    aGame addReversal: self at: targetPosition.
    aGame addPermanentCardPlayed: self.
]

{ #category : 'removing' }
Reversal >> removeCardEffect: aCardCollection and: aGame [ 
    aGame removeReversal: self.
    aGame removePermanentCardPlayed: self.
]
