/**
 * User: Sol23
 */
package de.sol.swarmflow.game.systems {
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;

	import de.sol.swarmflow.game.EntityCreator;
	import de.sol.swarmflow.game.GameConfig;
	import de.sol.swarmflow.game.nodes.GravityAffectedNode;
	import de.sol.swarmflow.game.nodes.GravityNode;
	import de.sol.swarmflow.game.nodes.ParticleCollisionNode;

	import flash.geom.Point;

	public class GravitySystem extends System {

		[Inject]
		public var creator:EntityCreator;

		private var _affectedNodes:NodeList;
		private var _gravityNodes:NodeList;

		override public function addToEngine(engine:Engine):void {
			_affectedNodes = engine.getNodeList(GravityAffectedNode);
			_gravityNodes = engine.getNodeList(GravityNode);
		}

		override public function removeFromEngine(engine:Engine):void {
			_affectedNodes = engine.getNodeList(GravityAffectedNode);
			_gravityNodes = engine.getNodeList(GravityNode);
		}

		override public function update(time:Number):void {
			var affectedNode:GravityAffectedNode;
			var gravityNode:GravityNode;
			var gravPull:Point;
			var s:Number;

			for (affectedNode = _affectedNodes.head; affectedNode; affectedNode = affectedNode.next) {
				for (gravityNode = _gravityNodes.head; gravityNode; gravityNode = gravityNode.next) {
					gravPull = gravityNode.position.subtract(affectedNode.position);
					if(gravPull.length < GameConfig.MIN_GRAVITY_DISTANCE) continue;

					s = Math.min(1, Math.pow(gravityNode.reach.value / gravPull.length, 2));
					s *= gravityNode.strength.amount * gravityNode.strength.factor;
					gravPull.normalize(s);

					affectedNode.acceleration.x += gravPull.x;
					affectedNode.acceleration.y += gravPull.y;
				}
			}
		}
	}
}
