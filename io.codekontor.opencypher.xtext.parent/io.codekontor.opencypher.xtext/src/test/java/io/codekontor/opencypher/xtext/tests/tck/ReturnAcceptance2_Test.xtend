package io.codekontor.opencypher.xtext.tests.tck

import org.junit.Test
import io.codekontor.opencypher.xtext.tests.AbstractCypherTest

class ReturnAcceptance2_Test extends AbstractCypherTest {
    
    /*
    Scenario: Fail when returning properties of deleted nodes
    Given an empty graph
    And having executed:
      """
      CREATE ({p: 0})
      """
    */
    @Test
    def void testReturnAcceptance2_01() {
        test('''
        MATCH (n)
        DELETE n
        RETURN n.p
        ''')
    }

    /*
    Scenario: Fail when returning labels of deleted nodes
    Given an empty graph
    And having executed:
      """
      CREATE (:A)
      """
    */
    @Test
    def void testReturnAcceptance2_02() {
        test('''
        MATCH (n)
        DELETE n
        RETURN labels(n)
        ''')
    }

    /*
    Scenario: Fail when returning properties of deleted relationships
    Given an empty graph
    And having executed:
      """
      CREATE ()-[:T {p: 0}]->()
      """
    */
    @Test
    def void testReturnAcceptance2_03() {
        test('''
        MATCH ()-[r]->()
        DELETE r
        RETURN r.p
        ''')
    }

    /*
    Scenario: Do not fail when returning type of deleted relationships
    Given an empty graph
    And having executed:
      """
      CREATE ()-[:T]->()
      """
    */
    @Test
    def void testReturnAcceptance2_04() {
        test('''
        MATCH ()-[r]->()
        DELETE r
        RETURN type(r)
        ''')
    }

    /*
    Scenario: Accept valid Unicode literal
    Given any graph
    */
    @Test
    def void testReturnAcceptance2_05() {
        test('''
        RETURN '\u01FF' AS a
        ''')
    }

    /*
    Scenario: LIMIT 0 should return an empty result
    Given an empty graph
    And having executed:
      """
      CREATE (), (), ()
      """
    */
    @Test
    def void testReturnAcceptance2_06() {
        test('''
        MATCH (n)
        RETURN n
        LIMIT 0
        ''')
    }

    /*
    Scenario: Ordering with aggregation
    Given an empty graph
    And having executed:
      """
      CREATE ({name: 'nisse'})
      """
    */
    @Test
    def void testReturnAcceptance2_07() {
        test('''
        MATCH (n)
        RETURN n.name, count(*) AS foo
        ORDER BY n.name
        ''')
    }

    /*
    Scenario: DISTINCT on nullable values
    Given an empty graph
    And having executed:
      """
      CREATE ({name: 'Florescu'}), (), ()
      """
    */
    @Test
    def void testReturnAcceptance2_08() {
        test('''
        MATCH (n)
        RETURN DISTINCT n.name
        ''')
    }

    /*
    Scenario: Return all variables
    Given an empty graph
    And having executed:
      """
      CREATE (:Start)-[:T]->()
      """
    */
    @Test
    def void testReturnAcceptance2_09() {
        test('''
        MATCH p = (a:Start)-->(b)
        RETURN *
        ''')
    }

    /*
    Scenario: Setting and returning the size of a list property
    Given an empty graph
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testReturnAcceptance2_10() {
        test('''
        MATCH (n)
        SET n.x = [1, 2, 3]
        RETURN size(n.x)
        ''')
    }

    /*
    Scenario: `sqrt()` returning float values
    Given any graph
    */
    @Test
    def void testReturnAcceptance2_11() {
        test('''
        RETURN sqrt(12.96)
        ''')
    }

    /*
    Scenario: Arithmetic expressions inside aggregation
    Given an empty graph
    And having executed:
      """
      CREATE (andres {name: 'Andres'}),
             (michael {name: 'Michael'}),
             (peter {name: 'Peter'}),
             (bread {type: 'Bread'}),
             (veggies {type: 'Veggies'}),
             (meat {type: 'Meat'})
      CREATE (andres)-[:ATE {times: 10}]->(bread),
             (andres)-[:ATE {times: 8}]->(veggies),
             (michael)-[:ATE {times: 4}]->(veggies),
             (michael)-[:ATE {times: 6}]->(bread),
             (michael)-[:ATE {times: 9}]->(meat),
             (peter)-[:ATE {times: 7}]->(veggies),
             (peter)-[:ATE {times: 7}]->(bread),
             (peter)-[:ATE {times: 4}]->(meat)
      """
    */
    @Test
    def void testReturnAcceptance2_12() {
        test('''
        MATCH (me)-[r1:ATE]->()<-[r2:ATE]-(you)
        WHERE me.name = 'Michael'
        WITH me, count(DISTINCT r1) AS H1, count(DISTINCT r2) AS H2, you
        MATCH (me)-[r1:ATE]->()<-[r2:ATE]-(you)
        RETURN me, you, sum((1 - abs(r1.times / H1 - r2.times / H2)) * (r1.times + r2.times) / (H1 + H2)) AS sum
        ''')
    }

