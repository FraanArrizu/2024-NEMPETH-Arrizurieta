Class {
	#name : 'NormalModifierTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
NormalModifierTest >> test001CanBeCreated [
    | modifier |
    
    modifier := NormalModifier new.
    
    self assert: (modifier isKindOf: NormalModifier).
]

{ #category : 'tests' }
NormalModifierTest >> test002RespondsToApplyEffectOf [
    | modifier |
    
    modifier := NormalModifier new.
    
    self assert: (modifier respondsTo: #applyEffectOf:on:and:).
]

{ #category : 'tests' }
NormalModifierTest >> test003testDelegatesToBoxNormalEffect [
    | modifier box |
    
    modifier := NormalModifier new.
    box := MockBox new.
    
    modifier applyEffectOf: box on: OrderedCollection new and: nil.
    
    self assert: box normalEffectWasCalled.
]
