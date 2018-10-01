package iface.common.domain.level 
{
	import iface.common.domain.enemy.IEnemy;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ILevelListener 
	{
		function enemyCreated( enemey:IEnemy ):void;
		function enemyDeath( enemy:IEnemy ):void;
		function enemiesMoved( numEnemiesMoved:int ):void;
		function typo():void;
	}
	
}