    /*
    Scenario: Matching and disregarding output, then matching again
    Given an empty graph
    And having executed:
      """
      CREATE (andres {name: 'Andres'}),
             (michael {name: 'Michael'}),
             (peter {name: 'Peter'}),
             (bread {type: 'Bread'}),
             (veggies {type: 'Veggies'}),
             (meat {type: 'Meat'})
      CREATE (andres)-[:ATE {times: 10}]->(bread),
             (andres)-[:ATE {times: 8}]->(veggies),
             (michael)-[:ATE {times: 4}]->(veggies),
             (michael)-[:ATE {times: 6}]->(bread),
             (michael)-[:ATE {times: 9}]->(meat),
             (peter)-[:ATE {times: 7}]->(veggies),
             (peter)-[:ATE {times: 7}]->(bread),
             (peter)-[:ATE {times: 4}]->(meat)
      """
    */
    @Test
    def void testReturnAcceptance2_13() {
        test('''
        MATCH ()-->()
        WITH 1 AS x
        MATCH ()-[r1]->()<--()
        RETURN sum(r1.times)
        ''')
    }

    /*
    Scenario: Returning a list property
    Given an empty graph
    And having executed:
      """
      CREATE ({foo: [1, 2, 3]})
      """
    */
    @Test
    def void testReturnAcceptance2_14() {
        test('''
        MATCH (n)
        RETURN n
        ''')
    }

    /*
    Scenario: Returning a projected map
    Given an empty graph
    And having executed:
      """
      CREATE ({foo: [1, 2, 3]})
      """
    */
    @Test
    def void testReturnAcceptance2_15() {
        test('''
        RETURN {a: 1, b: 'foo'}
        ''')
    }

    /*
    Scenario: Returning an expression
    Given an empty graph
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testReturnAcceptance2_16() {
        test('''
        MATCH (a)
        RETURN exists(a.id), a IS NOT NULL
        ''')
    }

    /*
    Scenario: Concatenating and returning the size of literal lists
    Given any graph
    */
    @Test
    def void testReturnAcceptance2_17() {
        test('''
        RETURN size([[], []] + [[]]) AS l
        ''')
    }

    /*
    Scenario: Returning nested expressions based on list property
    Given an empty graph
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testReturnAcceptance2_18() {
        test('''
        MATCH (n)
        SET n.array = [1, 2, 3, 4, 5]
        RETURN tail(tail(n.array))
        ''')
    }

    /*
    Scenario: Limiting amount of rows when there are fewer left than the LIMIT argument
    Given an empty graph
    And having executed:
      """
      UNWIND range(0, 15) AS i
      CREATE ({count: i})
      """
    */
    @Test
    def void testReturnAcceptance2_19() {
        test('''
        MATCH (a)
        RETURN a.count
        ORDER BY a.count
        SKIP 10
        LIMIT 10
        ''')
    }

    /*
    Scenario: `substring()` with default second argument
    Given any graph
    */
    @Test
    def void testReturnAcceptance2_20() {
        test('''
        RETURN substring('0123456789', 1) AS s
        ''')
    }

    /*
    Scenario: Returning all variables with ordering
    Given an empty graph
    And having executed:
      """
      CREATE ({id: 1}), ({id: 10})
      """
    */
    @Test
    def void testReturnAcceptance2_21() {
        test('''
        MATCH (n)
        RETURN *
        ORDER BY n.id
        ''')
    }

    /*
    Scenario: Using aliased DISTINCT expression in ORDER BY
    Given an empty graph
    And having executed:
      """
      CREATE ({id: 1}), ({id: 10})
      """
    */
    @Test
    def void testReturnAcceptance2_22() {
        test('''
        MATCH (n)
        RETURN DISTINCT n.id AS id
        ORDER BY id DESC
        ''')
    }

    /*
    Scenario: Returned columns do not change from using ORDER BY
    Given an empty graph
    And having executed:
      """
      CREATE ({id: 1}), ({id: 10})
      """
    */
    @Test
    def void testReturnAcceptance2_23() {
        test('''
        MATCH (n)
        RETURN DISTINCT n
        ORDER BY n.id
        ''')
    }

