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
package io.codekontor.opencypher.xtext.tests

import org.junit.Test
import java.util.List
import java.util.LinkedList
import org.junit.Assert

class KeywordIssue_Test extends AbstractCypherTest {

	@Test
	def void keywords() {

		val keywords = newLinkedList('CYPHER', 'EXPLAIN', 'PROFILE', 'USING', 'PERIODIC', 'COMMIT', 'UNION', 'ALL',
			'CREATE', 'INDEX', 'ON', 'DROP', 'CONSTRAINT', 'ASSERT', 'IS', 'UNIQUE', 'EXISTS', 'LOAD', 'CSV', 'WITH',
			'HEADERS', 'FROM', 'AS', 'FIELDTERMINATOR', 'OPTIONAL', 'MATCH', 'UNWIND', 'MERGE', 'SET', 'DELETE',
			'DETACH', 'REMOVE', 'FOREACH', 'IN', 'RETURN', 'ORDER', 'BY', 'SKIP', 'LIMIT', 'DESCENDING', 'DESC',
			'ASCENDING', 'ASC', 'JOIN', 'SCAN', 'START', 'NODE', 'RELATIONSHIP', 'REL', 'WHERE', 'SHORTESTPATH',
			'ALLSHORTESTPATHS', 'OR', 'XOR', 'AND', 'STARTS', 'ENDS', 'CONTAINS', 'COUNT', 'FILTER', 'EXTRACT', 'ANY',
			'NONE', 'SINGLE', 'REDUCE', 'NOT', 'NULL', 'TRUE', 'FALSE', 'CASE', 'ELSE', 'END', 'WHEN', 'THEN')

		// failing!
		// keywords.addAll(#['DISTINCT'])
		//
		val List<String> failedKeywords = new LinkedList
		for (keyword : keywords) {
			try {
				test('''
					MATCH (�keyword�) 
					RETURN �keyword�
				''');
			} catch (AssertionError exception) {
				failedKeywords.add(keyword)
			}
		}

		//
		if (!failedKeywords.isEmpty) {
			Assert.fail("Failed Keywords: " + failedKeywords);
		}
	}
}
