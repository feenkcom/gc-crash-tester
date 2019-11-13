"
GtCrasherClassGenerator new
  createClassesPrefixed: 'GtCrasherGenerated'
  packaged: 'GToolkit-CrasherGenerated'
  amount: 1
"
Class {
	#name : #GtCrasherClassGenerator,
	#superclass : #Object,
	#instVars : [
		'numberConverter',
		'words',
		'instVars'
	],
	#category : #'GToolkit-Crasher'
}

{ #category : #private }
GtCrasherClassGenerator >> createClassPrefixed: aPrefix packaged: aPackageName index: aNumber [
	| aClassName |
	
	aClassName := (self generateClassNamePrefix: aPrefix index: aNumber) asSymbol.
	self class environment
		at: aClassName
		ifPresent: [ ^ nil ].

	^ Object subclass: (self generateClassNamePrefix: aPrefix index: aNumber) asSymbol
		instanceVariableNames: self pickInstVars
		classVariableNames: ''
		package: aPackageName
]

{ #category : #generation }
GtCrasherClassGenerator >> createClassesPrefixed: aPrefix packaged: aPackageName amount: aClassCount [
	| aMethodGenerator theMethodPrefixes |
	
	EpMonitor current disable.
	[ 
	
		aMethodGenerator := GtCrasherMethodGenerator new.
		theMethodPrefixes := self pickWords: 50.
		
		(1 to: aClassCount) do:[ :aClassIndex | 
			| eachClass |
			
			eachClass := self createClassPrefixed: aPrefix packaged: aPackageName index: aClassIndex.
			eachClass ifNotNil: [
				1 to: (20 to: 200) atRandom do: [ :aMethodIndex |
					| aMethodName |
					
					aMethodName := String streamContents: [ :aStream | aStream nextPutAll: theMethodPrefixes atRandom; nextPutAll: (numberConverter convertToBase26: aMethodIndex) ].
					aMethodGenerator compileMethodNamed: aMethodName inClass: eachClass ] ] ]
		displayingProgress:[ :aClassIndex | 'Generating class {1} out of {2}' format: { aClassIndex . aClassCount } ]

	] ensure: [ EpMonitor current enable ]
]

{ #category : #private }
GtCrasherClassGenerator >> generateClassNamePrefix: aPrefix index: aNumber [
	^ String streamContents: [ :aStream | aStream nextPutAll: aPrefix; nextPutAll: (numberConverter convertToBase26: aNumber) ]
]

{ #category : #initialization }
GtCrasherClassGenerator >> generateInstVars [
	| aSet |
	aSet := self generateWords: 20 atRandom + 5.
	^ String streamContents: [:s | aSet do: [:each | s << each asString] separatedBy: [s << ' ']]
]

{ #category : #initialization }
GtCrasherClassGenerator >> generateWord [
	^ String streamContents: [ :aStream | (10 atRandom + 5) timesRepeat: [ aStream nextPut: Character alphabet atRandom ] ]
]

{ #category : #initialization }
GtCrasherClassGenerator >> generateWords: aNumber [
	^ ((1 to: aNumber) collect: [ :i | self generateWord ]) copyWithoutDuplicates
]

{ #category : #initialization }
GtCrasherClassGenerator >> initialize [
	super initialize.
	
	numberConverter := GtCrasherNumberConverter default.

	words := self generateWords: 50000.
	instVars := (1 to: 10000) collect: [ :i | self generateInstVars ]
]

{ #category : #generation }
GtCrasherClassGenerator >> pickInstVars [
	^ instVars atRandom
]

{ #category : #generation }
GtCrasherClassGenerator >> pickWords: anAmount [
	^ ((1 to: anAmount) collect: [ :i | words atRandom ]) copyWithoutDuplicates
]
