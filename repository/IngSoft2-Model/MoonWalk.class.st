Class {
	#name : 'MoonWalk',
	#superclass : 'Box',
	#instVars : [
		'boxesToMove'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
MoonWalk class >> createWith: boxesToMoveBackward [

	^ self new initializeWith: boxesToMoveBackward.
]

{ #category : 'accessing' }
MoonWalk >> applyNormalEffect: spaceships and: actualSpaceship [

	spaceships do: [ :aSpaceship |
		aSpaceship position ~= 1 ifTrue: [
			aSpaceship move: -1 * boxesToMove ] ]
]

{ #category : 'as yet unclassified' }
MoonWalk >> applyReversedEffect: spaceships and: actualSpaceship [
    spaceships do: [ :aSpaceship |
        aSpaceship move: boxesToMove ].
]

{ #category : 'initialization' }
MoonWalk >> initializeWith: boxesToMoveBackward [

	boxesToMove := boxesToMoveBackward.
]
