Class {
	#name : #GtCrasherMethodGenerator,
	#superclass : #Object,
	#instVars : [
		'generators',
		'allProtocols'
	],
	#category : #'GToolkit-Crasher'
}

{ #category : #compiling }
GtCrasherMethodGenerator >> compileMethodNamed: aMethodName inClass: aClass [
	aClass compile: (self generateMethodSourceNamed: aMethodName inClass: aClass) classified: self generateProtocolName
]

{ #category : #'private - method types' }
GtCrasherMethodGenerator >> generateByteArray [
	| anArray |
	
	anArray := ByteArray new: ((20 to: 200) atRandom).
	1 to: anArray size do: [ :anIndex | anArray at: anIndex put: (255 atRandom) ].

	^ String streamContents: [ :aStream |
		aStream tab; nextPut: $^; space.
		aStream print: anArray ]
]

{ #category : #'private - method types' }
GtCrasherMethodGenerator >> generateComment [
	^ String streamContents: [ :aStream |
		aStream nextPut: $".
		aStream nextPutAll: (String loremIpsum: (20 to: 200) atRandom) trimBoth.
		aStream nextPut: $" ]
]

{ #category : #'private - method types' }
GtCrasherMethodGenerator >> generateInstVarGetter: aClass [
	^ String streamContents: [ :aStream |
		aStream tab; nextPut: $^; space; nextPutAll: aClass instVarNames atRandom asString ]
]

{ #category : #private }
GtCrasherMethodGenerator >> generateMethodSourceNamed: aName inClass: aClass [
	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: aName;
			nextPutAll: OSPlatform current lineEnding.
		
		#(true false) atRandom ifTrue: [
			aStream tab;
			nextPutAll: self generateComment;
			nextPutAll: OSPlatform current lineEnding ].
		
		aStream nextPutAll: (generators atRandom cull: aClass) ]
]

{ #category : #private }
GtCrasherMethodGenerator >> generateProtocolName [
	^ allProtocols atRandom
]

{ #category : #'private - method types' }
GtCrasherMethodGenerator >> generateString [
	^ String streamContents: [ :aStream |
		aStream tab; nextPut: $^; space; nextPut: $'.
		aStream nextPutAll: (String loremIpsum: (100 to: 1000) atRandom) trimBoth.
		aStream nextPut: $' ]
]

{ #category : #'private - method types' }
GtCrasherMethodGenerator >> generateSymbol [
	^ String streamContents: [ :aStream |
		aStream tab; nextPut: $^; space; nextPut: $#.
		(50 atRandom + 5) timesRepeat: [ aStream nextPut: Character alphabet atRandom ] ]
]

{ #category : #initialization }
GtCrasherMethodGenerator >> initialize [
	super initialize.

	generators := {
		[ self generateByteArray ].
		[ self generateString ].
		[ self generateSymbol ].
		[ :aClass | self generateInstVarGetter: aClass ] }.

	allProtocols := Smalltalk allClasses
		flatCollect: [ :aClass | 
			aClass organization allProtocols
				reject: [ :eachProtocol | 
					eachProtocol isExtensionProtocol
						or: [ eachProtocol isVirtualProtocol or: [ eachProtocol isEmpty ] ] ]
				thenCollect: #name ]
		as: Set
]
