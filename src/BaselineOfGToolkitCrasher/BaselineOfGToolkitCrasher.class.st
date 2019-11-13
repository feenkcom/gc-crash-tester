Class {
	#name : #BaselineOfGToolkitCrasher,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitCrasher
}

{ #category : #baselines }
BaselineOfGToolkitCrasher >> baseline: spec [
	<baseline>
	spec for: #'common' do: [ spec package: 'GToolkit-Crasher' ].
]
