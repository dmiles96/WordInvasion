package impl.common.domain.enemy 
{
	import iface.common.domain.enemy.EnemyTypes;	
	import iface.common.domain.enemy.IPositioner;
	import iface.common.domain.enemy.IVelocityComputer;
	import iface.common.domain.enemy.IWord;
	import iface.common.domain.ICollisionDetector;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Word extends FallingEnemy implements IWord
	{
		public function Word( data:String, positioner:IPositioner, collisionDetector:ICollisionDetector, velocityComputer:IVelocityComputer, width:int, height:int, ticksToExplode:int ) 
		{
			super(data, positioner, collisionDetector, velocityComputer, width, height, ticksToExplode, velocityComputer.computeFallingEnemyVelocity(height));
		}
		
		public function getType():int
		{
			return EnemyTypes.NORMAL_WORD_ENEMY_TYPE;
		}		
	}
	
}