Class {
	#name : #TostMaterializationTests,
	#superclass : #TostTransporterTestCase,
	#instVars : [
		'materializer',
		'binaryData'
	],
	#category : 'TostSerializer-Tests'
}

{ #category : #helpers }
TostMaterializationTests >> binaryData: aByteArray [
	
	binaryData := aByteArray asByteArray.
	materializer dataStream: binaryData readStream
]

{ #category : #helpers }
TostMaterializationTests >> serialize: anObject [
	
	self serializeAll: {anObject}
]

{ #category : #helpers }
TostMaterializationTests >> serializeAll: objects [
	
	| serializer dataStream |
	dataStream := ByteArray new writeStream.
	serializer := TostSerialization by: transporter on: dataStream.
	
	objects do: [:each | serializer serialize: each].
	
	self binaryData: dataStream contents
]

{ #category : #running }
TostMaterializationTests >> setUp [
	super setUp.
	
	materializer := TostMaterialization by: transporter on: ByteArray new readStream
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testArrayWithTwoEmptyObjects [

	| actual |
	self serialize: {Object new. Object new}.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: Array.
	actual should haveSize: 2.
	actual first should beInstanceOf: Object.
	actual last should beInstanceOf: Object.
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testBitmapInstance [

	| actual |
	self serialize: (Bitmap withAll: #(1 2 5 10)).
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: Bitmap.
	actual should equalInOrder: #(1 2 5 10)
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testBlockClosureWithContex [

	| actual temp block |
	temp := 10.
	block := [temp + 2 ].
	transporter addFirstFormat: (TostWellKnownObjectFormat on: {self. self class >> testSelector. thisContext sender}).
	self serialize: block.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: BlockClosure.
	actual value should equal: temp + 2
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testBlockClosureWithoutContext [

	| actual temp block |
	temp := 10.
	block := [temp + 2 ].
	transporter addFirstFormat: (TostWellKnownObjectFormat on: {self. self class >> testSelector. thisContext}).
	self serialize: block.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: BlockClosure.
	actual value should equal: temp + 2
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testByteArrayInstance [

	| actual |
	self serialize: #[1 2 5 10].
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: ByteArray.
	actual should equal: #[1 2 5 10]
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testByteString [

	| actual |
	self serialize: 'test string'.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: ByteString.
	actual should equal: 'test string'
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testByteSymbol [

	| actual |
	self serialize: #'test string'.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: ByteSymbol.
	actual should equal: #'test string'
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testCharacter [

	| actual |
	self serialize: $R.
	
	actual := materializer materializeObject.
	
	actual should equal: $R
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testCompiledMethod [

	| actual area |
	transporter addFirstFormat: (TostWellKnownObjectFormat on: {Rectangle}).
	self serialize: Rectangle >> #area.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: CompiledMethod.
	area := actual valueWithReceiver: (0@0 corner: 2@3) arguments: #().
	area should equal: 6
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testDictionary [
	| dict actual key1 key2 |
	dict := Dictionary newFrom: {Object new -> #item1. Object new -> #item2}.
	self serialize: dict.	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: Dictionary.
	"dictionary should be rehashed after materialization. So each key can access own value"
	key1 := actual keyAtValue: #item1.
	key2 := actual keyAtValue: #item2.
	actual should include: #item1 at: key1.
	actual should include: #item2 at: key2.
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testEmptyObject [

	| actual |
	self serialize: Object new.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: Object
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testFalse [
	| actual |
	self serialize: false.	
		
	actual := materializer materializeObject.
	
	actual should be: false
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testFloatInstance [

	| actual |
	self serialize: 1.5.
	
	actual := materializer materializeObject.
	
	actual should beKindOf: Float.
	actual should equal: 1.5
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testFraction [

	| actual |
	self serialize: 3/2.
	
	actual := materializer materializeObject.
	
	actual should beKindOf: Fraction.
	actual should equal: 3/2
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testIntegerInstance [

	| actual |
	self serialize: 300.
	
	actual := materializer materializeObject.
	
	actual should equal: 300
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testIntegerInstanceOf4Bytes [

	| actual |
	self serialize: 300000000. "300000000 digitLength 4"
	
	actual := materializer materializeObject.
	
	actual should equal: 300000000
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testLargeNegativeInteger [

	| actual |
	self serialize: -3575740990698772000111222.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: LargeNegativeInteger.
	actual should equal: -3575740990698772000111222
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testLargePositiveInteger [

	| actual |
	self serialize: 3575740990698772000111222.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: LargePositiveInteger.
	actual should equal: 3575740990698772000111222
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testNegativeFloatInstance [

	| actual |
	self serialize: -1.5.
	
	actual := materializer materializeObject.
	
	actual should beKindOf: Float.
	actual should equal: -1.5
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testNegativeFraction [

	| actual |
	self serialize: -3/2.
	
	actual := materializer materializeObject.
	
	actual should beKindOf: Fraction.
	actual should equal: -3/2
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testNil [
	| actual |
	self serialize: nil.	
		
	actual := materializer materializeObject.
	
	actual should be: nil
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testObjectOfWellKnownClass [

	| actual |
	transporter addFirstFormat: (TostNewObjectOfWellKnownClassFormat on: { Object }).
	self serialize: Object new.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: Object
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testObjectWhichReferenceShouldBeSubstitutedDynamicaly [

	| actual object root substitution substitutionFormat |
	object := 1@2.
	root := TostTestContainer with: {object. 3@4 }.
	substitution := 0@0 corner: 2@3.
	substitutionFormat := TostObjectDynamicSubstitutionFormat 
									for: [ :each | each == object ] by: [ :each | substitution ].
	transporter addFirstFormat: substitutionFormat.
	self serialize: root.
	actual := materializer materializeObject.
	
	actual should beInstanceOf: TostTestContainer.
	actual content should beInstanceOf: Array.
	actual content should haveSize: 2.
	actual content first should equal: substitution.
	actual content last should equal: 3@4
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testObjectWhichReferenceShouldBeSubstitutedStatically [

	| actual object root substitution substitutionFormat |
	object := 1@2.
	root := TostTestContainer with: {object. 3@4 }.
	substitution := 0@0 corner: 2@3.
	substitutionFormat := TostObjectStaticSubstitutionFormat substitutions: { object -> substitution  }.
	transporter addFirstFormat: substitutionFormat.
	self serialize: root.
	actual := materializer materializeObject.
	
	actual should beInstanceOf: TostTestContainer.
	actual content should beInstanceOf: Array.
	actual content should haveSize: 2.
	actual content first should equal: substitution.
	actual content last should equal: 3@4
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testObjectWhichReferencesAnotherObjectWhichReferencesInteger [

	| actual |
	self serialize: (TostTestContainer with: (TostTestContainer with: 10)).
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: TostTestContainer.
	actual content should beInstanceOf: TostTestContainer.
	actual content content should equal: 10
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testObjectWhichReferencesInteger [

	| actual |
	self serialize: (TostTestContainer with: 10).
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: TostTestContainer.
	actual content should equal: 10
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testObjectWithSubstitutionWhichContainsGivenObjectItself [

	| actual object root substitution substitutionFormat |
	<expectedFailure> 
	"all references to original object inside substitution will be replaced by substitution.
	It is rare case which make sence for specific applications.
	They needs to handle it by special format/transporter subclasses (for example Seamless do it)"
	object := 1@2.
	root := TostTestContainer with: {object. 3@4 }.
	substitution := TostTestContainer with: object.
	substitutionFormat := TostObjectStaticSubstitutionFormat substitutions: { object -> substitution  }.
	transporter addFirstFormat: substitutionFormat.
	self serialize: root.
	actual := materializer materializeObject.
	
	actual should beInstanceOf: TostTestContainer.
	actual content should beInstanceOf: Array.
	actual content should haveSize: 2.
	root content last should equal: 3@4.
	actual content last should equal: 3@4.
	actual content first should beInstanceOf: TostTestContainer.
	object should equal: 1@2.
	actual content first content should equal: object
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testObjectWithTwoReferencesToSameObjectWhichShouldBeSubstituted [

	| actual object root substitution substitutionFormat |
	object := 1@2.
	root := TostTestContainer with: {object. object }.
	substitution := 'substituted' copy.
	substitutionFormat := TostObjectStaticSubstitutionFormat substitutions: { object -> substitution  }.
	transporter addFormat: substitutionFormat before: TostDuplicatedObjectFormat.
	self serialize: root.
	actual := materializer materializeObject.
	
	actual should beInstanceOf: TostTestContainer.
	actual content should equal: { substitution. substitution }
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testPostProcessingLastSubstitution [
	"When full object graph is materialized traveler can stopped at deep child object.
	In that case it will not perform leave node action which will not trigger post processing.
	So materialization should execute extra command to leave them at the end of processing"
	| actual object root substitution substitutionFormat set item1 item2 |
	object := 1@2.
	root := TostTestContainer with: object.
	substitution := Set new.
	substitution add: Object new; add: Object new.
	substitutionFormat := TostObjectStaticSubstitutionFormat substitutions: { object -> substitution  }.
	transporter addFirstFormat: substitutionFormat.
	self serialize: root.
	actual := materializer materializeObject.
	
	set := actual content.
	set should beInstanceOf: Set.
	item1 := set asArray first.
	item2 := set asArray last.
	set should include: item1.
	set should include: item2
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testPostProcessingOfMultipleActions [
	"it should cover the case when last post processing action is evaluated but not removed.
	For example array with two sets will require two rehashing as post processing"
	| actual item1 item2 set1 set2 |
	self serialize: {
		Set new addAll: {Object new. Object new}; yourself.
		Set new addAll: {Object new. Object new}; yourself}.	
	actual := materializer materializeObject.
	set1 := actual first.
	item1 := set1 asArray first.
	item2 := set1 asArray last.
	set1 should include: item1.
	set1 should include: item2.
	
	set2 := actual first.
	item1 := set2 asArray first.
	item2 := set2 asArray last.
	set2 should include: item1.
	set2 should include: item2
]

{ #category : #'tests-primitive data' }
TostMaterializationTests >> testReadingBytes [

	| actual |
	self binaryData: #[1 2 3 4].
	
	actual := materializer readBytes: 2.
	
	actual should equal: #[1 2]
]

{ #category : #'tests-primitive data' }
TostMaterializationTests >> testReadingOneByteInteger [

	| actual |
	self binaryData: #[1 0 10].
	
	actual := materializer readInteger.
	
	actual should equal: 10
]

{ #category : #'tests-primitive data' }
TostMaterializationTests >> testReadingTwoBytesInteger [

	| actual |
	self binaryData: {2. 0. 300 digitAt: 2. 300 digitAt: 1}.
	
	actual := materializer readInteger.
	
	actual should equal: 300
]

{ #category : #'tests-primitive data' }
TostMaterializationTests >> testReadingTwoBytesNegativeInteger [

	| actual |
	self binaryData: {2. 1. 300 digitAt: 2. 300 digitAt: 1}.
	
	actual := materializer readInteger.
	
	actual should equal: -300
]

{ #category : #'tests-primitive data' }
TostMaterializationTests >> testReadingTwoBytesPositiveInteger [

	| actual |
	self binaryData: {2. 300 digitAt: 2. 300 digitAt: 1}.
	
	actual := materializer readPositiveInteger.
	
	actual should equal: 300
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testSameObjectTwice [

	| object first second |
	object := Object new.
	self serializeAll: {object. object}.
	
	first := materializer materializeObject.
	second := materializer materializeObject.
	
	first should beInstanceOf: Object.
	first should be: second
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testSet [
	| set actual item1 item2 |
	set := Set new. 
	set add: Object new; add: Object new.
	self serialize: set.	
	actual := materializer materializeObject.
	actual should beInstanceOf: Set.
	"set should be rehashed after materialization. So set should see that each item is included"
	item1 := actual asArray first.
	item2 := actual asArray last.
	actual should include: item1.
	actual should include: item2.
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testTreeObjectsOfSameClassWhereLastTwoAreSame [

	| first second object third |
	object := Object new.
	self serializeAll: {Object new. object. object}.
	
	first := materializer materializeObject.
	second := materializer materializeObject.
	third := materializer materializeObject.
	
	first should beInstanceOf: Object.
	second should beInstanceOf: Object.
	second should be: third
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testTrue [
	| actual |
	self serialize: true.	
		
	actual := materializer materializeObject.
	
	actual should be: true
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testTwoObjectsOfSameClass [

	| first second |
	self serializeAll: {Object new. Object new}.
	
	first := materializer materializeObject.
	second := materializer materializeObject.
	
	first should beInstanceOf: Object.
	second should beInstanceOf: Object.
	first should not be: second
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testUUIDInstance [

	| actual uuid |
	uuid := UUID new.
	self serialize: uuid.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: UUID.
	actual should equal: uuid
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testWellKnownEmptyObject [

	| actual object |
	object := Object new.
	transporter addFirstFormat: (TostWellKnownObjectFormat on: {2@3. object. 10@30}).
	self serialize: object.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: Object
]

{ #category : #'tests-objects' }
TostMaterializationTests >> testWideString [

	| actual |
	self serialize: '1234' asWideString .
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: WideString.
	actual should equal: '1234' asWideString
]
