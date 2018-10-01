package iface.common.domain.powerup 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IPowerUpManagerFactory 
	{
		function createPowerUpManager(specialPowerUpNotifier:ISpecialPowerUpNotifier, powerUpCommandExecutor:IPowerUpCommandExecutor):IPowerUpManager;
	}
	
}