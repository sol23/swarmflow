/**
 * User: Sol23
 */
package de.sol.swarmflow.game.components {
	import ash.fsm.EntityStateMachine;

	public class Particle {

		public static const STATE_SPAWN:String = "spawn";
		public static const STATE_SLEEP:String = "sleep";
		public static const STATE_ACTIVE:String = "active";

		public var states:EntityStateMachine;

		public function Particle(states:EntityStateMachine) {
			this.states = states;
		}
	}
}
