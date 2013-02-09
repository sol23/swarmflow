/**
 * User: Sol23
 */
package de.sol.swarmflow {
	import de.sol.swarmflow.SwarmFlowMain;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class SwarmFlowMediator extends Mediator {

		[Inject]
		public var view:SwarmFlowMain;

		override public function initialize():void {
			super.initialize();

			view.createContainer();
		}
	}
}
