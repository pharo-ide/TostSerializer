Class {
	#name : #BaselineOfTostSerializer,
	#superclass : #BaselineOf,
	#category : 'BaselineOfTostSerializer'
}

{ #category : #baselines }
BaselineOfTostSerializer >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'StateSpecs' with: [
				spec repository: 'github://dionisiydk/StateSpecs:v2.4.11'];
			baseline: 'ObjectTravel' with: [
				spec
					repository: 'github://pharo-ide/ObjectTravel:v0.6.6';
					loads: 'Core' ];
			project: 'ObjectTravelTests' copyFrom: 'ObjectTravel' with: [
				spec loads: 'Tests'].
		spec 
			package: 'TostSerializer' with: [ spec requires: #('ObjectTravel')];
			package: 'TostSerializer-Tests' with: [ spec requires: #('TostSerializer' 'StateSpecs' 'ObjectTravelTests')].
		spec 
			group: 'default' with: #('Core' 'Tests' );
			group: 'Core' with: #('TostSerializer' );
			group: 'Tests' with: #('TostSerializer-Tests' )]

]
