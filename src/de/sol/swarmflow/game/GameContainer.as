/**
 * User: Sol23
 */
package de.sol.swarmflow.game {
	import robotlegs.bender.extensions.simpleViewExtension.impl.FlashView;

	public class GameContainer extends FlashView {

		override public function initialize():void {
			super.initialize();
			trace("GameContainer initialized");
		}
	}
}
