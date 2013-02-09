/**
 * User: Sol23
 */
package de.sol.swarmflow.game.nodes {
	import ash.core.Node;

	import de.sol.swarmflow.game.components.Activatable;
	import de.sol.swarmflow.game.components.CollisionRadius;

	import de.sol.swarmflow.game.components.Particle;

	import de.sol.swarmflow.game.components.Position;

	public class ActivatableParticleNode extends Node {

		public var particle:Particle;
		public var position:Position;
		public var activatable:Activatable;
		public var collisionRadius:CollisionRadius;
	}
}
