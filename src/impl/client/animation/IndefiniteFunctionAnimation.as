package impl.client.animation 
{
	import iface.client.animation.IIndefiniteAnimation;
	/**
	 * ...
	 * @author ...
	 */
	public class IndefiniteFunctionAnimation extends Animation implements IIndefiniteAnimation
	{
		private var func:Function = null;
		private var ticksForMove:int = 0;
		private var targetObject:Object = null;
		private var moveTickCounter:int = 0;
		
		public function IndefiniteFunctionAnimation(ticksForMove:int, 
													targetObject:Object, 
													func:Function)
		{
			this.ticksForMove = ticksForMove;
			this.targetObject = targetObject;
			this.func = func;
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
				func.call(this.targetObject );
				this.moveTickCounter = 0;
			}
		}
		
		public override function isDone():Boolean
		{
			return false;
		}
	}
}