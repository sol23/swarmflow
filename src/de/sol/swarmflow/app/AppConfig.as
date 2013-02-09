package de.sol.swarmflow.app {
	import de.sol.swarmflow.*;
	import de.sol.swarmflow.SwarmFlowMediator;
	import de.sol.swarmflow.game.BackgroundMediator;
	import de.sol.swarmflow.game.BackgroundView;
	import de.sol.swarmflow.game.StartGameCommand;

	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;

	/**
	 * @author sol23
	 */
	public class AppConfig implements IConfig {

		[Inject]
		public var context:IContext;
		[Inject]
		public var eventMap:IEventCommandMap;
		[Inject]
		public var mediatorMap:IMediatorMap;
		[Inject]
		public var dispatcher:IEventDispatcher;
		[Inject]
		public var contextView:ContextView;

		public function configure():void {
			eventMap.map(Event.INIT).toCommand(StartGameCommand);
			mediatorMap.map(SwarmFlowMain).toMediator(SwarmFlowMediator);
			mediatorMap.map(BackgroundView).toMediator(BackgroundMediator);

			context.lifecycle.afterInitializing(init);
		}

		private function init():void {
			mediatorMap.mediate(contextView.view);
			dispatcher.dispatchEvent(new Event(Event.INIT));
		}
	}
}
