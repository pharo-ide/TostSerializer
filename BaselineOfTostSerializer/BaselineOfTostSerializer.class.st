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
				spec repository: 'github://dionisiydk/StateSpecs:v3.0.0'];
			baseline: 'ObjectTravel' with: [
				spec
					repository: 'github://pharo-ide/ObjectTravel:v1.0.0';
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
