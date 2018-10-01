package iface.client.presentation.enemy 
{
	import iface.client.service.video.ICanvas;
	import iface.common.domain.enemy.IEnemy;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IEnemyPresentation 
	{
		function move(moveDelta:int):void;
		function getCanvas():ICanvas;
		function addEnemyPresentationListener( enemyPresentationListener:IEnemyPresentationListener ):void;
		function present( drawingSurface:ICanvas ):void;
	}
	
}