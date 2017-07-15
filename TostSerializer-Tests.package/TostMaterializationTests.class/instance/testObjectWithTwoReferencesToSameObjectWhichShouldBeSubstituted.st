tests-objects
testObjectWithTwoReferencesToSameObjectWhichShouldBeSubstituted

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