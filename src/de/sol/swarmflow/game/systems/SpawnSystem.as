/**
 * User: Sol23
 */
package de.sol.swarmflow.game.systems {
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;

	import de.sol.swarmflow.game.EntityCreator;
	import de.sol.swarmflow.game.GameConfig;
	import de.sol.swarmflow.game.components.Particle;
	import de.sol.swarmflow.game.components.Position;
	import de.sol.swarmflow.game.nodes.LevelNode;
	import de.sol.swarmflow.game.nodes.ParticleSpawnNode;

	public class SpawnSystem extends System {

		[Inject]
		public var creator:EntityCreator;
		private var _particleSpawnNodes:NodeList;
		private var _levelNodes:NodeList;
		private var _time:Number = 0;

		override public function addToEngine(engine:Engine):void {
			_particleSpawnNodes = engine.getNodeList(ParticleSpawnNode);
			_particleSpawnNodes.nodeAdded.add(onParticleNodeAdded);
			_levelNodes = engine.getNodeList(LevelNode);
		}

		override public function removeFromEngine(engine:Engine):void {
			_particleSpawnNodes.nodeAdded.remove(onParticleNodeAdded);
			_particleSpawnNodes = null;
			_levelNodes = null;
		}

		private function onParticleNodeAdded(node:ParticleSpawnNode):void {
			if (_levelNodes.head && _levelNodes.head === _levelNodes.tail) {
				if (!node.spawn.active) {
					node.entity.add(new Position(_levelNodes.head.levelSize.width * Math.random(), _levelNodes.head.levelSize.height * Math.random(), 0));
					node.particle.states.changeState(Particle.STATE_SLEEP);
				} else {
					node.entity.add(new Position(_levelNodes.head.levelSize.width * 0.5, _levelNodes.head.levelSize.height * 0.5, 0));
					node.particle.states.changeState(Particle.STATE_ACTIVE);
				}
			} else {
				creator.destroyEntity(node.entity);
			}
		}

		override public function update(time:Number):void {
			_time += time;
			if (_time >= GameConfig.FOOD_SPAWN_INTERVAL) {
				_time -= GameConfig.FOOD_SPAWN_INTERVAL;
				creator.createParticle();
			}
		}
	}
}
