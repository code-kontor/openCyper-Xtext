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
package io.codekontor.opencypher.xtext.tests.tck

import org.junit.Test
import io.codekontor.opencypher.xtext.tests.AbstractCypherTest

class ComparisonOperatorAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Handling numerical ranges 1
    Given an empty graph
    And having executed:
      """
      UNWIND [1, 2, 3] AS i
      CREATE ({value: i})
      """
    */
    @Test
    def void testComparisonOperatorAcceptance_01() {
        test('''
        MATCH (n)
        WHERE 1 < n.value < 3
        RETURN n.value
        ''')
    }

    /*
    Scenario: Handling numerical ranges 2
    Given an empty graph
    And having executed:
      """
      UNWIND [1, 2, 3] AS i
      CREATE ({value: i})
      """
    */
    @Test
    def void testComparisonOperatorAcceptance_02() {
        test('''
        MATCH (n)
        WHERE 1 < n.value <= 3
        RETURN n.value
        ''')
    }

    /*
    Scenario: Handling numerical ranges 3
    Given an empty graph
    And having executed:
      """
      UNWIND [1, 2, 3] AS i
      CREATE ({value: i})
      """
    */
    @Test
    def void testComparisonOperatorAcceptance_03() {
        test('''
        MATCH (n)
        WHERE 1 <= n.value < 3
        RETURN n.value
        ''')
    }

    /*
    Scenario: Handling numerical ranges 4
    Given an empty graph
    And having executed:
      """
      UNWIND [1, 2, 3] AS i
      CREATE ({value: i})
      """
    */
    @Test
    def void testComparisonOperatorAcceptance_04() {
        test('''
        MATCH (n)
        WHERE 1 <= n.value <= 3
        RETURN n.value
        ''')
    }

    /*
    Scenario: Handling string ranges 1
    Given an empty graph
    And having executed:
      """
      UNWIND ['a', 'b', 'c'] AS c
      CREATE ({value: c})
      """
    */
    @Test
    def void testComparisonOperatorAcceptance_05() {
        test('''
        MATCH (n)
        WHERE 'a' < n.value < 'c'
        RETURN n.value
        ''')
    }

    /*
    Scenario: Handling string ranges 2
    Given an empty graph
    And having executed:
      """
      UNWIND ['a', 'b', 'c'] AS c
      CREATE ({value: c})
      """
    */
    @Test
    def void testComparisonOperatorAcceptance_06() {
        test('''
        MATCH (n)
        WHERE 'a' < n.value <= 'c'
        RETURN n.value
        ''')
    }

    /*
    Scenario: Handling string ranges 3
    Given an empty graph
    And having executed:
      """
      UNWIND ['a', 'b', 'c'] AS c
      CREATE ({value: c})
      """
    */
    @Test
    def void testComparisonOperatorAcceptance_07() {
        test('''
        MATCH (n)
        WHERE 'a' <= n.value < 'c'
        RETURN n.value
        ''')
    }

    /*
    Scenario: Handling string ranges 4
    Given an empty graph
    And having executed:
      """
      UNWIND ['a', 'b', 'c'] AS c
      CREATE ({value: c})
      """
    */
    @Test
    def void testComparisonOperatorAcceptance_08() {
        test('''
        MATCH (n)
        WHERE 'a' <= n.value <= 'c'
        RETURN n.value
        ''')
    }

    /*
    Scenario: Handling empty range
    Given an empty graph
    And having executed:
      """
      CREATE ({value: 3})
      """
    */
    @Test
    def void testComparisonOperatorAcceptance_09() {
        test('''
        MATCH (n)
        WHERE 10 < n.value <= 3
        RETURN n.value
        ''')
    }

    /*
    Scenario: Handling long chains of operators
    Given an empty graph
    And having executed:
      """
      CREATE (a:A {prop1: 3, prop2: 4})
      CREATE (b:B {prop1: 4, prop2: 5})
      CREATE (c:C {prop1: 4, prop2: 4})
      CREATE (a)-[:R]->(b)
      CREATE (b)-[:R]->(c)
      CREATE (c)-[:R]->(a)
      """
    */
    @Test
    def void testComparisonOperatorAcceptance_10() {
        test('''
        MATCH (n)-->(m)
        WHERE n.prop1 < m.prop1 = n.prop2 <> m.prop2
        RETURN labels(m)
        ''')
    }

}
