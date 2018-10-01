package impl.client.animation 
{
	import iface.client.animation.IWaitAnimation;
	
	/**
	 * ...
	 * @author ...
	 */
	public class WaitAnimation extends Animation implements IWaitAnimation
	{
		
		private var func:Function = null;
		private var ticksToWait:int = 0;
		private var targetObject:Object = null;
		private var waitTickCounter:int = 0;
		
		public function WaitAnimation(	ticksToWait:int, 
										targetObject:Object, 
										func:Function)
		{
			this.ticksToWait = ticksToWait;
			this.targetObject = targetObject;
			this.func = func;
		}
		
		public override function tick( tickDelta:int ):void
		{
			this.waitTickCounter += tickDelta;
			
			if ( this.ticksToWait <= this.waitTickCounter )
			{
				func.call(this.targetObject);
				this.waitTickCounter = 0;
			}
		}
		
		public function reset():void
		{
			this.waitTickCounter = 0;
		}
	}
}