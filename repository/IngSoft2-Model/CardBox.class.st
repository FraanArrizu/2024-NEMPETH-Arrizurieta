Class {
	#name : 'CardBox',
	#superclass : 'Box',
	#instVars : [
		'deck'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardBox class >> createWith: aDeck [ 
	^ self new initializeWith: aDeck
]

{ #category : 'accessing' }
CardBox >> applyNormalEffect: spaceships and: actualSpaceship [

	| aCard |
	aCard := deck giveACard.

	actualSpaceship obtain: aCard
]

{ #category : 'as yet unclassified' }
CardBox >> applyReversedEffect: spaceships and: actualSpaceship [
    actualSpaceship cards ifNotEmpty: [
        | randomCard |
        randomCard := actualSpaceship cards atRandom.
        actualSpaceship removeThis: randomCard ].
]

{ #category : 'initialization' }
CardBox >> initializeWith: aDeck [ 
	deck := aDeck
]
