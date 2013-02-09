/**
 * User: Sol23
 */
package de.sol.swarmflow.game.graphics {
	import de.sol.swarmflow.game.GameConfig;
	import de.sol.swarmflow.game.components.Display;

	import flash.display.Sprite;

	public class ActiveParticleGraphics extends Display {
		public function ActiveParticleGraphics() {
			super(new Sprite());
			draw();
		}

		private function draw():void {
			Sprite(displayObject).graphics.beginFill(0x000000);
			Sprite(displayObject).graphics.drawCircle(0, 0, GameConfig.COLLISION_RADIUS_PARTICLE);
			Sprite(displayObject).graphics.endFill();
			Sprite(displayObject).graphics.lineStyle(2);
			Sprite(displayObject).graphics.beginFill(0xFFFFFF);
			Sprite(displayObject).graphics.drawCircle(0, -GameConfig.COLLISION_RADIUS_PARTICLE, 10);
			Sprite(displayObject).graphics.endFill();
		}

	}
}
