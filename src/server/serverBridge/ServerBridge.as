package server.serverBridge 
{
	import com.pnwrain.flashsocket.events.FlashSocketEvent;
	import com.pnwrain.flashsocket.FlashSocket;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class ServerBridge 
	{
		
		protected var socket:FlashSocket;
		
		public var id:String;
		
		private var init:Boolean = true;
		
		public function ServerBridge() 
		{
			//82.77.154.114
			//192.168.11.51
			socket = new FlashSocket("192.168.11.51:8080");
			socket.addEventListener(FlashSocketEvent.CONNECT, onConnect);
            socket.addEventListener(FlashSocketEvent.MESSAGE, onMessage);
            socket.addEventListener(FlashSocketEvent.IO_ERROR, onError);
            socket.addEventListener(FlashSocketEvent.SECURITY_ERROR, onError);
            socket.addEventListener("my other event", myCustomMessageHandler);
		}
		
			protected function myCustomMessageHandler(event:FlashSocketEvent):void
			{
				trace('we got a custom event!')    
			}
			
            protected function onConnect(event:FlashSocketEvent):void 
			{
                //clearStatus();
            }
			
            protected function onError(event:FlashSocketEvent):void 
			{
                //setStatus("something went wrong");
				trace("smth went wrong")
            }
			
            protected function setStatus(msg:String):void
			{
				trace(msg);
                //status.text = msg;
            }
            protected function clearStatus():void
			{
                //status.text = "";
                //this.currentState = "";
				
            }
			
            protected function onMessage(event:FlashSocketEvent):void
			{
                trace('we got message: ' + event.data);
				
                socket.send( { msgdata: event.data }, "my other event");
				if (init)
				{
					id = String(event.data);
				}
            }
			
			/**
			 * 
			 * @param	obj
			 */
			public function sendToServer(obj:Object):void
			{
				if (socket.connected)
				{
					socket.send(obj);
				}
			}
		
	}

}