Class {
	#name : #GtCrasherClassGenerator,
	#superclass : #Object,
	#instVars : [
		'numberConverter'
	],
	#category : #'GToolkit-Crasher'
}

{ #category : #private }
GtCrasherClassGenerator >> createClassPrefixed: aPrefix packaged: aPackageName index: aNumber [
	^ Object subclass: (self generateClassNamePrefix: aPrefix index: aNumber) asSymbol
		instanceVariableNames: self generateInstVars
		classVariableNames: ''
		package: aPackageName
]

{ #category : #generation }
GtCrasherClassGenerator >> createClassesPrefixed: aPrefix packaged: aPackageName amount: aClassCount [
	| aMethodGenerator theMethodPrefixes |
	
	aMethodGenerator := GtCrasherMethodGenerator new.
	theMethodPrefixes := self generateWords: 20.
	
	1 to: aClassCount do: [ :aClassIndex |
		| eachClass |
		
		eachClass := self createClassPrefixed: aPrefix packaged: aPackageName index: aClassIndex.
		1 to: (20 to: 200) atRandom do: [ :aMethodIndex |
			aMethodGenerator compileMethodNamed: theMethodPrefixes atRandom, (numberConverter convertToBase26: aMethodIndex) inClass: eachClass ] ]
]

{ #category : #private }
GtCrasherClassGenerator >> generateClassNamePrefix: aPrefix index: aNumber [
	^ aPrefix, (numberConverter convertToBase26: aNumber)
]

{ #category : #private }
GtCrasherClassGenerator >> generateInstVars [
	| aSet |
	aSet := self generateWords: 20 atRandom + 5.
	^ String streamContents: [:s | aSet do: [:each | s << each asString] separatedBy: [s << ' ']]
]

{ #category : #private }
GtCrasherClassGenerator >> generateWord [
	^ String streamContents: [ :aStream | (10 atRandom + 5) timesRepeat: [ aStream nextPut: Character alphabet atRandom ] ]
]

{ #category : #private }
GtCrasherClassGenerator >> generateWords: aNumber [
	^ ((1 to: aNumber) collect: [ :i | self generateWord ]) copyWithoutDuplicates
]

{ #category : #initialization }
GtCrasherClassGenerator >> initialize [
	super initialize.
	
	numberConverter := GtCrasherNumberConverter new
]
