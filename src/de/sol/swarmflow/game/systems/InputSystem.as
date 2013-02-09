/**
 * User: Sol23
 */
package de.sol.swarmflow.game.systems {
	import ash.core.Engine;
	import ash.core.Node;
	import ash.core.NodeList;
	import ash.core.System;

	import de.sol.swarmflow.game.EntityCreator;
	import de.sol.swarmflow.game.GameConfig;
	import de.sol.swarmflow.game.nodes.TouchNode;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Dictionary;

	public class InputSystem extends System {

		[Inject]
		public var creator:EntityCreator;

		private const touches:Dictionary = new Dictionary(true);
		private var _container:DisplayObjectContainer;
		private var _touchNodes:NodeList;

		public function InputSystem(container:DisplayObjectContainer) {
			_container = container;
			if (!_container.stage) {
				_container.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
			} else {
				init();
			}
		}

		override public function update(time:Number):void {
			for (var touchNode:TouchNode = _touchNodes.head; touchNode; touchNode = touchNode.next) {
				touchNode.scalableDisplay.update(touchNode.strength.factor);
			}
		}

		override public function addToEngine(engine:Engine):void {
			_touchNodes = engine.getNodeList(TouchNode);
			_touchNodes.nodeAdded.add(onNodeAdded);
		}

		override public function removeFromEngine(engine:Engine):void {
			_touchNodes.nodeAdded.remove(onNodeAdded);
			_touchNodes = null;
		}

		/** initialize input handler
		 *
		 */
		private function init():void {
			if (Multitouch.supportsTouchEvents) {
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				_container.stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin, true);
				_container.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove, true);
				_container.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd, true);
			} else {
				_container.stage.addEventListener(MouseEvent.MOUSE_DOWN, onTouchBegin, true);
				_container.stage.addEventListener(MouseEvent.MOUSE_MOVE, onTouchMove, true);
				_container.stage.addEventListener(MouseEvent.MOUSE_UP, onTouchEnd, true);
			}
		}

		private function onAddedToStage(event:Event):void {
			init();
		}

		private function onNodeAdded(newNode:TouchNode):void {
			var oldNode:Node = touches[newNode.touch.id];
			if (oldNode) creator.destroyEntity(oldNode.entity);
			touches[newNode.touch.id] ||= newNode;
		}

		private function onTouchBegin(e:Event):void {
			var me:MouseEvent;
			var te:TouchEvent;
			if ((me = e as MouseEvent)) {
				creator.createTouchPoint(me.stageX, me.stageY, GameConfig.TOUCH_REACH);
			} else if ((te = e as TouchEvent) && te.touchPointID < GameConfig.MAX_TOUCHES) {
				creator.createTouchPoint(te.stageX, te.stageY, GameConfig.TOUCH_REACH, te.touchPointID, te.pressure);
			}
		}

		private function onTouchMove(e:Event):void {
			var te:TouchEvent;
			var me:MouseEvent;
			if ((te = e as TouchEvent) && te.touchPointID < GameConfig.MAX_TOUCHES) {
				touches[te.touchPointID].strength.factor = te.pressure;
				touches[te.touchPointID].position.x = te.stageX;
				touches[te.touchPointID].position.y = te.stageY;
			} else if ((me = e as MouseEvent) && me.buttonDown) {
				touches[0].position.x = me.stageX;
				touches[0].position.y = me.stageY;
			}
		}

		private function onTouchEnd(e:Event):void {
			var te:TouchEvent = e as TouchEvent;
			var id:int = te ? te.touchPointID : 0;
			if (touches[id]) creator.destroyEntity(touches[id].entity);
			delete touches[id];
		}
	}
}
