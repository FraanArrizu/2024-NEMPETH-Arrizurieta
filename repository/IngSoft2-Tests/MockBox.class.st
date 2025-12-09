Class {
	#name : 'MockBox',
	#superclass : 'Object',
	#instVars : [
		'normalEffectWasCalled'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
MockBox >> applyNormalEffect: spaceships and: actualSpaceship [
	normalEffectWasCalled := true
]

{ #category : 'initialization' }
MockBox >> initialize [ 
	super initialize .
	normalEffectWasCalled := false.
]

{ #category : 'accessing' }
MockBox >> normalEffectWasCalled [
	^normalEffectWasCalled
]
