I am substitution format which defines substitution objects dynamically by blocks:

- conditionBlock defines what objects should be substituted
- substitutionBlock defines substitutions for given objects
 
Internal Representation and Key Implementation Points.

    Instance Variables
	conditionBlock:		<BlockClosure>
	substitutionBlock:		<BlockClosure>