Class {
	#name : 'Box',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Box >> applyEffect: spaceships and: actualSpaceship through: aModifier [

	aModifier applyEffectOf: self on: spaceships and: actualSpaceship.
]

{ #category : 'as yet unclassified' }
Box >> applyNormalEffect: spaceships and: actualSpaceship [
    self subclassResponsibility.
]

{ #category : 'accessing' }
Box >> position [

	^ position
]

{ #category : 'accessing' }
Box >> position: aPosition [

	position := aPosition
]
