/**
 * User: Sol23
 */
package de.sol.swarmflow.game.systems {
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;

	import de.sol.swarmflow.game.GameConfig;

	import de.sol.swarmflow.game.GameConfig;

	import de.sol.swarmflow.game.nodes.AcceleratedMovementNode;

	import de.sol.swarmflow.game.nodes.MovementNode;

	public class MovementSystem extends System {

		private var _acceleratedMovementNodes:NodeList;
		private var _movementNodes:NodeList;

		override public function addToEngine(engine:Engine):void {
			_movementNodes = engine.getNodeList(MovementNode);
			_acceleratedMovementNodes = engine.getNodeList(AcceleratedMovementNode);
		}

		override public function removeFromEngine(engine:Engine):void {
			_movementNodes = null;
			_acceleratedMovementNodes = null;
		}

		override public function update(time:Number):void {
			var mNode:MovementNode;
			var amNode:AcceleratedMovementNode;

			// updating acceleration
			for (amNode = _acceleratedMovementNodes.head; amNode; amNode = amNode.next) {
				if(!amNode.acceleration.length) continue;

				amNode.velocity.x += amNode.acceleration.x * time;
				amNode.velocity.y += amNode.acceleration.y * time;
				amNode.acceleration.x = amNode.acceleration.y = 0;
			}

			for (mNode = _movementNodes.head; mNode; mNode = mNode.next) {
				if(!mNode.velocity.length) continue;

				mNode.position.x += mNode.velocity.x * time;
				mNode.position.y += mNode.velocity.y * time;
				mNode.position.rotation = Math.atan2(mNode.velocity.y,  mNode.velocity.x) + (Math.PI*0.5);
				mNode.velocity.normalize(mNode.velocity.length * (1-GameConfig.FRICTION*time));
			}
		}
	}
}
