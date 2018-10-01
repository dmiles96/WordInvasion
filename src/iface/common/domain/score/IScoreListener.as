package iface.common.domain.score 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IScoreListener 
	{
		function scoreChanged( newScore:int ):void;
		function scoreRewarded():void;
	}
	
}