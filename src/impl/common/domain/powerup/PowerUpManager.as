package impl.common.domain.powerup 
{
	import iface.common.domain.powerup.IPowerUp;
	import iface.common.domain.powerup.IPowerUpCommandExecutor;
	import iface.common.domain.powerup.IPowerUpManager;
	import iface.common.domain.powerup.IPowerUpManagerListener;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PowerUpManager implements IPowerUpManager
	{
		private var powerUpSlots:Array = null;
		private var powerUpManagerListeners:Array = new Array();
		private var powerUpFactory:PowerUpFactory = null;
		
		public function PowerUpManager( powerUpFactory:PowerUpFactory, maxNumPowerUps:int ) 
		{
			this.powerUpFactory = powerUpFactory;
			
			this.powerUpSlots = new Array( maxNumPowerUps );
		}
		
		public function usePowerUp( slotNumber:int ):void
		{
			var powerUp:IPowerUp = this.powerUpSlots[slotNumber];
			
			if ( powerUp != null )
			{
				powerUp.apply();
				this.powerUpSlots[slotNumber] = null;
				
				firePowerUpUsedEvent( slotNumber );
			}
			else
			{
				fireSlotEmptyEvent( slotNumber );
			}
		}
		
		public function addPowerUp( powerUpType:int ):void
		{			
			for ( var powerUpIndex:int = 0; powerUpIndex < powerUpSlots.length; powerUpIndex++ )
			{
				if ( this.powerUpSlots[powerUpIndex] == null )
				{
					this.powerUpSlots[powerUpIndex] = this.powerUpFactory.createPowerUp( powerUpType );
					this.firePowerUpAddedEvent(powerUpType, powerUpIndex);
					
					break;
				}
			}
		}
		
		public function addPowerUpManagerListener( powerUpManagerListener:IPowerUpManagerListener ):void
		{
			this.powerUpManagerListeners.push( powerUpManagerListener );
		}
		
		private function firePowerUpUsedEvent( slotNumber:int ):void
		{
			if ( powerUpManagerListeners[0] != null )
				powerUpManagerListeners[0].powerUpUsed( slotNumber );
		}
		
		private function fireSlotEmptyEvent( slotNumber:int ):void
		{
			if ( powerUpManagerListeners[0] != null )
				powerUpManagerListeners[0].slotEmpty( slotNumber );
		}
		
		private function firePowerUpAddedEvent( powerUpType:int, slotNumber:int ):void
		{
			if ( powerUpManagerListeners[0] != null )
				powerUpManagerListeners[0].powerUpAdded( powerUpType, slotNumber );
		}

	}
	
}