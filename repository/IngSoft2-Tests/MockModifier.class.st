Class {
	#name : 'MockModifier',
	#superclass : 'Object',
	#instVars : [
		'applyEffectOfWasCalled'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
MockModifier >> applyEffectOf: aBox on: spaceships and: actualSpaceship [
    applyEffectOfWasCalled := true.
]

{ #category : 'accessing' }
MockModifier >> applyEffectOfWasCalled [
    ^ applyEffectOfWasCalled
]

{ #category : 'initialization' }
MockModifier >> initialize [ 
	super initialize.
	applyEffectOfWasCalled := false
]
