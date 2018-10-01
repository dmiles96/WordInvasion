package iface.client.presentation.score 
{
	import iface.client.service.video.ICanvas;
	import iface.common.time.ITickHandler;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IScoreManagerPresentation
	{
		function getCanvas():ICanvas;
		function isShowingBonusMessage():Boolean;
		function clearBonusMessage():void;
		function addScoreManagerPresentationListener( scoreManagerPresentationListener:IScoreManagerPresentationListener ):void;
	}
	
}