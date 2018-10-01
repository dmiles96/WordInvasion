package iface.common.domain.enemy 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IVelocityComputer 
	{
		function computeFallingEnemyVelocity( height:int ):Number;
		function computeFlyingEnemyVelocity( width:int ):Number;
		function computeBombVelocity( height:int ):Number;
	}
	
}