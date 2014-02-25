package server.serverBridge 
{
	import com.pnwrain.flashsocket.events.FlashSocketEvent;
	import com.pnwrain.flashsocket.FlashSocket;
	import signals.Signals;
	import signals.SignalsHub;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class ServerBridge 
	{
		
		protected var socket:FlashSocket;
		
			public function ServerBridge() 
			{
				
			}
			
			public function connect(address:String):void
			{
				socket = new FlashSocket(address);
				socket.addEventListener(FlashSocketEvent.CONNECT, onConnect);
				socket.addEventListener(FlashSocketEvent.MESSAGE, onMessage);
				socket.addEventListener(FlashSocketEvent.IO_ERROR, onError);
				socket.addEventListener(FlashSocketEvent.SECURITY_ERROR, onError);
				socket.addEventListener("my other event", myCustomMessageHandler);
			}
			
			/**
			 * 
			 * @param	event
			 */
			protected function myCustomMessageHandler(event:FlashSocketEvent):void
			{
				
			}
			
			/**
			 * 
			 * @param	event
			 */
            protected function onConnect(event:FlashSocketEvent):void 
			{
				
            }
			
			/**
			 * 
			 * @param	event
			 */
            protected function onError(event:FlashSocketEvent):void 
			{
				
            }
			
			/**
			 * 
			 * @param	msg
			 */
            protected function setStatus(msg:String):void
			{
				
            }
			
			/**
			 * 
			 */
            protected function clearStatus():void
			{
				
            }
			
			/**
			 * 
			 * @param	event
			 */
            protected function onMessage(event:FlashSocketEvent):void
			{
				
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