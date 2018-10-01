package iface.common.domain.level 
{
	import iface.common.domain.city.ICity;
	import iface.common.domain.powerup.IPowerUpManager;
	import iface.common.time.ITickHandler;
	import impl.common.domain.level.LevelAttributes;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ILevel extends ITickHandler
	{
		function addLevelListener( levelListener:ILevelListener ):void;
		function getCity():ICity;
		function getPowerUpManager():IPowerUpManager;
		function inputAlphaNumeric( typedChar:String ):void;
		function inputCommand( command:int ):void;
		function addLevelCompleteListener( levelCompleteListener:ILevelCompleteListener ):void;
		function changeAttributes( newLevelAttributes:LevelAttributes ):void;
		function repairCity():void;
		function addRandomPowerUp():Boolean;
		function getStartMessages():Array;
	}
	
}