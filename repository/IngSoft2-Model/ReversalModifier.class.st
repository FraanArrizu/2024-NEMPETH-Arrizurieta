Class {
	#name : 'ReversalModifier',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
ReversalModifier >> applyEffectOf: aBox on: spaceships and: actualSpaceship [
    aBox applyReversedEffect: spaceships and: actualSpaceship.
]
