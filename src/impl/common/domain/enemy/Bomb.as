package impl.common.domain.enemy 
{
	import iface.common.domain.enemy.EnemyTypes;
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.enemy.IPositioner;
	import iface.common.domain.enemy.IVelocityComputer;
	import iface.common.domain.ICollisionDetector;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Bomb extends FallingEnemy implements IEnemy
	{
		
		public function Bomb(data:String, positioner:IPositioner, collisionDetector:ICollisionDetector, velocityComputer:IVelocityComputer, width:int, height:int, ticksToExplode:int) 
		{
			super(data, positioner, collisionDetector, velocityComputer, width, height, ticksToExplode, velocityComputer.computeBombVelocity(height));
		}
		
		public function getType():int
		{
			return EnemyTypes.BOMB_ENEMY_TYPE;
		}
	}
	
}