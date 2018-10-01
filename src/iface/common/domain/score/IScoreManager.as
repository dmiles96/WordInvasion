package iface.common.domain.score 
{
	import iface.common.domain.enemy.IEnemy;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IScoreManager 
	{
		function scoreNonExsistantLetter():void;
		function scoreTypo():void;
		function scoreEnemyDeath( enemy:IEnemy ):void;
		function addScoreListener( scoreListener:IScoreListener ):void;
		function getScore():int;
	}
	
}