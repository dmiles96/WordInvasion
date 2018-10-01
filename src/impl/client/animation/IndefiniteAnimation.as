package impl.client.animation 
{
	import iface.client.animation.IIndefiniteAnimation;
	
	/**
	 * ...
	 * @author ...
	 */
	public class IndefiniteAnimation extends Animation implements IIndefiniteAnimation
	{
		private var propertyName:String = null;
		private var valueDelta:int = 0;
		private var ticksForMove:int = 0;
		private var targetObject:Object = null;
		private var moveTickCounter:int = 0;
		
		public function IndefiniteAnimation( 	ticksForMove:int, 
												valueDelta:Number, 
												targetObject:Object, 
												propertyName:String) 
		{
			this.ticksForMove = ticksForMove;
			this.valueDelta = valueDelta;
			this.targetObject = targetObject;
			this.propertyName = propertyName;
		}
		
		public function updateRate( rateDelta:int ):void
		{
			this.ticksForMove = this.ticksForMove + rateDelta;
		}
		
		public override function tick( tickDelta:int ):void
		{
			this.moveTickCounter += tickDelta;
			
			if ( this.moveTickCounter > this.ticksForMove )
			{
				this.targetObject[this.propertyName] += this.valueDelta;
				this.moveTickCounter = 0;
			}
		}
		
		public override function isDone():Boolean
		{
			return false;
		}
	}
	
}