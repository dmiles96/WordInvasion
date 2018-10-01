package iface.common.domain.enemy 
{
	import iface.common.domain.IClipper;
	import iface.common.domain.ICollisionDetector;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IEnemyFactory 
	{
		function createEnemy( enemyType:int, positioner:IPositioner, collisionDetector:ICollisionDetector, clipper:IClipper, velocityComputer:IVelocityComputer, charExclusionMap:CharacterExclusionMap, specialEnemyNotifier:ISpecialEnemyNotifier, notificationsPerSecond:int, bombCreator:IBombCreator ):IEnemy;
		function createBomb( data:String, positioner:IPositioner, collisionDetector:ICollisionDetector, velocityComputer:IVelocityComputer, charExclusionMap:CharacterExclusionMap ):IEnemy;
	}
	
}