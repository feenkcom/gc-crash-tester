Class {
	#name : #GtCrasherMethodGeneratorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Crasher'
}

{ #category : #examples }
GtCrasherMethodGeneratorExamples >> generateByteArray [
	<gtExample>
	
	^ GtCrasherMethodGenerator new generateByteArray
]

{ #category : #examples }
GtCrasherMethodGeneratorExamples >> generateComment [
	<gtExample>
	
	^ GtCrasherMethodGenerator new generateComment
]

{ #category : #examples }
GtCrasherMethodGeneratorExamples >> generateInstVarGetter [
	<gtExample>
	
	^ GtCrasherMethodGenerator new generateInstVarGetter: Morph
]

{ #category : #examples }
GtCrasherMethodGeneratorExamples >> generateMethodSourceNamedInClass [
	<gtExample>
	
	^ GtCrasherMethodGenerator new generateMethodSourceNamed: 'methodName' inClass: Morph
]

{ #category : #examples }
GtCrasherMethodGeneratorExamples >> generateString [
	<gtExample>
	
	^ GtCrasherMethodGenerator new generateString
]

{ #category : #examples }
GtCrasherMethodGeneratorExamples >> generateSymbol [
	<gtExample>
	
	^ GtCrasherMethodGenerator new generateSymbol
]
