package iface.common.domain 
{
	import iface.common.domain.level.ILevel;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IGameStateChangeListener 
	{
		function gameStarted():void;
		function gamePaused():void;
		function gameUnpaused():void;
		function gameQuit():void;
		function gamePausedInputCommand( command:String ):void;		
		function levelStarted(levelNumber:int):void;
		function levelWon( rewarded:Boolean ):void;
		function levelCreated(newLevel:ILevel):void;
		function levelLost():void;
		function nextLevelStartMessage(startMessage:String):void;
	}
	
}
