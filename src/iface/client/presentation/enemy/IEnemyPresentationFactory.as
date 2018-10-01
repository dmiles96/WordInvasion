package iface.client.presentation.enemy 
{
	import iface.common.domain.enemy.IEnemy;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IEnemyPresentationFactory 
	{
		function createEnemyPresentation( enemy:IEnemy ):IEnemyPresentation;
	}
	
}