package impl.common.domain.level 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class EnemyDestructionRecord 
	{
		private var powerUpDeath:Boolean = false;
		
		public function EnemyDestructionRecord( powerUpDeath:Boolean ) 
		{
			this.powerUpDeath = powerUpDeath
		}
		
		public function isPowerUpDeath():Boolean
		{
			return this.powerUpDeath;
		}
	}
	
}