package impl.client.task 
{
	import iface.client.service.video.ICanvas;
	import iface.client.task.IViewTasks;
	import iface.client.view.IView;
	import iface.client.service.video.ICanvasFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ViewTasks implements IViewTasks
	{
		private var mainCanvas:ICanvas = null;
		
		public function ViewTasks( canvasFactory:ICanvasFactory )
		{
			this.mainCanvas = canvasFactory.getMainCanvas();
		}
		
		public function showView(view:IView):void
		{
			mainCanvas.clear();
			mainCanvas.addCanvas(view.getCanvas());
			view.getCanvas().takeFocus();
		}
		
		public function removeView( view:IView ):void
		{
			mainCanvas.removeCanvas( view.getCanvas() );
		}
	}
	
}