/**
 * User: Sol23
 */
package de.sol.swarmflow.game.systems {
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;

	import de.sol.swarmflow.game.components.Display;

	import de.sol.swarmflow.game.components.Position;

	import de.sol.swarmflow.game.nodes.RenderNode;

	import flash.display.DisplayObject;

	import flash.display.DisplayObjectContainer;

	public class RenderSystem extends System {
		private var _container:DisplayObjectContainer;
		private var nodes:NodeList;

		public function RenderSystem(container:DisplayObjectContainer) {
			super();
			_container = container;
		}

		private function addToDisplay(node:RenderNode):void {
			_container.addChild(node.display.displayObject);
		}

		private function removeFromDisplay(node:RenderNode):void {
			_container.removeChild(node.display.displayObject);
		}

		override public function addToEngine(engine:Engine):void {
			nodes = engine.getNodeList(RenderNode);

			for (var node:RenderNode = nodes.head; node; node = node.next) {
				addToDisplay(node);
			}
			nodes.nodeAdded.add(addToDisplay);
			nodes.nodeRemoved.add(removeFromDisplay);
		}

		override public function update(time:Number):void {
			var node:RenderNode;
			var position:Position;
			var display:Display;
			var displayObject:DisplayObject;

			for (node = nodes.head; node; node = node.next) {
				display = node.display;
				displayObject = display.displayObject;
				position = node.position;

				displayObject.x = position.x;
				displayObject.y = position.y;
				displayObject.rotation = position.rotation * 180 / Math.PI;
			}
		}
	}
}
