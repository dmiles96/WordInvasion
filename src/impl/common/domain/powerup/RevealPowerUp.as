package impl.common.domain.powerup 
{
	import iface.common.domain.powerup.IPowerUp;
	import iface.common.domain.powerup.IPowerUpCommandExecutor;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RevealPowerUp implements IPowerUp
	{
		private var powerUpCommandExecutor:IPowerUpCommandExecutor = null;
		
		public function RevealPowerUp(powerUpCommandExecutor:IPowerUpCommandExecutor) 
		{
			this.powerUpCommandExecutor = powerUpCommandExecutor;
		}
		
		public function apply():void
		{
			this.powerUpCommandExecutor.revealLetters();
		}		
	}
	
}