package impl.common.domain.powerup 
{
	import flash.utils.Dictionary;
	import iface.common.configuration.IApplicationConfiguration;
	import iface.common.domain.powerup.IPowerUp;
	import iface.common.domain.powerup.IPowerUpCommandExecutor;
	import iface.common.domain.powerup.ISpecialPowerUpNotifier;
	import iface.common.domain.powerup.PowerUpTypes;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PowerUpFactory
	{
		private var powerUpCommandExecutor:IPowerUpCommandExecutor = null;
		private var appConfig:IApplicationConfiguration = null;
		private var specialPowerUpNotifier:ISpecialPowerUpNotifier = null;
		
		public function PowerUpFactory(specialPowerUpNotifier:ISpecialPowerUpNotifier, powerUpCommandExecutor:IPowerUpCommandExecutor, appConfig:IApplicationConfiguration) 
		{
			this.powerUpCommandExecutor = powerUpCommandExecutor;
			this.specialPowerUpNotifier = specialPowerUpNotifier;
			this.appConfig = appConfig;
		}
		
		public function createPowerUp( powerUpType:int ):IPowerUp
		{
			if ( powerUpType == PowerUpTypes.EXPLODE_POWERUP )
			{
				return new ExplodePowerUp(powerUpCommandExecutor);
			}
			else if ( powerUpType == PowerUpTypes.PAUSE_POWERUP )
			{
				return new PausePowerUp(specialPowerUpNotifier, powerUpCommandExecutor, this.appConfig.getTicksForPausePowerUpToPause());
			}
			else if ( powerUpType == PowerUpTypes.REVEAL_POWERUP )
			{
				return new RevealPowerUp(powerUpCommandExecutor);
			}
			
			return null;
		}
	}
	
}