package iface.common.domain.enemy 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IDropLetterWord extends ILetterHider, ISpecialEnemy
	{
		function getNumLettersDropped():int;
	}
	
}