/**
 * User: Sol23
 */
package de.sol.swarmflow.game.components {
	import flash.display.DisplayObject;

	public class ScalableDisplay extends Display {

		public function ScalableDisplay(displayObject:DisplayObject, scale:Number) {
			super(displayObject);
			update(scale);
		}

		public function update(scale:Number):void {

		}
	}
}
