package iface.common.domain.enemy 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ISpecialEnemyNotifier 
	{
		function registerSpecialEnemyForNotification( specialEnemy:ISpecialEnemy ):void;
		function unregisterSpecialEnemyFromNotification( specialEnemy:ISpecialEnemy ):void;
	}
	
}