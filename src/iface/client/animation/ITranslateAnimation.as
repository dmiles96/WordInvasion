package iface.client.animation 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ITranslateAnimation extends IAnimation
	{
		function updateValues( curValue:int, endValue:int ):void;
	}
	
}