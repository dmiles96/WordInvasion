package impl.common.time
{
	import iface.common.time.ITimeline;
	import iface.common.time.ITimelineTickRecord;
	
	/**
	 * ...
	 * 
	 * @author ...
	 */
	public class TimelineTickRecord implements ITimelineTickRecord
	{
		private var tickDelay:Number = 0;
		private var timeline:ITimeline = null;
		private var curTicks:Number = 0;
		
		public function TimelineTickRecord(  tickDelay:int, timeline:ITimeline ) 
		{
			this.tickDelay =  tickDelay;
			this.timeline = timeline;
		}
		
		public function tick( tickDelta:int ):void
		{
			this.curTicks += tickDelta;
			
			if ( this.curTicks > this.tickDelay )
			{
				var curTickDelta:int = int(this.curTicks / this.tickDelay);
				var extraTicks:int = this.curTicks % this.tickDelay;
				
				//this.timeline.tick(curTickDelta);
				this.curTicks += extraTicks;
			}
			else if ( this.curTicks == this.tickDelay )
			{
				this.timeline.tick(1);
				this.curTicks = 0;
			}
		}
	}
	
}