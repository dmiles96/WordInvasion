package iface.client.presentation.score 
{
	import iface.client.service.video.ICanvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IScoreManagerPresentationListener 
	{
		function scoreDisplayChanged(scoreCanvas:ICanvas):void;
	}
	
}