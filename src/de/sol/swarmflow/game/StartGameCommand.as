package de.sol.swarmflow.game {
	import ash.core.Engine;
	import ash.tick.ITickProvider;

	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	import robotlegs.bender.framework.api.ILogger;

	/**
	 * @author sol23
	 */
	public class StartGameCommand implements ICommand {

		[Inject]
		public var logger:ILogger;

		[Inject]
		public var engine:Engine;

		[Inject]
		public var creator:EntityCreator;

		[Inject]
		public var tickProvider:ITickProvider;

		public function execute():void {
			tickProvider.add(engine.update);
			tickProvider.start();

			creator.createParticle(true);
		}
	}
}
