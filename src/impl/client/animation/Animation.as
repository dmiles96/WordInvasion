package impl.client.animation 
{
	import iface.client.animation.IAnimation;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Animation implements IAnimation
	{
		private var paused:Boolean = false;
		private var complete:Boolean = false;
		
		public function isDone():Boolean {  return complete; }
		public function tick( tickDelta:int ): void { /* abstract */ }
		
		public function isPaused():Boolean
		{
			return paused;
		}
		
		public function pause():void
		{
			this.paused = true;
		}
		
		public function play():void
		{
			this.paused = false;
		}
		
		public function cancel():void
		{
			this.complete = true;
		}
		
		public function done():void
		{
			this.complete = true;
		}
		
		public function run():void
		{
			
		}
	}
	
}