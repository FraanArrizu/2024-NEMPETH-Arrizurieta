Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Box',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
HyperSpaceJump >> applyNormalEffect: spaceships and: actualSpaceship [

	actualSpaceship move: 4.
	actualSpaceship updateShield: -1
]
