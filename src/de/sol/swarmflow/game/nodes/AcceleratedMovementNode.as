/**
 * User: Sol23
 */
package de.sol.swarmflow.game.nodes {
	import ash.core.Node;

	import de.sol.swarmflow.game.components.Acceleration;
	import de.sol.swarmflow.game.components.Velocity;

	public class AcceleratedMovementNode extends Node {

		public var velocity:Velocity;
		public var acceleration:Acceleration;
	}
}
