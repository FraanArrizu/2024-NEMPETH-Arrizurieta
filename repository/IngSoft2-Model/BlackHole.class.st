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
