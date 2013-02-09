/**
 * User: Sol23
 */
package de.sol.swarmflow.game.nodes {
	import ash.core.Node;

	import de.sol.swarmflow.game.components.Particle;
	import de.sol.swarmflow.game.components.Spawn;

	public class ParticleSpawnNode extends Node {
		public var spawn:Spawn;
		public var particle:Particle;
	}
}
