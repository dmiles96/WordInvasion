package impl.common.domain.powerup 
{
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.powerup.IPowerUp;
	import iface.common.domain.powerup.IPowerUpCommandExecutor;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ExplodePowerUp implements IPowerUp
	{
		private var powerUpCommandExecutor:IPowerUpCommandExecutor = null;
		
		public function ExplodePowerUp(powerUpCommandExecutor:IPowerUpCommandExecutor) 
		{
			this.powerUpCommandExecutor = powerUpCommandExecutor;
		}
		
		public function apply():void
		{
			this.powerUpCommandExecutor.destroyEnemies();
		}
		
	}
	
}