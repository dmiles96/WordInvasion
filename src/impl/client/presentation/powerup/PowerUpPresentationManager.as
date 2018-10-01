package impl.client.presentation.powerup 
{
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextFormat;
	import iface.client.presentation.powerup.IPowerUpPresentation;
	import iface.client.presentation.powerup.IPowerUpPresentationManager;
	import iface.client.presentation.powerup.IPowerUpPresentationManagerListener;
	import iface.client.service.audio.IGameSound;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import iface.common.domain.powerup.IPowerUpManager;
	import iface.common.domain.powerup.IPowerUpManagerListener;
	import iface.common.domain.powerup.PowerUpTypes;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PowerUpPresentationManager implements IPowerUpPresentationManager, IPowerUpManagerListener
	{
		private var powerUpWidth:int = 0;
		private var powerUpHeight:int = 0;
		private var slots:Array = null;
		private var drawingSurface:ICanvas = null;
		private var canvasFactory:ICanvasFactory = null;
		private var powerUpPresentationManagerListeners:Array = new Array();
		private var powerUpAppearsSound:IGameSound = null;
		private var powerUpSlotEmptySound:IGameSound = null;
		private var powerUpExplodeSound:IGameSound = null;
		private var powerUpPauseSound:IGameSound = null;
		private var powerUpRevealSound:IGameSound = null;
		private var powerUpCharacterFormat:TextFormat = null;
		
		public function PowerUpPresentationManager( canvasFactory:ICanvasFactory, powerUpManager:IPowerUpManager, maxNumPowerUps:int, drawingSurface:ICanvas, powerUpEndX:int, powerUpStartY:int, powerUpWidth:int, powerUpHeight:int, powerUpPadding:int, powerUpAppearsSound:IGameSound, powerUpSlotEmptySound:IGameSound, powerUpExplodeSound:IGameSound, powerUpPauseSound:IGameSound, powerUpRevealSound:IGameSound, powerUpCharacterFormat:TextFormat ) 
		{
			this.drawingSurface = drawingSurface;
			this.powerUpWidth = powerUpWidth;
			this.powerUpHeight = powerUpHeight;
			this.canvasFactory = canvasFactory;
			this.powerUpAppearsSound = powerUpAppearsSound;
			this.powerUpSlotEmptySound = powerUpSlotEmptySound;
			this.powerUpExplodeSound = powerUpExplodeSound;
			this.powerUpPauseSound = powerUpPauseSound;
			this.powerUpRevealSound = powerUpRevealSound;
			this.powerUpCharacterFormat = powerUpCharacterFormat;
			
			this.slots = new Array( maxNumPowerUps );
			
			var powerUpStartX:int = powerUpEndX - powerUpPadding;
			
			for ( var slotPositionIndex:int = 0; slotPositionIndex < maxNumPowerUps; slotPositionIndex++ )
			{
				powerUpStartX -= this.powerUpWidth;
				this.slots[slotPositionIndex] = new PowerUpPresentationSlot( this.drawingSurface, new Point( powerUpStartX, powerUpStartY ));
				powerUpStartX -= powerUpPadding;
			}
			
			this.slots.reverse();
			
			powerUpManager.addPowerUpManagerListener( this );
		}
		
		public function powerUpUsed( slotNumber:int ):void
		{
			var powerUpPresentationSlot:PowerUpPresentationSlot = this.slots[slotNumber];
			var powerUpPresentation:IPowerUpPresentation = powerUpPresentationSlot.empty();
			
			this.firePowerUpsUpdatedEvent();
			powerUpPresentation.playSound();
		}
		
		public function slotEmpty( slotNumber:int ):void
		{
			this.powerUpSlotEmptySound.play();
		}
		
		public function powerUpAdded( powerUpType:int, slotNumber:int ):void
		{
			var powerUpPresentationSlot:PowerUpPresentationSlot = this.slots[slotNumber];
			
			powerUpPresentationSlot.fill(this.createPowerUpPresentation(powerUpType));
			this.firePowerUpsUpdatedEvent();
			this.powerUpAppearsSound.play();
		}

		public function addPowerUpPresentationManagerListener( powerUpPresentationManagerListener:IPowerUpPresentationManagerListener ):void
		{
			this.powerUpPresentationManagerListeners.push( powerUpPresentationManagerListener );
		}
		
		private function createPowerUpPresentation( powerUpType:int ):IPowerUpPresentation
		{
			if ( powerUpType == PowerUpTypes.EXPLODE_POWERUP )
			{
				return new ExplodePowerUpPresentation(canvasFactory, this.powerUpWidth, this.powerUpHeight, this.powerUpExplodeSound, this.powerUpCharacterFormat);
			}
			else if ( powerUpType == PowerUpTypes.PAUSE_POWERUP )
			{
				return new PausePowerUpPresentation(canvasFactory, this.powerUpWidth, this.powerUpHeight, this.powerUpPauseSound, this.powerUpCharacterFormat);
			}
			else if ( powerUpType == PowerUpTypes.REVEAL_POWERUP )
			{
				return new RevealPowerUpPresentation(canvasFactory, this.powerUpWidth, this.powerUpHeight, this.powerUpRevealSound, this.powerUpCharacterFormat);
			}
			
			return null;
		}
		
		private function firePowerUpsUpdatedEvent():void
		{
			if ( this.powerUpPresentationManagerListeners[0] != null )
				this.powerUpPresentationManagerListeners[0].powerUpsUpdated();
		}
	}
	
}