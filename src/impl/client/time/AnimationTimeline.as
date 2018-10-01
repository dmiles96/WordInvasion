package impl.client.time 
{
	import iface.client.animation.IAnimationEngine;
	import iface.client.time.IAnimationTimeline;
	import iface.common.time.ITimeline;
	import impl.common.time.Timeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AnimationTimeline extends Timeline implements IAnimationTimeline
	{
		private var animationEngine:IAnimationEngine = null;
		
		public function AnimationTimeline(animationFramesPerSecond:int, animationEngine:IAnimationEngine) 
		{
			super( animationFramesPerSecond );

			this.animationEngine = animationEngine;
		}
	
		public function getAnimationEngine():IAnimationEngine
		{
			return this.animationEngine;
		}
		
		public override function tick( tickDelta:int ):void
		{
			this.animationEngine.tick(tickDelta);			
		}
	}
	
}