package iface.common.domain.enemy 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import iface.common.domain.projectile.ITarget;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IEnemy extends ITarget
	{
		function move( moveFactor:Number ):int;
		function getData():String;
		function getFirstChar():String;
		function matchNextChar( nextChar:String ):int;
		function isDead():Boolean;
		function addEnemyListener( enemyListener:IEnemyListener ):void;
		function getX():Number;
		function getY():Number;		
		function getWidth():int;
		function getHeight():int;
		function die():void;
		function isDestroyed():Boolean;
		function getType():int;
		function getNumChars():int;
		function destroy():void;
		function pause():void;
		function unPause():void;
		function isPaused():Boolean;		
		function getRect():Rectangle;
		function isExploded():Boolean;
		function explode():void;
		function tickExplosion( tickDelta:Number ):Boolean;
		function isTargeted():Boolean;
	}
	
}