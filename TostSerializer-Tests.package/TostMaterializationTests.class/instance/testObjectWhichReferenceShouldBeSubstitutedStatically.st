tests-objects
testObjectWhichReferenceShouldBeSubstitutedStatically

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