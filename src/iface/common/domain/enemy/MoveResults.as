package iface.common.domain.enemy 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class MoveResults 
	{
		public static const MOVE_SUCCESSFUL:int = 0;
		public static const MOVE_FAILURE_COLLISION:int = 1;
		public static const MOVE_FAILURE_OFFSCREEN:int = 2;
		public static const MOVE_FAILURE_PAUSED:int = 3;
	}
	
}