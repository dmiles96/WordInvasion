package iface.common.domain.powerup 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IPowerUpManager 
	{
		function addPowerUp( powerUpType:int ):void;
		function usePowerUp( slotNumber:int ):void;
		function addPowerUpManagerListener( powerUpManagerListener:IPowerUpManagerListener ):void;
	}
	
}