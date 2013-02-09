/**
 * User: Sol23
 */
package de.sol.swarmflow.game.systems {
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;

	import de.sol.swarmflow.game.EntityCreator;
	import de.sol.swarmflow.game.components.Particle;
	import de.sol.swarmflow.game.nodes.ActivatableParticleNode;
	import de.sol.swarmflow.game.nodes.ParticleCollisionNode;

	import flash.geom.Point;

	public class ParticleCollisionSystem extends System {

		[Inject]
		public var creator:EntityCreator;
		private var _particleNodes:NodeList;
		private var _sleepingParticleNodes:NodeList;

		override public function addToEngine(engine:Engine):void {
			_particleNodes = engine.getNodeList(ParticleCollisionNode);
			_sleepingParticleNodes = engine.getNodeList(ActivatableParticleNode);
		}

		override public function removeFromEngine(engine:Engine):void {
			_particleNodes = null;
		}

		override public function update(time:Number):void {
			var sleepingNode:ActivatableParticleNode;
			var primaryNode:ParticleCollisionNode;
			var secondaryNode:ParticleCollisionNode;
			var distance:Point;

			for (sleepingNode = _sleepingParticleNodes.head; sleepingNode; sleepingNode = sleepingNode .next) {
				for (secondaryNode = _particleNodes.head; secondaryNode; secondaryNode = secondaryNode.next) {
					distance = sleepingNode.position.subtract(secondaryNode.position);
					if(distance.length < sleepingNode.collisionRadius.value+secondaryNode.collisionRadius.value) {
						sleepingNode.particle.states.changeState(Particle.STATE_ACTIVE);
					}
				}
			}

			for (primaryNode = _particleNodes.head; primaryNode; primaryNode = primaryNode.next) {
				for (secondaryNode = _particleNodes.head; secondaryNode; secondaryNode = secondaryNode.next) {
					if(secondaryNode===primaryNode) continue;

					distance = primaryNode.position.subtract(secondaryNode.position);
					if(distance.length < primaryNode.collisionRadius.value+secondaryNode.collisionRadius.value) {
							distance.normalize(Math.pow(distance.length, Math.random()*2));
							primaryNode.acceleration.x += distance.x;
							primaryNode.acceleration.y += distance.y;
							secondaryNode.acceleration.x -= distance.x;
							secondaryNode.acceleration.y -= distance.y;
					}
				}
			}
		}
	}
}
