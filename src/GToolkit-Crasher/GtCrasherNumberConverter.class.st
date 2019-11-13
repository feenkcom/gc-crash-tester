Class {
	#name : #GtCrasherNumberConverter,
	#superclass : #Object,
	#instVars : [
		'alphabet',
		'size',
		'numberConverter'
	],
	#category : #'GToolkit-Crasher'
}

{ #category : #converting }
GtCrasherNumberConverter >> convertToBase26: aNumber [
	<return: #String>
	
	^ String streamContents: [ :aStream | self convertToBase26: aNumber on: aStream ]
]

{ #category : #private }
GtCrasherNumberConverter >> convertToBase26: aNumber on: aStream [
	<return: #String>
	| aDiv aRest |
	
	aNumber <= size
		ifTrue: [ ^ aStream nextPut: (alphabet at: aNumber) ].
		
	aDiv := aNumber // size.
	aRest := aNumber % size.
	aRest isZero
		ifTrue: [
			aDiv := aDiv - 1.
			aRest := size ].

	self convertToBase26: aDiv on: aStream.
	self convertToBase26: aRest on: aStream
]

{ #category : #initialization }
GtCrasherNumberConverter >> initialize [
	super initialize.
	
	alphabet := Character alphabet asUppercase.
	size := alphabet size.
]
