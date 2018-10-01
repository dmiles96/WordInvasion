package impl.client.time 
{
	import iface.client.service.timer.ITimer;
	import iface.client.service.video.IRenderer;
	import iface.client.service.timer.ITimerHandler;
	import iface.client.time.ITimelineFactory;
	import iface.common.time.IMasterTimeline;
	import iface.common.time.ITimeline;
	import iface.common.time.ITimelineTickRecord;
	import impl.common.time.Timeline;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MasterTimeline implements IMasterTimeline, ITimerHandler
	{
		private var ticksPerSecond:int = 0;
		private var timer:ITimer = null;
		private var timelineTickRecords:Array = new Array();
		private var timelineFactory:ITimelineFactory = null;
		private var millisecondsPerTick:int = 0;
		private var running:Boolean = false;
		
		public function MasterTimeline(timelineFactory:ITimelineFactory, timer:ITimer, millisecondsPerTick:int) 
		{
			this.ticksPerSecond = 1000 / millisecondsPerTick;
			this.timer = timer;
			this.timelineFactory = timelineFactory;
			this.millisecondsPerTick = millisecondsPerTick;
		}
		
		public function start():void
		{
			timer.start(millisecondsPerTick, this);
			this.running = true;
		}
		
		public function stop():void
		{
			timer.stop();
			this.running = false;
		}
		
		public function addTimeline(timeline:ITimeline):void
		{
			var tickDelay:int = int( ticksPerSecond / timeline.getTicksPerSecond());

			if ( tickDelay == 0 )
				tickDelay = 1;
				
			timelineTickRecords.push( this.timelineFactory.createTimelineTickRecord( tickDelay, timeline ));
		}

		public function timerTick( millisecondDelta:int, renderer:IRenderer ):void
		{
			//var startTime:int = flash.utils.getTimer();
			
			for each( var timelineTickRecord:ITimelineTickRecord in this.timelineTickRecords )
			{
				if ( !this.running )
					break;
					
				timelineTickRecord.tick(1);
			}
			
			renderer.render();
			renderer.renderEnd();
			
			//trace( "duration: ", getTimer() - startTime);
		}
		
	}
	
}