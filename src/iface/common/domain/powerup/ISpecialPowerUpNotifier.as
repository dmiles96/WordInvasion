package iface.common.domain.powerup 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ISpecialPowerUpNotifier 
	{
		function registerSpecialPowerUpForNotification( specialPowerUp:IPowerUp ):void;
		function unregisterSpecialPowerUpFromNotification( specialPowerUp:IPowerUp ):void;
	}
	
}