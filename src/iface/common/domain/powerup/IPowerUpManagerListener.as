package iface.common.domain.powerup 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IPowerUpManagerListener 
	{
		function powerUpUsed( slotNumber:int ):void;
		function slotEmpty( slotNumber:int ):void;
		function powerUpAdded( powerUpType:int, slotNumber:int ):void;
	}
	
}