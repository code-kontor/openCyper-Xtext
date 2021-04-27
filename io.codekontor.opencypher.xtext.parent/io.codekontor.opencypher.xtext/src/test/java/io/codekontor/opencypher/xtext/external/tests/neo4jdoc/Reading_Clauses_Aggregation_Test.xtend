/*
 * openCypher Xtext - Slizaa Static Software Analysis Tools
 * Copyright © ${year} Code-Kontor GmbH and others (slizaa@codekontor.io)
 *
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *
 * Contributors:
 *  Code-Kontor GmbH - initial API and implementation
 */
package io.codekontor.opencypher.xtext.external.tests.neo4jdoc

import org.junit.Test
import io.codekontor.opencypher.xtext.tests.AbstractCypherTest

class Reading_Clauses_Aggregation_Test extends AbstractCypherTest {

	@Test
	def void example_Query() {
		test('''
			MATCH (me:Person)-->(friend:Person)-->(friend_of_friend:Person)
			WHERE me.name = 'A'
			RETURN count(DISTINCT friend_of_friend), count(friend_of_friend)
		''');
	}

	@Test
	def void example_CountNodes() {
		test('''
			MATCH (n { name: 'A' })-->(x)
			RETURN n, count(*)
		''');
	}

	@Test
	def void example_GroupCountRelationshipTypes() {
		test('''
			MATCH (n { name: 'A' })-[r]->()
			RETURN type(r), count(*)
		''');
	}

	@Test
	def void example_CountEntities() {
		test('''
			MATCH (n { name: 'A' })-->(x)
			RETURN count(x)
		''');
	}

	@Test
	def void example_CountNonNullValues() {
		test('''
			MATCH (n:Person)
			RETURN count(n.property)
		''');
	}

	@Test
	def void example_StatisticsSum() {
		test('''
			MATCH (n:Person)
			RETURN sum(n.property)
		''');
	}

	@Test
	def void example_StatisticsAvg() {
		test('''
			MATCH (n:Person)
			RETURN avg(n.property)
		''');
	}

	@Test
	def void example_StatisticsPercentileDisc() {
		test('''
			MATCH (n:Person)
			RETURN percentileDisc(n.property, 0.5)
		''');
	}

	@Test
	def void example_StatisticsPercentileCount() {
		test('''
			MATCH (n:Person)
			RETURN percentileCont(n.property, 0.4)
		''');
	}

	@Test
	def void example_StatisticsPercentileStdev() {
		test('''
			MATCH (n)
			WHERE n.name IN ['A', 'B', 'C']
			RETURN stdev(n.property)
		''');
	}

	@Test
	def void example_StatisticsPercentileStdevp() {
		test('''
			MATCH (n)
			WHERE n.name IN ['A', 'B', 'C']
			RETURN stdevp(n.property)
		''');
	}

	@Test
	def void example_StatisticsPercentileMax() {
		test('''
			MATCH (n:Person)
			RETURN max(n.property)
		''');
	}

	@Test
	def void example_StatisticsPercentileMin() {
		test('''
			MATCH (n:Person)
			RETURN min(n.property)
		''');
	}

	@Test
	def void example_Collect() {
		test('''
			MATCH (n:Person)
			RETURN collect(n.property)
		''');
	}

	@Test
	def void example_DISTINCT() {
		test('''
			MATCH (a:Person { name: 'A' })-->(b)
			RETURN count(DISTINCT b.eyes)
		''');
	}
}
