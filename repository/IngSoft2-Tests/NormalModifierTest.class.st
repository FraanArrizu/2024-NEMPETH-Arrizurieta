Class {
	#name : 'NormalModifierTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
NormalModifierTest >> test001WhenNormalModifierIsCreatedThenIsInstanceOfNormalModifier [
    | modifier |
    
    modifier := NormalModifier new.
    
    self assert: (modifier isKindOf: NormalModifier).
]

{ #category : 'tests' }
NormalModifierTest >> test002WhenNormalModifierIsCreatedThenRespondsToApplyEffectOf [
    | modifier |
    
    modifier := NormalModifier new.
    
    self assert: (modifier respondsTo: #applyEffectOf:on:and:).
]

{ #category : 'tests' }
NormalModifierTest >> test003WhenNormalModifierIsAppliedThenDelegatesToBoxNormalEffect [
    | modifier box |
    
    modifier := NormalModifier new.
    box := MockBox new.
    
    modifier applyEffectOf: box on: OrderedCollection new and: nil.
    
    self assert: box normalEffectWasCalled.
]

{ #category : 'tests' }
NormalModifierTest >> test004WhenBoxIsCreatedThenRespondsToApplyEffectThrough [
    | box |
    
    box := NormalBox new.
    
    self assert: (box respondsTo: #applyEffect:and:through:).
]

{ #category : 'tests' }
NormalModifierTest >> test005WhenBoxAppliesEffectThroughModifierThenDelegatesToModifier [
    | box modifier |
    
    box := NormalBox new.
    modifier := MockModifier new.
    
    box applyEffect: OrderedCollection new and: nil through: modifier.
    
    self assert: modifier applyEffectOfWasCalled.
]
