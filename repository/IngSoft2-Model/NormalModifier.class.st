Class {
	#name : 'NormalModifier',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
NormalModifier >> applyEffectOf: aBox on: spaceships and: actualSpaceship [
    aBox applyNormalEffect: spaceships and: actualSpaceship.
]
