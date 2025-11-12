Class {
	#name : 'BlackHole',
	#superclass : 'Box',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
BlackHole >> applyNormalEffect: spaceships and: actualSpaceship [
	actualSpaceship move: -4.
]

{ #category : 'as yet unclassified' }
BlackHole >> applyReversedEffect: spaceships and: actualSpaceship [
    | positionBefore positionAfter |
    positionBefore := actualSpaceship position.
    
    actualSpaceship move: 4.
    
    positionAfter := actualSpaceship position.
]
