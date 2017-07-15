tests-objects
testPostProcessingLastSubstitution
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