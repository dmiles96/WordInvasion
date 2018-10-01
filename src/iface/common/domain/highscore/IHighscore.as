package iface.common.domain.highscore 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IHighscore 
	{
		function getName():String;
		function getScore():int;
		function isLessThan( score:int ):Boolean;
	}
	
}