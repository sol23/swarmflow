/**
 * User: Sol23
 */
package de.sol.swarmflow.game {
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.fsm.EntityStateMachine;

	import de.sol.swarmflow.game.components.Acceleration;
	import de.sol.swarmflow.game.components.Activatable;
	import de.sol.swarmflow.game.components.AffectedByGravity;
	import de.sol.swarmflow.game.components.CollisionRadius;
	import de.sol.swarmflow.game.components.Display;
	import de.sol.swarmflow.game.components.Gravity;
	import de.sol.swarmflow.game.components.LevelSize;
	import de.sol.swarmflow.game.components.Particle;
	import de.sol.swarmflow.game.components.Position;
	import de.sol.swarmflow.game.components.Reach;
	import de.sol.swarmflow.game.components.ScalableDisplay;
	import de.sol.swarmflow.game.components.Spawn;
	import de.sol.swarmflow.game.components.Strength;
	import de.sol.swarmflow.game.components.Touch;
	import de.sol.swarmflow.game.components.Velocity;
	import de.sol.swarmflow.game.graphics.ActiveParticleGraphics;
	import de.sol.swarmflow.game.graphics.SleepingParticleGraphics;
	import de.sol.swarmflow.game.graphics.TouchGraphics;

	import flash.geom.Rectangle;

	public class EntityCreator {

		[Inject]
		public var engine:Engine;

		public function EntityCreator(engine:Engine) {
			this.engine = engine;
		}

		public function createTouchPoint(x:Number, y:Number, size:int, id:int = 0, strength:Number = 0.5):void {
			var touchGfx:TouchGraphics = new TouchGraphics(size, strength);

			var touchPoint:Entity = new Entity()
					.add(new Position(x, y, 0))
					.add(new Touch(id))
					.add(new Gravity())
					.add(new Strength(GameConfig.TOUCH_GRAVITY, strength))
					.add(touchGfx, Display)
					.add(touchGfx, ScalableDisplay)
					.add(new Reach(size));

			engine.addEntity(touchPoint);
		}

		public function createParticle(active:Boolean = false):void {
			var particle:Entity = new Entity();
			var esm:EntityStateMachine = new EntityStateMachine(particle);

			particle.add(new Particle(esm));

			esm.createState(Particle.STATE_SPAWN)
					.add(Spawn).withInstance(new Spawn(active));

			esm.createState(Particle.STATE_SLEEP)
					.add(Display).withInstance(new SleepingParticleGraphics())
					.add(CollisionRadius).withInstance(new CollisionRadius(GameConfig.COLLISION_RADIUS_FOOD))
					.add(Activatable);

			esm.createState(Particle.STATE_ACTIVE)
					.add(Display).withInstance(new ActiveParticleGraphics())
					.add(CollisionRadius).withInstance(new CollisionRadius(GameConfig.COLLISION_RADIUS_PARTICLE))
					.add(Velocity)
					.add(Acceleration)
					.add(AffectedByGravity);

			esm.changeState(Particle.STATE_SPAWN);

			engine.addEntity(particle);
		}

		public function destroyEntity(entity:Entity):void {
			engine.removeEntity(entity);
		}

		public function createLevel(size:Rectangle, centralGravity:Number = 0):void {
			var level:Entity = new Entity();

			level.add(new LevelSize(size.width, size.height));
			engine.addEntity(level);

			if (centralGravity > 0) {
				var cg:Entity = new Entity()
						.add(new Position(size.width * 0.5, size.height * 0.5))
						.add(new Gravity())
						.add(new Strength(centralGravity, 1))
						.add(new Reach(int.MAX_VALUE));

				engine.addEntity(cg);
			}
		}
	}
}
