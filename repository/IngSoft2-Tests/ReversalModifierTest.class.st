Class {
	#name : 'ReversalModifierTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ReversalModifierTest >> test001ReversalModifierCanBeCreated [
    | modifier |
    
    modifier := ReversalModifier new.
    
    self assert: (modifier isKindOf: ReversalModifier).
]

{ #category : 'tests' }
ReversalModifierTest >> test002RespondsToApplyEffectOf [
    | modifier |
    
    modifier := ReversalModifier new.
    
    self assert: (modifier respondsTo: #applyEffectOf:on:and:).
]
