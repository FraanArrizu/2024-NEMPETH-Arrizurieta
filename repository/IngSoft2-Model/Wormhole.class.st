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
    | movement isForwardWormhole |
    
    movement := self position - wormholeEnd position.
    isForwardWormhole := self position < wormholeEnd position.
    
    "Caso 1: Forward wormhole revertido con lap > 0 → lap anterior"
    (isForwardWormhole and: [ actualSpaceship lapsCompleted > 0 ]) ifTrue: [
        actualSpaceship subtractLap.
        actualSpaceship move: wormholeEnd position - actualSpaceship position.
        ^ self
    ].
    
    "Caso 2: Backward wormhole revertido → lap siguiente"
    isForwardWormhole ifFalse: [
        actualSpaceship addLap.
        actualSpaceship move: wormholeEnd position - actualSpaceship position.
        ^ self
    ].
    
    "Caso 3: Forward wormhole revertido con lap = 0 → movimiento simple"
    actualSpaceship move: movement.
]

{ #category : 'as yet unclassified' }
Wormhole >> associateWith: aWormhole [

	wormholeEnd := aWormhole
]
