/**
 * User: Sol23
 */
package de.sol.swarmflow.game.graphics {
	import de.sol.swarmflow.game.GameConfig;
	import de.sol.swarmflow.game.components.Display;

	import flash.display.Sprite;

	public class SleepingParticleGraphics extends Display {
		public function SleepingParticleGraphics() {
			super(new Sprite());
			draw();
		}

		private function draw():void {
			Sprite(displayObject).graphics.beginFill(0x55FF55);
			Sprite(displayObject).graphics.drawCircle(0,0, GameConfig.COLLISION_RADIUS_FOOD);
			Sprite(displayObject).graphics.endFill();
		}
	}
}
