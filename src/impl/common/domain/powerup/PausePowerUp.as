package impl.common.domain.powerup 
{
	import iface.common.domain.powerup.IPowerUpCommandExecutor;
	import iface.common.domain.powerup.ISpecialPowerUp;
	import iface.common.domain.powerup.ISpecialPowerUpNotifier;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PausePowerUp implements ISpecialPowerUp
	{
		private var powerUpCommandExecutor:IPowerUpCommandExecutor = null;
		private var ticksToPause:int = 0;
		private var pauseCounter:int = 0;
		private var specialPowerUpNotifier:ISpecialPowerUpNotifier = null;
		
		public function PausePowerUp(specialPowerUpNotifier:ISpecialPowerUpNotifier, powerUpCommandExecutor:IPowerUpCommandExecutor, ticksToPause:int) 
		{
			this.powerUpCommandExecutor = powerUpCommandExecutor;
			this.ticksToPause = ticksToPause;
			this.specialPowerUpNotifier = specialPowerUpNotifier;
		}
		
		public function apply():void
		{
			this.powerUpCommandExecutor.pauseEnemies();
			this.specialPowerUpNotifier.registerSpecialPowerUpForNotification(this);
		}
		
		public function notify( notificationDelta:int ):void
		{
			this.pauseCounter += notificationDelta;
			
			if ( pauseCounter >= this.ticksToPause )
			{
				this.powerUpCommandExecutor.unpauseEnemies();
				this.specialPowerUpNotifier.unregisterSpecialPowerUpFromNotification(this);
			}
		}
	}
	
}