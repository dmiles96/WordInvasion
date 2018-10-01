package iface.common.domain.enemy 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IEnemyListener 
	{
		function moved( x:int, y:int ):void;
		function enemyDied():void;
		function numMatchedCharsUpdated( characterEndIndex:int ):void;
		function enemyExploding( enemy:IEnemy ):void;
	}
	
}