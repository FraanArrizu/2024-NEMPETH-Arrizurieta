Class {
	#name : 'Wormhole',
	#superclass : 'Box',
	#instVars : [
		'wormholeEnd'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Wormhole >> applyNormalEffect: spaceships and: actualSpaceship [

	actualSpaceship move: wormholeEnd position - self position.
]

{ #category : 'as yet unclassified' }
Wormhole >> applyReversedEffect: spaceships and: actualSpaceship [
    actualSpaceship move: self position - wormholeEnd position.
]

{ #category : 'as yet unclassified' }
Wormhole >> associateWith: aWormhole [

	wormholeEnd := aWormhole
]
