/**
 * User: Sol23
 */
package de.sol.swarmflow.game.nodes {
	import ash.core.Node;

	import de.sol.swarmflow.game.components.Position;
	import de.sol.swarmflow.game.components.ScalableDisplay;
	import de.sol.swarmflow.game.components.Strength;
	import de.sol.swarmflow.game.components.Touch;

	public class TouchNode extends Node {
		public var touch:Touch;
		public var position:Position;
		public var strength:Strength;
		public var scalableDisplay:ScalableDisplay;
	}
}
