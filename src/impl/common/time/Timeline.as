package impl.common.time 
{
	import iface.common.time.ITimeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Timeline implements ITimeline
	{
		private var ticksPerSecond:int = 0;
		
		public function Timeline(ticksPerSecond:int) 
		{
			this.ticksPerSecond = ticksPerSecond;
		}
		
		public function getTicksPerSecond():int
		{
			return this.ticksPerSecond;
		}
		
		public function tick(tickDelta:int):void { /* abstract */ }
	}
	
}