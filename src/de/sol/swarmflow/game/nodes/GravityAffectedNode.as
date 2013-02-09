/**
 * User: Sol23
 */
package de.sol.swarmflow.game.nodes {
	import ash.core.Node;

	import de.sol.swarmflow.game.components.Acceleration;
	import de.sol.swarmflow.game.components.AffectedByGravity;
	import de.sol.swarmflow.game.components.Position;

	public class GravityAffectedNode extends Node {

		public var position:Position;
		public var acceleration:Acceleration;
		public var afectedByGravity:AffectedByGravity;
	}
}
