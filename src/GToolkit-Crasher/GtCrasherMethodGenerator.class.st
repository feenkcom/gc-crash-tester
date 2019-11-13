Class {
	#name : #GtCrasherMethodGenerator,
	#superclass : #Object,
	#instVars : [
		'generators',
		'allProtocols',
		'byteArrays',
		'strings',
		'symbols',
		'comments'
	],
	#category : #'GToolkit-Crasher'
}

{ #category : #compiling }
GtCrasherMethodGenerator >> compileMethodNamed: aMethodName inClass: aClass [
	aClass compile: (self generateMethodSourceNamed: aMethodName inClass: aClass) classified: self pickProtocolName
]

{ #category : #initialization }
GtCrasherMethodGenerator >> generateByteArray [
	^ String streamContents: [ :aStream |
		| anArray |
	
		anArray := ByteArray new: ((20 to: 200) atRandom).
		1 to: anArray size do: [ :anIndex | anArray at: anIndex put: (255 atRandom) ].

		aStream tab; nextPut: $^; space.
		aStream print: anArray ]
]

{ #category : #initialization }
GtCrasherMethodGenerator >> generateComment [
	^ String streamContents: [ :aStream |
		aStream nextPut: $".
		aStream nextPutAll: (String loremIpsum: (20 to: 200) atRandom) trimBoth.
		aStream nextPut: $" ]
]

{ #category : #private }
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
			nextPutAll: self pickComment;
			nextPutAll: OSPlatform current lineEnding ].
		
		aStream nextPutAll: (generators atRandom cull: aClass) ]
]

{ #category : #initialization }
GtCrasherMethodGenerator >> generateString [
	^ String streamContents: [ :aStream |
		aStream tab; nextPut: $^; space; nextPut: $'.
		aStream nextPutAll: (String loremIpsum: (100 to: 1000) atRandom) trimBoth.
		aStream nextPut: $' ]
]

{ #category : #initialization }
GtCrasherMethodGenerator >> generateSymbol [
	^ String streamContents: [ :aStream |
		aStream tab; nextPut: $^; space; nextPut: $#.
		(50 atRandom + 5) timesRepeat: [ aStream nextPut: Character alphabet atRandom ] ]
]

{ #category : #initialization }
GtCrasherMethodGenerator >> initialize [
	super initialize.

	byteArrays := (1 to: 1000) collect: [ :i | self generateByteArray ].
	strings := (1 to: 1000) collect: [ :i | self generateString ].
	symbols := (1 to: 1000) collect: [ :i | self generateSymbol ].
	comments := (1 to: 1000) collect: [ :i | self generateComment ].

	generators := {
		[ self pickByteArray ].
		[ self pickString ].
		[ self pickSymbol ].
		[ :aClass | self generateInstVarGetter: aClass ] }.

	allProtocols := (Smalltalk allClasses
		flatCollect: [ :aClass | 
			aClass organization allProtocols
				reject: [ :eachProtocol | 
					eachProtocol isExtensionProtocol
						or: [ eachProtocol isVirtualProtocol or: [ eachProtocol isEmpty ] ] ]
				thenCollect: #name ]
		as: Set) asArray
]

{ #category : #private }
GtCrasherMethodGenerator >> pickByteArray [
	^ byteArrays atRandom
]

{ #category : #private }
GtCrasherMethodGenerator >> pickComment [
	^ comments atRandom
]

{ #category : #private }
GtCrasherMethodGenerator >> pickProtocolName [
	^ allProtocols atRandom
]

{ #category : #private }
GtCrasherMethodGenerator >> pickString [
	^ strings atRandom
]

{ #category : #private }
GtCrasherMethodGenerator >> pickSymbol [
	^ symbols atRandom
]
