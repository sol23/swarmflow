package de.sol.swarmflow {
	import ash.integration.robotlegs.AshExtension;

	import de.sol.swarmflow.app.AppConfig;
	import de.sol.swarmflow.app.MenuContainer;
	import de.sol.swarmflow.game.GameConfig;
	import de.sol.swarmflow.game.GameContainer;

	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;

	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.simpleViewExtension.SimpleViewConfig;
	import robotlegs.bender.extensions.viewProcessorMap.ViewProcessorMapExtension;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	import robotlegs.bender.framework.impl.Context;

	/**
	 * @author sol23
	 */
	public class SwarmFlowMain extends Sprite {

		private var context:IContext;

		private var gameContainer:GameContainer;
		private var menuContainer:MenuContainer;

		public function SwarmFlowMain() {
			this.addEventListener(Event.ENTER_FRAME, init);
			stage.frameRate = 60;
		}

		protected function init(e:Event):void {
			this.removeEventListener(Event.ENTER_FRAME, init);

			// Initializing Context
			context = new Context();
			CONFIG::debug {
				context.logLevel = LogLevel.DEBUG;
			}
			context
					.install(MVCSBundle)
					.install(ViewProcessorMapExtension)
					.install(AshExtension)
					.configure(SimpleViewConfig)
					.configure(AppConfig)
					.configure(new GameConfig(gameContainer = new GameContainer()))
					.configure(new ContextView(this));

			if (Capabilities.cpuArchitecture == "ARM") {
				NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, onActivate, false, 0, true);
				NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onDeactivate, false, 0, true);
				NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
			}
		}

		public function createContainer():void {
			addChild(gameContainer);

			menuContainer = new MenuContainer();
			addChild(menuContainer);
		}

		private function onDeactivate(e:Event):void {

		}

		private function onActivate(e:Event):void {

		}

		private function onKeyDown(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.BACK:
					NativeApplication.nativeApplication.exit();
					break;
			}
		}
	}
}
