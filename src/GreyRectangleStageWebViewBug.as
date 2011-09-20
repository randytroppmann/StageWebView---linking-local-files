package{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.LocationChangeEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class GreyRectangleStageWebViewBug extends Sprite{
		protected var stageWebView:StageWebView;
		protected var loader:URLLoader;
		
		public function GreyRectangleStageWebViewBug(){
			super();			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// loader used to load the local page
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onPageLoadComplete, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onStageViewIOError, false, 0, true);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event):void{
			stageWebView = new StageWebView();
			stageWebView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, onLocationChanging, false, 0, true);
			stageWebView.addEventListener(IOErrorEvent.IO_ERROR, onStageViewIOError, false, 0, true);
			stageWebView.addEventListener(Event.COMPLETE, onStageWebViewComplete, false, 0, true);
			stageWebView.addEventListener(ErrorEvent.ERROR, onWebViewError, false, 0, true);
			stageWebView.viewPort = new Rectangle(10, 10, stage.fullScreenWidth-20, stage.fullScreenHeight-20);
			stageWebView.stage = stage;
			loadPage("data/0.html");
		}
		
		protected function onLocationChanging(event:LocationChangeEvent):void{
			stageWebView.stop();
			var index:Number = 0;			
			if (event.location.indexOf("air/")>0) index = event.location.indexOf("air/") + 4;
			var loadingURL:String = "data/" + event.location.substr(index);
			loadPage(loadingURL);
		}
		
		protected function loadPage(p_url:String):void{				
			loader.load(new URLRequest(p_url));
		}
		
		protected function onPageLoadComplete(event:Event):void{
			stageWebView.loadString( event.target.data, "text/html" );
		}
		
		protected function onStageViewIOError(event:IOErrorEvent):void{
			
		}
		
		protected function onStageWebViewComplete(event:Event):void{
			
		}
		
		protected function onWebViewError(event:ErrorEvent):void{
			
		}
		
	}
}