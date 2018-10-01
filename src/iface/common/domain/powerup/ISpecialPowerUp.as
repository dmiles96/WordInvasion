package iface.common.domain.powerup 
{
	import iface.common.time.ITickHandler;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ISpecialPowerUp extends IPowerUp
	{
		function notify( notificationDelta:int ):void;
	}
	
}