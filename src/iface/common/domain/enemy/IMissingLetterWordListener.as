package iface.common.domain.enemy 
{
	import iface.common.domain.Dimension;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IMissingLetterWordListener extends IHiddenLetterListener
	{
		function missingLettersChosen( missingLetterIndexes:Array ):Dimension
		function revealMatchedLetter( matchedLetterIndex:int, machtedLetter:String ):void;
	}
	
}