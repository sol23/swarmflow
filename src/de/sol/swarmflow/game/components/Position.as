/**
 * User: Sol23
 */
package de.sol.swarmflow.game.components {
	import flash.geom.Point;

	public class Position extends Point {
		public var rotation:Number;

		public function Position(x:Number = 0, y:Number = 0, rotation:Number = 0) {
			super(x, y);
			this.rotation = rotation;
		}
	}
}
