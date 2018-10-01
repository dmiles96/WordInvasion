package iface.common.domain
{
	import iface.common.domain.score.IScoreManager;
	import iface.common.time.ITickHandler;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IGame extends ITickHandler
	{
		function start():void;
		function addGameStateChangeListener(gameStateChangeListener: IGameStateChangeListener):void;
		function inputAlphaNumeric( typedChar:String ):void;
		function inputCommand( command:int ):void;
		function getScoreManager():IScoreManager;
		function isEnded():Boolean;
	}
	
}