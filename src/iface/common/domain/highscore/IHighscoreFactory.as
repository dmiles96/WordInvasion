package iface.common.domain.highscore 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IHighscoreFactory 
	{
		function createHighscore( name:String, score:int ):IHighscore;
	}
	
}