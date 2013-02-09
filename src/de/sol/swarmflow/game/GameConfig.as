/**
 * User: Sol23
 */
package de.sol.swarmflow.game {
	import ash.core.Engine;
	import ash.tick.FrameTickProvider;
	import ash.tick.ITickProvider;

	import de.sol.swarmflow.game.components.CollisionRadius;

	import de.sol.swarmflow.game.systems.GravitySystem;
	import de.sol.swarmflow.game.systems.InputSystem;
	import de.sol.swarmflow.game.systems.MovementSystem;
	import de.sol.swarmflow.game.systems.ParticleCollisionSystem;
	import de.sol.swarmflow.game.systems.RenderSystem;
	import de.sol.swarmflow.game.systems.SpawnSystem;
	import de.sol.swarmflow.game.systems.SystemPriorities;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import org.swiftsuspenders.Injector;

	import robotlegs.bender.framework.api.IConfig;

	public class GameConfig implements IConfig {

		public static const FRICTION:Number = 0.2;

		public static const CENTRAL_GRAVITY:int = 200;

		public static const MIN_GRAVITY_DISTANCE:int = 30;

		public static const MAX_TOUCHES:int = 3;
		public static const TOUCH_REACH:int = 250;
		public static const TOUCH_GRAVITY:int = 500;
		public static const FOOD_SPAWN_INTERVAL:int = 5;

		public static const COLLISION_RADIUS_FOOD:int = 7;
		public static const COLLISION_RADIUS_PARTICLE:int = 20;

		[Inject]
		public var injector:Injector;

		[Inject]
		public var engine:Engine;

		private var creator:EntityCreator;
		private var _container:DisplayObjectContainer;

		public function GameConfig(container:DisplayObjectContainer) {
			_container = container;
		}

		public function configure():void {
			creator = new EntityCreator(engine);
			injector.map(EntityCreator).toValue(creator);
			injector.map(ITickProvider).toValue(new FrameTickProvider(_container));

			engine.addSystem(new InputSystem(_container), SystemPriorities.PREPARE);
			engine.addSystem(new SpawnSystem(), SystemPriorities.PREPARE);
			engine.addSystem(new GravitySystem(), SystemPriorities.PRE_UPDATE);
			engine.addSystem(new ParticleCollisionSystem(), SystemPriorities.UPDATE);
			engine.addSystem(new MovementSystem(), SystemPriorities.UPDATE);
			engine.addSystem(new RenderSystem(_container), SystemPriorities.RENDER);

			if (_container.stage) {
				initGame();
			} else {
				_container.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
		}

		private function onAddedToStage(e:Event):void {
			_container.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			initGame();
		}

		private function initGame():void {
			creator.createLevel(new Rectangle(0, 0, _container.stage.stageWidth, _container.stage.stageHeight), CENTRAL_GRAVITY);
		}
	}
}
