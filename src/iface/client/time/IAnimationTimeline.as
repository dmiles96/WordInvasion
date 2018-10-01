package iface.client.time 
{
	import iface.client.animation.IAnimationEngine;
	import iface.common.time.ITimeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IAnimationTimeline extends ITimeline
	{
		function getAnimationEngine():IAnimationEngine;
	}
	
}