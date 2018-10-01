package impl.common.scope 
{
	import iface.common.domain.IGame;
	import iface.common.scope.ISessionScope;
	import iface.common.time.IGameTimeline;
	import iface.common.time.IMasterTimeline;
	import iface.common.time.ITimeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SessionScope implements ISessionScope
	{
		private var gameTimeline:IGameTimeline = null;
		private var masterTimeline:IMasterTimeline = null;
		private var inputTimeline:ITimeline = null;
		
		public function SessionScope(masterTimeline:IMasterTimeline, gameTimeline:IGameTimeline) 
		{
			this.masterTimeline = masterTimeline;
			this.gameTimeline = gameTimeline;
		}
		
		public function getGameTimeline():IGameTimeline
		{
			return gameTimeline;
		}
		
		public function getMasterTimeline():IMasterTimeline
		{
			return masterTimeline;
		}
	}
	
}