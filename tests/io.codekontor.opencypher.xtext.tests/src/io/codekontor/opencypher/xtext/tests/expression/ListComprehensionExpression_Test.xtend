package io.codekontor.opencypher.xtext.tests.expression

import org.junit.Test
import io.codekontor.opencypher.xtext.openCypher.Cypher
import io.codekontor.opencypher.xtext.tests.AbstractCypherTest

class ListComprehensionExpression_Test extends AbstractCypherTest {

	@Test
	def void listComprehensionExpressionTest() {
		val Cypher cypher = test('''
			START month = node:months('name:*')
			MATCH (month)-[:in_month]-(game)-[:scored_in]-(player)
			WITH month, player, count(game) AS games
			ORDER BY games DESC
			WITH month, 
			     [x IN COLLECT()[0..5] | x[0]] AS players,
			     [x IN COLLECT()[0..5] | x[1]] AS goals
			RETURN month.name
		''');
	}

	@Test
	def void listComprehensionExpressionTest_2() {
		val Cypher cypher = test('''
			START month = node:months('name:*')
			MATCH (month)-[:in_month]-(game)-[:scored_in]-(player)
			WITH month, player, count(game) AS games
			ORDER BY games DESC
			WITH month, 
			     [x IN COLLECT([player.name, games])[0..5] | x[0]] AS players,
			     [x IN COLLECT([player.name, games])[0..5] | x[1]] AS goals
			RETURN month.name
		''');
	}
}
