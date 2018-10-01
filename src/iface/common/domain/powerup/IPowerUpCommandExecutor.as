package iface.common.domain.powerup 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IPowerUpCommandExecutor 
	{
		function destroyEnemies():void;
		function pauseEnemies():void;
		function unpauseEnemies():void;
		function revealLetters():void;
	}
	
}