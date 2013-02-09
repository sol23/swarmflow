/**
 * User: Sol23
 */
package de.sol.swarmflow.game.nodes {
	import ash.core.Node;

	import de.sol.swarmflow.game.components.Gravity;

	import de.sol.swarmflow.game.components.Reach;

	import de.sol.swarmflow.game.components.Position;
	import de.sol.swarmflow.game.components.Strength;

	public class GravityNode extends Node {

		public var gravity:Gravity;
		public var reach:Reach;
		public var strength:Strength;
		public var position:Position;
	}
}
