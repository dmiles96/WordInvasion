package iface.common.domain.enemy 
{
	import iface.common.domain.Dimension;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IDropLetterWordListener extends IHiddenLetterListener
	{
		function letterToDropChosen( letterToDropIndex:int ):void;
		function letterDropped( letterToDropIndex:int ):Dimension;
		function revealMatchedLetter( matchedLetterIndex:int, machtedLetter:String ):void;
	}
	
}