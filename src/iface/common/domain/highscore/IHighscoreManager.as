package iface.common.domain.highscore 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IHighscoreManager 
	{
		function load():Array;
		function save( highscores:Array ):void;
	}
	
}