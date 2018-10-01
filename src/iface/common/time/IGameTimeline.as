package iface.common.time 
{
	import iface.common.domain.IGame;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IGameTimeline extends ITimeline
	{
		function getGame(): IGame;
	}
	
}