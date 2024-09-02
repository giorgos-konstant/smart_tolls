from py_acr122u import nfc
from py_acr122u import error
import time

def nfc_read() -> bool:
    reader = nfc.Reader()
    
    while True:
        try:
            try:
                reader.connect()
                print("NFC TAG DETECTED")
                time.sleep(2)
                return True
            except (error.NoCommunication) as e :
                time.sleep(2)
                return False
        except KeyboardInterrupt:
            print("Program terminated.")
            exit()

if __name__ == "__main__":
    nfc_read()
    
    
