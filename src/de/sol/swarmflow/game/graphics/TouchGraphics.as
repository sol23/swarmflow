/**
 * User: Sol23
 */
package de.sol.swarmflow.game.graphics {

	import de.sol.swarmflow.game.components.ScalableDisplay;

	import flash.display.Sprite;

	public class TouchGraphics extends ScalableDisplay {
		private var _size:Number;
		public function TouchGraphics(size:Number, factor:Number = 0.5) {
			_size = size;
			super(new Sprite(), factor);
		}

		override public function update(scale:Number):void {
			Sprite(displayObject).graphics.clear();
			Sprite(displayObject).graphics.lineStyle(5, 0xFF0000);
			Sprite(displayObject).graphics.beginFill(0x999999, 0.3);
			Sprite(displayObject).graphics.drawCircle(0, 0, _size);
			Sprite(displayObject).graphics.endFill();
			displayObject.alpha = Math.max(0.5, scale);
		}
	}
}
