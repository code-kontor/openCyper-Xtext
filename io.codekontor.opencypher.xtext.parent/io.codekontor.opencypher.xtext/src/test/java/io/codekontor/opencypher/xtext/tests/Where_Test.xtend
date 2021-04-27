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

class Where_Test extends AbstractCypherTest {

	@Test
	def void whereAlias() {
		test('''
			MATCH (p:Person)-->(c:Car)
			WITH p, count(c) AS carNumber
			WHERE carNumber > 1
			RETURN p
		''');
	}
}
