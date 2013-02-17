package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import org.wiiflash.Wiimote;
	import org.wiiflash.IR;
	import net.eriksjodin.arduino.ArduinoWithServo;
	import net.eriksjodin.arduino.Arduino;
	import net.eriksjodin.arduino.events.ArduinoEvent;
	
	/**
	 * ...
	 * @author Miguel Murça
	 */
	public class Main extends Sprite 
	{
		public var wiimote:Wiimote;
		private var ledPin:Number = 13;
		
		public var arduino:ArduinoWithServo = new ArduinoWithServo("127.0.0.1", 5331);
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//Remember WiiFlashServer!
			//Remember Serproxy!
			//create Wiimote Object
			wiimote = new Wiimote();
			wiimote.addEventListener(Event.CONNECT, wiimoteIsConnected);
			wiimote.connect();
		}
		
		private function wiimoteIsConnected(e:Event = null):void
		{
			trace("Connected!");
			removeEventListener(Event.CONNECT, wiimoteIsConnected);
			//IR Calibration
			trace("Press any key to calibrate");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, calibrate);
		}
		
		private function calibrate(e:Event = null)
		{
			removeEventListener(KeyboardEvent.KEY_DOWN, calibrate);
			trace("calibration");
			trace("calibration ended");
			arduino.addEventListener(ArduinoEvent.FIRMWARE_VERSION, onArduinoStartup);
			arduino.requestFirmwareVersion();
		}
		
		private function onArduinoStartup(e:ArduinoEvent):void
		{
			trace("Arduino started!");
			arduino.setPinMode(ledPin, Arduino.OUTPUT);
			arduino.writeDigitalPin(ledPin, Arduino.HIGH);
			irtrace();
		}
		
		private function irtrace():void
		{
			trace("IR TRACKING");
		}
	}
	
}