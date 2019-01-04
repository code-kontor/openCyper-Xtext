package io.codekontor.opencypher.xtext.tests

import org.junit.Test

class Remove_Test extends AbstractCypherTest{

	@Test
	def void removeLabel() {
		test('''
			MATCH (n)
			REMOVE n:Person
		''');
	}
	
		@Test
	def void removeProperty() {
		test('''
			MATCH (n)
			REMOVE n.property
		''');
	}
}
