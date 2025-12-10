Class {
	#name : 'AtomicBomb',
	#superclass : 'Box',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
AtomicBomb >> applyNormalEffect: spaceships and: actualSpaceship [

	spaceships do: [ :aSpaceship |
		aSpaceship position ~= 1 ifTrue: [
			aSpaceship move:  -1 * aSpaceship position + 1.
			 ].
		aSpaceship updateShield:  -1].
		

	actualSpaceship move: -1 * actualSpaceship position + 1.
	actualSpaceship updateShield: -1
]

{ #category : 'as yet unclassified' }
AtomicBomb >> applyReversedEffect: spaceships and: actualSpaceship [
	self applyNormalEffect: spaceships and: actualSpaceship
]
