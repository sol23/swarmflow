/**
 * User: Sol23
 */
package de.sol.swarmflow.game.nodes {
	import ash.core.Node;

	import de.sol.swarmflow.game.components.Acceleration;

	import de.sol.swarmflow.game.components.CollisionRadius;
	import de.sol.swarmflow.game.components.Particle;
	import de.sol.swarmflow.game.components.Position;

	public class ParticleCollisionNode extends Node {

		public var particle:Particle;
		public var position:Position;
		public var acceleration:Acceleration;
		public var collisionRadius:CollisionRadius;
	}
}
