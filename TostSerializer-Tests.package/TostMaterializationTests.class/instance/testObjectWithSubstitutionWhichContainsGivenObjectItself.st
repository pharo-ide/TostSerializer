tests-objects
testObjectWithSubstitutionWhichContainsGivenObjectItself

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