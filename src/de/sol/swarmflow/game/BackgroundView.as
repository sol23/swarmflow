package de.sol.swarmflow.game {
	import robotlegs.bender.extensions.simpleViewExtension.impl.FlashView;

	/**
	 * @author sol23
	 */
	public class BackgroundView extends FlashView {


		override public function initialize():void {
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
	}
}