    /*
    Scenario: Arithmetic expressions should propagate null values
    Given any graph
    */
    @Test
    def void testReturnAcceptance2_24() {
        test('''
        RETURN 1 + (2 - (3 * (4 / (5 ^ (6 % null))))) AS a
        ''')
    }

    /*
    Scenario: Indexing into nested literal lists
    Given any graph
    */
    @Test
    def void testReturnAcceptance2_25() {
        test('''
        RETURN [[1]][0][0]
        ''')
    }

    /*
    Scenario: Aliasing expressions
    Given an empty graph
    And having executed:
      """
      CREATE ({id: 42})
      """
    */
    @Test
    def void testReturnAcceptance2_26() {
        test('''
        MATCH (a)
        RETURN a.id AS a, a.id
        ''')
    }

    /*
    Scenario: Projecting an arithmetic expression with aggregation
    Given an empty graph
    And having executed:
      """
      CREATE ({id: 42})
      """
    */
    @Test
    def void testReturnAcceptance2_27() {
        test('''
        MATCH (a)
        RETURN a, count(a) + 3
        ''')
    }

    /*
    Scenario: Multiple aliasing and backreferencing
    Given any graph
    */
    @Test
    def void testReturnAcceptance2_28() {
        test('''
        CREATE (m {id: 0})
        WITH {first: m.id} AS m
        WITH {second: m.first} AS m
        RETURN m.second
        ''')
    }

    /*
    Scenario: Aggregating by a list property has a correct definition of equality
    Given an empty graph
    And having executed:
      """
      CREATE ({a: [1, 2, 3]}), ({a: [1, 2, 3]})
      """
    */
    @Test
    def void testReturnAcceptance2_29() {
        test('''
        MATCH (a)
        WITH a.a AS a, count(*) AS count
        RETURN count
        ''')
    }

    /*
    Scenario: Reusing variable names
    Given an empty graph
    And having executed:
      """
      CREATE (a:Person), (b:Person), (m:Message {id: 10})
      CREATE (a)-[:LIKE {creationDate: 20160614}]->(m)-[:POSTED_BY]->(b)
      """
    */
    @Test
    def void testReturnAcceptance2_30() {
        test('''
        MATCH (person:Person)<--(message)<-[like]-(:Person)
        WITH like.creationDate AS likeTime, person AS person
        ORDER BY likeTime, message.id
        WITH head(collect({likeTime: likeTime})) AS latestLike, person AS person
        RETURN latestLike.likeTime AS likeTime
        ORDER BY likeTime
        ''')
    }

    /*
    Scenario: Concatenating lists of same type
    Given any graph
    */
    @Test
    def void testReturnAcceptance2_31() {
        test('''
        RETURN [1, 10, 100] + [4, 5] AS foo
        ''')
    }

    /*
    Scenario: Appending lists of same type
    Given any graph
    */
    @Test
    def void testReturnAcceptance2_32() {
        test('''
        RETURN [false, true] + false AS foo
        ''')
    }

    /*
    Scenario: DISTINCT inside aggregation should work with lists in maps
    Given an empty graph
    And having executed:
      """
      CREATE ({list: ['A', 'B']}), ({list: ['A', 'B']})
      """
    */
    @Test
    def void testReturnAcceptance2_33() {
        test('''
        MATCH (n)
        RETURN count(DISTINCT {foo: n.list}) AS count
        ''')
    }

    /*
    Scenario: Handling DISTINCT with lists in maps
    Given an empty graph
    And having executed:
      """
      CREATE ({list: ['A', 'B']}), ({list: ['A', 'B']})
      """
    */
    @Test
    def void testReturnAcceptance2_34() {
        test('''
        MATCH (n)
        WITH DISTINCT {foo: n.list} AS map
        RETURN count(*)
        ''')
    }

    /*
    Scenario: DISTINCT inside aggregation should work with nested lists in maps
    Given an empty graph
    And having executed:
      """
      CREATE ({list: ['A', 'B']}), ({list: ['A', 'B']})
      """
    */
    @Test
    def void testReturnAcceptance2_35() {
        test('''
        MATCH (n)
        RETURN count(DISTINCT {foo: [[n.list, n.list], [n.list, n.list]]}) AS count
        ''')
    }

    /*
    Scenario: DISTINCT inside aggregation should work with nested lists of maps in maps
    Given an empty graph
    And having executed:
      """
      CREATE ({list: ['A', 'B']}), ({list: ['A', 'B']})
      """
    */
    @Test
    def void testReturnAcceptance2_36() {
        test('''
        MATCH (n)
        RETURN count(DISTINCT {foo: [{bar: n.list}, {baz: {apa: n.list}}]}) AS count
        ''')
    }

}
