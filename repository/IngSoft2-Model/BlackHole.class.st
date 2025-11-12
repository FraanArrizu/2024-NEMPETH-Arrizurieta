Class {
	#name : 'BlackHole',
	#superclass : 'Box',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
BlackHole >> applyNormalEffect: spaceships and: actualSpaceship [
	Transcript show: 'BlackHole applyNormalEffect'; cr.
	actualSpaceship move: -4.
]

{ #category : 'as yet unclassified' }
BlackHole >> applyReversedEffect: spaceships and: actualSpaceship [
    | positionBefore positionAfter |
    positionBefore := actualSpaceship position.
    Transcript show: 'BlackHole reversed: posición ANTES = ', positionBefore asString; cr.
    
    actualSpaceship move: 4.
    
    positionAfter := actualSpaceship position.
    Transcript show: 'BlackHole reversed: posición DESPUÉS = ', positionAfter asString; cr.
    Transcript show: 'Movimiento: ', (positionAfter - positionBefore) asString; cr.
]
