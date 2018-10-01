package impl.common.domain.enemy 
{
	import iface.common.domain.enemy.EnemyTypes;
	import iface.common.domain.enemy.IBonusWord;
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.enemy.IPositioner;
	import iface.common.domain.enemy.IVelocityComputer;
	import iface.common.domain.IClipper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BonusWord extends FlyingEnemy implements IBonusWord
	{
		
		public function BonusWord(data:String, positioner:IPositioner, clipper:IClipper, velocityComputer:IVelocityComputer, width:int, height:int, ticksToExplode:int, playAreaWidth:int, millisecondsPerTick:int) 
		{
			super(data, positioner, clipper, velocityComputer, width, height, ticksToExplode, playAreaWidth, millisecondsPerTick, velocityComputer.computeFlyingEnemyVelocity(width));
		}
		
		public function getType():int
		{
			return EnemyTypes.BONUS_WORD_ENEMY_TYPE;
		}
	}
	
}