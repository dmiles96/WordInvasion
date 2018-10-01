package iface.client.presentation.city
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ICityPresentation 
	{
		function addCityPresentationListener( cityPresentationListener:ICityPresentationListener ):void;
		function getDisplay():Sprite;
	}
	
}